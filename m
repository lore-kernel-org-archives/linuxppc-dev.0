Return-Path: <thierry.reding@gmail.com>
Received: from mail-ee0-x232.google.com (mail-ee0-x232.google.com
 [IPv6:2a00:1450:4013:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F87E2C016B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 18:35:43 +1100 (EST)
Received: by mail-ee0-f50.google.com with SMTP id l10so1695891eei.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 00:35:37 -0700 (PDT)
Date: Fri, 25 Oct 2013 09:35:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 08/10] of/platform: Resolve interrupt references at
 probe time
Message-ID: <20131025073534.GA19622@ulmo.nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-9-git-send-email-treding@nvidia.com>
 <20131015232436.19F61C40099@trevor.secretlab.ca>
 <20131024163749.68D01C403B6@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <20131024163749.68D01C403B6@trevor.secretlab.ca>
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


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 05:37:49PM +0100, Grant Likely wrote:
> On Wed, 16 Oct 2013 00:24:36 +0100, Grant Likely <grant.likely@linaro.org=
> wrote:
> > On Wed, 18 Sep 2013 15:24:50 +0200, Thierry Reding <thierry.reding@gmai=
l.com> wrote:
> > > Interrupt references are currently resolved very early (when a device=
 is
> > > created). This has the disadvantage that it will fail in cases where =
the
> > > interrupt parent hasn't been probed and no IRQ domain for it has been
> > > registered yet. To work around that various drivers use explicit
> > > initcall ordering to force interrupt parents to be probed before devi=
ces
> > > that need them are created. That's error prone and doesn't always wor=
k.
> > > If a platform device uses an interrupt line connected to a different
> > > platform device (such as a GPIO controller), both will be created in =
the
> > > same batch, and the GPIO controller won't have been probed by its dri=
ver
> > > when the depending platform device is created. Interrupt resolution w=
ill
> > > fail in that case.
> >=20
> > What is the reason for all the rework on the irq parsing return values?
> > A return value of '0' is always an error on irq parsing, regardless of
> > architecture even if NO_IRQ is defined as -1. I may have missed it, but
> > I don't see any checking for specific error values in the return paths
> > of the functions.
> >=20
> > If the specific return value isn't required (and I don't think it is),
> > then you can simplify the whole series by getting rid of the rework
> > patches.
>=20
> I've not heard back about the above, but I've just had a conversation
> with Rob about what to do here.

I thought I had sent a reply regarding this about a week ago. Perhaps it
got lost. I'll resend.

> The problem that I have is that it makes a specific return code need
> to traverse several levels of function calls and have a meaning come
> out the other end. It becomes difficult to figure out where that code
> actually comes from when reading the code. That's more of a gut-feel
> reaction rather than pointing out specifics though.

To be honest, I'm not all that happy with that aspect myself, but at the
same time I didn't feel like duplicating a lot of code to get this done
more easily. I imagine that would've caused significant pushback as
well. It's somewhat unfortunate that we have to propagate back through
several level, but that's just the way the code is currently written and
I don't think we can really get the information (EPROBE_DEFER) from any
other place but from the lowest level.

> The other thing that makes me nervous how invasive the series is.

Well, I guess that comes with the territory, doesn't it? Interrupts are
used in a large number of places and they have been used in a very
static manner so far. The end result of this patch series is that for
most devices instantiated from the device tree interrupts end up in the
same category as any other resources such as GPIOs, regulators or
clocks. They become mostly dynamic.

That in itself is a big change, so I don't think it's all that
surprising that the required changes are invasive.

And I think if we really want to solve it properly we need to make even
more invasive changes. For example, Grygorii pointed out that we could
have a setup in the future where the following happens:

	1) driver providing interrupts is probed
	2) driver using interrupts is probed, interrupt references are
	   resolved at probe time
	3) both drivers are unloaded
	4) both drivers are reloaded

In that case with the current set of patches the added core code assumes
that the interrupts have already been resolved and are still valid.

Possibly the easiest way to fix that would be to just zero out the
interrupt resources on remove so that they can be re-resolved on next
probe.

But that's somewhat cumbersome and it seems to me like a better fix
might be to go and change struct platform_device to not use a single
array of resources, but rather a list, or perhaps an array per type of
resource. The current platform_device structure is simple and easy, but
it doesn't work well with all the new dynamicity that we want/need/have
today.

Obviously modifying the innards of struct platform_device will likely
turn out to be a mammoth task of its own, but if that's what it takes
I'm prepared to do that as well. Or at least even try.

> However, even with saying all of the above, I'm not saying outright no.
> I want to get this feature in.

That's good to hear. Last time we talked about it we seemed to have an
agreement that this needs to be done, but you not replying had me
worried that perhaps you had changed your mind. It seems you've been
busy trying to address other issues that maybe are even more pressing so
I can hardly complain. =3D)

I'm good as long as we can keep moving in the right direction.

> It is obviously needed and I'll even merge the patches piecemeal as the
> look ready (I've already merged 2). Regardless, the current series needs
> to be reworked. It conflicts with the other IRQ rework that I've already
> put into my tree. The best thing to do would probably be respin it
> against my current tree and repost.

Sure, that won't be a problem. I might not get to it immediately, but
I'll get back to it.

> I'll take a fresh look then.... In the mean time, anything you can do to
> /sanely/ reduce the impact will probably help.  :-)

I might be able to do that. But I'll mention that in another thread in
the right context.

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSah9GAAoJEN0jrNd/PrOhglEQALEA8kYxwwnW0OoScRWWD2Fw
conQGp/mjJecS8927ypLouy7SX2DNAX/234wnaTPGVrnJ9xwXS1Y4Xd+uEd2DWQO
9NfWP+9bdWhIbVO7oVpX6uQtUT4OXcelmMOVmvotDIAnBFHA5jLE6RwWpW8Pn3yU
YSGaDkiOGHU0o2K5kk3+ZxqtZaDpm32MgtzB/ZcJWgJkUmebZ1gof01ARsev3+Vb
5IC3tuhzT6uNR3fxEhoyPUN71f2+1tUNzzjVhn5A9nuAYnU4pYLkLwN3KXf7q1V2
FfX6UhHC5mqHXkmdPqiT5Cg8rtS9nulq3zDwDd65HYq/g2Xlp/Qo5798h6xdoqeF
EjCAOvucO333e7Ce9AiiDZsU6njVriNZU3UemPc2oW6BV1aOsUFaw/htbu1f7jze
XmOtwGrY7fcQCVwNc7ff8aHsQ2equ6lPieN+HYI9hYQdysOpH8XBVlTP3OfJrhro
hk2Zhhj4tJxBY80Wtd4g8TNtXa0n7HCzaTXdi7Ia7xpIlZ93XPENznOOTcXlYhhj
dilfWfJX6ZpaPFd5bNcQr+iKNmIOM4x8DZYG8Ds+olEEgDm1uM4FsfqFZYaDJnPU
93FDVkj/k7SLWzyk2FUnWMydi2P1A+Qr7il89cVMbazzMxRilwvpRXPGigVN69dV
4+nSk5B422FhPGAEUZl9
=WlHh
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
