Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7E0671007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 02:14:43 +1000 (EST)
Date: Mon, 11 Jun 2012 18:12:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120611161215.GA12116@redhat.com>
References: <20120608093257.GG13409@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120608093257.GG13409@in.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 antonb@thinktux.localdomain, lkml <linux-kernel@vger.kernel.org>,
 michael@ellerman.id.au, Jim Keniston <jkenisto@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ananth, Srikar,

I think the patch is correct and I am sorry for nit-picking,
this is really minor.

But,

On 06/08, Ananth N Mavinakayanahalli wrote:
>
> Changes in V2:
> Pass (unsigned long)addr

Well, IMHO, this is confusing.

First of all, why do we have this "addr" or even "vaddr"? It should
not exists. We pass it to copy_insn(), but for what?? copy_insn()
should simply use uprobe->offset, the virtual address for this
particular mapping does not matter at all. I am going to send
the cleanup.

Note also that we should move this !UPROBE_COPY_INSN from
install_breakpoint() to somewhere near alloc_uprobe(). This code
is called only once, it looks a bit strange to use the "random" mm
(the first mm vma_prio_tree_foreach() finds) and its mapping to
verify the insn. In fact this is simply not correct and should be
fixed, note that on x86 arch_uprobe_analyze_insn() checks
mm->context.ia32_compat.

IOW, Perhaps uprobe->offset makes more sense?

> --- linux-3.5-rc1.orig/kernel/events/uprobes.c
> +++ linux-3.5-rc1/kernel/events/uprobes.c
> @@ -697,7 +697,7 @@ install_breakpoint(struct uprobe *uprobe
>  		if (is_swbp_insn((uprobe_opcode_t *)uprobe->arch.insn))
>  			return -EEXIST;
>
> -		ret = arch_uprobe_analyze_insn(&uprobe->arch, mm);
> +		ret = arch_uprobe_analyze_insn(&uprobe->arch, mm, addr);

Just fyi, this conflicts with
"[PATCH 1/3] uprobes: install_breakpoint() should fail if is_swbp_insn() == T"
I sent, but the conflict is trivial.

Oleg.
