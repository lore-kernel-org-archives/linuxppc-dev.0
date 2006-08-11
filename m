Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 849CC67B62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 22:42:27 +1000 (EST)
In-Reply-To: <4DA89577C33E194ABEBC978921E858541B8E3B@exchange.ingenient.net>
References: <995B09A8299C2C44B59866F6391D2635018CA7@zch01exm21.fsl.freescale.net>
	<4DA89577C33E194ABEBC978921E858541B8E3B@exchange.ingenient.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <94857DB0-ABC7-4AA5-BE5B-1CBEAA09D906@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI driver on EB8347
Date: Fri, 11 Aug 2006 07:42:19 -0500
To: rajan rai <Rajan.Rai@ingenient.com>
Cc: "Gala Kumar K.-galak" <kumar.gala@freescale.com>,
	Liu Dave-r63238 <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 11, 2006, at 4:15 AM, rajan rai wrote:

>
>                       I'm using polling mechanism and not  
> interrupts in my driver. Although I'm not using polling I see  
> strange behavior When I do lspci -v I don't see any interrupts  
> being allocated to PCI device behind PCI bridge !!!! But when I use  
> same card directly on primary bus I do see interrupt being  
> allocated to PCI device. Any advise why IRQ's being not allocated  
> in case its attached to PCI bridge ?
>
>                               Do I need to take care of any extra  
> configuration in case of PCI card is attached to PCI bridge ?

You need to make sure that the pci_map_irq/mpc83xx_map_irq function  
handles the right swizziling for the P2P bridge for your setup.  If  
you are just connected directly its pretty straight forward.  However  
IRQ assignment behind the bridge can be very board specific and so  
you need to make sure that the code is doing the right think for you.

What ever strangeness do you see from lspci?

- k
