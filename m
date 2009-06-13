Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 08565B70F7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 07:54:10 +1000 (EST)
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 46920DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 07:54:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
Date: Sat, 13 Jun 2009 23:53:38 +0200
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
In-Reply-To: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906132353.39269.arnd@arndb.de>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 13 June 2009, Paul Mackerras wrote:
> +extern long long atomic64_read(const atomic64_t *v);
> +extern void     atomic64_set(atomic64_t *v, long long i);
> +extern void     atomic64_add(long long a, atomic64_t *v);
> +extern long long atomic64_add_return(long long a, atomic64_t *v);
> +extern void     atomic64_sub(long long a, atomic64_t *v);
> +extern long long atomic64_sub_return(long long a, atomic64_t *v);
> +extern long long atomic64_dec_if_positive(atomic64_t *v);
> +extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
> +extern long long atomic64_xchg(atomic64_t *v, long long new);
> +extern int      atomic64_add_unless(atomic64_t *v, long long a, long long u);
> +
> +#define atomic64_add_negative(a, v)    (atomic64_add_return((a), (v)) < 0)
> +#define atomic64_inc(v)                        atomic64_add(1LL, (v))
> +#define atomic64_inc_return(v)         atomic64_add_return(1LL, (v))
> +#define atomic64_inc_and_test(v)       (atomic64_inc_return(v) == 0)
> +#define atomic64_sub_and_test(a, v)    (atomic64_sub_return((a), (v)) == 0)
> +#define atomic64_dec(v)                        atomic64_sub(1LL, (v))
> +#define atomic64_dec_return(v)         atomic64_sub_return(1LL, (v))
> +#define atomic64_dec_and_test(v)       (atomic64_dec_return((v)) == 0)
> +#define atomic64_inc_not_zero(v)       atomic64_add_unless((v), 1LL, 0LL)
> +

How about also doing these:?

#define atomic64_sub(a, v)		atomic64_add(-a, v)
#define atomic64_sub_return(a, v)	atomic64_add_return(-a, v)
#define atomic64_add(a, v)		(void)atomic64_add_return(a, v)

The cost to the caller (one or two instruction per call site)
seems to be about the same as for the other wrapper macros.

	Arnd <><
