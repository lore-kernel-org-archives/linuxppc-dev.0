Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 969DB67BB0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 02:17:41 +1000 (EST)
Message-ID: <45195296.8000405@cambridgebroadband.com>
Date: Tue, 26 Sep 2006 17:17:26 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: local_irq_save not masking interrupts
References: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
	<451900B0.7010006@cambridgebroadband.com>
	<45194F1F.7030003@freescale.com>
In-Reply-To: <45194F1F.7030003@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Scott,

Thanks for your reply.  Comments below.

Scott Wood wrote:
> Alex Zeffertt wrote:
>> Well, mpc832xemds_phy_interrupt_enable() does nothing except call
>> request_irq(,,SA_SHIRQ,,).  I suspect that request_irq() is somehow
>> reenabling interrupts, but I can't see where it might be doing so.
> 
> One possibile way (in 2.6.18; I'm assuming 2.6.11 is similar) is that 
> request_irq() calls setup_irq(), which calls register_irq_proc() and 
> register_handler_proc(), both of which call proc_mkdir(), which 
> eventually calls proc_create(), which calls kmalloc() with GFP_KERNEL. 
> This is probably a bug, since request_irq itself uses GFP_ATOMIC, 
> indicating an intent for request_irq() to be safely callable in atomic 
> context.
> 

I agree this indicates an intent to make it atomic, but I don't see how
this could cause interrupts to become re-enabled during the request_irq()
call.  Also, since I am calling request_irq at insmod time, i.e. in process
context, both GFP_ flags *should* work.

> Can you disable the interrupts at the device level until the handler is 
> in place, and thus avoid the need to disable IRQs at all?
> 
> -Scott

Yup, I've come to the same conclusion.  I now, for each shared interrupt:

* initialise all the devices which share the interrupt, turning interrupt generation off

* register all handlers for each device which shares the interrupt

* turn interrupt generation back on for each device.

This avoids the original problem, but it does not explain it.  I still
can't see how I can get an interrupt on line 3 below:

1.         local_irq_save(flags);
2.         request_irq(MPC83xx_IRQ_EXT6, handler, SA_SHIRQ, "name", dev1);
3.
4.         request_irq(MPC83xx_IRQ_EXT6, handler, SA_SHIRQ, "name", dev2);
5          local_irq_restore(flags);

Regards,

Alex
