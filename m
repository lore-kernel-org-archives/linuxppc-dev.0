Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-x235.google.com (mail-bk0-x235.google.com
 [IPv6:2a00:1450:4008:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE7342C035F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 19:23:03 +1100 (EST)
Received: by mail-bk0-f53.google.com with SMTP id d7so138277bkh.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 01:22:58 -0700 (PDT)
Date: Wed, 16 Oct 2013 10:20:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 08/10] of/platform: Resolve interrupt references at
 probe time
Message-ID: <20131016082039.GA21963@ulmo.nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-9-git-send-email-treding@nvidia.com>
 <20131015232436.19F61C40099@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <20131015232436.19F61C40099@trevor.secretlab.ca>
Cc: devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 linux-mips@linux-mips.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2013 at 12:24:36AM +0100, Grant Likely wrote:
> On Wed, 18 Sep 2013 15:24:50 +0200, Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > Interrupt references are currently resolved very early (when a device is
> > created). This has the disadvantage that it will fail in cases where the
> > interrupt parent hasn't been probed and no IRQ domain for it has been
> > registered yet. To work around that various drivers use explicit
> > initcall ordering to force interrupt parents to be probed before devices
> > that need them are created. That's error prone and doesn't always work.
> > If a platform device uses an interrupt line connected to a different
> > platform device (such as a GPIO controller), both will be created in the
> > same batch, and the GPIO controller won't have been probed by its driver
> > when the depending platform device is created. Interrupt resolution will
> > fail in that case.
>=20
> What is the reason for all the rework on the irq parsing return values?
> A return value of '0' is always an error on irq parsing, regardless of
> architecture even if NO_IRQ is defined as -1. I may have missed it, but
> I don't see any checking for specific error values in the return paths
> of the functions.
>=20
> If the specific return value isn't required (and I don't think it is),
> then you can simplify the whole series by getting rid of the rework
> patches.

The whole reason for this patch set is to propagate the precise error
code so that when one of the top-level OF IRQ functions is called (such
as irq_of_parse_and_map()) the caller can actually make an reasonable
choice on how to handle the error.

More precisely, the goal of this series was to propagate failure to
create a mapping, due to an IRQ domain not having been registered yet
for the device node passed into irq_create_of_mapping(), back to the
caller, irq_of_parse_and_map(), which can then propagate it further.
Ultimately this will allow driver probing to fail with EPROBE_DEFER
when IRQ mapping fails and allow deferred probing to be triggered.

This cannot be done if all you have as error status is 0. Mapping of
IRQs can fail for a number of reasons, such as when an IRQ descriptor
cannot be allocated or when an IRQ domain's .xlate() fails. You don't
want to be deferring probe on all errors because some of them are
genuinely fatal and cannot be recovered from by deferring probe.

With the current implementation in the kernel, interrupt references are
resolved very early, usually when a device is instantiated from the
device tree. So unless all interrupt parents of all devices have been
probed by that time (which usually can only be done using explicit
initcall ordering, and even in that case doesn't always work) then many
devices will end up with an invalid interrupt number.

The typical case where this can happen is if you have a GPIO expander on
an I2C bus that provides interrupt services to other devices. With the
current implementation, the GPIO expander will be probed fairly late, at
which point many of its users will already have been instantiated and
assigned an invalid interrupt. Many drivers try to work around that by
explicitly calling irq_of_parse_and_map() within their .probe() function
because that's usually called sometime after the device's instantiation.
However even that isn't guaranteed to work. If the GPIO expander depends
itself on other resources that cause it to require deferred probing, or
if its driver is built as a module and therefore making the registration
of the corresponding IRQ domain is completely non-deterministic, then
this can fail just as easily.

With this patch series all of these issues should go away. All of the
dependencies should be resolvable by using deferred probing. Furthermore
the mechanism introduced to have the core resolve the IRQ references can
be used to request other standard resources as well. A particular one
that I'm aware of is how IOMMUs are associated with devices. Currently a
variety of quirks have been proposed to work around these issues, such
as reordering nodes in the device tree, which only work because the DTC
implementation that everybody uses happens to keep them ordered in the
same way in the DTB as they were in the DTS.

Thierry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXkxXAAoJEN0jrNd/PrOhIJUQALy0Oj2HWU7c49EWZz/xzUZ7
cDSvnJR+5DV5QEnRw5OX7RJ1HM3lLD10CClzJlArMzkbg9U5odwQhnCwLOf0Eb1v
RPu476yK4EyUPMZWrJIF05dDTqjV/mbLmhLvrB2X2E01kE8pBDkS+p17YBlHhqZY
mmK02iZtNYU/0BtsIe2tPxXcSqRstgr9tJ6KSbETrXtvOr9KLWDwmRtS28JHsLiC
9GwLqdsxaGWX084yqLn71u1skpb+vvgQreUIcmfOjBwDYn6wSomedEN6eonHJSDw
/jypgg6PL/mzjXrt3nQEWw6/zMvB2IDbU1REtrPsz7eHth+JfWSm5NFLiycT9sLU
+Vco64HZ/sv3mlsM1LLFOgEWBgzTiVQrP2h0AJGGG2PDbG66t9bmfiHMvN7n6TT9
B6f6a2B4xzTVn3EVdpQODDsNycsdQKht/dDaqkiIY+YsKp9mP0ngG15XLEmaB4gx
PKM4Gm3Mqg1A9cWGtjXKMQx/8m65E7Enf7SHhV9zSfttNEGYX+0+HXCYKJ62s2SI
31C1Tf05sOJzJvYysmwctV7/UKe/WtcMqJA2rVynLaCyEF+lJKkKINaCTBwdSYMO
OBFab+ATYt8J8hEX1EH8QiErq7f8wYTp4/r0qPu5RSEsfEVU14rl5gYPreidAwue
/wZb2phDusCARWQ3t3gq
=lnB4
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
