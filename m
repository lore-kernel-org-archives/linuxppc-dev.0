Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkqZ13DFbzDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 13:49:44 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id o126so7657787pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 19:49:44 -0700 (PDT)
Date: Fri, 17 Mar 2017 12:49:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] powerpc/64s: fix POWER9 machine check handler from
 stop state
Message-ID: <20170317124927.2a628998@roar.ozlabs.ibm.com>
In-Reply-To: <67bd0a9f-ebaa-acdb-cfbf-8a4acba256a3@linux.vnet.ibm.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-5-npiggin@gmail.com>
 <67bd0a9f-ebaa-acdb-cfbf-8a4acba256a3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Mar 2017 18:10:48 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 03/14/2017 02:53 PM, Nicholas Piggin wrote:
> > The ISA specifies power save wakeup can cause a machine check interrupt.
> > The machine check handler currently has code to handle that for POWER8,
> > but POWER9 crashes when trying to execute the P8 style sleep
> > instructions.
> > 
> > So queue up the machine check, then call into the idle code to wake up
> > as the system reset interrupt does, rather than attempting to sleep
> > again without going through the main idle path.
> > 
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/reg.h       |  1 +
> >  arch/powerpc/kernel/exceptions-64s.S | 69 ++++++++++++++++++------------------
> >  2 files changed, 35 insertions(+), 35 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index fc879fd6bdae..8bbdfacce970 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -656,6 +656,7 @@
> >  #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
> >  #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
> >  #define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 and 9 */
> > +#define   SRR1_WAKEMCE_RESVD	0x003c0000 /* Unused/reserved value used by MCE wakeup to indicate cause to idle wakeup handler */
> >  #define   SRR1_WAKESYSERR	0x00300000 /* System error */
> >  #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
> >  #define   SRR1_WAKEHVI		0x00240000 /* Hypervisor Virtualization Interrupt (P9) */
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index e390fcd04bcb..5779d2d6a192 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -306,6 +306,33 @@ EXC_COMMON_BEGIN(machine_check_common)
> >  	/* restore original r1. */			\
> >  	ld	r1,GPR1(r1)
> > 
> > +#ifdef CONFIG_PPC_P7_NAP
> > +EXC_COMMON_BEGIN(machine_check_idle_common)
> > +	bl	machine_check_queue_event
> > +	/*
> > +	 * Queue the machine check, then reload SRR1 and use it to set
> > +	 * CR3 according to pnv_powersave_wakeup convention.
> > +	 */
> > +	ld	r12,_MSR(r1)
> > +	rlwinm	r11,r12,47-31,30,31
> > +	cmpwi	cr3,r11,2
> > +
> > +	/*
> > +	 * Now put SRR1_WAKEMCE_RESVD into SRR1, allows it to follow the
> > +	 * system reset wakeup code.
> > +	 */
> > +	oris	r12,r12,SRR1_WAKEMCE_RESVD@h
> > +	mtspr	SPRN_SRR1,r12
> > +	std	r12,_MSR(r1)
> > +
> > +	/*
> > +	 * Decrement MCE nesting after finishing with the stack.
> > +	 */
> > +	lhz	r11,PACA_IN_MCE(r13)
> > +	subi	r11,r11,1
> > +	sth	r11,PACA_IN_MCE(r13)  
> 
> Looks like we are not winding up.. Shouldn't we ? What if we may end up
> in pnv_wakeup_noloss() which assumes that no GPRs are lost. Am I missing
> anything ?

Hmm, on second look, I don't think any non-volatile GPRs are overwritten
in this path. But this MCE is a slow path, and it is a much longer path
than the system reset idle wakeup... So I'll add the napstatelost with
a comment.

Thanks,
Nick
