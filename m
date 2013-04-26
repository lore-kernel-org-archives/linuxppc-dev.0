Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id C54B22C011E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 08:53:28 +1000 (EST)
Date: Fri, 26 Apr 2013 15:53:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 1/3] rapidio: make enumeration/discovery configurable
Message-Id: <20130426155325.09fbad8c382dc8c549d503d0@linux-foundation.org>
In-Reply-To: <1366813919-13766-2-git-send-email-alexandre.bounine@idt.com>
References: <1366813919-13766-1-git-send-email-alexandre.bounine@idt.com>
 <1366813919-13766-2-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>, linux-kernel@vger.kernel.org,
 Andre van Herk <andre.van.herk@Prodrive.nl>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 24 Apr 2013 10:31:57 -0400 Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Rework to implement RapidIO enumeration/discovery method selection
> combined with ability to use enumeration/discovery as a kernel module.
> 
> This patch adds ability to introduce new RapidIO enumeration/discovery methods
> using kernel configuration options or loadable modules. Configuration option
> mechanism allows to select built-in or modular enumeration/discovery method from
> the list of existing methods or use external modules.
> If a modular enumeration/discovery is selected each RapidIO mport device can
> have its own method attached to it.
> 
> The currently existing enumeration/discovery code was updated to be used
> as built-in or modular method. This configuration option is named "Basic
> enumeration/discovery" method.
> 
> Several common routines have been moved from rio-scan.c to make them available
> to other enumeration methods and reduce number of exported symbols.
> 
> ...
>
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -47,4 +47,23 @@ config RAPIDIO_DEBUG
>  
>  	  If you are unsure about this, say N here.
>  
> +choice
> +	prompt "Enumeration method"
> +	depends on RAPIDIO
> +	help
> +	  There are different enumeration and discovery mechanisms offered
> +	  for RapidIO subsystem. You may select single built-in method or
> +	  or any number of methods to be built as modules.
> +	  Selecting a built-in method disables use of loadable methods.
> +
> +	  If unsure, select Basic built-in.
> +
> +config RAPIDIO_ENUM_BASIC
> +	tristate "Basic"
> +	help
> +	  This option includes basic RapidIO fabric enumeration and discovery
> +	  mechanism similar to one described in RapidIO specification Annex 1.
> +
> +endchoice

This Kconfig change makes my kbuild do Weird Things.

make mrproper ; yes "" | make allmodconfig ; make 2>/tmp/x

: scripts/kconfig/conf --silentoldconfig Kconfig
: *
: * Restart config...
: *
: *
: * Bus options (PCI etc.)
: *
: PCI support (PCI) [Y/n/?] y
:   Support mmconfig PCI config space access (PCI_MMCONFIG) [Y/n] y
:   Read CNB20LE Host Bridge Windows (PCI_CNB20LE_QUIRK) [Y/n/?] y
:   PCI Express support (PCIEPORTBUS) [Y/n/?] y
:     PCI Express Hotplug driver (HOTPLUG_PCI_PCIE) [M/n/?] m
:     Root Port Advanced Error Reporting support (PCIEAER) [Y/n/?] y
:       PCI Express ECRC settings control (PCIE_ECRC) [Y/n/?] y
:       PCIe AER error injector support (PCIEAER_INJECT) [M/n/y/?] m
:     PCI Express ASPM control (PCIEASPM) [Y/n/?] y
:       Debug PCI Express ASPM (PCIEASPM_DEBUG) [Y/n/?] y
:       Default ASPM policy
:       > 1. BIOS default (PCIEASPM_DEFAULT)
:         2. Powersave (PCIEASPM_POWERSAVE)
:         3. Performance (PCIEASPM_PERFORMANCE)
:       choice[1-3]: 1
: Message Signaled Interrupts (MSI and MSI-X) (PCI_MSI) [Y/?] y
: PCI Debugging (PCI_DEBUG) [Y/n/?] y
: Enable PCI resource re-allocation detection (PCI_REALLOC_ENABLE_AUTO) [Y/n/?] y
: PCI Stub driver (PCI_STUB) [M/n/y/?] m
: Xen PCI Frontend (XEN_PCIDEV_FRONTEND) [M/n/y/?] m
: Interrupts on hypertransport devices (HT_IRQ) [Y/n/?] y
: PCI IOV support (PCI_IOV) [Y/n/?] y
: PCI PRI support (PCI_PRI) [Y/?] y
: PCI PASID support (PCI_PASID) [Y/?] y
: PCI IO-APIC hotplug support (PCI_IOAPIC) [M/n/y] m
: ISA-style DMA support (ISA_DMA_API) [Y/n/?] y
: RapidIO support (RAPIDIO) [Y/n/?] y
:   IDT Tsi721 PCI Express SRIO Controller support (RAPIDIO_TSI721) [Y/n/?] y
:   Discovery timeout duration (seconds) (RAPIDIO_DISC_TIMEOUT) [30] 30
:   Enable RapidIO Input/Output Ports (RAPIDIO_ENABLE_RX_TX_PORTS) [Y/n/?] y
:   DMA Engine support for RapidIO (RAPIDIO_DMA_ENGINE) [Y/n/?] y
:   RapidIO subsystem debug messages (RAPIDIO_DEBUG) [Y/n/?] y
:   Enumeration method [M/y/?] (NEW) aborted!
: 
: Console input/output is redirected. Run 'make oldconfig' to update configuration.
: 
:   SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
:   SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
:   SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h


See the "Enumeration method [M/y/?] (NEW) aborted!"

Note that this only happens when make's stderr is redirected.

I've no idea what's going on here.  This appears to fix things:

--- a/drivers/rapidio/Kconfig~rapidio-make-enumeration-discovery-configurable-fix
+++ a/drivers/rapidio/Kconfig
@@ -59,7 +59,7 @@ choice
 	  If unsure, select Basic built-in.
 
 config RAPIDIO_ENUM_BASIC
-	tristate "Basic"
+	bool "Basic"
 	help
 	  This option includes basic RapidIO fabric enumeration and discovery
 	  mechanism similar to one described in RapidIO specification Annex 1.

but doesn't appear to be what you intended.
