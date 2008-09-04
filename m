Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DAD2DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 00:45:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m84Ej1P0029167
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 07:45:02 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m84EivYB008726
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 09:44:58 -0500 (CDT)
Date: Thu, 4 Sep 2008 09:44:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: Oscar Takeshita <oscar@silvustechnologies.com>
Subject: Re: Hooking an IRQ on a modified mpc8349emitx board
Message-ID: <20080904144457.GA2522@ld0162-tx32.am.freescale.net>
References: <48BF15ED.4050707@silvustechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BF15ED.4050707@silvustechnologies.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2008 at 03:55:41PM -0700, Oscar Takeshita wrote:
> I've been trying to hook an IRQ on a modified mpc8349emitx board without 
> success.
> 
> The IRQ is hooked physically to IRQ1/GPIO2[13] on the mpc8349e. No other 
> devices are
> tied to this pin.
> 
> I'm using uboot 1.2.0 and kernel 2.6.22.19.
> 
> Do I need to have a dts entry for this interrupt in order to make
> request_irq() succeed?
> 
> How can I find the IRQ number? I tried probe_irq_on/off unfortunately it 
> did not work.
> Would it be MPC83xx_IRQ_EXT1 in arch/powerpc/include/asm/mpc83xx.h ?
> 
> I'm new doing kernel work. Any hints appreciated.

You need to describe the IRQ in a device tree node and use
irq_of_parse_and_map().  request_irq() takes virtual IRQ numbers.

Maybe we should put together an arch/powerpc FAQ...

-Scott
