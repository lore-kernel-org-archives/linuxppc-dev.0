Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7FF83DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 19:19:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support
	ofMPC8641D
Date: Thu, 24 May 2007 11:19:23 +0200
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<200705230105.53013.arnd@arndb.de>
	<46B96294322F7D458F9648B60E15112C307037@zch01exm26.fsl.freescale.net>
In-Reply-To: <46B96294322F7D458F9648B60E15112C307037@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705241119.23793.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 May 2007, Zhang Wei-r63237 wrote:
> Of_platform_driver is a good framework. But this RapidIO driver is not a
> device driver. It's a _bus_ driver very similar to PCI bus. So,
> of_platform_driver is not fit here.

But there is not a fundamental difference between the two. In the Linux
driver model, a bus driver is a simply device driver whose devices have
other devices as child nodes.

Your example of PCI buses fits well here. Traditionally, each platform
had its own PCI scanning code that went looking for pci host bridges.
Now we have the of_pci_phb_driver in arch/powerpc/kernel/of_platform.c
that automatically sets up the bridges, and the platform only
needs to provide a ppc_md.pci_setup_phb() callback.

	Arnd <><
