Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8B59DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:21:53 +1000 (EST)
Message-Id: <1530CE92-A052-487F-B5D1-643E166068B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090428124503.70AF1123B3@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics
Date: Tue, 28 Apr 2009 08:21:26 -0500
References: <20090428124503.70AF1123B3@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2009, at 7:45 AM, Michael Neuling wrote:

> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/mmu.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/mmu.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/mmu.h
> @@ -58,6 +58,11 @@
>  */
> #define MMU_FTR_TLBILX_EARLY_OPCODE	ASM_CONST(0x00400000)
>
> +/* This indicates that the processor uses the ISA 2.06 server tlbie
> + * mnemonics
> + */
> +#define MMU_FTR_TLBIE_206		ASM_CONST(0x00800000)
> +
> #ifndef __ASSEMBLY__
> #include <asm/cputable.h>

You aren't going to like me, but I just got rid of  
MMU_FTR_TLBILX_EARLY_OPCODE and thus freed up 0x00400000.  So a) patch  
will probably bitch when being applied by Ben b) we should use  
0x00400000.

(suggest pulling in paulus/merge as that has the "revert" patch that  
removes MMU_FTR_TLBILX_EARLY_OPCODE - and paul's sent a pull request  
to linus for it.)

- k
