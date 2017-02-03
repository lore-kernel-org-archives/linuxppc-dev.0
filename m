Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFRz36cxYzDqBj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 06:39:59 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v13JY89A072191
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 14:39:57 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28cy6nj0gg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 14:39:57 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 4 Feb 2017 01:09:53 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 21094E005A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 01:11:15 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v13JctO112517622
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 Feb 2017 01:08:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v13JdpHo032656
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 Feb 2017 01:09:52 +0530
Date: Sat, 4 Feb 2017 01:09:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com,
 mahesh@linux.vnet.ibm.com, paulus@samba.org, mhiramat@kernel.org,
 srikar@linux.vnet.ibm.com
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
 <87a8a6dvwo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a8a6dvwo.fsf@concordia.ellerman.id.au>
Message-Id: <20170203193949.GD4090@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
Thanks for the review! I'll defer to Anju on most of the aspects, but...

On 2017/02/01 09:53PM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> 
> > +static void optimized_callback(struct optimized_kprobe *op,
> > +			       struct pt_regs *regs)
> > +{
> > +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> > +	unsigned long flags;
> > +
> > +	/* This is possible if op is under delayed unoptimizing */
> > +	if (kprobe_disabled(&op->kp))
> > +		return;
> > +
> > +	local_irq_save(flags);
> 
> What is that protecting against? Because on powerpc it doesn't actually
> disable interrupts, it just masks some of them, the perf interrupt for
> example can still run.

That's an excellent catch, as always! :)

This is meant to prevent us from missing kprobe hits while processing 
interrupts that arrive when this optprobe is being handled. And you are 
totally right -- we would miss kprobe hits during PMI handling with the 
current approach. We need a hard_irq_disable() there.

> > +	/*
> > +	 * Optprobe template:
> > +	 * This template gets copied into one of the slots in optinsn_slot
> > +	 * and gets fixed up with real optprobe structures et al.
> > +	 */
> > +	.global optprobe_template_entry
> > +optprobe_template_entry:
> > +	/* Create an in-memory pt_regs */
> > +	stdu	r1,-INT_FRAME_SIZE(r1)
> > +	SAVE_GPR(0,r1)
> > +	/* Save the previous SP into stack */
> > +	addi	r0,r1,INT_FRAME_SIZE
> > +	std	r0,GPR1(r1)
> > +	SAVE_10GPRS(2,r1)
> > +	SAVE_10GPRS(12,r1)
> > +	SAVE_10GPRS(22,r1)
> > +	/* Save SPRS */
> > +	mfmsr	r5
> > +	std	r5,_MSR(r1)
> > +	li	r5,0x700
> > +	std	r5,_TRAP(r1)
> > +	li	r5,0
> > +	std	r5,ORIG_GPR3(r1)
> > +	std	r5,RESULT(r1)
> > +	mfctr	r5
> > +	std	r5,_CTR(r1)
> > +	mflr	r5
> > +	std	r5,_LINK(r1)
> > +	mfspr	r5,SPRN_XER
> > +	std	r5,_XER(r1)
> > +	mfcr	r5
> > +	std	r5,_CCR(r1)
> > +	lbz     r5,PACASOFTIRQEN(r13)
> > +	std     r5,SOFTE(r1)
> > +	mfdar	r5
> > +	std	r5,_DAR(r1)
> > +	mfdsisr	r5
> > +	std	r5,_DSISR(r1)
> 
> So this is what made me originally reply to this patch. This
> save/restore sequence.
> 
> I'm not clear on why this is what we need to save/restore.
> 
> Aren't we essentially just interposing a function call? If so do we need
> to save/restore all of these? eg. MSR/DAR/DSISR. Non-volatile GPRs? And
> why are we pretending there was a 0x700 trap?
> 
> Is it because we're going to end up emulating the instruction and so we
> need everything in pt_regs ?

Yes, that and also for the kprobe pre_handler() which takes pt_regs.


Regards,
- Naveen
