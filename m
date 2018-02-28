Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrsdX2KKBzF1Yy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 21:44:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc: Don't do runtime futex_cmpxchg test
In-Reply-To: <20180226140950.12111-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180226140950.12111-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 21:44:47 +1100
Message-ID: <874lm14cm8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> futex_detect_cmpxchg() does a cmpxchg_futex_value_locked on a NULL user addr to
> runtime detect whether architecture implements atomic cmpxchg for futex. POWER
> do implement the feature and hence we can enable the config instead of depending
> on runtime detection.
>
> We could possible enable this on everything. For now limitted to book3s_64
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/Kconfig.cputype | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index a429d859f15d..31bc2bd5dfd1 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -75,6 +75,7 @@ config PPC_BOOK3S_64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select IRQ_WORK
>  	select HAVE_KERNEL_XZ
> +	select HAVE_FUTEX_CMPXCHG if FUTEX
  
I'd rather it was under config PPC with an if BOOK3S_64 check. Just so
that all those top-level style configs are in once place.

eg.

config PPC
	...
	select HAVE_FUTEX_CMPXCHG if FUTEX && PPC_BOOK3S_64

cheers
