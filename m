Return-Path: <stefani@seibold.net>
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0EA2B2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:40:09 +1000 (EST)
Received: from [37.5.209.66] (helo=[192.168.0.4])
 by www84.your-server.de with esmtpsa (SSLv3:AES256-SHA:256)
 (Exim 4.74) (envelope-from <stefani@seibold.net>) id 1UrY9q-00079H-Tr
 for linuxppc-dev@lists.ozlabs.org; Tue, 25 Jun 2013 20:40:03 +0200
Message-ID: <1372185614.4726.12.camel@wall-e>
Subject: BUG: no PCI/PCIe devices found in 85xx architecture
From: Stefani Seibold <stefani@seibold.net>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Jun 2013 20:40:14 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

there is a bug in kernel 3.9 which the new fsl_pci platform driver. The
pcibios_init in pci_32.c will be called before the platform driver probe
will be invoked.

The call order for a p2020 board with linux 3.9 is currently:

fsl_pci_init
pcibios_init
fsl_pci_probe
fsl_pci_probe
fsl_pci_probe

Therefore the PCI/PCIe bridge will be added after the PCI/PCIe busses
was scanned for devices. So no PCI/PCIe devices are available.

Everything works fine by reverting the fsl_pci.[ch] to the version in
linux 3.4, because the PCI/PCIe bridges will be added in
the ..._setup_arch() function, before the pcibios_init function is
called.

Any solution for this issue?

- Stefani
