Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3STC4xNDzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:28:15 +1000 (AEST)
Date: Thu, 13 Apr 2017 13:28:04 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] powerpc: kprobes: fix handling of function
 offsets on ABIv2
Message-Id: <20170413132804.0db5e64a2ee6e9b2130719bb@kernel.org>
In-Reply-To: <dcf77485d32f1a49d0c79a5be7e038491c10ea2a.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <dcf77485d32f1a49d0c79a5be7e038491c10ea2a.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Apr 2017 16:28:25 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

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
> ---
>  arch/powerpc/kernel/kprobes.c   | 4 ++--
>  arch/powerpc/kernel/optprobes.c | 4 ++--
>  include/linux/kprobes.h         | 2 +-
>  kernel/kprobes.c                | 7 ++++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index a7aa7394954d..0732a0291ace 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -42,14 +42,14 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
>  struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
>  
> -kprobe_opcode_t *kprobe_lookup_name(const char *name)
> +kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)

Hmm, if we do this change, it is natural that kprobe_lookup_name()
returns the address + offset.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
