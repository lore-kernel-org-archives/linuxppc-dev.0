Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9D1CB7CEE
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 08:11:55 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2QL5DZ8014101
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 15:05:13 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2QLBlj8139946
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 15:11:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2QLBk7O001796
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 15:11:47 -0600
Subject: Re: [RFC Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
In-Reply-To: <20100323140724.GC21836@in.ibm.com>
References: <20100323140008.954823303@pr> <20100323140724.GC21836@in.ibm.com>
Content-Type: text/plain
Date: Fri, 26 Mar 2010 16:11:45 -0500
Message-Id: <1269637905.4760.34.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-23 at 19:37 +0530, K.Prasad wrote:
> plain text document attachment (ppc64_hbkpt_02)
> Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
> These interfaces help arbitrate requests from various users and schedules
> them as appropriate.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>

SNIP

> Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/cputable.h
> +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> @@ -511,6 +511,13 @@ static inline int cpu_has_feature(unsign
>  		& feature);
>  }
> 
> +#define CPU_FTR_HAS_DABR (defined(CONFIG_PPC64) && \
> +			  !defined(CONFIG_PPC_ADV_DEBUG_REGS))
> +#ifdef CPU_FTR_HAS_DABR
> +/* Number of physical HW breakpoint registers */
> +#define HBP_NUM 1
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
> 
>  #endif /* __KERNEL__ */

These new defines don't really correlate to the cpu table.  One would
expect cpu_has_feature(CPU_FTR_HAS_DABR) to have meaning, but it would
have to be defined similar to the other CPU_FTR_ constants, and or-ed
with CPU_FTRS_ALWAYS (when appropriate).

Similarly, I would expect the cpu_spec structure to have a new field,
hbp_num, which is initialized in cputable.c.  Maybe a longer name would
be better, num_hw_brkpts?

When I added the PPC_ADV_DEBUG config options for the bookE features, I
didn't see an immediate need to clutter the cputable since their values
are fixed at compile time.  We should be consistent with these, but
unless we are going to determine any of these at run-time, I don't know
that they belong in the cpu table.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
