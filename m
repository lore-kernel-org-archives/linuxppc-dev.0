Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6D80DDE2C
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 19:54:35 +1100 (EST)
Subject: Re: hibernate, suspend and s2both support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tim Dijkstra <newsuser@famdijkstra.org>
In-Reply-To: <20070318010044.0b0bebf0@commensaal.drs.p>
References: <20070318010044.0b0bebf0@commensaal.drs.p>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Cicj75zwP9U6jkS47IrZ"
Date: Sun, 18 Mar 2007 09:54:43 +0100
Message-Id: <1174208083.13027.36.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Cicj75zwP9U6jkS47IrZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Tim,

Let me try to answer your questions, I've worked on suspend for powermac
machines for quite a while.

On Sun, 2007-03-18 at 01:00 +0100, Tim Dijkstra wrote:
> [please cc me]

You should have used linuxppc-dev instead of debian-powerpc but since
the thread is already here I'll just add them. Maybe take off
debian-powerpc when replying, people there can follow in the archives or
on linuxppc-dev. I just didn't want to take it out right away and leave
the thread floating.


> I'm the maintainer of uswsusp and pm-utils (which isn't in the archive
> yet). pm-utils will be used by hal/gnome-power-manager to suspend or
> hibernate. At the moment I'm looking at how to fold-in support for
> uswsusp, which can also do 's2both', which means writing the system
> state to disk before suspending to ram. Leaving you with the possibility
> to resume when you run out of batteries. To support that too for ppc I
> have some question about how hibernate/suspend is done on a ppc.

At this point you should start differentiating between powerpc (generic)
and powermac (Apple), although at the moment the only powerpc machine
that I'm aware of that can suspend to ram is 32-bit powermac in the
laptop form-factor.

> AFAIK, one can suspend-to-ram by using some ioctl's on the PMU. (Do all
> ppc's have a PMU? What about ppc64?)

Yes, although I have a patch series that I'm going to post soon that
deprecates the PMU ioctl and uses the regular mem > /sys/power/state
mechanism, in fact the PMU ioctl only invokes that exact same code.
However, you'll need to support older kernels, but trying
sys/power/state before PMU will be safe on any kernel released after May
25 2006 (commit 0fba3a1f39f8b0a50b56c8b068fa52131cbc84c2). Before that,
the machine just crashed when using the pm ops stuff and at the time I
hadn't understood yet why and just papered over the problem.

No 64-bit machines currently support suspend to ram at all, but I expect
that if we ever figure out how to wake up the nvidia video on some of
them we may support it, and it will then be via the /sys/power/state
mechanism.

> Hibernation can be done in the usual way. And s2both is unsupported.=20

Yup; I've played with s2both a bit but it hangs the machine, I'm not
really sure why yet. It may be related to another slight bug I just
found yesterday though.

> Also s2ram doesn't need any quirks done to the graphics card, which is
> so often needed for x86 machines.

Yeah, although I think that's mostly because we don't allow s2ram on
machines where the regular graphics card is one that we don't know how
to wake up in the kernel...

> If this is all true, could someone try to build 's2ram' and 's2both'
> from the following tarball and run it? (no guarantees, on your own
> risk, etc;)
>=20
> http://www.famdijkstra.org/~tdykstra/suspend_pmu.tar.bz2

It works on my machine (see above), but it doesn't use the PMU ioctl:

#ifndef CONFIG_PMU
        int fd;
        unsigned long arg =3D 0;

        if ((fd =3D open("/dev/pmu", O_RDWR)) < 0)
...

seems to be the wrong way around. A kernel-based suspend to both has no
chance of working properly since I currently disallow using 'platform'
for the disk poweroff state, but I intend to fix this if I can. I can't
try a userspace based s2both right now since I'd probably have to
rebuild my initramfs at least to test a power-failure during suspend.

johannes

--=-Cicj75zwP9U6jkS47IrZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/P5T/ETPhpq3jKURAoj2AJ0SwBc4SViN+kiVkqSRzgP6Cjib9wCgu3ez
ICgmROmlQvXBkaOO4PSlf0U=
=C/72
-----END PGP SIGNATURE-----

--=-Cicj75zwP9U6jkS47IrZ--
