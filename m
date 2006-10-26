Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 214D067CD3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 17:59:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k9Q7x4gd002354
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 00:59:04 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9Q7x2kW010389
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 02:59:03 -0500 (CDT)
Subject: Re: MPC7448_HPC2 question
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1161783936.22582.89.camel@localhost.localdomain>
References: <1161753605.22582.42.camel@localhost.localdomain>
	<1161768688.17597.8.camel@localhost.localdomain>
	<1161783936.22582.89.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1161849578.21362.14.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 26 Oct 2006 15:59:38 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Alexandre.Bounine@tundra.com" <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 21:45, Benjamin Herrenschmidt wrote:
> On Wed, 2006-10-25 at 17:31 +0800, Zang Roy-r61911 wrote:
> > On Wed, 2006-10-25 at 13:20, Benjamin Herrenschmidt wrote:
> > 
> > > 
> > > Cannot be replaced by:
> > > 
> > >         pci_read_irq_line(dev);
> > 
> > When I use pci_read_irq_line(), the pci interrupt number exceeds the
> > limit of mpic-> irq_count. my mpic->irq_count = 0x18, which is
> gotten
> > from on chip register. 
> > 
> > mpic_host_map() can not return successful value.
> 
> That is not normal... Something must be wrong with your code or your
> DT... can you get more details about what precisely is happening in
> both
> cases ?
> 
> Ben.
> 

I think I have gotten the point. For tsi108/9, there are 24 internal
interrupt. PCI/INTA  to PCI/INTD are routed to interrupt 23 with a
special mechanism on the chip. INTA to INTD are assiged to nubmer 36 to
39, which are exceed the nubmer irq number assigned in mpic_alloc().
This cause abnormal return in function pci_read_irq_line().
I have worked out a patch. after a test, I will publish it.
Roy
