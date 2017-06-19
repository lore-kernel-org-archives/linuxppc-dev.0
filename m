Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqqh1cdnzDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:22:40 +1000 (AEST)
In-Reply-To: <354168131ffd13a9109172f616255fe1e0983387.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v2,
 3/4] powerpc/kprobes_on_ftrace: Skip livepatch_handler() for jprobes
Message-Id: <3wrqqh0yNKz9s89@ozlabs.org>
Date: Mon, 19 Jun 2017 22:22:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 10:48:17 UTC, "Naveen N. Rao" wrote:
> ftrace_caller() depends on a modified regs->nip to detect if a certain
> function has been livepatched. However, with KPROBES_ON_FTRACE, it is
> possible for regs->nip to have been modified by the kprobes pre_handler
> (jprobes, for instance). In this case, we do not want to invoke the
> livepatch_handler so as not to consume the livepatch stack.
> 
> To distinguish between the two (kprobes and livepatch), we check if
> there is an active kprobe on the current function. If there is, then we
> know for sure that it must have modified the NIP as we don't support
> livepatching a kprobe'd function. In this case, we simply skip the
> livepatch_handler and branch to the new NIP. Otherwise, the
> livepatch_handler is invoked.
> 
> Fixes: ead514d5fb30a ("powerpc/kprobes: Add support for
> KPROBES_ON_FTRACE")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c05b8c4474c03026aaa7f8872e7836

cheers
