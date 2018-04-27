Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XPB02w86zF26p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 16:27:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: paste - Mask XERSO bit in CR
In-Reply-To: <1524725319.26204.4.camel@hbabu-laptop>
References: <1524725319.26204.4.camel@hbabu-laptop>
Date: Fri, 27 Apr 2018 16:27:35 +1000
Message-ID: <871sf15fl4.fsf@concordia.ellerman.id.au>
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

Haren Myneni <haren@linux.vnet.ibm.com> writes:
>     
> NX can set 3rd bit in CR register for XER[SO] (Summation overflow)
> which is not used for paste return value. So. mask this bit to get
> proper return status.

This sounds like a bug fix, but I can't tell from the change log.

What happens if we don't merge this patch? Is it bad?

Should I add:

  Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
  Cc: stable@vger.kernel.org # v4.14+


cheers

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
