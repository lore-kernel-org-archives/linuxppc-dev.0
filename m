Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87709DE04D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:54:34 +1000 (EST)
Subject: Re: pci issue - wrong detection of pci ressources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1208566122.6958.425.camel@pasglop>
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>
Content-Type: text/plain
Date: Sat, 19 Apr 2008 10:51:15 +1000
Message-Id: <1208566275.6958.427.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-04-19 at 10:48 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2008-04-18 at 14:07 +0200, Christian Ehrhardt wrote:
> > => Region 2 is not detected with our kernel, this later break things
> > like radeonfb initialization.
> 
> I'll need some information here:
> 
> - Your device-tree (is that the base sequoia one ?)
> - Enable DEBUG in arch/powerpc/kernel/pci-common.c and pci_32.c
> - Send me the resulting dmesg log
> - Also include the output of /proc/iomem

Actually, there's a bug in radeonfb:

In radeonfb.h, try changing

	unsigned long		mmio_base_phys;
	unsigned long		fb_base_phys;

To

	resource_size_t		mmio_base_phys;
	resource_size_t		fb_base_phys;

And tell us if it makes a difference too.

Cheers,
Ben.
