Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 50A7A67D92
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:52:08 +1100 (EST)
Date: Mon, 13 Nov 2006 07:23:16 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 12/16] powerpc: add ps3 platform interrupt support
In-Reply-To: <4554DB08.6050804@am.sony.com>
Message-ID: <Pine.LNX.4.62.0611130720040.16998@pademelon.sonytel.be>
References: <4554DB08.6050804@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Geoff,

On Fri, 10 Nov 2006, Geoff Levand wrote:
> +static struct irq_chip irq_chip = {
> +	.name = "ps3pf",
> +	.mask = chip_mask,
> +	.unmask = chip_unmask,
> +	.eoi = chip_eoi,
> +};

For 2.6.19, you have to set .typename, not .name, else /proc/interrupts prints
`<NULL>'.

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Index: linux-ps3-geert/arch/powerpc/platforms/ps3pf/interrupt.c
===================================================================
--- linux-ps3-geert.orig/arch/powerpc/platforms/ps3pf/interrupt.c	2006-11-10 16:56:32.000000000 +0900
+++ linux-ps3-geert/arch/powerpc/platforms/ps3pf/interrupt.c	2006-11-13 14:52:31.000000000 +0900
@@ -423,7 +423,7 @@ chip_eoi (unsigned int virq)
 
 static struct irq_chip irq_chip =
 {
-	.name = "ps3pf",
+	.typename = "ps3pf",
 	.mask = chip_mask,
 	.unmask = chip_unmask,
 	.eoi = chip_eoi,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
