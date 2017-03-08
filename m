Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdVVr6D02zDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 21:43:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powerpc: kretprobes: override default function
 entry offset
In-Reply-To: <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 08 Mar 2017 21:43:29 +1100
Message-ID: <87o9xcujzi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> With ABIv2, we offset 8 bytes into a function to get at the local entry
> point.
>
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I'm OK with this change, and I'm happy for it to go with the rest of the
series via acme's tree:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


But, you've also sent a series to do KPROBES_ON_FTRACE, and that also
touches this function, see the 2nd to last hunk at:

  https://patchwork.ozlabs.org/patch/730675/


If this goes via acme's tree it will be awkward for me to merge the
series above via the powerpc tree.

So we could do topic branches and so on, or we could just drop this
patch from this series, and I'll merge it as part of the other series.
It won't do anything useful until it's merged with a tree that also has
the rest of this series. Or something else I haven't thought of.

cheers

> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index fce05a38851c..331751701fed 100644
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
> 2.11.1
