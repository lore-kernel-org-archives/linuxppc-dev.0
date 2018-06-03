Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zFCk14gjzF1JK
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2018 20:48:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Subject: Re: powerpc/powernv: copy/paste - Mask XERS0 bit in CR
In-Reply-To: <1527740956.5945.12.camel@hbabu-laptop>
References: <1527740956.5945.12.camel@hbabu-laptop>
Date: Sun, 03 Jun 2018 20:48:16 +1000
Message-ID: <87r2lokuxb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Haren,

Haren Myneni <haren@linux.vnet.ibm.com> writes:
>     
> NX can set 3rd bit in CR register for XER[SO] (Summation overflow)
> which is not related to paste request. The current paste function
> returns failure for the successful request when this bit is set.
> So mask this bit and check the proper return status.
>
> Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
> Cc: stable@vger.kernel.org # v4.14+    
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>
> diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
> index c9a5036..82392e3 100644
> --- a/arch/powerpc/platforms/powernv/copy-paste.h
> +++ b/arch/powerpc/platforms/powernv/copy-paste.h
> @@ -9,7 +9,8 @@
>  #include <asm/ppc-opcode.h>
>  
>  #define CR0_SHIFT	28
> -#define CR0_MASK	0xF
> +#define CR0_MASK	0xE /* 3rd bit undefined or set for XER[SO] */
> +
>  /*
>   * Copy/paste instructions:
>   *

Unfortunately this no longer applies to my next branch, because those
macros have been moved out of this header as part of an unrelated patch.

The following patch should work instead, can you please confirm by
testing it?

diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
index 3fa62de96d9c..c46a326776cf 100644
--- a/arch/powerpc/platforms/powernv/copy-paste.h
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -41,5 +41,7 @@ static inline int vas_paste(void *paste_address, int offset)
 		: "b" (offset), "b" (paste_address)
 		: "memory", "cr0");
 
-	return (cr >> CR0_SHIFT) & CR0_MASK;
+
+	/* We mask with 0xE to ignore SO */
+	return (cr >> CR0_SHIFT) & 0xE;
 }


cheers
