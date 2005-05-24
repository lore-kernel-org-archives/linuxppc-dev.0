Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8CB2B679F6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2005 04:48:20 +1000 (EST)
Date: Tue, 24 May 2005 19:05:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <42926A07.20706@am.sony.com>
Message-ID: <Pine.LNX.4.62.0505241905020.3229@numbat.sonytel.be>
References: <42926A07.20706@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] add machine state register support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 May 2005, Geoff Levand wrote:
> This patch adds routines to get and set the machine state register.  These 
> are needed by power management code on some platforms.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
> 
> --
> 
> Index:linux-2.6.11/arch/ppc/kernel/misc.S
> ===================================================================
> --- linux-2.6.11.orig/arch/ppc/kernel/misc.S	2005-04-15 14:59:12.408518820 -0700
> +++ linux-2.6.11/arch/ppc/kernel/misc.S	2005-04-15 14:59:34.005586781 -0700
> 
> @@ -1160,6 +1159,14 @@
>  	addi	r1,r1,16
>  	blr
>  
> +_GLOBAL(_get_msr)
> +	mfmsr   r3
> +	blr
> +
> +_GLOBAL(_set_msr)
> +	mtmsr   r3
> +	blr
> +

Please check m[ft]msr() in <asm/reg.h>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
