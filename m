Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id E35C72C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 23:45:11 +1100 (EST)
Date: Wed, 20 Mar 2013 13:43:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130320124301.GA30887@redhat.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320122639.GA29541@redhat.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/20, Oleg Nesterov wrote:
>
> But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().
>
> And I am just curious, could you explain how X and UPROBE_SWBP_INSN
> differ?

IOW, if I wasn't clear... Lets forget about gdb/etc for the moment.
Suppose we apply the patch below. Will uprobes on powerpc work?

If yes, then your patch should be fine. If not, we probably need more
changes.

And, forgot to mention. If you change is_swbp_insn(), you can remove
is_trap() from arch_uprobe_analyze_insn().

Oleg.

--- x/arch/powerpc/include/asm/uprobes.h
+++ x/arch/powerpc/include/asm/uprobes.h
@@ -31,7 +31,7 @@ typedef ppc_opcode_t uprobe_opcode_t;
 #define UPROBE_XOL_SLOT_BYTES	(MAX_UINSN_BYTES)
 
 /* The following alias is needed for reference from arch-agnostic code */
-#define UPROBE_SWBP_INSN	BREAKPOINT_INSTRUCTION
+#define UPROBE_SWBP_INSN	TRAP_INSN_USED_BY_GDB
 #define UPROBE_SWBP_INSN_SIZE	4 /* swbp insn size in bytes */
 
 struct arch_uprobe {
