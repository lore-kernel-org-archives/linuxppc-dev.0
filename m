Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rB5TZ3yqwzDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 21:35:30 +1000 (AEST)
Date: Fri, 20 May 2016 20:35:15 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 masami.hiramatsu.pt@hitachi.com, jkenisto@us.ibm.com,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 hemant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 2/3] arch/powerpc : optprobes for powerpc core
Message-Id: <20160520203515.d1e2e752f59fcc3d3e72e69c@kernel.org>
In-Reply-To: <573D7016.2050900@linux.vnet.ibm.com>
References: <1463517578-27760-1-git-send-email-anju@linux.vnet.ibm.com>
 <1463517578-27760-3-git-send-email-anju@linux.vnet.ibm.com>
 <20160519001304.c7104e18062b324651c97260@kernel.org>
 <573D7016.2050900@linux.vnet.ibm.com>
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

On Thu, 19 May 2016 13:19:42 +0530
Anju T <anju@linux.vnet.ibm.com> wrote:

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
> > Please make sure addr != op->kp.addr and addr is aligned.
> 
> The only case this check will succeed is if kp.addr is not a multiple of 4, which is not a valid address at all on
> Power.So should we again check here for that?

Ah, right. OK, so we may not need that.

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
