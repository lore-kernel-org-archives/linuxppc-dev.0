Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 762212C02CD
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 20:01:19 +1000 (EST)
Message-ID: <1369994474.3928.132.camel@pasglop>
Subject: Re: can't access PCIe card under sbc8548
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: wolfking <wolfking2000@msn.com>
Date: Fri, 31 May 2013 20:01:14 +1000
In-Reply-To: <1369960818166-71847.post@n7.nabble.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <1369931365.14679.7@snotra> <1369960818166-71847.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 17:40 -0700, wolfking wrote:
> hi, scott:
>   Thanks for replying!
> > In what specific way does it not work?
>   when I use iowrite8 to write, things seem OK, the codes continue running,
>   when I use ioread8 to read, the console I use freezes. The console stops
>   responding.
> > Why can't it succeed?  Is there nothing mapped at 0xfc7fc000?
>   My PCIe card's local bus register is at BAR0+0xC7, so the driver should
> access 0xfc7fc027 and the following 7 bytes. But When I access the areas:
> ioread8 just freezes. 

That looks more like a HW error to me unless you are hitting completely
the wrong system addresses.

What would be useful would be to add printk's to check what exact
physical address pci_iomap ends up using and whether that matches
to the iobase_phys of the PCI bridge + the BAR value of the card.

Cheers,
Ben.
