Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1481DB7D1E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 06:23:05 +1000 (EST)
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100527141203.GA20770@in.ibm.com>
Date: Thu, 27 May 2010 15:22:45 -0500
Message-Id: <666A1FDB-C8EC-493A-957E-3C4291CCB439@kernel.crashing.org>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com>
To: ananth@in.ibm.com
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


On May 27, 2010, at 9:12 AM, Ananth N Mavinakayanahalli wrote:

> Hi Paul,
> 
> While we are at it, can we also add nop to the list of emulated
> instructions?

Dare I ask why we need to emulate nop?

- k

> 
> Ananth
> ---
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Emulate ori 0,0,0 (nop).
> 
> The long winded way is to do:
> 
>        case 24:
>                rd = (instr >> 21) & 0x1f;
>                if (rd != 0)
>                        break;
>                rb = (instr >> 11) & 0x1f;
>                if (rb != 0)
>                        break;
>                imm = (instr & 0xffff);
>                if (imm == 0) {
>                        regs->nip += 4;
>                        return 1;
>                }
>                break;
> 
> But, the following is more straightforward for this case at least.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
> arch/powerpc/lib/sstep.c |    6 ++++++
> 1 file changed, 6 insertions(+)
> 
> Index: linux-27may/arch/powerpc/lib/sstep.c
> ===================================================================
> --- linux-27may.orig/arch/powerpc/lib/sstep.c
> +++ linux-27may/arch/powerpc/lib/sstep.c
> @@ -412,6 +412,12 @@ int __kprobes emulate_step(struct pt_reg
> 	int err;
> 	mm_segment_t oldfs;
> 
> +	/* ori 0,0,0 is a nop. Emulate that too */
> +	if (instr == 0x60000000) {
> +		regs->nip += 4;
> +		return 1;
> +	}
> +
> 	opcode = instr >> 26;
> 	switch (opcode) {
> 	case 16:	/* bc */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
