Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8536CB7BB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 11:20:32 +1100 (EST)
Date: Thu, 5 Nov 2009 11:20:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
Message-Id: <20091105112020.33f02552.sfr@canb.auug.org.au>
In-Reply-To: <200910201415.34361.rusty@rustcorp.com.au>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<200910201142.34006.rusty@rustcorp.com.au>
	<1256002193.6546.2.camel@slab>
	<200910201415.34361.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__5_Nov_2009_11_20_20_+1100_+dqOcjvsFQwyL1KA"
Cc: Hollis Blanchard <hollisb@us.ibm.com>, linux-kernel@vger.kernel.org,
	kvm-ppc@vger.kernel.org, linux-next@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__5_Nov_2009_11_20_20_+1100_+dqOcjvsFQwyL1KA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Tue, 20 Oct 2009 14:15:33 +1030 Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>
> +#ifndef __OPTIMIZE__
> +#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> +#else
> +extern int __build_bug_on_failed;
> +#define BUILD_BUG_ON(condition)					\
> +	do {							\
> +		((void)sizeof(char[1 - 2*!!(condition)]));	\
> +		if (condition) __build_bug_on_failed =3D 1;	\
> +	} while(0)
> +#endif
> +#define MAYBE_BUILD_BUG_ON(condition) BUILD_BUG_ON(condition)
> +

I decided to try this in linux-next, but an x86_64 allmodconfig build
gave this (gcc 4.4.0):

ERROR: "__build_bug_on_failed" [drivers/net/virtio_net.ko] undefined!
ERROR: "__build_bug_on_failed" [drivers/block/virtio_blk.ko] undefined!

I assume that this is caused by the "MAYBE_BUILD_BUG_ON(fbit >=3D 32)" in
virtio_has_feature() (in include/linux/virtio_config.h) which is called
all over the place.  Unfortunately, virtio_has_feature() gets uninlined
in those two files ...

I have taken the patch back out again for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__5_Nov_2009_11_20_20_+1100_+dqOcjvsFQwyL1KA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkryGkQACgkQjjKRsyhoI8yNnwCgqxtqC7HlRrQPSf2/86SIICQx
NNUAn0WTwWtUTvocyofSmByl1KGyiCwd
=1ISe
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Nov_2009_11_20_20_+1100_+dqOcjvsFQwyL1KA--
