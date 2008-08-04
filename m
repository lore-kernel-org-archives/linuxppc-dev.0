Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	by ozlabs.org (Postfix) with ESMTP id 55935DDF28
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 06:08:41 +1000 (EST)
Received: from [134.82.224.137] (wifi224-137.bucknell.edu [134.82.224.137])
	(authenticated bits=0)
	by ivory.bucknell.edu (8.14.2/8.14.2) with ESMTP id m74K8XJh015226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Mon, 4 Aug 2008 16:08:38 -0400
Message-ID: <489761C1.8030805@bucknell.edu>
Date: Mon, 04 Aug 2008 16:08:33 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PCI support on the ML310 (Linux 2.4/2.6)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to get PCI support on the ML310. I was able to port Linux 
2.6 (linux-2.6-virtex from Secret Lab) onto the board, but unfortunately 
there is no PCI support in the kernel. When I enabled PCI support, I got 
the same errors (see below) that were reported on the Secret Lab Wiki.


  CC      arch/ppc/syslib/ppc4xx_setup.o
arch/ppc/syslib/ppc4xx_setup.c: In function `ppc4xx_map_io':
arch/ppc/syslib/ppc4xx_setup.c:118: error: `PPC4xx_PCI_IO_VADDR' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:118: error: (Each undeclared identifier 
is reported only once
arch/ppc/syslib/ppc4xx_setup.c:118: error: for each function it appears in.)
arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_PADDR' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_SIZE' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:120: error: `PPC4xx_PCI_CFG_VADDR' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_PADDR' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_SIZE' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:122: error: `PPC4xx_PCI_LCFG_VADDR' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_PADDR' 
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_SIZE' 
undeclared (first use in this function)
make[1]: *** [arch/ppc/syslib/ppc4xx_setup.o] Error 1
make: *** [arch/ppc/syslib] Error 2


I went back to Linux 2.4 (v2.4.20_mvl31-ml300), but the system hangs 
during ml310_init( ), specifically when it gets to pci_init( ), in 
ml310.c. I put some print statements in ml310.c to debug and found out 
that it gets pass the first two lines in pci_init( ) before hanging. 
Basically, all I get on my screen is:


Xilinx ML310 Board-Specific Initialization:


ml310_init( ) looks like this:


void
ml310_init()
{
    prints("\n\n");
    prints("Xilinx ML310 Board-Specific Initialization:\n");
    prints("\n");


    pci_init();
    ppb_init(9);
    pci_scan();
    sio_init();
    sbr_init();
};


and pci_init( ) looks like this:


void
pci_init()
{
    /* self-configuration */
    WR32(PCI_CONFIG_ADDR, htole32(0x80004004)); // address
    WR32(PCI_CONFIG_DATA, htole32(0xffff0147)); // data
    /* max latency timer on bridge */
    WR32(PCI_CONFIG_ADDR, htole32(0x8000400c)); // address
    WR32(PCI_CONFIG_DATA, htole32(0x0000ff00)); // data
    /* max bus number */
    WR32(PCI_CONFIG_ADDR+8, htole32(0xff000000));
};


ml310.c was generated when I made the BSP in Xilinx EDK 9.1. I copied 
it, along with the other files from the BSP, into the kernel source. I 
am using a Crosstool cross-compiler, gcc-3.4.1-glibc-2.3.3. I have also 
tried the linuxppc-2.4 and mvistappc_2_4_devel kernels from 
source.mvista.com, but those both crashed with similar (and several) 
errors concerning ide-taskfile.c during compilation.

Is anybody aware of how to manually map the PCI constants in 2.6 and 
willing to help me map them? Does anybody have an idea why pci_init( ) 
is getting stuck? Any suggestions, in general, would be greatly appreciated.

Let me know if I need to provide more information or code. Thanks!


-Juliana
