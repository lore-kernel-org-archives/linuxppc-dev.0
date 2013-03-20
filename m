Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 500FA2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 23:28:50 +1100 (EST)
Date: Wed, 20 Mar 2013 13:26:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130320122639.GA29541@redhat.com>
References: <20130320104033.GA19844@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320104033.GA19844@in.ibm.com>
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

Hi Ananth,

First of all, let me remind that I know nothing about powerpc ;)

But iirc we already discussed this a bit, I forgot the details but
still I have some concerns...

On 03/20, Ananth N Mavinakayanahalli wrote:
>
> GDB uses a variant of the trap instruction that is different from the
> one used by uprobes. Currently, running gdb on a program being traced
> by uprobes causes an endless loop since uprobes doesn't understand
> that the trap is inserted by some other entity and hence a SIGTRAP needs
> to be delivered.

Yes, and thus is_swbp_at_addr()->is_swbp_insn() called by handle_swbp()
should be updated,

> +bool is_swbp_insn(uprobe_opcode_t *insn)
> +{
> +	return (is_trap(*insn));
> +}

And this patch should fix the problem. (and probably this is fine
for prepare_uprobe()).


But, at the same time, is the new definition fine for verify_opcode()?

IOW, powerpc has another is_trap() insn(s) used by gdb, lets denote it X.
X != UPROBE_SWBP_INSN.

Suppose that gdb installs the trap X at some addr, and then uprobe_register()
tries to install uprobe at the same address. Then set_swbp() will do nothing,
assuming the uprobe was already installed.

But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
verify. If not, we need 2 definitions. is_uprobe_insn() should still check
insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().

And I am just curious, could you explain how X and UPROBE_SWBP_INSN
differ?

Oleg.
