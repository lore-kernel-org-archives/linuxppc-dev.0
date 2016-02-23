Return-Path: <boqun.feng@gmail.com>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC9301A07BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 20:16:10 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id x65so109099468pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 01:16:10 -0800 (PST)
Date: Tue, 23 Feb 2016 17:15:25 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, open list <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "'Peter Zijlstra (Intel)\"" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch/powerpc: use BUILD_BUG() when detect unfit
 {cmp}xchg, size
Message-ID: <20160223091525.GA2918@fixme-laptop.cn.ibm.com>
References: <56CC1C1C.6030405@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <56CC1C1C.6030405@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 04:45:16PM +0800, Pan Xinhui wrote:
> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
>=20
> __xchg_called_with_bad_pointer() can't tell us what codes use {cmp}xchg
> in incorrect way.  And no error will be reported until the link stage.
> To fix such kinds of issues in a easy way, we use BUILD_BUG() here.
>=20
> Signed-off-by: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cmpxchg.h | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/as=
m/cmpxchg.h
> index d1a8d93..20c0a30 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -5,6 +5,7 @@
>  #include <linux/compiler.h>
>  #include <asm/synch.h>
>  #include <asm/asm-compat.h>
> +#include <linux/bug.h>
> =20
>  /*
>   * Atomic exchange
> @@ -92,12 +93,6 @@ __xchg_u64_local(volatile void *p, unsigned long val)
>  }
>  #endif
> =20
> -/*
> - * This function doesn't exist, so you'll get a linker error
> - * if something tries to do an invalid xchg().
> - */
> -extern void __xchg_called_with_bad_pointer(void);
> -
>  static __always_inline unsigned long
>  __xchg(volatile void *ptr, unsigned long x, unsigned int size)
>  {
> @@ -109,7 +104,7 @@ __xchg(volatile void *ptr, unsigned long x, unsigned =
int size)
>  		return __xchg_u64(ptr, x);
>  #endif
>  	}
> -	__xchg_called_with_bad_pointer();
> +	BUILD_BUG();

Maybe we can use BUILD_BUG_ON_MSG(1, "Unsupported size for xchg"), which
could provide more information.

With or without this verbosity:

Acked-by: Boqun Feng <boqun.feng@gmail.com>


Regards,
Boqun

>  	return x;
>  }
> =20
> @@ -124,7 +119,7 @@ __xchg_local(volatile void *ptr, unsigned long x, uns=
igned int size)
>  		return __xchg_u64_local(ptr, x);
>  #endif
>  	}
> -	__xchg_called_with_bad_pointer();
> +	BUILD_BUG();
>  	return x;
>  }
>  #define xchg(ptr,x)							     \
> @@ -235,10 +230,6 @@ __cmpxchg_u64_local(volatile unsigned long *p, unsig=
ned long old,
>  }
>  #endif
> =20
> -/* This function doesn't exist, so you'll get a linker error
> -   if something tries to do an invalid cmpxchg().  */
> -extern void __cmpxchg_called_with_bad_pointer(void);
> -
>  static __always_inline unsigned long
>  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
>  	  unsigned int size)
> @@ -251,7 +242,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsi=
gned long new,
>  		return __cmpxchg_u64(ptr, old, new);
>  #endif
>  	}
> -	__cmpxchg_called_with_bad_pointer();
> +	BUILD_BUG();
>  	return old;
>  }
> =20
> @@ -267,7 +258,7 @@ __cmpxchg_local(volatile void *ptr, unsigned long old=
, unsigned long new,
>  		return __cmpxchg_u64_local(ptr, old, new);
>  #endif
>  	}
> -	__cmpxchg_called_with_bad_pointer();
> +	BUILD_BUG();
>  	return old;
>  }
> =20
> --=20
> 2.5.0
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWzCMVAAoJEEl56MO1B/q4HbwH/j0W3DHSoFUSsEUjW0PcwDyf
gbp5yNmB+jFhINe4jzbvkCHeWIE9mRRtUVPKGwG4ajjGs30Q0UlNyPUMM3rdCN2c
wqCNyVzVxaPM/xY074niuIO1lUH4ovqG0451wLhTgGDaGask44pD0IJXBS3AvFaD
C76oBrKcdFxodiUZ4R4z047hlMJGVV8zg3jddUd/+3yHmJxITg25xkKEZI1efsPs
ZUOrH6WisrhYd8sCR4zES+5JEB7hFRtOU/X9vIpcDv1ZWxXyKWwUou4ntuMvk3Pk
IAdK25T/WRt2fSbR8SltJzKZbNcAzHiw172K8jZkFAdEw3znCVLFrvvY6I/64Hg=
=hHN8
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
