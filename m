Return-Path: <bhelgaas@google.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68BE51A0329
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 10:42:53 +1100 (EST)
Received: by mail-qg0-f43.google.com with SMTP id j107so1745452qga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 16:42:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141015170650.4063.2816.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170650.4063.2816.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Oct 2014 17:42:30 -0600
Message-ID: <CAErSpo4upmuUW5u6XdmYXbfcf7HVcxdt_8=9+9MF0_icff_HLQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] uprobes: Remove "weak" from function declarations
To: Jason Wessel <jason.wessel@windriver.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Ingo Molnar <mingo@redhat.com>, John Stultz <john.stultz@linaro.org>,
 Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Russell King <linux@arm.linux.org.uk>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Victor Kamensky <victor.kamensky@linaro.org>, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "David A. Long" <dave.long@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Victor, Oleg, David, Srikar, Ananth, Russell, linux-arm-kernel,
Ben, Paul, Michael, linuxppc-dev.  arm and powerpc define some of
these functions and are at risk for this issue.]

On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> For the following interfaces:
>
>   set_swbp()
>   set_orig_insn()
>   is_swbp_insn()
>   is_trap_insn()
>   uprobe_get_swbp_addr()
>   arch_uprobe_ignore()
>   arch_uprobe_copy_ixol()
>
> kernel/events/uprobes.c provides default definitions explicitly marked
> "weak".  Some architectures provide their own definitions intended to
> override the defaults, but the "weak" attribute on the declarations applied
> to the arch definitions as well, so the linker chose one based on link
> order (see 10629d711ed7 ("PCI: Remove __weak annotation from
> pcibios_get_phb_of_node decl")).
>
> Remove the "weak" attribute from the declarations so we always prefer a
> non-weak definition over the weak one, independent of link order.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Victor Kamensky <victor.kamensky@linaro.org>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: David A. Long <dave.long@linaro.org>
> CC: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> CC: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> ---
>  include/linux/uprobes.h |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 4f844c6b03ee..60beb5dc7977 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -98,11 +98,11 @@ struct uprobes_state {
>         struct xol_area         *xol_area;
>  };
>
> -extern int __weak set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
> -extern int __weak set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
> -extern bool __weak is_swbp_insn(uprobe_opcode_t *insn);
> -extern bool __weak is_trap_insn(uprobe_opcode_t *insn);
> -extern unsigned long __weak uprobe_get_swbp_addr(struct pt_regs *regs);
> +extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
> +extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
> +extern bool is_swbp_insn(uprobe_opcode_t *insn);
> +extern bool is_trap_insn(uprobe_opcode_t *insn);
> +extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> @@ -128,8 +128,8 @@ extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
>  extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
>  extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
> -extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
> -extern void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> +extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
> +extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>                                          void *src, unsigned long len);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>
