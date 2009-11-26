Return-Path: <anton@ozlabs.org>
Date: Thu, 26 Nov 2009 14:28:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: hypervisor call tracepoints  hcall_stats touchup.
Message-ID: <20091126032822.GS32182@kryten>
References: <1259165529.16349.191.camel@lexx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259165529.16349.191.camel@lexx>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, mingo@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Will,

> The tb_total and purr_total values reported via the hcall_stats code
> should be cumulative, rather than being replaced by the latest delta tb
> or purr value. 
> 
> Tested-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

Ouch! Nice catch.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> [ This is a touch-up to the "[3/6] powerpc: tracing: Add hypervisor call
> tracepoints" patch submitted by Anton a few weeks back, so I've copied
> folks Anton had on CC for his original patch, this fix is rather ppc
> specific, so can probably go in via the ppc tree, but I've no real
> preference. ]
> 
> diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
> index 2f58c71..1fefae7 100644
> --- a/arch/powerpc/platforms/pseries/hvCall_inst.c
> +++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
> @@ -124,8 +124,8 @@ static void probe_hcall_exit(unsigned long opcode, unsigned long retval,
>  
>  	h = &__get_cpu_var(hcall_stats)[opcode / 4];
>  	h->num_calls++;
> -	h->tb_total = mftb() - h->tb_start;
> -	h->purr_total = mfspr(SPRN_PURR) - h->purr_start;
> +	h->tb_total += mftb() - h->tb_start;
> +	h->purr_total += mfspr(SPRN_PURR) - h->purr_start;
>  
>  	put_cpu_var(hcall_stats);
>  }
> 
