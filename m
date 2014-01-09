Return-Path: <Minghuan.Lian@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 75CE72C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 13:21:43 +1100 (EST)
Message-ID: <52CE07CB.9010005@freescale.com>
Date: Thu, 9 Jan 2014 10:22:03 +0800
From: Lian Minghuan-b31939 <b31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Minghuan Lian
 <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH 02/12][v4] pci: fsl: add structure fsl_pci
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>	
 <1389157323-3088-2-git-send-email-Minghuan.Lian@freescale.com>
 <1389218288.25654.26.camel@snotra.buserror.net>
In-Reply-To: <1389218288.25654.26.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

please see my comments inline.

On 01/09/2014 05:58 AM, Scott Wood wrote:
> On Wed, 2014-01-08 at 13:01 +0800, Minghuan Lian wrote:
>> PowerPC uses structure pci_controller to describe PCI controller,
>> but ARM uses structure pci_sys_data. In order to support PowerPC
>> and ARM simultaneously, the patch adds a structure fsl_pci that
>> contains most of the members of the pci_controller and pci_sys_data.
>> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
>> be implemented in architecture-specific PCI controller driver to
>> convert pci_controller or pci_sys_data to fsl_pci.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> ---
>> change log:
>> v4:
>> Added indirect type macro
>> v1-v3:
>> Derived from http://patchwork.ozlabs.org/patch/278965/
>>
>> Based on upstream master.
>> Based on the discussion of RFC version here
>> http://patchwork.ozlabs.org/patch/274487/
>>
>>   include/linux/fsl/pci-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
> Same comments on this patchset as last time.
[Minghuan] I added the duplicate fields because PPC's struct 
pci_controller need them.
The common PCI driver gets the related information and pass to PowerPC 
driver.
The most fileds are parsed from dts. the common driver need them to 
initialize the ATMU
and access the PCI configuration. If fsl_pci does not contains them, 
PowerPC driver must parse
parse dts or access controller to get the information again. The best 
way is PowerPC and ARM can use
the common pci_controller structure, but currently, it is very hard and 
needs more effort. So I create fsl_pci
that contains most of the members of the pci_controller and pci_sys_data.


please see the following code for PowerPC:
int fsl_arch_pci_sys_register(struct fsl_pci *pci)
+{
+    struct pci_controller *hose;

+    hose = pcibios_alloc_controller(pci->dn);
+
+    hose->private_data = pci;
+    hose->parent = pci->dev;
+    hose->first_busno = pci->first_busno;
+    hose->last_busno = pci->last_busno;
+    hose->ops = pci->ops;
+
+    hose->io_base_virt = ioremap(pci->io_base_phys + 
pci->io_resource.start,
+                     pci->pci_io_size);
+    hose->pci_io_size = pci->io_resource.start + pci->pci_io_size;
+    hose->io_base_phys = pci->io_base_phys;
+    hose->io_resource = pci->io_resource;
+
+    memcpy(hose->mem_offset, pci->mem_offset, sizeof(hose->mem_offset));
+    memcpy(hose->mem_resources, pci->mem_resources,
+        sizeof(hose->mem_resources));
+    hose->dma_window_base_cur = pci->dma_window_base_cur;
+    hose->dma_window_size = pci->dma_window_size;
+    pci->sys = hose;
+....
+    return 0;
+}



The following is for ARM, I will submit them after verification:

+
+static inline struct fsl_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+    return sys->private_data;
+}
+
+static int fsl_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+    struct fsl_pcie *pcie;
+
+    pcie = sys_to_pcie(sys);
+
+    if (!pcie)
+        return 0;
+
+    pcie->sys = sys;
+
+    sys->io_offset = pcie->io_base_phys;
+    pci_ioremap_io(sys->io_offset, pcie->io_resource.start);
+    pci_add_resource_offset(&sys->resources, &pcie->io_resource,
+                sys->io_offset);
+
+    sys->mem_offset = pcie->mem_offset;
+    pci_add_resource_offset(&sys->resources, &pcie->mem_resource,
+                sys->mem_offset);
+
+    return 1;
+}
+
+static struct pci_bus *
+fsl_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+    struct pci_bus *bus;
+    struct fsl_pcie *pcie = sys_to_pcie(sys);
+
+    bus = pci_create_root_bus(pcie->dev, sys->busnr,
+                  pcie->ops, sys, &sys->resources);
+    if (!bus)
+        return NULL;
+
+    pci_scan_child_bus(bus);
+
+    return bus;
+}
+
+static int fsl_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+    struct of_irq oirq;
+    int ret;
+
+    ret = of_irq_map_pci(dev, &oirq);
+    if (ret)
+        return ret;
+
+    return irq_create_of_mapping(oirq.controller, oirq.specifier,
+                     oirq.size);
+}
+
+static struct hw_pci fsl_hw_pcie = {
+    .ops        = &fsl_indirect_pci_ops;
+    .setup        = fsl_pcie_setup,
+    .scan        = fsl_pcie_scan_bus,
+    .map_irq    = fsl_pcie_map_irq,
+};

+static struct pci_bus *
+fake_pci_bus(struct fsl_pcie *pcie, int busnr)
+{
+    static struct pci_bus bus;
+    static struct pci_sys_data sys;
+
+    bus.number = busnr;
+    bus.sysdata = &sys;
+    sys.private_data = pcie;
+    bus.ops = pcie->ops;
+    return &bus;
+}
+
+static int fsl_pcie_register(struct fsl_pcie *pcie)
+{
+    pcie->controller = fsl_hw_pcie.nr_controllers;
+    fsl_hw_pcie.nr_controllers = 1;
+    fsl_hw_pcie.private_data = (void **)&pcie;
+
+    pci_common_init(&fsl_hw_pcie);
+    pci_assign_unassigned_resources();
+#ifdef CONFIG_PCI_DOMAINS
+    fsl_hw_pcie.domain++;
+#endif
+}
>
> -Scott
>
>
