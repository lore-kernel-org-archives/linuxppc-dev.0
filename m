Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06D4F1A0E1E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 07:43:00 +1100 (AEDT)
Date: Tue, 20 Jan 2015 14:03:49 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <scottwood@freescale.com>, Wang Dongsheng <dongsheng.wang@freescale.com>,
 Anton Blanchard <anton@samba.org>, Himangi Saraogi <himangi774@gmail.com>,
 Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH] powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN
Message-ID: <20150120140349.a7a9885065c241b555b91717@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix this:

  CC      arch/powerpc/sysdev/fsl_pci.o
arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pcie_check_link':
arch/powerpc/sysdev/fsl_pci.c:91:1: error: the frame size of 1360 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

when configuring FRAME_WARN, by converting the allocation from the
stack to the heap.  We use GFP_ATOMIC since this function can be
called with interrupts disabled.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6455c1e..635d743 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -69,11 +69,13 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
 		if (hose->ops->read == fsl_indirect_read_config) {
-			struct pci_bus bus;
-			bus.number = hose->first_busno;
-			bus.sysdata = hose;
-			bus.ops = hose->ops;
-			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
+			struct pci_bus *bus;
+			bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
+			bus->number = hose->first_busno;
+			bus->sysdata = hose;
+			bus->ops = hose->ops;
+			indirect_read_config(bus, 0, PCIE_LTSSM, 4, &val);
+			kfree(bus);
 		} else
 			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
 		if (val < PCIE_LTSSM_L0)
-- 
2.2.2
