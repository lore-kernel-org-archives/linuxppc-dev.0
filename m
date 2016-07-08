Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmGtB62GxzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 00:22:58 +1000 (AEST)
In-Reply-To: <1467224062-9173-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, imunsie@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, gpiccoli@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, frederic.barrat@fr.ibm.com, paulus@samba.org,
 andrew.donnellan@au1.ibm.com, bhelgaas@google.com
Subject: Re: [v7] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
Message-Id: <3rmGtB5BtTz9t0h@ozlabs.org>
Date: Sat,  9 Jul 2016 00:22:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 18:14:22 UTC, "Guilherme G. Piccoli" wrote:
> The domain/PHB field of PCI addresses has its value obtained from a
> global variable, incremented each time a new domain (represented by
> struct pci_controller) is added on the system. The domain addition
> process happens during boot or due to PHB hotplug add.
> 
> As recent kernels are using predictable naming for network interfaces,
> the network stack is more tied to PCI naming. This can be a problem in
> hotplug scenarios, because PCI addresses will change if devices are
> removed and then re-added. This situation seems unusual, but it can
> happen if a user wants to replace a NIC without rebooting the machine,
> for example.
> 
> This patch changes the way PCI domain values are generated: now, we use
> device-tree properties to assign fixed PHB numbers to PCI addresses
> when available (meaning pSeries and PowerNV cases). We also use a bitmap
> to allow dynamic PHB numbering when device-tree properties are not
> used. This bitmap keeps track of used PHB numbers and if a PHB is
> released (by hotplug operations for example), it allows the reuse of
> this PHB number, avoiding PCI address to change in case of device remove
> and re-add soon after. No functional changes were introduced.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63a72284b159c569ec52f380c9

cheers
