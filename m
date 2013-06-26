Return-Path: <stefani@seibold.net>
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 22BCF2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 15:21:26 +1000 (EST)
Message-ID: <1372224092.3374.5.camel@wall-e>
Subject: Re: BUG: no PCI/PCIe devices found in 85xx architecture
From: Stefani Seibold <stefani@seibold.net>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 26 Jun 2013 07:21:32 +0200
In-Reply-To: <1372203995.8183.26@snotra>
References: <1372203995.8183.26@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, den 25.06.2013, 18:46 -0500 schrieb Scott Wood:
> On 06/25/2013 01:40:14 PM, Stefani Seibold wrote:
> > Hi,
> > 
> > there is a bug in kernel 3.9 which the new fsl_pci platform driver.  
> > The
> > pcibios_init in pci_32.c will be called before the platform driver  
> > probe
> > will be invoked.
> > 
> > The call order for a p2020 board with linux 3.9 is currently:
> > 
> > fsl_pci_init
> > pcibios_init
> > fsl_pci_probe
> > fsl_pci_probe
> > fsl_pci_probe
> > 
> > Therefore the PCI/PCIe bridge will be added after the PCI/PCIe busses
> > was scanned for devices. So no PCI/PCIe devices are available.
> > 
> > Everything works fine by reverting the fsl_pci.[ch] to the version in
> > linux 3.4, because the PCI/PCIe bridges will be added in
> > the ..._setup_arch() function, before the pcibios_init function is
> > called.
> > 
> > Any solution for this issue?
> 
> I can't reproduce this on p3041 -- pcibios_init gets called after  
> fsl_pci_probe, and its PCIe e1000 gets detected and used.
> 
> fsl_pci_probe should be called when of_platform_bus_probe is called,  
> which is in a machine_arch_initcall.  pcibios_init is a  
> subsys_initcall, which should happen later.
> 
> Which p2020 board are you using?  Could you check when it is calling  
> of_platform_bus_probe?
> 
> -Scott

Great, you are my hero. This is the solution.

In my old board support package for the kernel 3.4 there was a
machine_device_initcall(). I did not saw the tiny difference against
machine_arch_initcall() used by the other 85xx boards as i ported it to
3.9.

Thanks

- Stefani
