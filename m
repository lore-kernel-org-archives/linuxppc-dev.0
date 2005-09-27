Return-Path: <hollis@penguinppc.org>
Received: from smtpauth04.mail.atl.earthlink.net
	(smtpauth04.mail.atl.earthlink.net [209.86.89.64])
	by ozlabs.org (Postfix) with ESMTP id 35F4E683B6
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 10:09:25 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0509250043410.19178@scrub.home>
References: <Pine.LNX.4.61.0509250043410.19178@scrub.home>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <96e9df75a769d22905026438cb4c5131@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Mon, 26 Sep 2005 19:00:02 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/8] ppc: use correct asm ops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 24, 2005, at 5:43 PM, Roman Zippel wrote:
>
> Use the correct assembler instructions, which match
> __do_in_asm/__do_out_asm.

Could you define "correct" here?

> --- linux.orig/include/asm-ppc/io.h	2005-09-23 16:20:24.000000000 +0200
> +++ linux/include/asm-ppc/io.h	2005-09-23 16:20:26.000000000 +0200
> @@ -294,10 +294,10 @@ extern __inline__ void name(unsigned int
>  __do_out_asm(outb, "stbx")
>  #ifdef CONFIG_APUS
>  __do_in_asm(inb, "lbzx")
> -__do_in_asm(inw, "lhz%U1%X1")
> -__do_in_asm(inl, "lwz%U1%X1")
> -__do_out_asm(outl,"stw%U0%X0")
> -__do_out_asm(outw, "sth%U0%X0")
> +__do_in_asm(inw, "lhzx")
> +__do_in_asm(inl, "lwzx")
> +__do_out_asm(outl,"stwx")
> +__do_out_asm(outw, "sthx")
>  #elif defined (CONFIG_8260_PCI9)
>  /* in asm cannot be defined if PCI9 workaround is used */
>  #define inb(port)		in_8((port)+___IO_BASE)

I don't see where this is explained in the GCC docs, but as I 
understand it those %U %X things are allowing somebody to use the 
"update" and "index" variants of the instruction. Why doesn't this work 
for you?

-Hollis
