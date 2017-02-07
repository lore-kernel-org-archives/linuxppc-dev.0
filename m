Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHc4Q1hmQzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 18:52:06 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v177hnPi113390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 02:52:03 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28f86uc74v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 02:52:03 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 13:21:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 65F7AE0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:23:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v177puJa35979458
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 13:21:56 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v177pskr011702
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 13:21:55 +0530
Date: Tue, 7 Feb 2017 13:21:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
 <87a8a6dvwo.fsf@concordia.ellerman.id.au>
 <20170203193949.GD4090@naverao1-tp.localdomain>
 <20170207100541.7860e846f3def13a628bb05d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170207100541.7860e846f3def13a628bb05d@kernel.org>
Message-Id: <20170207075153.GI4090@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/07 10:05AM, Masami Hiramatsu wrote:
> On Sat, 4 Feb 2017 01:09:49 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Hi Michael,
> > Thanks for the review! I'll defer to Anju on most of the aspects, but...
> > 
> > On 2017/02/01 09:53PM, Michael Ellerman wrote:
> > > Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> > > 
> > > > +static void optimized_callback(struct optimized_kprobe *op,
> > > > +			       struct pt_regs *regs)
> > > > +{
> > > > +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> > > > +	unsigned long flags;
> > > > +
> > > > +	/* This is possible if op is under delayed unoptimizing */
> > > > +	if (kprobe_disabled(&op->kp))
> > > > +		return;
> > > > +
> > > > +	local_irq_save(flags);
> > > 
> > > What is that protecting against? Because on powerpc it doesn't actually
> > > disable interrupts, it just masks some of them, the perf interrupt for
> > > example can still run.
> > 
> > That's an excellent catch, as always! :)
> > 
> > This is meant to prevent us from missing kprobe hits while processing 
> > interrupts that arrive when this optprobe is being handled. And you are 
> > totally right -- we would miss kprobe hits during PMI handling with the 
> > current approach. We need a hard_irq_disable() there.
> 
> One note: it depends on the arch implementation of kprobes, since this
> is only for "emulating" the int3 behavior on x86 for compatibility.
> On x86, int3 is disabling interrupt automatically, so all the kprobes
> user handlers will be run under irq-disabled. This means that user may
> write their code to run as such condition. They even can not know
> that is optimized or not at programming timing, because the kprobe
> will be optimized after a while from enabled it.
> 
> So the important point is that you have to keep it compatible of
> unoptimized kprobes.

Thanks for the pointers, Masami.
Yes, with unoptimized kprobes on powerpc, we run with interrupts hard 
disabled as well. So, we need to hard disable for optprobes too.

Regards,
Naveen
