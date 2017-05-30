Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcNgs4GmCzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:17:45 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id u26so15652382pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 23:17:45 -0700 (PDT)
Date: Tue, 30 May 2017 16:17:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] powernv:idle: Restore LPCR on wakeup from deep-stop
Message-ID: <20170530161731.33fec50d@roar.ozlabs.ibm.com>
In-Reply-To: <147a42823bae78b98b76b91f736c620b886213ae.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <147a42823bae78b98b76b91f736c620b886213ae.1494585671.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 May 2017 14:19:45 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On wakeup from a deep stop state which is supposed to lose the
> hypervisor state, we don't restore the LPCR to the old value but set
> it to a "sane" value via cur_cpu_spec->cpu_restore().
> 
> The problem is that the "sane" value doesn't include UPRT and the HR
> bits which are required to run correctly in Radix mode.
> 
> Fix this on POWER9 onwards by restoring the LPCR value whatever it was
> before executing the stop instruction.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Yes I think we need this. I have a plan to rework some of
that cpu_restore and early CPU init stuff, but for now we
need this.

Does the OCC restore LPCR properly then we just trash it
with ->cpu_restore(), or is it always junk?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> ---
>  arch/powerpc/kernel/idle_book3s.S | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index afd029f..6c9920d 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -31,6 +31,7 @@
>   * registers for winkle support.
>   */
>  #define _SDR1	GPR3
> +#define _PTCR	GPR3
>  #define _RPR	GPR4
>  #define _SPURR	GPR5
>  #define _PURR	GPR6
> @@ -39,7 +40,7 @@
>  #define _AMOR	GPR9
>  #define _WORT	GPR10
>  #define _WORC	GPR11
> -#define _PTCR	GPR12
> +#define _LPCR	GPR12
>  
>  #define PSSCR_EC_ESL_MASK_SHIFTED          (PSSCR_EC | PSSCR_ESL) >> 16
>  
> @@ -55,12 +56,14 @@ save_sprs_to_stack:
>  	 * here since any thread in the core might wake up first
>  	 */
>  BEGIN_FTR_SECTION
> -	mfspr	r3,SPRN_PTCR
> -	std	r3,_PTCR(r1)
>  	/*
>  	 * Note - SDR1 is dropped in Power ISA v3. Hence not restoring
>  	 * SDR1 here
>  	 */
> +	mfspr	r3,SPRN_PTCR
> +	std	r3,_PTCR(r1)
> +	mfspr	r3,SPRN_LPCR
> +	std	r3,_LPCR(r1)
>  FTR_SECTION_ELSE
>  	mfspr	r3,SPRN_SDR1
>  	std	r3,_SDR1(r1)
> @@ -813,6 +816,10 @@ no_segments:
>  	mtctr	r12
>  	bctrl
>  
> +BEGIN_FTR_SECTION
> +	ld	r4,_LPCR(r1)
> +	mtspr	SPRN_LPCR,r4
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  hypervisor_state_restored:
>  
>  	mtspr	SPRN_SRR1,r16
