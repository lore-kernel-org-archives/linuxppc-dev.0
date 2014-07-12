Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 3D16A1A01C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:37 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] powerpc/mv64x60_pci: replace sscanf by kstrtou32
Date: Sat, 12 Jul 2014 13:36:15 +0200
Message-Id: <1405164980-9525-3-git-send-email-fabf@skynet.be>
In-Reply-To: <1405164980-9525-1-git-send-email-fabf@skynet.be>
References: <1405164980-9525-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See checkpatch warning
"Prefer kstrto<type> to single variable sscanf"

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/powerpc/sysdev/mv64x60_pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 330d566..ca0b29c 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -52,14 +52,17 @@ static ssize_t mv64x60_hs_reg_write(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *phb;
 	u32 v;
+	int rc;
 
 	if (off > 0)
 		return 0;
 	if (count <= 0)
 		return -EINVAL;
 
-	if (sscanf(buf, "%i", &v) != 1)
-		return -EINVAL;
+	rc = kstrtou32(buf, 0, &v);
+
+	if (rc)
+		return rc;
 
 	phb = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
 	if (!phb)
-- 
1.9.1
