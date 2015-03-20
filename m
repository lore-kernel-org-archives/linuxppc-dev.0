Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5197F1A073F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:39:54 +1100 (AEDT)
Message-ID: <1426829993.2581.2.camel@ellerman.id.au>
Subject: Re: [PATCH v3 0/4] powerpc: trivial unused functions cleanup
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Fri, 20 Mar 2015 16:39:53 +1100
In-Reply-To: <87pp84w9mj.fsf@KB00016249.iskra.kb>
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
 <1426825436.2581.1.camel@ellerman.id.au>
 <87pp84w9mj.fsf@KB00016249.iskra.kb>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-20 at 11:55 +0700, Arseny Solokha wrote:
> 
> And by the way, while revisiting the series I've noticed that though the patch
> 4/4 basically reverts [1], it leaves
> 
>   #define MPIC_GREG_GLOBAL_CONF_1		0x00030
> 
> in arch/powerpc/include/asm/mpic.h untouched. That define also loses its uses
> after applying the patch. Compare the following hunk in today's patch w/ the one
> you committed:
> 
>   @@ -33,11 +33,6 @@
>    #define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
>    #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
>    #define		MPIC_GREG_GCONF_MCK			0x08000000
>   -#define MPIC_GREG_GLOBAL_CONF_1		0x00030
>   -#define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000
>   -#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
>   -#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(r)	\
>   -			(((r) << 28) & MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK)
>    #define MPIC_GREG_VENDOR_0		0x00040
>    #define MPIC_GREG_VENDOR_1		0x00050
>    #define MPIC_GREG_VENDOR_2		0x00060
> 
> So the question is, should #define MPIC_GREG_GLOBAL_CONF_1 have been also
> removed, or could be left as is?
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-June/023867.html


OK, thanks for the thoroughness.

With #defines like that it's never clear if they should be removed or not. On
the one hand it's not used, so it should be removed. But, it can be useful to
keep the #defines there as documentation.

So I'm 50/50 on it. If you send me a patch to remove it I'll merge it, unless
someone else objects.

cheers
