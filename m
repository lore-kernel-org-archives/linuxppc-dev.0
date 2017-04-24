Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLQ3yJQzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:26 +1000 (AEST)
In-Reply-To: <77e96021f60d0cebd75bb8c5968e179c32781016.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [v3,
 2/7] powerpc: kprobes: fix handling of function offsets on ABIv2
Message-Id: <3wBhLQ2Vy4z9s8Y@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:51:01 UTC, "Naveen N. Rao" wrote:
> commit 239aeba76409 ("perf powerpc: Fix kprobe and kretprobe handling
> with kallsyms on ppc64le") changed how we use the offset field in struct
> kprobe on ABIv2. perf now offsets from the GEP (Global entry point) if an
> offset is specified and otherwise chooses the LEP (Local entry point).
> 
> Fix the same in kernel for kprobe API users. We do this by extending
> kprobe_lookup_name() to accept an additional parameter to indicate the
> offset specified with the kprobe registration. If offset is 0, we return
> the local function entry and return the global entry point otherwise.
> 
> With:
> 	# cd /sys/kernel/debug/tracing/
> 	# echo "p _do_fork" >> kprobe_events
> 	# echo "p _do_fork+0x10" >> kprobe_events
> 
> before this patch:
> 	# cat ../kprobes/list
> 	c0000000000d0748  k  _do_fork+0x8    [DISABLED]
> 	c0000000000d0758  k  _do_fork+0x18    [DISABLED]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> and after:
> 	# cat ../kprobes/list
> 	c0000000000d04c8  k  _do_fork+0x8    [DISABLED]
> 	c0000000000d04d0  k  _do_fork+0x10    [DISABLED]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/290e3070762ac80e5fc4087d8c4de7

cheers
