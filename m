Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5hYl0BdTzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 08:39:07 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s5hYk2Psmz9sC4
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Aug 2016 08:39:06 +1000 (AEST)
Message-ID: <1470436733.12584.164.camel@kernel.crashing.org>
Subject: Re: [PATCH] powernv: Load correct TOC pointer while waking up from
 winkle.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Sat, 06 Aug 2016 08:38:53 +1000
In-Reply-To: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
References: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-05 at 19:13 +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The function pnv_restore_hyp_resource() loads the TOC into r2 from
> the invalid PACA pointer before fixing r13 value. This do not affect
> POWER ISA 3.0 but it does have an impact on POWER ISA 2.07 or less
> leading CPU to get stuck forever.

When was this broken ? Should this get backported to stable ?

> 	login: [  471.830433] Processor 120 is stuck.
> 
> 
> This can be easily reproducible using following steps:
> - Turn off SMT
> 	$ ppc64_cpu --smt=off
> - offline/online any online cpu (Thread 0 of any core which is
> online)
> 	$ echo 0 > /sys/devices/system/cpu/cpu<num>/online
> 	$ echo 1 > /sys/devices/system/cpu/cpu<num>/online
> 
> For POWER ISA 2.07 or less, the last bit of HSPRG0 is set indicating
> that thread is waking up from winkle. Hence, the last bit of
> HSPRG0(r13)
> needs to be clear before accessing it as PACA to avoid loading
> invalid
> values from invalid PACA pointer.
> 
> Fix this by loading TOC after r13 register is corrected.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S
> index 8a56a51..45784ec 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -363,8 +363,8 @@ _GLOBAL(power9_idle_stop)
>   * cr3 - set to gt if waking up with partial/complete hypervisor
> state loss
>   */
>  _GLOBAL(pnv_restore_hyp_resource)
> -	ld	r2,PACATOC(r13);
>  BEGIN_FTR_SECTION
> +	ld	r2,PACATOC(r13);
>  	/*
>  	 * POWER ISA 3. Use PSSCR to determine if we
>  	 * are waking up from deep idle state
> @@ -395,6 +395,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	 */
>  	clrldi	r5,r13,63
>  	clrrdi	r13,r13,1
> +
> +	/* Now that we are sure r13 is corrected, load TOC */
> +	ld	r2,PACATOC(r13);
>  	cmpwi	cr4,r5,1
>  	mtspr	SPRN_HSPRG0,r13
>  
