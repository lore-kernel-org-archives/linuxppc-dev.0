Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9281BB7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 17:35:41 +1000 (EST)
Date: Fri, 23 Apr 2010 09:35:30 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: stevedeiters@basler.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <488136846.346871272008130135.JavaMail.ngmail@webmail06.arcor-online.net>
In-Reply-To: <181804936ABC2349BE503168465576460E8723C5@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460E8723C5@exchserver.basler.com>
Subject: Re: [PATCH] Fixes for MPC512x PSC
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steve:

A while ago I posted a patch which improves the baud rate calculation of the '5200, but also refactors the driver a little bit so it also influences the '512x.  However, there has been some confusion about the config regs of the 521x's uart.  It would be great if you colud have a look at the patch <http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/081477.html>, in particular function mpc512x_psc_set_baudrate(), and comment on it.  Some more infor is in the thread <http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080867.html>.

Thanks in advance,
Albrecht.


----- Original Nachricht ----
Von:     Steve Deiters <SteveDeiters@BASLER.com>
An:      linuxppc-dev@lists.ozlabs.org
Datum:   23.04.2010 02:13
Betreff: [PATCH] Fixes for MPC512x PSC

> This will apply on the mpc512x-v2.6.33-devel branch of the DENX git
> repository.  This is all mostly based
> on what was in the Freescale LTIB release from the Freescale website.
> 
> On a somewhat unrelated note, does anyone know if the Freescale LTIB
> drivers have been merged into any newer
> kernel versions?  In particular, I could not find a branch that has
> drivers for the newer NAND Flash controller
> that was in the LTIB version.
> 
> 
>  In clock.c replaced clk_enable with mpc5121_clk_enable as clk_functions
> is not yet set.
>  Added initialization of the FIFO address and size registers based on
> device tree.
>  Removed port-number property from mpc5121ads device tree as the driver
> doesn't use it.
>  Made sure PSC clocks are enabled early for console.
>  Made sure interrupt is requested with IRQF_SHARED as they share the
> FIFO irq.
>  Moved initialization of CSR to mpc52xx_uart_set_termios so it is done
> for the MPC512x
>  and also so it is done early in the console setup.

Traumziele - von Beschreibung bis Buchung jetzt kompakt auf den Reise-Seiten von Arcor.de! http://www.arcor.de/rd/footer.reise
