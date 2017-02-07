Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHR3j57yRzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 12:05:53 +1100 (AEDT)
Date: Tue, 7 Feb 2017 10:05:41 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anju T Sudhakar
 <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com,
 mahesh@linux.vnet.ibm.com, paulus@samba.org, mhiramat@kernel.org,
 srikar@linux.vnet.ibm.com
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
Message-Id: <20170207100541.7860e846f3def13a628bb05d@kernel.org>
In-Reply-To: <20170203193949.GD4090@naverao1-tp.localdomain>
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
 <87a8a6dvwo.fsf@concordia.ellerman.id.au>
 <20170203193949.GD4090@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 4 Feb 2017 01:09:49 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Hi Michael,
> Thanks for the review! I'll defer to Anju on most of the aspects, but...
> 
> On 2017/02/01 09:53PM, Michael Ellerman wrote:
> > Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> > 
> > > +static void optimized_callback(struct optimized_kprobe *op,
> > > +			       struct pt_regs *regs)
> > > +{
> > > +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> > > +	unsigned long flags;
> > > +
> > > +	/* This is possible if op is under delayed unoptimizing */
> > > +	if (kprobe_disabled(&op->kp))
> > > +		return;
> > > +
> > > +	local_irq_save(flags);
> > 
> > What is that protecting against? Because on powerpc it doesn't actually
> > disable interrupts, it just masks some of them, the perf interrupt for
> > example can still run.
> 
> That's an excellent catch, as always! :)
> 
> This is meant to prevent us from missing kprobe hits while processing 
> interrupts that arrive when this optprobe is being handled. And you are 
> totally right -- we would miss kprobe hits during PMI handling with the 
> current approach. We need a hard_irq_disable() there.

One note: it depends on the arch implementation of kprobes, since this
is only for "emulating" the int3 behavior on x86 for compatibility.
On x86, int3 is disabling interrupt automatically, so all the kprobes
user handlers will be run under irq-disabled. This means that user may
write their code to run as such condition. They even can not know
that is optimized or not at programming timing, because the kprobe
will be optimized after a while from enabled it.

So the important point is that you have to keep it compatible of
unoptimized kprobes.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
