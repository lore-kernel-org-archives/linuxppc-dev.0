Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 192E7B7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  9 May 2011 08:16:23 +1000 (EST)
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Eckelmann <sven@narfation.org>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 May 2011 08:15:39 +1000
Message-ID: <1304892939.2513.503.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m68k@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	linux-ia64@vger.kernel.org, linux-cris-kernel@axis.com,
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>,
	David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-03 at 23:30 +0200, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

For arch/powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(Sorry for catching up late)

Cheers,
Ben.

> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index b8f152e..906f49a 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -213,6 +213,7 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
>  }
>  
>  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>  
>  #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
>  #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
> @@ -469,6 +470,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>  }
>  
>  #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
>  
>  #else  /* __powerpc64__ */
>  #include <asm-generic/atomic64.h>
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
> index c2410af..3d4c58a 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -134,6 +134,7 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
>  }
>  
>  #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
> +#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
>  
>  #define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
>  #define local_dec_and_test(l)		(local_dec_return((l)) == 0)
