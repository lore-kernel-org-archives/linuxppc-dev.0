Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3D39F67C05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 02:02:44 +1000 (EST)
Message-ID: <45194F1F.7030003@freescale.com>
Date: Tue, 26 Sep 2006 11:02:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: local_irq_save not masking interrupts
References: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
	<451900B0.7010006@cambridgebroadband.com>
In-Reply-To: <451900B0.7010006@cambridgebroadband.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Liu Dave-r63238 <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex Zeffertt wrote:
> Well, mpc832xemds_phy_interrupt_enable() does nothing except call
> request_irq(,,SA_SHIRQ,,).  I suspect that request_irq() is somehow
> reenabling interrupts, but I can't see where it might be doing so.

One possibile way (in 2.6.18; I'm assuming 2.6.11 is similar) is that 
request_irq() calls setup_irq(), which calls register_irq_proc() and 
register_handler_proc(), both of which call proc_mkdir(), which 
eventually calls proc_create(), which calls kmalloc() with GFP_KERNEL. 
This is probably a bug, since request_irq itself uses GFP_ATOMIC, 
indicating an intent for request_irq() to be safely callable in atomic 
context.

Can you disable the interrupts at the device level until the handler is 
in place, and thus avoid the need to disable IRQs at all?

-Scott
