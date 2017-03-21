Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnHdg2YmbzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 14:01:27 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g2so22967857pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 20:01:27 -0700 (PDT)
Date: Tue, 21 Mar 2017 13:01:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add POWER9 copy_page() loop
Message-ID: <20170321130109.1dd058c0@roar.ozlabs.ibm.com>
In-Reply-To: <20170320234046.32718-1-anton@ozlabs.org>
References: <20170320234046.32718-1-anton@ozlabs.org>
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

On Tue, 21 Mar 2017 10:40:46 +1100
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> Add a POWER9 optimised copy_page() loop. This loop uses the new D form
> vector loads and stores, and uses dcbz to pre zero the destination.
> 
> A few questions:
> 
> - I'm using a nested feature section, but that is going to get unwieldy
>   at some stage. It would be nice to update the call site for copy_page
>   directly.

I've got a patch that makes alternate feature patching a bit
more flexible and not hit relocation limits when using big "else"
parts. I was thinking of doing something like

_GLOBAL_TOC(copy_page)
BEGIN_FTR_SECTION_NESTED(50)
#include "copypage_power9.S"
FTR_SECTION_ELSE_NESTED(50)
#include "copypage_power7.S"
ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_300, 50)

Patching callers directly is another option though. I'll bug mpe
about it again when he's least expecting it.

> - I'm using CPU_FTR_ARCH_300, but as our functions grow perhaps we want
>   the cputable entry to contain a pointer to optimised functions.

We might be able to do some nested alternatives macros to hide the
details and allow an IFSET / ELSEIFSET / etc / ELSE.

> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/lib/Makefile          |   2 +-
>  arch/powerpc/lib/copypage_64.S     |   4 +
>  arch/powerpc/lib/copypage_power9.S | 224 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 229 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/lib/copypage_power9.S
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 2b5e090..d3667b5 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
>  
>  obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
>  	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
> -	   memcpy_64.o memcmp_64.o
> +	   memcpy_64.o memcmp_64.o copypage_power9.o
>  
>  obj64-$(CONFIG_SMP)	+= locks.o
>  obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
> diff --git a/arch/powerpc/lib/copypage_64.S b/arch/powerpc/lib/copypage_64.S
> index 4bcc9e7..051423e 100644
> --- a/arch/powerpc/lib/copypage_64.S
> +++ b/arch/powerpc/lib/copypage_64.S
> @@ -21,7 +21,11 @@ _GLOBAL_TOC(copy_page)
>  BEGIN_FTR_SECTION
>  	lis	r5,PAGE_SIZE@h
>  FTR_SECTION_ELSE
> +  BEGIN_FTR_SECTION_NESTED(50)
> +	b	copypage_power9
> +  FTR_SECTION_ELSE_NESTED(50)
>  	b	copypage_power7
> +  ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_300, 50)
>  ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
>  	ori	r5,r5,PAGE_SIZE@l
>  BEGIN_FTR_SECTION
> diff --git a/arch/powerpc/lib/copypage_power9.S b/arch/powerpc/lib/copypage_power9.S
> new file mode 100644
> index 0000000..2493f94
> --- /dev/null
> +++ b/arch/powerpc/lib/copypage_power9.S
> @@ -0,0 +1,224 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (C) IBM Corporation, 2017
> + *
> + * Author: Anton Blanchard <anton@au.ibm.com>
> + */
> +#include <asm/page.h>
> +#include <asm/ppc_asm.h>
> +
> +_GLOBAL(copypage_power9)
> +	/*
> +	 * We prefetch the source using enhanced touch instructions. We use
> +	 * a stream ID of 0 for this. Since the source is page aligned we
> +	 * don't need to clear the bottom 7 bits of the address.
> +	 */
> +#ifdef CONFIG_PPC_64K_PAGES
> +	lis	r7,0x0E01	/* depth=7
> +				 * units/cachelines=512 */
> +#else
> +	lis	r7,0x0E00	/* depth=7 */
> +	ori	r7,r7,0x1000	/* units/cachelines=32 */
> +#endif
> +
> +	lis	r8,0x8000	/* GO=1 */
> +	clrldi	r8,r8,32
> +
> +.machine push
> +.machine "power4"
> +	/* setup read stream 0 */
> +	dcbt	r0,r4,0b01000	/* addr from */
> +	dcbt	r0,r7,0b01010	/* length and depth from */
> +	eieio
> +	dcbt	r0,r8,0b01010	/* all streams GO */
> +	eieio
> +.machine pop

I guess POWER asm doesn't need this but it's good practice to prevent
copy paste errors? It would be nice to have some macros to hide all these
constants, but that's for another patch. The commenting is good.

I don't suppose the stream setup is costly enough to consider touching a
cacheline or two ahead before starting it?

> +
> +	/*
> +	 * To reduce memory bandwidth on the store side we send dcbzs ahead.
> +	 * Experimental testing shows 2 cachelines as good enough.
> +	 */
> +	li	r6,128
> +	dcbz	0,r3
> +	dcbz	r6,r3
> +
> +#ifdef CONFIG_ALTIVEC
> +	mflr	r0
> +	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
> +	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
> +	std	r0,16(r1)
> +	stdu	r1,-STACKFRAMESIZE(r1)
> +	bl	enter_vmx_copy
> +	cmpwi	r3,0
> +	ld	r0,STACKFRAMESIZE+16(r1)
> +	ld	r3,STK_REG(R31)(r1)
> +	ld	r4,STK_REG(R30)(r1)
> +	addi	r1,r1,STACKFRAMESIZE
> +	mtlr	r0

(Also for another day) We might be able to avoid the stack and call
for some common cases. Pretty small overcall cost I guess, but it could
be beneficial for memcpy if not copy_page.

Thanks,
Nick
