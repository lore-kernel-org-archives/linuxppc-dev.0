Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 050ABB7CF8
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:13:27 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2UADRDg007043
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:13:27 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2UADR5H1888284
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:13:27 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2UADQLY024833
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:13:27 +1100
Date: Tue, 30 Mar 2010 15:42:34 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100330101234.GA14734@in.ibm.com>
References: <20100323140008.954823303@pr> <20100323140724.GC21836@in.ibm.com>
	<1269637905.4760.34.camel@norville.austin.ibm.com>
	<20100329113109.GA7854@in.ibm.com>
	<1269892416.28593.30.camel@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269892416.28593.30.camel@norville.austin.ibm.com>
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

On Mon, Mar 29, 2010 at 02:53:36PM -0500, Dave Kleikamp wrote:
> On Mon, 2010-03-29 at 17:01 +0530, K.Prasad wrote:
> > On Fri, Mar 26, 2010 at 04:11:45PM -0500, Dave Kleikamp wrote:
> > > On Tue, 2010-03-23 at 19:37 +0530, K.Prasad wrote:
> > > > plain text document attachment (ppc64_hbkpt_02)
> > > > Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
> > > > These interfaces help arbitrate requests from various users and schedules
> > > > them as appropriate.
> > > > 
> > > > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > > 
> > > SNIP
> > > 
> > > > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > > > ===================================================================
> > > > --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/cputable.h
> > > > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > > > @@ -511,6 +511,13 @@ static inline int cpu_has_feature(unsign
> > > >  		& feature);
> > > >  }
> > > > 
> > > > +#define CPU_FTR_HAS_DABR (defined(CONFIG_PPC64) && \
> > > > +			  !defined(CONFIG_PPC_ADV_DEBUG_REGS))
> > > > +#ifdef CPU_FTR_HAS_DABR
> > > > +/* Number of physical HW breakpoint registers */
> > > > +#define HBP_NUM 1
> > > > +#endif
> > > > +
> > > >  #endif /* !__ASSEMBLY__ */
> > > > 
> > > >  #endif /* __KERNEL__ */
> > > 
> > > These new defines don't really correlate to the cpu table.  One would
> > > expect cpu_has_feature(CPU_FTR_HAS_DABR) to have meaning, but it would
> > > have to be defined similar to the other CPU_FTR_ constants, and or-ed
> > > with CPU_FTRS_ALWAYS (when appropriate).
> > > 
> > 
[snipped] 
> > There are a few issues with such an approach:
> > i) Two such fields would be required in 'struct cpu_spec' - one for
> > instruction breakpoints and other for data.
> > ii) As pointed out by you below, hbp_num or num_hw_brkpts would always
> > be assigned to the compile time constant HBP_NUM (hence a variable is not
> > required to store it).
> > iii) HBP_NUM still cannot be entirely removed as it is used by generic
> > kernel/hw_breakpoint.c code (and is used by x86 code as well).
> > 
> > I think the simplest approach would be to have the following entry in
> > cputable.h (and get away with the rest of the additions seen in patch
> > ver XV)
> > 
> > #ifdef CONFIG_PPC_BOOK3S_64
> > #define HBP_NUM 1
> > #endif
> > 
> > The next version of the patch should contain changes to that effect
> > (assuming I hear no objections).
> 
> I just don't think this belongs in cputable.h.  Why not put this in
> hw_breakpoint.h?
>

HBP_NUM was originally defined in hw_breakpoint.h (until ver XIV) but 
was moved to cputable.h as it introduces a duplicate definition in 
processor.h (which is how it is done in the x86 implementation).
linux/hw_breakpoint.h inclusion in processor.h, to circumvent the
duplication leads to circular dependancies w.r.t. declarations.

I think leaving it in cputable.h (as in version XVI of the patch sent 
here: message-id:20100330095809.GA14403@in.ibm.com) gives us a much
cleaner implementation (than x86 which has duplicate HBP_NUM definitions).

Thanks,
K.Prasad
