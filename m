Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdkyh1yr1zF0bZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 19:05:57 +1100 (AEDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root as well
 as Downstream Ports
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20171202191827.GB18780@bhelgaas-glaptop.roam.corp.google.com>
Date: Sat, 10 Feb 2018 09:05:40 +0100
Cc: linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <33CA1586-051C-47F4-83CD-4A406FAE85F7@xenosoft.de>
References: <20171202002710.17686.21340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171202191827.GB18780@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

The AmigaOne X1000 doesn=E2=80=99t boot anymore since the PCI updates. I hav=
e seen, that the PCI updates are different to the updates below. The code be=
low works but the latest not. Is there a problem with the latest PCI updates=
 currently?

Thanks,
Christian

Sent from my iPhone

On 2. Dec 2017, at 20:18, Bjorn Helgaas <helgaas@kernel.org> wrote:

On Fri, Dec 01, 2017 at 06:27:10PM -0600, Bjorn Helgaas wrote:
From: Bjorn Helgaas <bhelgaas@google.com>

PCIe Downstream Ports normally have only a Device 0 below them.  To
optimize enumeration, we don't scan for other devices *unless* the
PCI_SCAN_ALL_PCIE_DEVS flag is set by set by quirks or the
"pci=3Dpcie_scan_all" kernel parameter.

Previously PCI_SCAN_ALL_PCIE_DEVS only affected scanning below Switch
Downstream Ports, not Root Ports.

But the "Nemo" system, also known as the AmigaOne X1000, has a PA Semi Root
Port whose link leads to an AMD/ATI SB600 South Bridge.  The Root Port is a
PCIe device, of course, but the SB600 contains only conventional PCI
devices with no visible PCIe port.

Simplify and restructure only_one_child() so that we scan for all possible
devices below Root Ports as well as Switch Downstream Ports when
PCI_SCAN_ALL_PCIE_DEVS is set.

This is enough to make Nemo work with "pci=3Dpcie_scan_all".  We would also
like to add a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically on Nemo so
users wouldn't have to use the "pci=3Dpcie_scan_all" parameter, but we don't=

have that yet.

Link: https://lkml.kernel.org/r/CAErSpo55Q8Q=3D5p6_+uu7ahnw+53ibVDNRXxrzRV9Q=
nUr_9EUfw@mail.gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D198057
Reported-and-Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/enumeration for v4.16.

---
drivers/pci/probe.c |   25 +++++++++++++++----------
1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1ff38b..303c0cb0550c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2215,22 +2215,27 @@ static unsigned next_fn(struct pci_bus *bus, struct p=
ci_dev *dev, unsigned fn)

static int only_one_child(struct pci_bus *bus)
{
-    struct pci_dev *parent =3D bus->self;
+    struct pci_dev *bridge =3D bus->self;

-    if (!parent || !pci_is_pcie(parent))
+    /*
+     * Systems with unusual topologies set PCI_SCAN_ALL_PCIE_DEVS so
+     * we scan for all possible devices, not just Device 0.
+     */
+    if (pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
       return 0;
-    if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
-        return 1;

   /*
-     * PCIe downstream ports are bridges that normally lead to only a
-     * device 0, but if PCI_SCAN_ALL_PCIE_DEVS is set, scan all
-     * possible devices, not just device 0.  See PCIe spec r3.0,
-     * sec 7.3.1.
+     * A PCIe Downstream Port normally leads to a Link with only Device
+     * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
+     * only for Device 0 in that situation.
+     *
+     * Checking has_secondary_link is a hack to identify Downstream
+     * Ports because sometimes Switches are configured such that the
+     * PCIe Port Type labels are backwards.
    */
-    if (parent->has_secondary_link &&
-        !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
+    if (bridge && pci_is_pcie(bridge) && bridge->has_secondary_link)
       return 1;
+
   return 0;
}
