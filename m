Return-Path: <det.nicolas@free.fr>
Received: from smtp3.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 4BE7867A67
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 21:58:40 +1100 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0309.wanadoo.fr (SMTP Server) with ESMTP id 9A00B1C007EC
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 11:58:38 +0100 (CET)
Received: from free.fr (ALyon-151-1-10-64.w83-113.abo.wanadoo.fr
	[83.113.150.64])
	by mwinf0309.wanadoo.fr (SMTP Server) with ESMTP id 3DB6C1C007DE
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 11:58:38 +0100 (CET)
From: Nicolas DET <det.nicolas@free.fr>
To: linuxppc-dev@ozlabs.org
Cc: 
Date: 07 Mar 2005 11:58:09 +0100
In-Reply-To: <20050307065210.GA21270@pegasos>
Message-Id: <20050307105838.3DB6C1C007DE@mwinf0309.wanadoo.fr>
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Sven,

On 07/03/2005, you wrote:

> But i hear Nicolas has done some useful work yesterday evening, i will
> review it as soon as he is back from dreamland :)

You can find the patch against 2.6.11 from kernel.org here:
http://powernico.free.fr/patch_2.6.11_mv64x60.diff.bz2

This patch shouldn't break mv code for others platform (non PegasosII), and
fix Pegasos II init...

Basicly, I added mv64360_ispegasos2() in include/asm-ppc/mv64x60.h. Then:

in arch/ppc/syslibs/mv64360_pic.c, I skip the IRQ init code
in arch/ppc/syslibs/mv64x60.c, I skip all the chip init & patch the
ressources tables for Pegasos II hardware (register base & IRQ).
in include/asm-ppc/mv64x60.h: added mv64360_ispegasos2()
in arch/ppc/kernel/chrp_setup.c, rename/added pegasos2_stuff() and call
mv64x60_init() if CONFIG_MV64x60
in drivers/net/mv64xx_eth.c, use SA_SHIRQ instead of SA_INTERRUPT for
request_irq if pegasos II detected

The only thing to do is to add mv64360_ispegasos2() in include/asm-mips/...
because I use this function to use the correct flags in the ethernet
driver.

Of course, this patch may be discuss as there are several architecture
using Marvell chipsets and each requieres some specific code.
I don't know where it's the best to place mv64360_ispeasos2(), maybe this
func could even be renamed mv64x60_ispegasos2()..

Please, people from others MV64x60 architectures review this patch, modify
if it neeeded and check it doesn't break your architecture (I shouldn't but
for MIPS ethernet).

Regards
-- 
Nicolas DET
MorphOS & Linux developer
