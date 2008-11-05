Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9754DDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 07:30:27 +1100 (EST)
Subject: Re: [PATCH 9/10] powerpc/pci: Fix various pseries PCI Hotplug issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18705.34001.627279.298632@cargo.ozlabs.ibm.com>
References: <1225172895.217185.958686212130.qpush@grosgo>
	<20081028054953.3DD34DE124@ozlabs.org>
	<18705.34001.627279.298632@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Nov 2008 07:30:20 +1100
Message-Id: <1225917020.13603.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-05 at 22:34 +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > The pseries PCI Hotplug code has a number of issues, ranging from
> > incorrect resource setup to crashes, depending on what is added,
> > when, whether it contains a bridge, etc etc....
> > 
> > This patch fixes a whole bunch of these, while actually simplifying
> > the code a bit, using more generic code in the process and factoring
> > out common code between adding of a PHB, a slot or a device.
> 
> This causes a compile error on Cell:
> 
> arch/powerpc/kernel/of_platform.c: In function 'of_pci_phb_probe':
> arch/powerpc/kernel/of_platform.c:287: error: implicit declaration of function 'pcibios_claim_one_bus'
> make[2]: *** [arch/powerpc/kernel/of_platform.o] Error 1

Ah right, cell +/- uses the hotplug PCI stuff to probe it's PHB, a
bit strange I admit. Probably have to take that out of CONFIG_HOTPLUG.

Ben.
