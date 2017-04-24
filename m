Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLY2KbzzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:33 +1000 (AEST)
In-Reply-To: <53ebcc66e4a7ccf1c22cd1703afb0e4738f981ea.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [v4,
 6/6] powerpc: kprobes: prefer ftrace when probing function entry
Message-Id: <3wBhLY159cz9s8Y@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:52:28 UTC, "Naveen N. Rao" wrote:
> KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
> eliminates the need for a trap, as well as the need to emulate or
> single-step instructions.
> 
> Though OPTPROBES provides us with similar performance, we have limited
> optprobes trampoline slots. As such, when asked to probe at a function
> entry, default to using the ftrace infrastructure.
> 
> With:
> 	# cd /sys/kernel/debug/tracing
> 	# echo 'p _do_fork' > kprobe_events
> 
> before patch:
> 	# cat ../kprobes/list
> 	c0000000000daf08  k  _do_fork+0x8    [DISABLED]
> 	c000000000044fc0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> and after patch:
> 	# cat ../kprobes/list
> 	c0000000000d074c  k  _do_fork+0xc    [DISABLED][FTRACE]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/24bd909e94776ecce95291bff910f1

cheers
