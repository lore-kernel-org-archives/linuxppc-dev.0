Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Shf1V0lzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:38:10 +1000 (AEST)
Date: Thu, 13 Apr 2017 13:37:58 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
Message-Id: <20170413133758.0f9e0c86bd3230dcd820f8e7@kernel.org>
In-Reply-To: <7021f79a5738ecb25ee3e07931e927138e9493eb.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <7021f79a5738ecb25ee3e07931e927138e9493eb.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 12 Apr 2017 16:28:28 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On kprobe handler re-entry, try to emulate the instruction rather than
> single stepping always.
> 

> As a related change, remove the duplicate saving of msr as that is
> already done in set_current_kprobe()

If so, this part might be separated as a cleanup patch...

Thanks,

> 
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 8b48f7d046bd..005bd4a75902 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -273,10 +273,17 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>  			 */
>  			save_previous_kprobe(kcb);
>  			set_current_kprobe(p, regs, kcb);
> -			kcb->kprobe_saved_msr = regs->msr;
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
