Return-Path: <ananth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNR9g65dPzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 15:28:23 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F4NdvA130870
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:28:21 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28m9wxkcjp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:28:21 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 21:28:20 -0700
Date: Wed, 15 Feb 2017 09:58:14 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: add support for KPROBES_ON_FTRACE
Reply-To: ananth@linux.vnet.ibm.com
References: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170215042814.GA4660@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2017 at 12:28:34AM +0530, Naveen N. Rao wrote:
> Allow kprobes to be placed on ftrace _mcount() call sites. This
> optimization avoids the use of a trap, by riding on ftrace
> infrastructure.
> 
> This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> MPROFILE_KERNEL, which is only currently enabled on powerpc64le with
> newer toolchains.
> 
> Based on the x86 code by Masami.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig                 |   1 +
>  arch/powerpc/include/asm/kprobes.h   |  10 ++++
>  arch/powerpc/kernel/Makefile         |   3 ++
>  arch/powerpc/kernel/kprobes-ftrace.c | 100 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/kprobes.c        |   4 +-
>  arch/powerpc/kernel/optprobes.c      |   3 ++
>  6 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/kernel/kprobes-ftrace.c

You'll also need to update
Documentation/features/debug/kprobes-on-ftrace/arch-support.txt

> +/* Ftrace callback handler for kprobes */
> +void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
> +			   struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +	unsigned long flags;
> +
> +	/* Disable irq for emulating a breakpoint and avoiding preempt */
> +	local_irq_save(flags);
> +	hard_irq_disable();
> +
> +	p = get_kprobe((kprobe_opcode_t *)nip);
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		goto end;
> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		unsigned long orig_nip = regs->nip;
> +		/* Kprobe handler expects regs->nip = nip + 1 as breakpoint hit */

Can you clarify this? On powerpc, the regs->nip at the time of
breakpoint hit points to the probed instruction, not the one after.

Ananth
