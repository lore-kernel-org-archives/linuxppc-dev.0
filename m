Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdts75qnBzDqmw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:59:55 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id u25so1033209iou.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:59:54 -0700 (PDT)
Date: Tue, 28 Jun 2016 13:03:56 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 2/3] powerpc/spinlock: support vcpu preempted check
Message-ID: <20160628050356.GA25008@insomnia>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160627145832.GB19108@insomnia>
 <5771F166.5060604@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <5771F166.5060604@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2016 at 11:39:18AM +0800, xinhui wrote:
[snip]
> > > +{
> > > +	struct lppaca *lp =3D &lppaca_of(cpu);
> > > +
> > > +	if (unlikely(!(lppaca_shared_proc(lp) ||
> > > +			lppaca_dedicated_proc(lp))))
> >=20
> > Do you want to detect whether we are running in a guest(ie. pseries
> > kernel) here? Then I wonder whether "machine_is(pseries)" works here.
> >=20
> I tried as you said yesterday. but .h file has dependencies.
> As you said, if we add #ifdef PPC_PSERIES, this is not a big problem. onl=
y powernv will be affected as they are built into same kernel img.
>=20

I never said this it not a big problem ;-)

The problem here is that we only need to detect the vcpu preemption in
a guest, and there could be several ways we can detect whether the
kernel is running in a guest. It's worthwhile to try find the best one
for this. Besides, it's really better that you can make sure we are
runing out of options before you introduce something like
lppaca_dedicated_proc().

I have a feeling that yield_count is non-zero only if we are running in
a guest, if so, we can use this and save several loads. But surely we
need the confirmation from ppc maintainers.

Regards,
Boqun

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXcgU0AAoJEEl56MO1B/q4voUH/0utHA4GYk3lIrSQ8PYSSzJd
QZN8FExYQPtTo0pghf2CIPmwhrq/GSh30iLC6M22vS9mL3+Jx9tuenxuAiyHJPt8
+ZydEhQHyrX54ewMc2MF9elwZ0yqnrfznFrTOwwA9CoisRbj8yh1OZJnnR47GmnK
qBMBpypSIg4JPAV8ZnXx+MDjAFrrUkcSTieVAhEDD1ZevHT9EOgItFSXceW6O7A0
bHIqIoMOmXj5Lvo2PmupTIzSjN0vXEc8r6W9OLjNqwZd9v4wETgmoCkbZWREy3eN
HgTbbhoUoA9kziPtKagziq0+XpvLwKgPEV/8rpuNbETwCUJ4NzJt84tsZrkhwFg=
=Rahy
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
