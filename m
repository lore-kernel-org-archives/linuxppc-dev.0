Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xg2jt5KnzzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Aug 2017 14:58:58 +1000 (AEST)
Message-ID: <1503809791.3814.43.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/44x: mask and shift to zero bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, Matthias Fuchs
 <matthias.fuchs@esd-electronics.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Date: Sun, 27 Aug 2017 14:56:31 +1000
In-Reply-To: <20170825103340.op3uphrv3eyeutiz@mwanda>
References: <20170825103340.op3uphrv3eyeutiz@mwanda>
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

On Fri, 2017-08-25 at 13:33 +0300, Dan Carpenter wrote:
> My static checker complains that 0x00001800 >> 13 is zero.  Looking at
> the context, it seems like a copy and paste bug from the line below and
> probably 0x3 << 13 or 0x00006000 was intended.
> 
> Fixes: 2af59f7d5c3e ("[POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Not tested!
> 
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> index 9d3bd4c45a24..f7da65169124 100644
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -564,7 +564,7 @@ void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
>  		fbdv = 16;
>  	cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
>  	opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
> -	ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
> +	ppdv = ((pllmr & 0x00006000) >> 13) + 1; /* PLB:PCI */
>  	epdv = ((pllmr & 0x00001800) >> 11) + 2; /* PLB:EBC */
>  	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1; 

That rings a bell... Is this something we tried to fix before and had
problems ? The thing is when I opened the 405GP and EP manual PDF,
evince had memorized that this register was the last page I looked at
:-) And I don't remember how many years ago that is.

According to the 405gp spec ppdv is IBM bits 17,18 so your patch is
correct.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
