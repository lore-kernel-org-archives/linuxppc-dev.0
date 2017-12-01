Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypT243v1mzDsMC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 09:08:57 +1100 (AEDT)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-pci@vger.kernel.org
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
Date: Fri, 1 Dec 2017 23:08:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/mixed; boundary="------------5E30C47088605C2C2C212BBE"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------5E30C47088605C2C2C212BBE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.11.2017 23:42, Bjorn Helgaas wrote:
 >
 > 00:11.0 claims to be a PCIe Root Port leading to [bus 05-06]. That
 > means there's a Link (presumably this A-Link II Express thing), and the
 > downstream end of the Link *should* be a PCIe Upstream Port on bus 05,
 > but no such device is visible.  I suppose the SB600 does implement
 > some sort of PCIe Port there, but keeps it invisible to software, and
 > at the same time, contains an invisible bridge that connects the Link
 > to all the conventional PCI devices on bus 05.
 >
 > When we scan bus 05, we do this:
 >
 >   pci_scan_child_bus_extend(bus=05)
 >     for (devfn = 0; devfn < 0x100; devfn += 8)
 >       pci_scan_slot(05, 00.0)
 >         pci_scan_single_device
 >           pci_scan_device(05, 00.0)           # fails; no 05:00.0
 >       pci_scan_slot(05, 01.0)
 >         only_one_child(bus=05)
 >           parent = 00:11.0
 >           pci_pcie_type(00:11.0) == ROOT_PORT # returns true
 >
 > Since only_one_child() sees that 00:11.0 is a Root Port, we give up
 > before we even get to the PCI_SCAN_ALL_PCIE_DEVS test.
 >
 > I *think* something like the patch below should make this work if you
 > use the "pci=pcie_scan_all" parameter.  We have some x86 DMI quirks
 > that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
 > something similar on powerpc, but maybe you do?
 >

Hi Bjorn,

I tested your new patch today. It boots with the boot argument 
"pci=pcie_scan_all". Well done! :-)

It doesn't boot without the boot argument "pci=pcie_scan_all".

Many thanks for your help.

Cheers,
Christian


--------------5E30C47088605C2C2C212BBE
Content-Type: text/x-patch;
 name="probe.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="probe.c.patch"

commit 75eaf674066590e79b3e03d32488871fc881ab40
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Nov 30 15:22:39 2017 -0600

    PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root Ports as well as Downstream
    
    Previously PCI_SCAN_ALL_PCIE_DEVS (set by quirks or the "pci=pcie_scan_all"
    kernel parameter) only affected Switch Downstream Ports, not Root Ports.
    
    Simplify and restructure only_one_child() so PCI_SCAN_ALL_PCIE_DEVS means
    we scan for all possible devices below Root Ports as well as Switch
    Downstream Ports.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1ff38b..9e57d4ef0c1f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2217,20 +2217,28 @@ static int only_one_child(struct pci_bus *bus)
 {
 	struct pci_dev *parent = bus->self;
 
-	if (!parent || !pci_is_pcie(parent))
+	if (!parent)
+		return 0;
+
+	/*
+	 * Systems with unusual topologies set PCI_SCAN_ALL_PCIE_DEVS so
+	 * we scan for all possible devices, not just Device 0.
+	 */
+	if (pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
 		return 0;
-	if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
-		return 1;
 
 	/*
-	 * PCIe downstream ports are bridges that normally lead to only a
-	 * device 0, but if PCI_SCAN_ALL_PCIE_DEVS is set, scan all
-	 * possible devices, not just device 0.  See PCIe spec r3.0,
-	 * sec 7.3.1.
+	 * A PCIe Downstream Port normally leads to a Link with only Device
+	 * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
+	 * only for Device 0 in that situation.
+	 *
+	 * Checking has_secondary_link is a hack to identify Downstream
+	 * Ports because sometimes Switches are configured such that the
+	 * PCIe Port Type labels are backwards.
 	 */
-	if (parent->has_secondary_link &&
-	    !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
+	if (pci_is_pcie(parent) && parent->has_secondary_link)
 		return 1;
+
 	return 0;
 }

--------------5E30C47088605C2C2C212BBE--
