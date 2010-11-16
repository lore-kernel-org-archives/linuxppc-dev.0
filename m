Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 8ABB6B7131
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 21:17:37 +1100 (EST)
Subject: Re: Corrected data type mismatch
From: Milton Miller <miltonm@bga.com>
Message-Id: <mdm-kgbd-badfix@mdm.bga.com>
In-Reply-To: <1289700419-11072-2-git-send-email-shan.hai@windriver.com>
References: <1289700419-11072-2-git-send-email-shan.hai@windriver.com>
To: Hai Shan <shan.hai@windriver.com>
Date: Tue, 16 Nov 2010 04:17:25 -0600
Cc: kgdb-bugreport@lists.sourceforge.net,
	Dongdong Deng <dongdong.deng@windriver.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Jason Wessel <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[added cc's based on from ff10b88b5a05c8f1646dd15fb9f6093c1384ff6d,
which added the patched line ]

https://patchwork.kernel.org/patch/323022/

On Sun, 14 Nov 2010 around 02:06:59 -0000, Hai Shan wrote:
> 
> Corrected data type mismatch
> 
This merely hides the type mismatch by force casting it.

Looking at the context I believe the intent is to copy the the value to
or from the register content slot, not take the previous value of the
register and use that as an address to copy to or from.

milton
> Signed-off-by: Hai Shan <shan.hai@windriver.com>
> 
> ---
> arch/powerpc/kernel/kgdb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 7a9db64..c5ce65f 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>  		/* FP registers 32 -> 63 */
>  #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
>  		if (current)
> -			memcpy(mem, current->thread.evr[regno-32],
> +			memcpy(mem, (void *)current->thread.evr[regno-32],
>  					dbg_reg_def[regno].size);
>  #else
>  		/* fp registers not used by kernel, leave zero */
> @@ -362,7 +362,7 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>  	if (regno >= 32 && regno < 64) {
>  		/* FP registers 32 -> 63 */
>  #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
> -		memcpy(current->thread.evr[regno-32], mem,
> +		memcpy((void *)current->thread.evr[regno-32], mem,
>  				dbg_reg_def[regno].size);
>  #else
>  		/* fp registers not used by kernel, leave zero */
