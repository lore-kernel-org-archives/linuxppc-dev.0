Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 760DDDDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 11:50:59 +1000 (EST)
Date: Tue, 31 Jul 2007 11:50:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Attempt at addressing head*.S for modpost warnings
Message-Id: <20070731115047.8b88cb78.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0707250147150.9086@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0707250147150.9086@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__31_Jul_2007_11_50_47_+1000_BZ=no8jtL/G/jQPd"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__31_Jul_2007_11_50_47_+1000_BZ=no8jtL/G/jQPd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

[sorry for the slow reply]

On Wed, 25 Jul 2007 01:49:04 -0500 (CDT) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> Paul said you were looking into this issue as well.  Wanted to post what I
> did on ppc32/e500 as a start for you to look at.  I think the other ppc32
> head*.S can follow the same pattern if we like this.  However, wasn't sure
> how to do _ENTRY() for ppc64.

What I have done so far is to put some peices of the asm code into
the .text.init.refok section (see the _INIT_STATIC macro in asm/ppc_asm.h
in the current kernel).  I was hoping to separate some of the asm into a
new file (init_64.S) that would contain this and other code in
the .init.text section.  That is currently not working (ld crashed on
me :-)).

Even if you create a .text.head, you will need to teach modpost about it.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__31_Jul_2007_11_50_47_+1000_BZ=no8jtL/G/jQPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGrpWBTgG2atn1QN8RAiqFAJ9EJrcWzBuD69qxJ7t5w+GmyosW/gCdEyt5
Qkl1eIGQ7DRJ/IPeF/qgkRY=
=50nr
-----END PGP SIGNATURE-----

--Signature=_Tue__31_Jul_2007_11_50_47_+1000_BZ=no8jtL/G/jQPd--
