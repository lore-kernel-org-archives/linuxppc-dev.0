Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2737B7CED
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 22:31:14 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2TBVChc000751
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 17:01:12 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2TBVBGc3203112
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 17:01:12 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2TBVBif005454
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 22:31:11 +1100
Date: Mon, 29 Mar 2010 17:01:09 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100329113109.GA7854@in.ibm.com>
References: <20100323140008.954823303@pr> <20100323140724.GC21836@in.ibm.com>
	<1269637905.4760.34.camel@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269637905.4760.34.camel@norville.austin.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 04:11:45PM -0500, Dave Kleikamp wrote:
> On Tue, 2010-03-23 at 19:37 +0530, K.Prasad wrote:
> > plain text document attachment (ppc64_hbkpt_02)
> > Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
> > These interfaces help arbitrate requests from various users and schedules
> > them as appropriate.
> > 
> > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> 
> SNIP
> 
> > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/cputable.h
> > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > @@ -511,6 +511,13 @@ static inline int cpu_has_feature(unsign
> >  		& feature);
> >  }
> > 
> > +#define CPU_FTR_HAS_DABR (defined(CONFIG_PPC64) && \
> > +			  !defined(CONFIG_PPC_ADV_DEBUG_REGS))
> > +#ifdef CPU_FTR_HAS_DABR
> > +/* Number of physical HW breakpoint registers */
> > +#define HBP_NUM 1
> > +#endif
> > +
> >  #endif /* !__ASSEMBLY__ */
> > 
> >  #endif /* __KERNEL__ */
> 
> These new defines don't really correlate to the cpu table.  One would
> expect cpu_has_feature(CPU_FTR_HAS_DABR) to have meaning, but it would
> have to be defined similar to the other CPU_FTR_ constants, and or-ed
> with CPU_FTRS_ALWAYS (when appropriate).
> 

The code can be changed as below:

#if (defined(CONFIG_PPC64) && !defined(CONFIG_PPC_ADV_DEBUG_REGS))
#define CPU_FTR_HAS_DABR 1
/* Number of physical HW breakpoint registers */
#define HBP_NUM 1
#endif

However, a config option CONFIG_PPC_BOOK3S_64 (I just found) whose scope
includes only 64-bit server processors (having one DABR) to be the most
suitable.

I think it must be used in lieu of introducing a new CPU_FTR_HAS_DABR
definition in cputable.h


> Similarly, I would expect the cpu_spec structure to have a new field,
> hbp_num, which is initialized in cputable.c.  Maybe a longer name would
> be better, num_hw_brkpts?
> 

There are a few issues with such an approach:
i) Two such fields would be required in 'struct cpu_spec' - one for
instruction breakpoints and other for data.
ii) As pointed out by you below, hbp_num or num_hw_brkpts would always
be assigned to the compile time constant HBP_NUM (hence a variable is not
required to store it).
iii) HBP_NUM still cannot be entirely removed as it is used by generic
kernel/hw_breakpoint.c code (and is used by x86 code as well).

I think the simplest approach would be to have the following entry in
cputable.h (and get away with the rest of the additions seen in patch
ver XV)

#ifdef CONFIG_PPC_BOOK3S_64
#define HBP_NUM 1
#endif

The next version of the patch should contain changes to that effect
(assuming I hear no objections).

> When I added the PPC_ADV_DEBUG config options for the bookE features, I
> didn't see an immediate need to clutter the cputable since their values
> are fixed at compile time.  We should be consistent with these, but

It is even more true with ppc64-server processors, where the number of
debug registers (denoted by HBP_NUM) is fixed to 1 (unlike BookE where the
DACs can be used in standalone or as a pair of registers).

> unless we are going to determine any of these at run-time, I don't know
> that they belong in the cpu table.
>
> Thanks,
> Shaggy
> -- 

Thanks,
K.Prasad
