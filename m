Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PrL0LF4zDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:43:29 +1000 (AEST)
Date: Wed, 19 Apr 2017 23:43:19 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
Message-Id: <20170419234319.7893df9c158e565fede4a386@kernel.org>
In-Reply-To: <0d4193a90e4b2ad3cd2ef33d41228b80a2ac9f91.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <0d4193a90e4b2ad3cd2ef33d41228b80a2ac9f91.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
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


BTW, as I pointed, 5/7 and 6/7 should be merged since this actually
makes meaningful change.

Thank you,

On Wed, 19 Apr 2017 18:21:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On kprobe handler re-entry, try to emulate the instruction rather than
> single stepping always.
> 
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 46e8c1e03ce4..067e9863bfdf 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -276,6 +276,14 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>  			kprobes_inc_nmissed_count(p);
>  			prepare_singlestep(p, regs);
>  			kcb->kprobe_status = KPROBE_REENTER;
> +			if (p->ainsn.boostable >= 0) {
> +				ret = try_to_emulate(p, regs);
> +
> +				if (ret > 0) {
> +					restore_previous_kprobe(kcb);
> +					return 1;
> +				}
> +			}
>  			return 1;
>  		} else {
>  			if (*addr != BREAKPOINT_INSTRUCTION) {
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
