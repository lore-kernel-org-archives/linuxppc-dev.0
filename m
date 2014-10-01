Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CE321A180A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:02 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:07:59 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6A02F2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:07:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s916na8T45809706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 16:49:36 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9177uf3004731
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:07:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/powernv: Drop config requests in EEH accessors
Date: Wed,  1 Oct 2014 17:07:51 +1000
Message-Id: <1412147274-28770-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's bad idea to access the PCI config registers of the adapters,
which is experiencing reset. It leads to recursive EEH error without
exception. The patch drops PCI config requests in EEH accessors if
the PE has been marked to accept PCI config requests, for example
during PE reseet time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 37 ++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3e89cbf..04e42f7 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -383,6 +383,39 @@ static int powernv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 	return ret;
 }
 
+static inline bool powernv_eeh_cfg_blocked(struct device_node *dn)
+{
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+
+	if (!edev || !edev->pe)
+		return false;
+
+	if (edev->pe->state & EEH_PE_CFG_BLOCKED)
+		return true;
+
+	return false;
+}
+
+static int powernv_eeh_read_config(struct device_node *dn,
+				   int where, int size, u32 *val)
+{
+	if (powernv_eeh_cfg_blocked(dn)) {
+		*val = 0xFFFFFFFF;
+		return PCIBIOS_SET_FAILED;
+	}
+
+	return pnv_pci_cfg_read(dn, where, size, val);
+}
+
+static int powernv_eeh_write_config(struct device_node *dn,
+				    int where, int size, u32 val)
+{
+	if (powernv_eeh_cfg_blocked(dn))
+		return PCIBIOS_SET_FAILED;
+
+	return pnv_pci_cfg_write(dn, where, size, val);
+}
+
 /**
  * powernv_eeh_next_error - Retrieve next EEH error to handle
  * @pe: Affected PE
@@ -440,8 +473,8 @@ static struct eeh_ops powernv_eeh_ops = {
 	.get_log                = powernv_eeh_get_log,
 	.configure_bridge       = powernv_eeh_configure_bridge,
 	.err_inject		= powernv_eeh_err_inject,
-	.read_config            = pnv_pci_cfg_read,
-	.write_config           = pnv_pci_cfg_write,
+	.read_config            = powernv_eeh_read_config,
+	.write_config           = powernv_eeh_write_config,
 	.next_error		= powernv_eeh_next_error,
 	.restore_config		= powernv_eeh_restore_config
 };
-- 
1.8.3.2
