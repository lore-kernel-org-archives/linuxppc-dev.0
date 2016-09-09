Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sW1TY2CkBzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 01:34:25 +1000 (AEST)
Date: Sat, 10 Sep 2016 00:34:18 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 hemant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] arch/powerpc : optprobes for powerpc core
Message-Id: <20160910003418.f4ce0035ccec76c5ec14eb4e@kernel.org>
In-Reply-To: <fd56afb9-c78e-521c-ef60-3e75cb6e24c7@linux.vnet.ibm.com>
References: <1473240792-10596-1-git-send-email-anju@linux.vnet.ibm.com>
 <1473240792-10596-3-git-send-email-anju@linux.vnet.ibm.com>
 <20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org>
 <fd56afb9-c78e-521c-ef60-3e75cb6e24c7@linux.vnet.ibm.com>
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

Hi Anju,

On Fri, 9 Sep 2016 16:19:41 +0530
Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote:
> >> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> >> +{
> >> +	arch_arm_kprobe(&op->kp);
> >> +}
> >> +
> >> +void arch_unoptimize_kprobes(struct list_head *oplist,
> >> +			     struct list_head *done_list)
> >> +{
> >> +	struct optimized_kprobe *op;
> >> +	struct optimized_kprobe *tmp;
> >> +
> >> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> >> +		arch_unoptimize_kprobe(op);
> >> +		list_move(&op->list, done_list);
> >> +	}
> >> +}
> >> +
> >> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
> >> +				 unsigned long addr)
> >> +{
> >> +	return 0;
> > Here, please check the address range as same as arm32 optprobe implementation.
> >
> > e.g.
> >          return ((unsigned long)op->kp.addr <= addr &&
> >                  (unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
> >
> >
> > Thank you,
> 
> Do we really need this? The only case this check will succeed is if  
> kp.addr is not a multiple of 4, which is not a valid address at all  
> onPower. So should we again check here for that?

Yes, since that is exported function, which means it can be used from
other part, other usage (e.g. for debug reason someone wants to use it).
Please do not optimize the code only for current implementation, but
for generic use case. 

Thank  you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
