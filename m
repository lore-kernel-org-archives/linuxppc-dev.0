Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9DCCDDED0
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 00:32:45 +1000 (EST)
In-Reply-To: <20070616000618.706193913@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.706193913@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <43F789E2-BBB2-4382-9DA2-619357E9E006@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 5/9] kill isa_{io,mem}_base definitions for !PCI
Date: Sun, 17 Jun 2007 09:33:27 -0500
To: arnd@arndb.de
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 15, 2007, at 7:05 PM, arnd@arndb.de wrote:

> When CONFIG_PCI is disabled, the definitions for isa_io_base,
> isa_mem_base and pci_dram_offset are entirely unused, but they
> can result in link failure because they are defined in multiple
> places.
>
> The easiest fix is to just remove all these definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[snip]


> Index: linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> @@ -54,12 +54,6 @@
>
>  #define MPC7448HPC2_PCI_CFG_PHYS 0xfb000000
>
> -#ifndef CONFIG_PCI
> -isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
> -isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE;
> -pci_dram_offset = MPC7448_HPC2_PCI_MEM_OFFSET;
> -#endif
> -
>  extern void _nmask_and_or_msr(unsigned long nmask, unsigned long  
> or_val);

can you remove the defines in mpc7448_hpc2.h since they are appear to  
only be used here.

[snip]

- k
