Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D6993B70B7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2011 18:07:57 +1100 (EST)
Subject: RE: Request_irq fails for IRQ2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: smitha.vanga@wipro.com
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE014773@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE014773@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 09:07:44 +0200
Message-ID: <1318144064.29415.361.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-10-04 at 11:21 +0000, smitha.vanga@wipro.com wrote:
> Hi Scott,
> 
> I am able to register the IRQ now once I add the call irq_set_default_host in cpm2_pic.

This is a band-aid at best and will probably not be accepted upstream.

You should -really- describe your interrupt in the device-tree instead.

Ben.


> But when I call enable_irq the code throws the below warning and gives exception in enable irq at 
> spin_unlock_irqrestore(&desc->lock, flags); in enable_irq.
> 
> 
> printk(KERN_WARNING "Unbalanced enable for IRQ %d\n", irq);
> 
> Regards,
> Smitha
> Please do not print this email unless it is absolutely necessary. 
> 
> The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 
> 
> WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 
> 
> www.wipro.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
