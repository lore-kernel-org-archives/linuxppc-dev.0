Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqqg2ttgzDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:22:39 +1000 (AEST)
In-Reply-To: <309db8dc9b7d60b1264d277bd815403fbd2d6545.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v2,
 1/4] powerpc/kprobes: Pause function_graph tracing during jprobes
 handling
Message-Id: <3wrqqg2BVKz9s7v@ozlabs.org>
Date: Mon, 19 Jun 2017 22:22:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 10:48:15 UTC, "Naveen N. Rao" wrote:
> This fixes a crash when function_graph and jprobes are used together.
> This is essentially commit 237d28db036e ("ftrace/jprobes/x86: Fix
> conflict between jprobes and function graph tracing"), but for powerpc.
> 
> Jprobes breaks function_graph tracing since the jprobe hook needs to use
> jprobe_return(), which never returns back to the hook, but instead to
> the original jprobe'd function. The solution is to momentarily pause
> function_graph tracing before invoking the jprobe hook and re-enable it
> when returning back to the original jprobe'd function.
> 
> Fixes: 6794c78243bfd ("powerpc64: port of the function graph tracer")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a9f8553e935f26cb5447f67e280946

cheers
