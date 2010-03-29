Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DF19B7C06
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 06:54:08 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2TJlCAL001145
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 13:47:12 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o2TJrgBr102182
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 13:53:51 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2TJrfSM018925
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 13:53:42 -0600
Subject: Re: [RFC Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: prasad@linux.vnet.ibm.com
In-Reply-To: <20100329113109.GA7854@in.ibm.com>
References: <20100323140008.954823303@pr> <20100323140724.GC21836@in.ibm.com>
	<1269637905.4760.34.camel@norville.austin.ibm.com>
	<20100329113109.GA7854@in.ibm.com>
Content-Type: text/plain
Date: Mon, 29 Mar 2010 14:53:36 -0500
Message-Id: <1269892416.28593.30.camel@norville.austin.ibm.com>
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

On Mon, 2010-03-29 at 17:01 +0530, K.Prasad wrote:
> On Fri, Mar 26, 2010 at 04:11:45PM -0500, Dave Kleikamp wrote:
> > On Tue, 2010-03-23 at 19:37 +0530, K.Prasad wrote:
> > > plain text document attachment (ppc64_hbkpt_02)
> > > Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
> > > These interfaces help arbitrate requests from various users and schedules
> > > them as appropriate.
> > > 
> > > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > 
> > SNIP
> > 
> > > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > > ===================================================================
> > > --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/cputable.h
> > > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > > @@ -511,6 +511,13 @@ static inline int cpu_has_feature(unsign
> > >  		& feature);
> > >  }
> > > 
> > > +#define CPU_FTR_HAS_DABR (defined(CONFIG_PPC64) && \
> > > +			  !defined(CONFIG_PPC_ADV_DEBUG_REGS))
> > > +#ifdef CPU_FTR_HAS_DABR
> > > +/* Number of physical HW breakpoint registers */
> > > +#define HBP_NUM 1
> > > +#endif
> > > +
> > >  #endif /* !__ASSEMBLY__ */
> > > 
> > >  #endif /* __KERNEL__ */
> > 
> > These new defines don't really correlate to the cpu table.  One would
> > expect cpu_has_feature(CPU_FTR_HAS_DABR) to have meaning, but it would
> > have to be defined similar to the other CPU_FTR_ constants, and or-ed
> > with CPU_FTRS_ALWAYS (when appropriate).
> > 
> 
> The code can be changed as below:
> 
> #if (defined(CONFIG_PPC64) && !defined(CONFIG_PPC_ADV_DEBUG_REGS))
> #define CPU_FTR_HAS_DABR 1
> /* Number of physical HW breakpoint registers */
> #define HBP_NUM 1
> #endif
> 
> However, a config option CONFIG_PPC_BOOK3S_64 (I just found) whose scope
> includes only 64-bit server processors (having one DABR) to be the most
> suitable.
> 
> I think it must be used in lieu of introducing a new CPU_FTR_HAS_DABR
> definition in cputable.h
> 
> 
> > Similarly, I would expect the cpu_spec structure to have a new field,
> > hbp_num, which is initialized in cputable.c.  Maybe a longer name would
> > be better, num_hw_brkpts?
> > 
> 
> There are a few issues with such an approach:
> i) Two such fields would be required in 'struct cpu_spec' - one for
> instruction breakpoints and other for data.
> ii) As pointed out by you below, hbp_num or num_hw_brkpts would always
> be assigned to the compile time constant HBP_NUM (hence a variable is not
> required to store it).
> iii) HBP_NUM still cannot be entirely removed as it is used by generic
> kernel/hw_breakpoint.c code (and is used by x86 code as well).
> 
> I think the simplest approach would be to have the following entry in
> cputable.h (and get away with the rest of the additions seen in patch
> ver XV)
> 
> #ifdef CONFIG_PPC_BOOK3S_64
> #define HBP_NUM 1
> #endif
> 
> The next version of the patch should contain changes to that effect
> (assuming I hear no objections).

I just don't think this belongs in cputable.h.  Why not put this in
hw_breakpoint.h?

-- 
David Kleikamp
IBM Linux Technology Center
