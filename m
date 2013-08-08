Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 556042C0112
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 08:41:03 +1000 (EST)
Message-ID: <1376001597.12551.51.camel@pasglop>
Subject: Re: [PATCHv8 02/10] PCI: remove ARCH_SUPPORTS_MSI kconfig option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Fri, 09 Aug 2013 08:39:57 +1000
In-Reply-To: <1376000268-18397-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-3-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-pci@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter
 Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Jason Cooper <jason@lakedaemon.net>,
 Rob Herring <rob.herring@calxeda.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 Maen Suleiman <maen@marvell.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> Now that we have weak versions for each of the PCI MSI architecture
> functions, we can actually build the MSI support for all platforms,
> regardless of whether they provide or not architecture-specific
> versions of those functions. For this reason, the ARCH_SUPPORTS_MSI
> hidden kconfig boolean becomes useless, and this patch gets rid of it.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Daniel Price <daniel.price@gmail.com>
> Tested-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/arm/Kconfig     | 1 -
>  arch/ia64/Kconfig    | 1 -
>  arch/mips/Kconfig    | 2 --
>  arch/powerpc/Kconfig | 1 -
>  arch/s390/Kconfig    | 1 -
>  arch/sparc/Kconfig   | 1 -
>  arch/tile/Kconfig    | 1 -
>  arch/x86/Kconfig     | 1 -
>  drivers/pci/Kconfig  | 4 ----
>  9 files changed, 13 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 37c0f4e..41b6c96 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -441,7 +441,6 @@ config ARCH_NETX
>  config ARCH_IOP13XX
>  	bool "IOP13xx-based"
>  	depends on MMU
> -	select ARCH_SUPPORTS_MSI
>  	select CPU_XSC3
>  	select NEED_MACH_MEMORY_H
>  	select NEED_RET_TO_USER
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 5a768ad..098602b 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -9,7 +9,6 @@ config IA64
>  	select PCI if (!IA64_HP_SIM)
>  	select ACPI if (!IA64_HP_SIM)
>  	select PM if (!IA64_HP_SIM)
> -	select ARCH_SUPPORTS_MSI
>  	select HAVE_UNSTABLE_SCHED_CLOCK
>  	select HAVE_IDE
>  	select HAVE_OPROFILE
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c3abed3..01b5f5a 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -726,7 +726,6 @@ config CAVIUM_OCTEON_SOC
>  	select SYS_HAS_CPU_CAVIUM_OCTEON
>  	select SWAP_IO_SPACE
>  	select HW_HAS_PCI
> -	select ARCH_SUPPORTS_MSI
>  	select ZONE_DMA32
>  	select USB_ARCH_HAS_OHCI
>  	select USB_ARCH_HAS_EHCI
> @@ -762,7 +761,6 @@ config NLM_XLR_BOARD
>  	select CEVT_R4K
>  	select CSRC_R4K
>  	select IRQ_CPU
> -	select ARCH_SUPPORTS_MSI
>  	select ZONE_DMA32 if 64BIT
>  	select SYNC_R4K
>  	select SYS_HAS_EARLY_PRINTK
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3bf72cd..183a165 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -727,7 +727,6 @@ config PCI
>  	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
>  		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
>  	default PCI_QSPAN if !4xx && !CPM2 && 8xx
> -	select ARCH_SUPPORTS_MSI
>  	select GENERIC_PCI_IOMAP
>  	help
>  	  Find out whether your system includes a PCI bus. PCI is the name of
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 22f75b5..e9982a3 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -428,7 +428,6 @@ menuconfig PCI
>  	bool "PCI support"
>  	default n
>  	depends on 64BIT
> -	select ARCH_SUPPORTS_MSI
>  	select PCI_MSI
>  	help
>  	  Enable PCI support.
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index a00cbd3..1570ad2 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -52,7 +52,6 @@ config SPARC32
>  
>  config SPARC64
>  	def_bool 64BIT
> -	select ARCH_SUPPORTS_MSI
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_GRAPH_FP_TEST
> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 24565a7..74dff90 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -380,7 +380,6 @@ config PCI
>  	select PCI_DOMAINS
>  	select GENERIC_PCI_IOMAP
>  	select TILE_GXIO_TRIO if TILEGX
> -	select ARCH_SUPPORTS_MSI if TILEGX
>  	select PCI_MSI if TILEGX
>  	---help---
>  	  Enable PCI root complex support, so PCIe endpoint devices can
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b32ebf9..5db62ef 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2014,7 +2014,6 @@ menu "Bus options (PCI etc.)"
>  config PCI
>  	bool "PCI support"
>  	default y
> -	select ARCH_SUPPORTS_MSI if (X86_LOCAL_APIC && X86_IO_APIC)
>  	---help---
>  	  Find out whether you have a PCI motherboard. PCI is the name of a
>  	  bus system, i.e. the way the CPU talks to the other stuff inside
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 81944fb..b6a99f7 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -1,13 +1,9 @@
>  #
>  # PCI configuration
>  #
> -config ARCH_SUPPORTS_MSI
> -	bool
> -
>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
> -	depends on ARCH_SUPPORTS_MSI
>  	help
>  	   This allows device drivers to enable MSI (Message Signaled
>  	   Interrupts).  Message Signaled Interrupts enable a device to
