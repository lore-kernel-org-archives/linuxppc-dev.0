Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A5DEDDDF2C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 10:29:25 +1100 (EST)
Date: Wed, 9 Jan 2008 10:29:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Use <linux/of_{platform, device}.h> and not <asm/...>
	variants.
Message-Id: <20080109102912.16215a01.sfr@canb.auug.org.au>
In-Reply-To: <E1JCF5S-00043W-0U@jdl.com>
References: <E1JBwNX-0006XF-26@jdl.com>
	<20080108113637.5208a0c7.sfr@canb.auug.org.au>
	<E1JCF5S-00043W-0U@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_10_29_12_+1100_NbSi=hyfy+oXMyZC"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_10_29_12_+1100_NbSi=hyfy+oXMyZC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jan 2008 08:05:49 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>
> By $DIETY, I'll obtain Janitorial Karma one way or another!

:-)

> The question now is, what next?  I'm thinking about
> picking on arch/sparc/, then drivers/ and sound/,
> and finally pick off /include.

arch/sparc{,64} should be easy if you have a cross compiler (though it
should work, Dave gets cranky if you break his tree :-))  Dave should just
take the patches if you do test compile them.  Tell him I sent you :-)

> To be honest, I'm not sure what the final /include
> structure is supposed to look like or do as both
> pairs of these files mutually include their counterpart.
> (i/l/of_d.h includes i/a/of_d.h which includes i/l/of_d.h)
> (i/l/of_p.h includes i/a/of_p.h which includes i/l/of_p.h)

The intention is that everyone only includes linux/of*.h (except for
linux/of*.h of course) at which point we should be able to remove the
includes of linux/of*.h from asm*/of*.h.

> But, of course, the various asm/of_{platform,device}.h files
> are different for each arch/, so I wasn't sure if the longer
> term plan had folding the arch variants straight into the
> include/linux/ version of the file or not.  Seems there will
> come a point when the sparc and powerpc variants will need
> to be more unified...

Some more unification should be possible over time, but that is much
harder.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_10_29_12_+1100_NbSi=hyfy+oXMyZC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhAdOTgG2atn1QN8RAlY0AJ9SvmGCL1TO+w5KIv9aftnmK0RbOQCbBhz9
kIiV+AP+Z+zN1d2QbwzywfI=
=JI3G
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_10_29_12_+1100_NbSi=hyfy+oXMyZC--
