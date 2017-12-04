Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqw5C5FclzDrZW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 17:31:43 +1100 (AEDT)
Date: Mon, 4 Dec 2017 17:31:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171204063140.GR2130@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
 <20171130051126.GE3023@umbus.fritz.box>
 <87mv32bt3d.fsf@concordia.ellerman.id.au>
 <20171201214038.2bf70cba@roar.ozlabs.ibm.com>
 <20171204054914.GP2130@umbus.fritz.box>
 <20171204161206.3ee101db@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2qwbT0JTInWqknst"
In-Reply-To: <20171204161206.3ee101db@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2qwbT0JTInWqknst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 04:12:06PM +1000, Nicholas Piggin wrote:
> On Mon, 4 Dec 2017 16:49:14 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Dec 01, 2017 at 09:40:38PM +1000, Nicholas Piggin wrote:
> > > On Fri, 01 Dec 2017 22:11:50 +1100
> > > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >  =20
> > > > David Gibson <david@gibson.dropbear.id.au> writes:
> > > >  =20
> > > > > On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote: =
  =20
> > > > >> On Wed, 29 Nov 2017 15:06:52 +1100
> > > > >> David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >>    =20
> > > > >> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic no=
tifier"
> > > > >> > purports to fix a problem when the kernel panics with fadump n=
ot
> > > > >> > registered, but it breaks something else instead.  I _think_ i=
t was
> > > > >> > working on the incorrect assumption that ppc_md.panic was (or =
should
> > > > >> > be) only used with fadump, but I'm not really sure.
> > > > >> >=20
> > > > >> > Panic works with kdump enabled, and (I think) with fadump enab=
led).
> > > > >> > However, with neither of these enabled, we always go to the ge=
neric
> > > > >> > panic logic.   =20
> > > > >>=20
> > > > >> Yeah thanks, I can't remember what assumption I was working on t=
bh.
> > > > >>     =20
> > > > >> > That's incorrect for PAPR guests - they should call ibm,os-ter=
m via
> > > > >> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notif=
ication
> > > > >> > which higher-level management pays attention to.  Since a3b2cb=
30 we
> > > > >> > now reboot instead of reporting that.
> > > > >> >=20
> > > > >> > I believe it will also break panic for PS3 machines, but since=
 that
> > > > >> > platform basically no longer exists, we probably don't care.  =
 =20
> > > > >>=20
> > > > >> I (hope) it should just go down to the normal panic path and not=
 do
> > > > >> much worse than it already does -- although it won't print out t=
hat
> > > > >> message.
> > > > >>    =20
> > > > >> > I'm not entirely sure how to fix this.  I _think_ what we want=
 is to
> > > > >> > call ppc_md.panic from a late panic notifier, the way this pat=
ch does
> > > > >> > for fadump_panic_event() if fadump is registered.   =20
> > > > >>=20
> > > > >> The problem I had there is that some of the printk and console s=
tuff
> > > > >> wasn't getting flushed out, so I was getting a blank screen. Thi=
s was
> > > > >> probably in conjunction with panicing from NMI context that we'r=
e now
> > > > >> starting to introduce.
> > > > >>=20
> > > > >> So it's a bit annoying. There's other ugliness we have for being=
 unable
> > > > >> to control panic code well enough from arch code
> > > > >> (arch/powerpc/platforms/powernv/opal.c)
> > > > >>=20
> > > > >> I guess a really minimal fix is to put an #ifdef powerpc down th=
e bottom
> > > > >> there (/me *cries*).   =20
> > > > >
> > > > > Um.. right.  I'm not really sure from that how to go forward from
> > > > > here.  We want to fix this for RHEL7.5, which doesn't give us a l=
ot of
> > > > > time.
> > > > >
> > > > > Adding the #ifdef at the bottom of the generic panic code is gros=
s,
> > > > > but there's already a bunch of that, so maybe adequate until a be=
tter
> > > > > solution can be found?   =20
> > > >=20
> > > > I think you mean put an #ifdef at the bottom of panic(). If so that
> > > > won't work. Our default panic_timeout is 180 so we never get to the
> > > > bottom of panic(), we call emergency_restart().
> > > >=20
> > > > You *could* put an #ifdef powerpc before that, but that's even more
> > > > gross because it's in a different place to the sparc/s390 #ifdefs.
> > > >=20
> > > > I notice we don't implement machine_emergency_restart(), it just
> > > > becomes machine_restart(NULL).
> > > >=20
> > > > So it seems like that's the place we should be hooking,
> > > > machine_emergency_restart(). That's what x86 does.
> > > >=20
> > > > But panic() is not the only caller of emergency_restart(), so it's =
not
> > > > an entirely straight forward conversion.
> > > >=20
> > > > So I think for 4.15 and 4.14 I'm inclined to revert. Then we can do=
 a
> > > > bigger rework for 4.16.
> > > >=20
> > > > Nick that shouldn't break your original aim too badly I think? ie. =
worst
> > > > case is we panic() but don't see the output if we came from NMI? =
=20
> > >=20
> > > If the fix is not pretty obvious, then I guess revert. We actually
> > > do have a bit of a regression though, since we've started marking
> > > system reset interrupts as NMI. Previously a system reset would have
> > > a better chance of printing something there.
> > >=20
> > > So I wonder is an ifdef really all that much worse just because it's =
not
> > > in the same exact place as the others? We do get bug reports that were
> > > triggered by a system reset from hypervisor console. Hopefully they w=
ould
> > > be running with crash dumps usually. =20
> >=20
> > I don't think an ifdef there is really correct though.  Sounds like we
> > might instead need to move some console flushes before calling of all
> > the notifiers, so that things like platforms/pseries or pvpanic can
> > insert non-returning notifiers.
>=20
> Well, I don't necessarily think that's the right thing to do either.
> If we have a crash dump handler, we should get the console memory
> and rather do that immediately than try to flush it, no?
>=20
> I think a helper function that would do all the necessary generic
> panic flushing might be better, than handlers can decide for
> themselves.
>=20
> But a pseries rtas hcall at the end of panic should be okay for a
> backport, no? Revert would be easy, but if distros and things pick it
> up then we might get a bunch of bugs without console data then
> just have to backport something anway. That's my worry.

Hrm.  Well, sure, but I see a bunch of possibilities there without a
clear idea of what to do next.  I'm really inclined to revert then
re-fix the original problem once you figure out how.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2qwbT0JTInWqknst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok68kACgkQbDjKyiDZ
s5KgTA//Xz4MXBFDgupFN62q9Qmm6BA8VAjJOh7/fju+4EhRG/1WQD9yAMRSlal0
lbd9zGdHyV+iXCG7mPVXgPTDiRAz0wCGlkTandrebxNbWPyAtYz72xGH6VgA1Fwd
jlhG+dK+Ljl/OK3NIwSl0S1xAiEtndjpy2wNEyfCLJ0P0pz5i/4fTqTyWeGZfipy
3j48PNsbsWyLH6fnKBsNyF8/XPOVanF9yFWyZtn4OU9ZlB3972ElmQ35EUf6HF03
1MAgNi9KmUgscXlNDeOTlu9HQJBrrqJC5zEFB/oMEOS5r/hfvrAds3+8utuyP8wI
mXL9mWhXnhoW8oDzIAiQk6ROy0pkuNq2h823WS+TToe4VIkdw3WC71UVht3AN2TP
3qBjE1DsLA7tCBMnTWSQvQzXUgfsWuQnOakUJbJQM3kGnRhUagsWPntzmiScLZiv
jgw1cT8ym3H/sQkr5OksAc0CQxcWE2gRMaNv/XE7Ol8jVLbSf/s3cq/bQIWGWpnI
seG8ybQEul1+FmGlk2QRyzZ9MW1vcYBjjg6T0P2AdAOA3cGiRMbZSdDZ3u2euoaF
UdHpwWTG+nXgOAGfnJR0pA95qHfkrvi/1qEcRFWJtkIUUBOEaCkW6TFHXiD/CDkG
oH8YT7SJv0hdYG3nx5HOriTMfSwiedzq7kc9/M7BgqVRaUTZBcw=
=tyqD
-----END PGP SIGNATURE-----

--2qwbT0JTInWqknst--
