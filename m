Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0F971DDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 09:33:30 +1000 (EST)
Date: Mon, 10 Sep 2007 18:34:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] export new __io{re,un}map_at() symbols
Message-ID: <20070910233417.GA29773@lixom.net>
References: <20070831035851.GA24414@lixom.net>
	<18149.48608.754709.782967@cargo.ozlabs.ibm.com>
	<20070910224136.GA28808@lixom.net>
	<18149.52956.875510.937857@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18149.52956.875510.937857@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 09:10:20AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > electra_cf uses it, that driver is currently in -mm including below
> > update to use benh's rewritten interfaces:
> > 
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13237
> > 
> > It gets the effective addresses to use out of the device tree.
> 
> Huh?  What does firmware (or the device tree) know about how the
> kernel uses effective addresses?

Oh, sorry, of course it doesn't (I was thinking of the physical address
but writing effective).

I get effective address by allocating it with __get_vm_area same way
the pseries pci hotplug does:

	area = __get_vm_area(cf->io_size, 0, PHB_IO_BASE, PHB_IO_END);
	if (area == NULL)
		return -ENOMEM;

	cf->io_virt = (void __iomem *)(area->addr);


-Olof
