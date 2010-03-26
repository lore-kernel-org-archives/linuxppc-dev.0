Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F248DB7CE7
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 21:54:25 +1100 (EST)
Date: Fri, 26 Mar 2010 21:54:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-Id: <20100326215416.80d09610.sfr@canb.auug.org.au>
In-Reply-To: <20100326095821.GA7039@amit-x200.redhat.com>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
	<4BAC7AD4.4030309@in.ibm.com>
	<20100326095821.GA7039@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__26_Mar_2010_21_54_16_+1100_YZLZJcjnOWU7PRW3"
Cc: Greg Kroah-Hartman <gregkh@suse.de>, a.p.zijlstra@chello.nl,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__26_Mar_2010_21_54_16_+1100_YZLZJcjnOWU7PRW3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Fri, 26 Mar 2010 15:28:21 +0530 Amit Shah <amit.shah@redhat.com> wrote:
>
> On (Fri) Mar 26 2010 [14:43:56], Sachin Sant wrote:
> >
> > I too ran into this issue as reported by Anton. Unfortunately in my
> > case the following suggested patch does not help boot the powerpc
> > box successfully. The boot still hangs with following messages

I have been getting this on my linux-next boot tests for a while as well.

> Was the hang you saw before applying this patch at the same place / for
> the same reason?

I get the same hangs with and without the patch.  Paulus bisected it
(again) to the commit below and reverting that commit fixes the problem.

> OK, this gets even murkier. I don't know why taking a few krefs modifies
> hvc_console behaviour to such an extent.
>=20
> > Just to confirm i too am facing same issue as reported by Anton,
> > reverted commit e74d098c66543d0731de62eb747ccd5b636a6f4c and that allow=
ed
> > by box to boot successfully.
>=20
> Which module uses hvc_console in your case?

I assume hcv_vio.

I also tested using "init=3D/bin/bash" as a kernel command line option and
the console worked while I was running bash, but everything was very
sluggish.  Then when I did "exec /sbin/init" the console hung completely
- sysrq (^O) didn't even work any more (it did while I was running bash).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Mar_2010_21_54_16_+1100_YZLZJcjnOWU7PRW3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkusklgACgkQjjKRsyhoI8z2rgCfdQK7HbJ3o86vDpbSbghLmQwd
7CEAoI4ZvlWTUDm4FooAu/N5fA3VfHXg
=wzAl
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Mar_2010_21_54_16_+1100_YZLZJcjnOWU7PRW3--
