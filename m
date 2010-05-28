Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: ananth@in.ibm.com
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
In-reply-to: <20100527141203.GA20770@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com>
Date: Fri, 28 May 2010 12:28:43 +1000
Message-ID: <23979.1275013723@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <20100527141203.GA20770@in.ibm.com> you wrote:
> Hi Paul,
> 
> While we are at it, can we also add nop to the list of emulated
> instructions?
> 
> Ananth
> ---
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Emulate ori 0,0,0 (nop).
> 
> The long winded way is to do:
> 
>         case 24:
>                 rd = (instr >> 21) & 0x1f;
>                 if (rd != 0)
>                         break;
>                 rb = (instr >> 11) & 0x1f;
>                 if (rb != 0)
>                         break;

Don't we just need rb == rd?

>                 imm = (instr & 0xffff);
>                 if (imm == 0) {
>                         regs->nip += 4;
>                         return 1;
>                 }
>                 break;
> 
> But, the following is more straightforward for this case at least.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: linux-27may/arch/powerpc/lib/sstep.c
> ===================================================================
> --- linux-27may.orig/arch/powerpc/lib/sstep.c
> +++ linux-27may/arch/powerpc/lib/sstep.c
> @@ -412,6 +412,12 @@ int __kprobes emulate_step(struct pt_reg
>  	int err;
>  	mm_segment_t oldfs;
>  
> +	/* ori 0,0,0 is a nop. Emulate that too */
> +	if (instr == 0x60000000) {
> +		regs->nip += 4;
> +		return 1;
> +	}
> +
>  	opcode = instr >> 26;
>  	switch (opcode) {
>  	case 16:	/* bc */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
