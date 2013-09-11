Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DCDB2C0246
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 08:37:10 +1000 (EST)
Message-ID: <1378939017.12204.409.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 11 Sep 2013 17:36:57 -0500
In-Reply-To: <201309111644.r8BGiuDZ016325@localhost.localdomain>
References: <201309111644.r8BGiuDZ016325@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 18:44 +0200, Christophe Leroy wrote:
> Activating CONFIG_PIN_TLB is supposed to pin the IMMR and the first three
> 8Mbytes pages. But the setting of the MD_CTR was missing so as the index is
> decremented every DTLB update, the pinning of the third 8Mbytes page was
> overwriting the DTLB entry for IMMR.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S linux-3.11/arch/powerpc/kernel/head_8xx.S
> --- linux-3.11.org/arch/powerpc/kernel/head_8xx.S	2013-09-02 22:46:10.000000000 +0200
> +++ linux-3.11/arch/powerpc/kernel/head_8xx.S	2013-09-09 11:28:54.000000000 +0200
> @@ -862,6 +862,9 @@
>  	addis	r11, r11, 0x0080	/* Add 8M */
>  	mtspr	SPRN_MD_RPN, r11
>  
> +	addi	r10, r10, 0x0100
> +	mtspr	SPRN_MD_CTR, r10
> +
>  	addis	r8, r8, 0x0080		/* Add 8M */
>  	mtspr	SPRN_MD_EPN, r8
>  	mtspr	SPRN_MD_TWC, r9

I wonder why we don't start from entry 31 so we can actually make use of
that autodecrement.  What will happen when we load the first normal TLB
entry later on?  I don't see any setting of SPRN_MD_CTR after this code,
so won't it overwrite entry 30 (the middle 8M) in the CONFIG_PIN_TLB
case?

Ben, would patches like this be considered bugfixes as far as merging
goes, or would they be for next given that it's something that's never
really worked right and hasn't been touched in years?

-Scott
