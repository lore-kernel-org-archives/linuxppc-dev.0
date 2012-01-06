Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DCB8B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2012 09:50:17 +1100 (EST)
Message-ID: <1325890210.23910.29.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix kernel log of oops/panic instruction dump
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Sat, 07 Jan 2012 09:50:10 +1100
In-Reply-To: <1325889247-17205-1-git-send-email-iws@ovro.caltech.edu>
References: <1325889247-17205-1-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-01-06 at 14:34 -0800, Ira W. Snyder wrote:
> A kernel oops/panic prints an instruction dump showing several
> instructions before and after the instruction which caused the
> oops/panic.
> 
> The code intended that the faulting instruction be enclosed in angle
> brackets, however a bug caused the faulting instruction to be
> interpreted by printk() as the message log level.
> 
> To fix this, the KERN_CONT log level is added before the actualy text of
> the printed message.

Nice one, thanks.

Cheers,
Ben.

> === Before the patch ===
> 
> [ 1081.587266] Instruction dump:
> [ 1081.590236] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> [ 1081.598034] 3d20c03a 9009a114 7c0004ac 39200000
> [ 1081.602500]  4e800020 3803ffd0 2b800009
> 
> <4>[ 1081.587266] Instruction dump:
> <4>[ 1081.590236] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> <4>[ 1081.598034] 3d20c03a 9009a114 7c0004ac 39200000
> <98090000>[ 1081.602500]  4e800020 3803ffd0 2b800009
> 
> === After the patch ===
> 
> [   51.385216] Instruction dump:
> [   51.388186] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> [   51.395986] 3d20c03a 9009a114 7c0004ac 39200000 <98090000> 4e800020 3803ffd0 2b800009
> 
> <4>[   51.385216] Instruction dump:
> <4>[   51.388186] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> <4>[   51.395986] 3d20c03a 9009a114 7c0004ac 39200000 <98090000> 4e800020 3803ffd0 2b800009
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> 
> In the above examples, the first block is what is shown on the serial
> console as the machine dies. The second block is the dump as captured by
> mtdoops.
> 
>  arch/powerpc/kernel/process.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 6457574..271f809 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -566,12 +566,12 @@ static void show_instructions(struct pt_regs *regs)
>  		 */
>  		if (!__kernel_text_address(pc) ||
>  		     __get_user(instr, (unsigned int __user *)pc)) {
> -			printk("XXXXXXXX ");
> +			printk(KERN_CONT "XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> -				printk("<%08x> ", instr);
> +				printk(KERN_CONT "<%08x> ", instr);
>  			else
> -				printk("%08x ", instr);
> +				printk(KERN_CONT "%08x ", instr);
>  		}
>  
>  		pc += sizeof(int);
