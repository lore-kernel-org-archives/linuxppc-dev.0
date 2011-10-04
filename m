Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4942BB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 02:30:48 +1100 (EST)
Received: from mail117-va3 (localhost.localdomain [127.0.0.1])	by
	mail117-va3-R.bigfish.com (Postfix) with ESMTP id 911ED2A021A	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2011 15:30:42 +0000 (UTC)
Message-ID: <4E8B269C.5020606@freescale.com>
Date: Tue, 4 Oct 2011 10:30:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: Request_irq fails for IRQ2
References: <40631E9A2581F14BA60888C87A76A1FE014773@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE014773@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/2011 06:21 AM, smitha.vanga@wipro.com wrote:
> Hi Scott,
> 
> I am able to register the IRQ now once I add the call irq_set_default_host in cpm2_pic.
> But when I call enable_irq the code throws the below warning and gives exception in enable irq at 
> spin_unlock_irqrestore(&desc->lock, flags); in enable_irq.
> 
> 
> printk(KERN_WARNING "Unbalanced enable for IRQ %d\n", irq);

The IRQ is automatically enabled when you request it.  Only call
enable_irq() if you previously called disable_irq().

-Scott
