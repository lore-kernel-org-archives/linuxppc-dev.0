Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (unknown [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3DB82DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 07:08:09 +1100 (EST)
Date: Wed, 21 Mar 2007 15:22:11 -0500
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070321202211.GA9682@lixom.net>
References: <20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
	<46018A00.9080703@freescale.com>
	<7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
	<46018F7B.40107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46018F7B.40107@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 03:03:07PM -0500, Timur Tabi wrote:
> Segher Boessenkool wrote:
> 
> >> If the property exists in the device tree, then it should be used, no? 
> >>  Whether or not it exists is not for the driver to decide.
> > 
> > The property doesn't describe anything about the device;
> > it merely tells you something about what the firmware did
> > during booting.
> 
> Ah, I see your point.  But how else can the bootloader tell the kernel what MAC address to 
> use?  You need to make sure that both use the same address.  I don't think the kernel 
> command line supports MAC addresses.
> 
> > Just everything everywhere that mentions "mac-address" should be
> > completely and utterly eradicated :-)
> 
> Are you saying that Linux should not acknowledge the existence of the mac-address 
> property, even though it's part of the OF spec?

Why? It's a property of the device -- the mac address it was assigned by
the vendor. It might not be a property of the ethernet controller chip,
but of the adapter it is.

> Depends on what you mean by a fix.  Although I understand your point that the MAC address 
> doesn't really belong in the device tree, I don't see any better place for it.  So for 

Right, there's no other place that makes sense. Leave it in there.

> now, I'm going on the assumption that mac-address and local-mac-address are valid 
> properties, so it's just a question on *how* they should be supported.  In that context, 
> the kernel has been updated already, and some of U-Boot has also.  Well, I'm ignoring some 
> of the more obscure IBM systems, because I don't know anything about them.  All that's 
> left is 85xx, 86xx, and 5xxx, and then I can clean up the DTS files, and then as far as 
> I'm concerned, I'm done.

We're using them in our driver/device tree as well.


-Olof
