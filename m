Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3ACD9B6F19
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 20:02:39 +1100 (EST)
Subject: Re: PCI interrupt question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Hane <jeff.hane@maxim-ic.com>
In-Reply-To: <1259869140.18190.52.camel@qu102.quarc.com>
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
	<1259869140.18190.52.camel@qu102.quarc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 20:02:32 +1100
Message-ID: <1259917352.2076.1267.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  So are you saying linux should be writing the irq number to the
> INTERRUPT_LINE config reg?  This is what I expected but I do not see
> it.  

No it won't necessarily touch it, this is not terribly useful anyways.
Linux will assign an interrupt based on the informations from the
device-tree and you should be able to retrieve it in pci_dev->irq.

>  I believe the DTS is being parsed properly and the connection is made
> to the correct interrupt line on the device.  But somebody still needs
> to assign and IRQ number, right?  

What do you mean ? If the connection is made properly, the code will
obtain an HW IRQ input number on the UIC and will map it to a linux
virtual IRQ number which you can find in pci_dev->irq.
 
> This is the part that is not clear,
> there is an irq field in pci_dev structure which is filled in after
> looking at the DTS and I just want to be sure this is the irq number to
> be used when calling request_irq.

Yes, it is.

If things don't work, it's possible that you assigned the wrong number
in the device-tree ?

Cheers,
Ben.

> thanks,
> jeff
> 
> 
> 
> > These comments might not be 100% correct, but the list of things
> > to check should be close enough for you to track down your
> > problem.
> > 
> > Cheers,
> > Dave
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
