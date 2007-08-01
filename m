Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E78F9DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 18:36:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Date: Wed, 1 Aug 2007 10:36:31 +0200
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200708010025.33732.arnd@arndb.de> <46AFD0C8.5010704@mvista.com>
In-Reply-To: <46AFD0C8.5010704@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708011036.31601.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 01 August 2007, Dave Jiang wrote:
> Do you mean the pci_controller hose that's allocated in fsl_add_bridge? Couple
> questions....
> 1. How do I even get access to that? (in fsl_soc.c that is)
> 2. pci_controller has no "struct device" member. It only has "struct device
> *parent". What do I set the dev->parent of the platform device to?

You already have the device_node, and can simply call
of_find_device_by_node() on it to get the of_device.

The current fsl_pci code does not use the of_device of the hose but
adds the hose at the top of the device tree, afaics, but that can
change when the ppc32 PCI initialization gets changed to do the
initialization later during boot.

	Arnd <><
