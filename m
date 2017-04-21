Return-Path: <srs0=gslz=35=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8PzV5NtXzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 15:53:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w8PzV4c8rz8tBQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 15:53:10 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w8PzV1Vgmz9s4s
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2017 15:53:09 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3L5ml1e003052
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2017 01:53:07 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y27wvt9j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2017 01:53:07 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 15:52:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3L5qfsI16384064
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2017 15:52:49 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3L5qBx7000671
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2017 15:52:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: bhsharma@redhat.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] powerpc/mm: Add support for runtime configuration of
 ASLR limits
In-Reply-To: <1492698980-19510-1-git-send-email-mpe@ellerman.id.au>
References: <1492698980-19510-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 21 Apr 2017 11:21:52 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zifafguf.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Add powerpc support for mmap_rnd_bits and mmap_rnd_compat_bits, which are two
> sysctls that allow a user to configure the number of bits of randomness used for
> ASLR.
>
> Because of the way the Kconfig for ARCH_MMAP_RND_BITS is defined, we have to
> construct at least the MIN value in Kconfig, vs in a header which would be more
> natural. Given that we just go ahead and do it all in Kconfig.
>
> At least according to the code (the documentation makes no mention of it), the
> value is defined as the number of bits of randomisation *of the page*, not the
> address. This makes some sense, with larger page sizes more of the low bits are
> forced to zero, which would reduce the randomisation if we didn't take the
> PAGE_SIZE into account. However it does mean the min/max values have to change
> depending on the PAGE_SIZE in order to actually limit the amount of address
> space consumed by the randomisation.
>
> The result of that is that we have to define the default values based on both
> 32-bit vs 64-bit, but also the configured PAGE_SIZE. Furthermore now that we
> have 128TB address space support on Book3S, we also have to take that into
> account.
>
> Finally we can wire up the value in arch_mmap_rnd().
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/Kconfig   | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/mm/mmap.c | 11 ++++++-----
>  2 files changed, 50 insertions(+), 5 deletions(-)
>
> v2: Fix the 32-bit MAX value incorrectly using MIN as spotted by Kees.
>
> Kees/Bhupesh, would love a Review/Ack/Tested-by from you, I'll plan to merge
> this later today (Friday) my time.
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 97a8bc8a095c..6f0503951e94 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -22,6 +22,48 @@ config MMU
>  	bool
>  	default y
>  
> +config ARCH_MMAP_RND_BITS_MAX
> +	# On Book3S 64, the default virtual address space for 64-bit processes
> +	# is 2^47 (128TB). As a maximum, allow randomisation to consume up to
> +	# 32T of address space (2^45), which should ensure a reasonable gap
> +	# between bottom-up and top-down allocations for applications that
> +	# consume "normal" amounts of address space. Book3S 64 only supports 64K
> +	# and 4K page sizes.
> +	default 29 if PPC_BOOK3S_64 && PPC_64K_PAGES # 29 = 45 (32T) - 16 (64K)
> +	default 33 if PPC_BOOK3S_64		     # 33 = 45 (32T) - 12 (4K)
> +	#
> +	# On all other 64-bit platforms (currently only Book3E), the virtual
> +	# address space is 2^46 (64TB). Allow randomisation to consume up to 16T
> +	# of address space (2^44). Only 4K page sizes are supported.
> +	default 32 if 64BIT	# 32 = 44 (16T) - 12 (4K)
> +	#
> +	# For 32-bit, use the compat values, as they're the same.
> +	default ARCH_MMAP_RND_COMPAT_BITS_MAX
> +
> +config ARCH_MMAP_RND_BITS_MIN
> +	# Allow randomisation to consume up to 1GB of address space (2^30).
> +	default 14 if 64BIT && PPC_64K_PAGES	# 14 = 30 (1GB) - 16 (64K)
> +	default 18 if 64BIT			# 18 = 30 (1GB) - 12 (4K)
> +	#
> +	# For 32-bit, use the compat values, as they're the same.
> +	default ARCH_MMAP_RND_COMPAT_BITS_MIN
> +
> +config ARCH_MMAP_RND_COMPAT_BITS_MAX
> +	# Total virtual address space for 32-bit processes is 2^31 (2GB).
> +	# Allow randomisation to consume up to 512MB of address space (2^29).
> +	default 11 if PPC_256K_PAGES	# 11 = 29 (512MB) - 18 (256K)
> +	default 13 if PPC_64K_PAGES	# 13 = 29 (512MB) - 16 (64K)
> +	default 15 if PPC_16K_PAGES 	# 15 = 29 (512MB) - 14 (16K)
> +	default 17			# 17 = 29 (512MB) - 12 (4K)
> +
> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
> +	# Total virtual address space for 32-bit processes is 2^31 (2GB).
> +	# Allow randomisation to consume up to 8MB of address space (2^23).
> +	default 5 if PPC_256K_PAGES	#  5 = 23 (8MB) - 18 (256K)
> +	default 7 if PPC_64K_PAGES	#  7 = 23 (8MB) - 16 (64K)
> +	default 9 if PPC_16K_PAGES	#  9 = 23 (8MB) - 14 (16K)
> +	default 11			# 11 = 23 (8MB) - 12 (4K)
> +
>  config HAVE_SETUP_PER_CPU_AREA
>  	def_bool PPC64
>  
> @@ -120,6 +162,8 @@ config PPC
>  	select HAVE_ARCH_HARDENED_USERCOPY
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_KGDB
> +	select HAVE_ARCH_MMAP_RND_BITS
> +	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_CBPF_JIT			if !PPC64
> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> index a5d9ef59debe..6141cfff634e 100644
> --- a/arch/powerpc/mm/mmap.c
> +++ b/arch/powerpc/mm/mmap.c
> @@ -59,13 +59,14 @@ static inline int mmap_is_legacy(void)
>  
>  unsigned long arch_mmap_rnd(void)
>  {
> -	unsigned long rnd;
> +	unsigned long shift, rnd;
>  
> -	/* 8MB for 32bit, 1GB for 64bit */
> +	shift = mmap_rnd_bits;
> +#ifdef CONFIG_COMPAT
>  	if (is_32bit_task())
> -		rnd = get_random_long() % (1<<(23-PAGE_SHIFT));
> -	else
> -		rnd = get_random_long() % (1UL<<(30-PAGE_SHIFT));
> +		shift = mmap_rnd_compat_bits;
> +#endif
> +	rnd = get_random_long() % (1 << shift);
>  
>  	return rnd << PAGE_SHIFT;
>  }
> -- 
> 2.7.4
