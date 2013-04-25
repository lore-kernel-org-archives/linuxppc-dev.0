Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc/power8: fix secondary CPUs hanging on boot for
 HV=0
In-reply-to: <27249.1366873237@ale.ozlabs.ibm.com>
References: <27249.1366873237@ale.ozlabs.ibm.com>
Date: Thu, 25 Apr 2013 17:05:53 +1000
Message-ID: <27559.1366873553@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Nishanth Aravamudan <nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> wrote:

> In __restore_cpu_power8 we determine if we are HV and if not, we return
> before setting HV only resources.
> 
> Unfortunately we forgot to restore the link register from r11 before
> returning.
> 
> This will happen on boot and with secondary CPUs not coming online.
> 
> This adds the missing link register restore.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

cc: stable@kernel.org

> 
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index ea847ab..1167008 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -66,6 +66,7 @@ _GLOBAL(__restore_cpu_power8)
>  	bl	__init_FSCR
>  	mfmsr	r3
>  	rldicl.	r0,r3,4,63
> +	mtlr	r11
>  	beqlr
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
