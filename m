Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40snJB2N0rzF1yt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 23:33:13 +1000 (AEST)
Date: Fri, 25 May 2018 06:33:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Clear PCR on boot
Message-ID: <20180525133308.GA17443@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 11:37:42AM +1000, Michael Neuling wrote:
> Clear the PCR (Processor Compatibility Register) on boot to ensure we
> are not running in a compatibility mode.
> 
> We've seen this cause problems when a crash (and kdump) occurs while
> running compat mode guests. The kdump kernel then runs with the PCR
> set and causes problems. The symptom in the kdump kernel (also seen in
> petitboot after fast-reboot) is early userspace programs taking
> sigills on newer instructions (seen in libc).
> 

Hi folks,

this patch causes qemu to bail out with

Trying to write privileged spr 338 (0x152) at c000000000033454

when running it with "-M powernv -cpu POWER8" and powernv_defconfig.

Can you confirm that this is a bug in qemu ?

Thanks,
Guenter

> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/cpu_setup_power.S | 6 ++++++
>  arch/powerpc/kernel/dt_cpu_ftrs.c     | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 3f30c994e931..458b928dbd84 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -28,6 +28,7 @@ _GLOBAL(__setup_cpu_power7)
>  	beqlr
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
> +	mtspr	SPRN_PCR,r0
>  	mfspr	r3,SPRN_LPCR
>  	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
>  	bl	__init_LPCR_ISA206
> @@ -41,6 +42,7 @@ _GLOBAL(__restore_cpu_power7)
>  	beqlr
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
> +	mtspr	SPRN_PCR,r0
>  	mfspr	r3,SPRN_LPCR
>  	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
>  	bl	__init_LPCR_ISA206
> @@ -57,6 +59,7 @@ _GLOBAL(__setup_cpu_power8)
>  	beqlr
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
> +	mtspr	SPRN_PCR,r0
>  	mfspr	r3,SPRN_LPCR
>  	ori	r3, r3, LPCR_PECEDH
>  	li	r4,0 /* LPES = 0 */
> @@ -78,6 +81,7 @@ _GLOBAL(__restore_cpu_power8)
>  	beqlr
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
> +	mtspr	SPRN_PCR,r0
>  	mfspr   r3,SPRN_LPCR
>  	ori	r3, r3, LPCR_PECEDH
>  	li	r4,0 /* LPES = 0 */
> @@ -99,6 +103,7 @@ _GLOBAL(__setup_cpu_power9)
>  	mtspr	SPRN_PSSCR,r0
>  	mtspr	SPRN_LPID,r0
>  	mtspr	SPRN_PID,r0
> +	mtspr	SPRN_PCR,r0
>  	mfspr	r3,SPRN_LPCR
>  	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE  | LPCR_HEIC)
>  	or	r3, r3, r4
> @@ -123,6 +128,7 @@ _GLOBAL(__restore_cpu_power9)
>  	mtspr	SPRN_PSSCR,r0
>  	mtspr	SPRN_LPID,r0
>  	mtspr	SPRN_PID,r0
> +	mtspr	SPRN_PCR,r0
>  	mfspr   r3,SPRN_LPCR
>  	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE | LPCR_HEIC)
>  	or	r3, r3, r4
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 8ab51f6ca03a..c904477abaf3 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -101,6 +101,7 @@ static void __restore_cpu_cpufeatures(void)
>  	if (hv_mode) {
>  		mtspr(SPRN_LPID, 0);
>  		mtspr(SPRN_HFSCR, system_registers.hfscr);
> +		mtspr(SPRN_PCR, 0);
>  	}
>  	mtspr(SPRN_FSCR, system_registers.fscr);
>  
> -- 
> 2.7.4
