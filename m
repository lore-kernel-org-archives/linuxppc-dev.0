Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AB10DE1E7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 03:33:01 +1000 (EST)
Message-ID: <4856A3CA.4010905@freescale.com>
Date: Mon, 16 Jun 2008 12:32:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
References: <101441.49932.qm@web83508.mail.sp1.yahoo.com>
In-Reply-To: <101441.49932.qm@web83508.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> Here's my code.  There are a few other things that happen but they are inconsequential to this
> problem.  I'm sure that the request_irq call is right, especially since it works if the fsldma
> drivers are builtin to the kernel.  Also, the irq number 71 comes from the reference manual for
> them MPC8313.  It is the internal interrupt for the DMA.  I'll do some more testing in a little
> while to try to determine the cause of the error in request_irq.

You cannot pass hardware IRQ numbers directly to request_irq() -- it has 
no idea which IRQ controller you're referring to (even if there happens 
to be only one on your board).

You should get the IRQ from the device tree, using 
irq_of_parse_and_map() on the device node for the DMA channel (see the 
mpc8377mds device tree for an example DMA node).

-Scott
