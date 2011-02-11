Return-Path: <scottwood@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87A42B7187
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 08:57:01 +1100 (EST)
Date: Fri, 11 Feb 2011 15:56:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kenny Ho <kho@belairnetworks.com>
Subject: Re: Question on setting up external interrupt for P1020 (MPC8xxx)
	with device tree
Message-ID: <20110211155644.6799f6b6@udp111988uds>
In-Reply-To: <92C536451C241244A14F3001819BF6688A503B@bnott05.belairnetworks.com>
References: <92C536451C241244A14F3001819BF6688A503B@bnott05.belairnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Feb 2011 14:07:26 -0500
Kenny Ho <kho@belairnetworks.com> wrote:

> Hi,
> 
>  
> 
> I am trying to write a device driver that uses an external interrupt
> (one of the 16 irq lines) for the Freescale P1020 processor and I hope
> some of you can help.  Am I suppose to setup a separate node in the dts
> and look for that node in my driver to setup the interrupt? 

Ideally, yes.  It's good to describe your device with a node even if it
doesn't have interrupts.

> Or does the > dts interrupt declaration belong to the interrupt-controller
> declaration?  I noticed the mpc8xxx_gpio driver defined its own irq_chip
> but I thought that may be because each gpio pin can trigger an
> interrupt.

Right, it's because gpio is an interrupt controller, not just a user of one.

> Do I need to define my own irq_chip structure for my device
> even if I am using one of the hard irq lines?  

No.  If the device's node describes the interrupt correctly, you can use
irq_of_parse_and_map() on the device node to get a virtual irq that you can
pass to request_irq().

-Scott
