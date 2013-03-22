Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7C7582C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 01:56:21 +1100 (EST)
Date: Fri, 22 Mar 2013 15:54:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/3] uprobes: add trap variant helper
Message-ID: <20130322145406.GB17286@redhat.com>
References: <20130322114446.GG26183@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322114446.GG26183@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22, Ananth N Mavinakayanahalli wrote:
>
> +/**
> + * is_trap_insn - check if instruction is breakpoint instruction.
> + * @insn: instruction to be checked.
> + * Default implementation of is_trap_insn
> + * Returns true if @insn is a breakpoint instruction.
> + *
> + * This function is needed for the case where an architecture has multiple
> + * trap instructions (like powerpc).
> + */
> +bool __weak is_trap_insn(uprobe_opcode_t *insn)
> +{
> +	return is_swbp_insn(insn);
> +}

OK, thanks, the whole series looks fine, just one note...

My patch also changed prepare_uprobe() to use is_trap_insn(), and I think
this is right. Exactly because of 3/3 which removes is_trap() from
arch_uprobe_analyze_insn().

If the original insn is_trap(), we do not want to singlestep it and get
another trap after we hit handle_swbp().

Oleg.
