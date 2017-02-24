Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVMMY55PgzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 06:57:29 +1100 (AEDT)
Date: Fri, 24 Feb 2017 16:57:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc: kretprobes: override default function
 entry offset
Message-ID: <20170224195722.GM3595@kernel.org>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <e27a624a724f1b00d09e769cbce24abdb27d8688.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e27a624a724f1b00d09e769cbce24abdb27d8688.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Feb 22, 2017 at 07:23:38PM +0530, Naveen N. Rao escreveu:
> With ABIv2, we offset 8 bytes into a function to get at the local entry
> point.

So, I think I can carry the first one via Ingo, etc, what about this
one?

Is it ok for me to process it?

Seems simple enough, has been thru a lot of discussion, but would be
better if it was Reviewed-by the PPC maintainers or else just processed
by them.

Please advise,

- Arnaldo
 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 735ff3d3f77d..e37b76b8b6b2 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -131,6 +131,15 @@ static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
>  	kcb->kprobe_saved_msr = regs->msr;
>  }
>  
> +bool arch_function_offset_within_entry(unsigned long offset)
> +{
> +#ifdef PPC64_ELF_ABI_v2
> +	return offset <= 8;
> +#else
> +	return !offset;
> +#endif
> +}
> +
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs)
>  {
> -- 
> 2.11.0
