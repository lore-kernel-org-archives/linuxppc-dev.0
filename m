Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqv8K5JShzDrns
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 16:49:21 +1100 (AEDT)
Date: Mon, 4 Dec 2017 16:47:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171204054715.GO2130@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
 <20171130051126.GE3023@umbus.fritz.box>
 <87mv32bt3d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eHmdSDY+kY2au76U"
In-Reply-To: <87mv32bt3d.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eHmdSDY+kY2au76U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 10:11:50PM +1100, Michael Ellerman wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote:
> >> On Wed, 29 Nov 2017 15:06:52 +1100
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>=20
> >> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
> >> > purports to fix a problem when the kernel panics with fadump not
> >> > registered, but it breaks something else instead.  I _think_ it was
> >> > working on the incorrect assumption that ppc_md.panic was (or should
> >> > be) only used with fadump, but I'm not really sure.
> >> >=20
> >> > Panic works with kdump enabled, and (I think) with fadump enabled).
> >> > However, with neither of these enabled, we always go to the generic
> >> > panic logic.
> >>=20
> >> Yeah thanks, I can't remember what assumption I was working on tbh.
> >> =20
> >> > That's incorrect for PAPR guests - they should call ibm,os-term via
> >> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
> >> > which higher-level management pays attention to.  Since a3b2cb30 we
> >> > now reboot instead of reporting that.
> >> >=20
> >> > I believe it will also break panic for PS3 machines, but since that
> >> > platform basically no longer exists, we probably don't care.
> >>=20
> >> I (hope) it should just go down to the normal panic path and not do
> >> much worse than it already does -- although it won't print out that
> >> message.
> >>=20
> >> > I'm not entirely sure how to fix this.  I _think_ what we want is to
> >> > call ppc_md.panic from a late panic notifier, the way this patch does
> >> > for fadump_panic_event() if fadump is registered.
> >>=20
> >> The problem I had there is that some of the printk and console stuff
> >> wasn't getting flushed out, so I was getting a blank screen. This was
> >> probably in conjunction with panicing from NMI context that we're now
> >> starting to introduce.
> >>=20
> >> So it's a bit annoying. There's other ugliness we have for being unable
> >> to control panic code well enough from arch code
> >> (arch/powerpc/platforms/powernv/opal.c)
> >>=20
> >> I guess a really minimal fix is to put an #ifdef powerpc down the bott=
om
> >> there (/me *cries*).
> >
> > Um.. right.  I'm not really sure from that how to go forward from
> > here.  We want to fix this for RHEL7.5, which doesn't give us a lot of
> > time.
> >
> > Adding the #ifdef at the bottom of the generic panic code is gross,
> > but there's already a bunch of that, so maybe adequate until a better
> > solution can be found?
>=20
> I think you mean put an #ifdef at the bottom of panic(). If so that
> won't work. Our default panic_timeout is 180 so we never get to the
> bottom of panic(), we call emergency_restart().
>=20
> You *could* put an #ifdef powerpc before that, but that's even more
> gross because it's in a different place to the sparc/s390 #ifdefs.
>=20
> I notice we don't implement machine_emergency_restart(), it just
> becomes machine_restart(NULL).
>=20
> So it seems like that's the place we should be hooking,
> machine_emergency_restart(). That's what x86 does.

Only sort of.  machine_emergency_restart() is in basically the right
place, but AFAICT it is supposed to restart the machine, which os-term
(by design) does not.  x86 uses this for a restart, when using pvpanic
which provides similar functionality to os-term, that gets called
before reaching emergency_reset().

> But panic() is not the only caller of emergency_restart(), so it's not
> an entirely straight forward conversion.
>=20
> So I think for 4.15 and 4.14 I'm inclined to revert. Then we can do a
> bigger rework for 4.16.

I've sent a revert for now.

> Nick that shouldn't break your original aim too badly I think? ie. worst
> case is we panic() but don't see the output if we came from NMI?
>=20
> cheers
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eHmdSDY+kY2au76U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok4WMACgkQbDjKyiDZ
s5K0Rg//ThkbjJcFJtirqiFJSDoxdZL2G89gk29CU32cLuLWup43ixGc8mW3xBHw
fcxp8qymmh8iYTWo5K0AVBNpjRbESv7unICcQZJ4vREuWOMLXoLbbOqHDkpPIaj6
HSXKh8GaOyzbCqDDfHNoKBtQ03pSeIXOngVmg/GitxYuAXtTxuiMyXes21d6ea/f
EIn9HPE94T800BPxijOyGa+vdnY3JNWUySuk0jBcuTSwdok8s0AdXepG9PE8GCJu
DFD6cO3Eqe3Y0iwgS6Daikwne7oUQbI5aOT931Nn1ESpNQggZAJ78u4jB8412Odv
nLea2bjHC6IW66H7bC3GUpkf3wf7eJWj7DKR76YyFrCT9OSmulrzpERzN41dsp06
WscA3k8Nt8e/t4jQRxQlRQJ/xo/eMVXyE+OczftU+IFArvS0pIzW1gRUKxH/IF8A
L9y2go6jzmmeQSQhg5zBDUnK00sRg0tuXgKyY6s/JBONQfixuLThPS9ujIIKPc6w
vccRvD6ZVdbvF5IEvqGwI2wLXlflcgqCAJFFSDMU0NYr9cP3oFW1XNNF9Ne43Eqh
wUl6mPOMxMBhrwUJtI8fXpE8Xy/cnPpEVKvH2Et0MSLM8Na8u9Y99/Tf8tsPSRRf
/zyg0GVmxl5NZ4dsjz7UOm970tC0cwH2WqCZqaV+XI4p3itizQY=
=ohEY
-----END PGP SIGNATURE-----

--eHmdSDY+kY2au76U--
