Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbrw444PlzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 17:25:08 +1100 (AEDT)
Message-ID: <1459491908.10334.8.camel@ellerman.id.au>
Subject: Re: [PATCH 65/65] powerpc/mm/radix: Cputable update for radix
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, distroguy@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Apr 2016 17:25:08 +1100
In-Reply-To: <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Sun, 2016-03-27 at 13:54 +0530, Aneesh Kumar K.V wrote:

> This patch move the existing p9 hash to a different PVR and add
> radix feature with p9 PVR. That implies we will not be able to
> runtime select P9 hash. With P9 Radix we need to do
> 
> * set UPRT = 0 in cpu setup
> * set different TLB set count
> 
> We ideally want to use ibm,pa-features to enable disable radix. But
> we have already done setup cpu by the time we reach pa-features check.
> 
> So for now use this hack.
> 
> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
...
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 584e119fa8b0..e9b76c651bd1 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -117,6 +117,41 @@ _GLOBAL(__restore_cpu_power9)
>  	mtlr	r11
>  	blr
>  
> +_GLOBAL(__setup_cpu_power9_uprt)
> +	mflr	r11
> +	bl	__init_FSCR
> +	bl	__init_hvmode_206
> +	mtlr	r11
> +	beqlr
> +	li	r0,0
> +	mtspr	SPRN_LPID,r0
> +	mfspr	r3,SPRN_LPCR
> +	ori	r3, r3, LPCR_PECEDH
> +	oris	r3,r3,(LPCR_UPRT >> 16)
> +	bl	__init_LPCR

I don't see why we *have* to initialise this here.

ie. could we do it later in early_init_mmu() or similar ?

cheers
