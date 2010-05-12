Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEB9FB7DFB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 20:30:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4CANQP5002954
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2010 04:23:26 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o4CAUg6q187430
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2010 04:30:43 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4CAUclC005627
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2010 04:30:38 -0600
Date: Wed, 12 May 2010 06:30:37 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix UART clocks on 440SPe
Message-ID: <20100512103037.GD10526@zod.rchland.ibm.com>
References: <1273630970.21352.85.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273630970.21352.85.camel@pasglop>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 12, 2010 at 12:22:50PM +1000, Benjamin Herrenschmidt wrote:
>The code to fixup the serial ports on 440SPe uses the incorrect
>addresses for these. This fixes it.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>---
>
>I'm surprised nobody noticed, serial is pretty busted for me without
>that patch :-)

Odd.  I don't have a 440SPe, so no surprise there but I would have thought
someone would notice.  Though this is only needed if you are using an older
U-Boot that needs cuImage, and I'm guessing Stefan runs u-boot.git on his
boards ;)

>
>diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
>index 27db893..627de25 100644
>--- a/arch/powerpc/boot/4xx.c
>+++ b/arch/powerpc/boot/4xx.c
>@@ -544,9 +544,9 @@ void ibm440spe_fixup_clocks(unsigned int sys_clk,
> 	unsigned int plb_clk = __ibm440eplike_fixup_clocks(sys_clk, tmr_clk, 1);
>
> 	/* serial clocks beed fixup based on int/ext */

You couldn't be bothered to fixup the typo?  s/beed/need ;)  I'll fix it when
I bring this in.

>-	eplike_fixup_uart_clk(0, "/plb/opb/serial@10000200", ser_clk, plb_clk);
>-	eplike_fixup_uart_clk(1, "/plb/opb/serial@10000300", ser_clk, plb_clk);
>-	eplike_fixup_uart_clk(2, "/plb/opb/serial@10000600", ser_clk, plb_clk);
>+	eplike_fixup_uart_clk(0, "/plb/opb/serial@f0000200", ser_clk, plb_clk);
>+	eplike_fixup_uart_clk(1, "/plb/opb/serial@f0000300", ser_clk, plb_clk);
>+	eplike_fixup_uart_clk(2, "/plb/opb/serial@f0000600", ser_clk, plb_clk);
> }
