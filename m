Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqkfF326KzDqZJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 00:24:21 +1000 (AEST)
Date: Wed, 20 Apr 2016 16:24:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160420142408.GF3430@twins.programming.kicks-ass.net>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <571782F0.2020201@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 09:24:00PM +0800, Pan Xinhui wrote:

> +#define __XCHG_GEN(cmp, type, sfx, skip, v)				\
> +static __always_inline unsigned long					\
> +__cmpxchg_u32##sfx(v unsigned int *p, unsigned long old,		\
> +			 unsigned long new);				\
> +static __always_inline u32						\
> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
> +{									\
> +	int size = sizeof (type);					\
> +	int off = (unsigned long)ptr % sizeof(u32);			\
> +	volatile u32 *p = ptr - off;					\
> +	int bitoff = BITOFF_CAL(size, off);				\
> +	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
> +	u32 oldv, newv, tmp;						\
> +	u32 ret;							\
> +	oldv = READ_ONCE(*p);						\
> +	do {								\
> +		ret = (oldv & bitmask) >> bitoff;			\
> +		if (skip && ret != old)					\
> +			break;						\
> +		newv = (oldv & ~bitmask) | (new << bitoff);		\
> +		tmp = oldv;						\
> +		oldv = __cmpxchg_u32##sfx((v u32*)p, oldv, newv);	\
> +	} while (tmp != oldv);						\
> +	return ret;							\
> +}

So for an LL/SC based arch using cmpxchg() like that is sub-optimal.

Why did you choose to write it entirely in C?
