Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F424B7BF4
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 21:22:48 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix segment mapping in vdso32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2bpkoomlw.fsf@whitebox.home>
References: <m2bpkoomlw.fsf@whitebox.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Oct 2009 21:22:09 +1000
Message-Id: <1254568929.7122.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-03 at 11:25 +0200, Andreas Schwab wrote:
> Due to missing segment assignments the .text section was put in the NOTES
> segment (and marked as NOTE section), and the .got was put in the DYNAMIC
> segment.

Ouch, good catch ! Thanks.

Cheers,
Ben.

> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/powerpc/kernel/vdso32/vdso32.lds.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
> index 904ef13..0546bcd 100644
> --- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
> +++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
> @@ -25,7 +25,7 @@ SECTIONS
>  	. = ALIGN(16);
>  	.text		: {
>  		*(.text .stub .text.* .gnu.linkonce.t.* __ftr_alt_*)
> -	}
> +	}		      	      			:text
>  	PROVIDE(__etext = .);
>  	PROVIDE(_etext = .);
>  	PROVIDE(etext = .);
> @@ -56,7 +56,7 @@ SECTIONS
>  	.fixup		: { *(.fixup) }
>  
>  	.dynamic	: { *(.dynamic) }		:text	:dynamic
> -	.got		: { *(.got) }
> +	.got		: { *(.got) }			:text
>  	.plt		: { *(.plt) }
>  
>  	_end = .;
> -- 
> 1.6.4.4
> 
