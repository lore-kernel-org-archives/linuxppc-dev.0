Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqB3wn4zF1s5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:26 +1000 (AEST)
In-Reply-To: <20180328185531.10945-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Matt Brown <matthew.brown.dev@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3] powerpc/altivec: Add missing prototypes for altivec
Message-Id: <40skq96GJMz9s4w@ozlabs.org>
Date: Fri, 25 May 2018 21:41:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-28 at 18:55:25 UTC, Mathieu Malaterre wrote:
> Some functions prototypes were missing for the non-altivec code. Add the
> missing prototypes in a new header file, fix warnings treated as errors
> with W=1:
> 
>   arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for ‘xor_altivec_2’ [-Werror=missing-prototypes]
>   arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for ‘xor_altivec_3’ [-Werror=missing-prototypes]
>   arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for ‘xor_altivec_4’ [-Werror=missing-prototypes]
>   arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for ‘xor_altivec_5’ [-Werror=missing-prototypes]
> 
> The prototypes were already present in <asm/xor.h> but this header file is
> meant to be included after <include/linux/raid/xor.h>. Trying to re-use
> <asm/xor.h> directly would lead to warnings such as:
> 
>   arch/powerpc/include/asm/xor.h:39:15: error: variable ‘xor_block_altivec’ has initializer but incomplete type
> 
> Trying to re-use <asm/xor.h> after <include/linux/raid/xor.h> in
> xor_vmx_glue.c would in turn trigger the following warnings:
> 
>   include/asm-generic/xor.h:688:34: error: ‘xor_block_32regs’ defined but not used [-Werror=unused-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7cf76a68f1bcf69214da2812e8f615

cheers
