Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqv8K5nt0zDrnv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 16:49:21 +1100 (AEDT)
Date: Mon, 4 Dec 2017 16:49:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171204054914.GP2130@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
 <20171130051126.GE3023@umbus.fritz.box>
 <87mv32bt3d.fsf@concordia.ellerman.id.au>
 <20171201214038.2bf70cba@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dT+85zccSFkyJC53"
In-Reply-To: <20171201214038.2bf70cba@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dT+85zccSFkyJC53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 09:40:38PM +1000, Nicholas Piggin wrote:
> On Fri, 01 Dec 2017 22:11:50 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> > > On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote: =20
> > >> On Wed, 29 Nov 2017 15:06:52 +1100
> > >> David Gibson <david@gibson.dropbear.id.au> wrote:
> > >>  =20
> > >> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifi=
er"
> > >> > purports to fix a problem when the kernel panics with fadump not
> > >> > registered, but it breaks something else instead.  I _think_ it was
> > >> > working on the incorrect assumption that ppc_md.panic was (or shou=
ld
> > >> > be) only used with fadump, but I'm not really sure.
> > >> >=20
> > >> > Panic works with kdump enabled, and (I think) with fadump enabled).
> > >> > However, with neither of these enabled, we always go to the generic
> > >> > panic logic. =20
> > >>=20
> > >> Yeah thanks, I can't remember what assumption I was working on tbh.
> > >>   =20
> > >> > That's incorrect for PAPR guests - they should call ibm,os-term via
> > >> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notificat=
ion
> > >> > which higher-level management pays attention to.  Since a3b2cb30 we
> > >> > now reboot instead of reporting that.
> > >> >=20
> > >> > I believe it will also break panic for PS3 machines, but since that
> > >> > platform basically no longer exists, we probably don't care. =20
> > >>=20
> > >> I (hope) it should just go down to the normal panic path and not do
> > >> much worse than it already does -- although it won't print out that
> > >> message.
> > >>  =20
> > >> > I'm not entirely sure how to fix this.  I _think_ what we want is =
to
> > >> > call ppc_md.panic from a late panic notifier, the way this patch d=
oes
> > >> > for fadump_panic_event() if fadump is registered. =20
> > >>=20
> > >> The problem I had there is that some of the printk and console stuff
> > >> wasn't getting flushed out, so I was getting a blank screen. This was
> > >> probably in conjunction with panicing from NMI context that we're now
> > >> starting to introduce.
> > >>=20
> > >> So it's a bit annoying. There's other ugliness we have for being una=
ble
> > >> to control panic code well enough from arch code
> > >> (arch/powerpc/platforms/powernv/opal.c)
> > >>=20
> > >> I guess a really minimal fix is to put an #ifdef powerpc down the bo=
ttom
> > >> there (/me *cries*). =20
> > >
> > > Um.. right.  I'm not really sure from that how to go forward from
> > > here.  We want to fix this for RHEL7.5, which doesn't give us a lot of
> > > time.
> > >
> > > Adding the #ifdef at the bottom of the generic panic code is gross,
> > > but there's already a bunch of that, so maybe adequate until a better
> > > solution can be found? =20
> >=20
> > I think you mean put an #ifdef at the bottom of panic(). If so that
> > won't work. Our default panic_timeout is 180 so we never get to the
> > bottom of panic(), we call emergency_restart().
> >=20
> > You *could* put an #ifdef powerpc before that, but that's even more
> > gross because it's in a different place to the sparc/s390 #ifdefs.
> >=20
> > I notice we don't implement machine_emergency_restart(), it just
> > becomes machine_restart(NULL).
> >=20
> > So it seems like that's the place we should be hooking,
> > machine_emergency_restart(). That's what x86 does.
> >=20
> > But panic() is not the only caller of emergency_restart(), so it's not
> > an entirely straight forward conversion.
> >=20
> > So I think for 4.15 and 4.14 I'm inclined to revert. Then we can do a
> > bigger rework for 4.16.
> >=20
> > Nick that shouldn't break your original aim too badly I think? ie. worst
> > case is we panic() but don't see the output if we came from NMI?
>=20
> If the fix is not pretty obvious, then I guess revert. We actually
> do have a bit of a regression though, since we've started marking
> system reset interrupts as NMI. Previously a system reset would have
> a better chance of printing something there.
>=20
> So I wonder is an ifdef really all that much worse just because it's not
> in the same exact place as the others? We do get bug reports that were
> triggered by a system reset from hypervisor console. Hopefully they would
> be running with crash dumps usually.

I don't think an ifdef there is really correct though.  Sounds like we
might instead need to move some console flushes before calling of all
the notifiers, so that things like platforms/pseries or pvpanic can
insert non-returning notifiers.

Or else we need a different mechanism from the existing panic
notifiers for hooking in a "how to die" function from platform or
device.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dT+85zccSFkyJC53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok4doACgkQbDjKyiDZ
s5JQgg/9GND24KU9XV7kALhxdDSSA7aYYXB6OrdkK6z0wXcFqz8afZBq1O1u9hN4
iDH/6RHVuKBEroeth0SKnrM9jVSyKEAX+u/458bFHglSDwi8GN1nLNAqK9eIygtI
LDO+EVqksNcpdxagLbd1GEELb/bYHDU6samheN/SNqAegJQMSeNnX/T5tYPvuWvR
Pu6xszh3O19abIZ/8HqVSLbHKA+MtO9JKtFciAChRzre0T4aPaFm2z/a2kabJyk+
xhNkgpPAVZmuQDG6V48nzRKauDydvq2PVO/bXXc9VJBHLyL1e4n4JSaHPSLEDCxk
bXjEj30DAwWbRhJLFouOFJL4+TwntJLBnKP03IvMpFM/1cpAtcm6FB/qpqCTievn
1ku0L/AEVnCTlWUeeANRd+48DKY3LwoD+n9GCtzQuh7hKoxMojlHOcOqTlUgEsnx
CNCrKj5XRFYaZe1YGAdI4VSxfYlRkQT569Hd7jBRlZOo8HwjnUFY5M3U7FTBwWOw
+ycf/kAjbkhnILE/+R7ke1TL0bREerBuek4QQ3HpbgDdVUTAwRa2Fz//tPwKtlaG
w09mRURkyha6HvpnjdXa9SEW5J/dA62Dkag5mHYWgOfPfb2z4j4z61BrHFOMxL1n
w96NnSulPhjboSQIVUWmeHe4fhWfhtAP7XlR0qzszlgXclQZ5dg=
=6z0K
-----END PGP SIGNATURE-----

--dT+85zccSFkyJC53--
