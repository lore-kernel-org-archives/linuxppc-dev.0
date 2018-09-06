Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425fGP1JtLzF3MQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 21:58:04 +1000 (AEST)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 01C4840311
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 11:58:02 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQsmPjq3zslM for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  6 Sep 2018 14:58:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 4AD4A411F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 14:58:00 +0300 (MSK)
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <linux@yadro.com>, Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v2 1/5] powerpc/pci: Access PCI config space directly w/o
 pci_dn
Date: Thu, 6 Sep 2018 14:57:48 +0300
Message-ID: <20180906115752.29316-2-s.miroshnichenko@yadro.com>
In-Reply-To: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pci_dn structures are retrieved from a DT, but hot-plugged PCIe
devices don't have them. Don't stop PCIe I/O in absence of pci_dn, so
it is now possible to discover new devices.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/rtas_pci.c       | 97 +++++++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.c | 64 ++++++++++++------
 2 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index c2b148b1634a..0611b46d9b5f 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -55,10 +55,26 @@ static inline int config_access_valid(struct pci_dn *dn, int where)
 	return 0;
 }
 
-int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
+static int rtas_read_raw_config(unsigned long buid, int busno, unsigned int devfn,
+				int where, int size, u32 *val)
 {
 	int returnval = -1;
-	unsigned long buid, addr;
+	unsigned long addr = rtas_config_addr(busno, devfn, where);
+	int ret;
+
+	if (buid) {
+		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
+				addr, BUID_HI(buid), BUID_LO(buid), size);
+	} else {
+		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
+	}
+	*val = returnval;
+
+	return ret;
+}
+
+int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
+{
 	int ret;
 
 	if (!pdn)
@@ -71,16 +87,8 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 		return PCIBIOS_SET_FAILED;
 #endif
 
-	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
-	buid = pdn->phb->buid;
-	if (buid) {
-		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
-				addr, BUID_HI(buid), BUID_LO(buid), size);
-	} else {
-		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
-	}
-	*val = returnval;
-
+	ret = rtas_read_raw_config(pdn->phb->buid, pdn->busno, pdn->devfn,
+				   where, size, val);
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -98,18 +106,44 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
 
-	/* Validity of pdn is checked in here */
-	ret = rtas_read_config(pdn, where, size, val);
-	if (*val == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (pdn && eeh_enabled()) {
+		/* Validity of pdn is checked in here */
+		ret = rtas_read_config(pdn, where, size, val);
+
+		if (*val == EEH_IO_ERROR_VALUE(size) &&
+		    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
+			ret = PCIBIOS_DEVICE_NOT_FOUND;
+	} else {
+		struct pci_controller *phb = pci_bus_to_host(bus);
+
+		ret = rtas_read_raw_config(phb->buid, bus->number, devfn,
+					   where, size, val);
+	}
 
 	return ret;
 }
 
+static int rtas_write_raw_config(unsigned long buid, int busno, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	unsigned long addr = rtas_config_addr(busno, devfn, where);
+	int ret;
+
+	if (buid) {
+		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
+				BUID_HI(buid), BUID_LO(buid), size, (ulong)val);
+	} else {
+		ret = rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val);
+	}
+
+	if (ret)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 {
-	unsigned long buid, addr;
 	int ret;
 
 	if (!pdn)
@@ -122,15 +156,8 @@ int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 		return PCIBIOS_SET_FAILED;
 #endif
 
-	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
-	buid = pdn->phb->buid;
-	if (buid) {
-		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
-			BUID_HI(buid), BUID_LO(buid), size, (ulong) val);
-	} else {
-		ret = rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val);
-	}
-
+	ret = rtas_write_raw_config(pdn->phb->buid, pdn->busno, pdn->devfn,
+				    where, size, val);
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -141,12 +168,20 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 				 unsigned int devfn,
 				 int where, int size, u32 val)
 {
-	struct pci_dn *pdn;
+	struct pci_dn *pdn = pci_get_pdn_by_devfn(bus, devfn);
+	int ret;
 
-	pdn = pci_get_pdn_by_devfn(bus, devfn);
+	if (pdn && eeh_enabled()) {
+		/* Validity of pdn is checked in here. */
+		ret = rtas_write_config(pdn, where, size, val);
+	} else {
+		struct pci_controller *phb = pci_bus_to_host(bus);
 
-	/* Validity of pdn is checked in here. */
-	return rtas_write_config(pdn, where, size, val);
+		ret = rtas_write_raw_config(phb->buid, bus->number, devfn,
+					    where, size, val);
+	}
+
+	return ret;
 }
 
 static struct pci_ops rtas_pci_ops = {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 13aef2323bbc..3f87a2dc6578 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -654,30 +654,29 @@ static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
 	}
 }
 
-int pnv_pci_cfg_read(struct pci_dn *pdn,
-		     int where, int size, u32 *val)
+int pnv_pci_cfg_read_raw(u64 phb_id, int busno, unsigned int devfn,
+			 int where, int size, u32 *val)
 {
-	struct pnv_phb *phb = pdn->phb->private_data;
-	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
+	u32 bdfn = (busno << 8) | devfn;
 	s64 rc;
 
 	switch (size) {
 	case 1: {
 		u8 v8;
-		rc = opal_pci_config_read_byte(phb->opal_id, bdfn, where, &v8);
+		rc = opal_pci_config_read_byte(phb_id, bdfn, where, &v8);
 		*val = (rc == OPAL_SUCCESS) ? v8 : 0xff;
 		break;
 	}
 	case 2: {
 		__be16 v16;
-		rc = opal_pci_config_read_half_word(phb->opal_id, bdfn, where,
-						   &v16);
+		rc = opal_pci_config_read_half_word(phb_id, bdfn, where,
+						    &v16);
 		*val = (rc == OPAL_SUCCESS) ? be16_to_cpu(v16) : 0xffff;
 		break;
 	}
 	case 4: {
 		__be32 v32;
-		rc = opal_pci_config_read_word(phb->opal_id, bdfn, where, &v32);
+		rc = opal_pci_config_read_word(phb_id, bdfn, where, &v32);
 		*val = (rc == OPAL_SUCCESS) ? be32_to_cpu(v32) : 0xffffffff;
 		break;
 	}
@@ -686,27 +685,28 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
 	}
 
 	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		 __func__, pdn->busno, pdn->devfn, where, size, *val);
+		 __func__, busno, devfn, where, size, *val);
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int pnv_pci_cfg_write(struct pci_dn *pdn,
-		      int where, int size, u32 val)
+int pnv_pci_cfg_write_raw(u64 phb_id, int busno, unsigned int devfn,
+			  int where, int size, u32 val)
 {
-	struct pnv_phb *phb = pdn->phb->private_data;
-	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
+	u32 bdfn = (busno << 8) | devfn;
 
 	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		 __func__, pdn->busno, pdn->devfn, where, size, val);
+		 __func__, busno, devfn, where, size, val);
+
 	switch (size) {
 	case 1:
-		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
+		opal_pci_config_write_byte(phb_id, bdfn, where, val);
 		break;
 	case 2:
-		opal_pci_config_write_half_word(phb->opal_id, bdfn, where, val);
+		opal_pci_config_write_half_word(phb_id, bdfn, where, val);
 		break;
 	case 4:
-		opal_pci_config_write_word(phb->opal_id, bdfn, where, val);
+		opal_pci_config_write_word(phb_id, bdfn, where, val);
 		break;
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
@@ -715,6 +715,24 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+int pnv_pci_cfg_read(struct pci_dn *pdn,
+		     int where, int size, u32 *val)
+{
+	struct pnv_phb *phb = pdn->phb->private_data;
+
+	return pnv_pci_cfg_read_raw(phb->opal_id, pdn->busno, pdn->devfn,
+				    where, size, val);
+}
+
+int pnv_pci_cfg_write(struct pci_dn *pdn,
+		      int where, int size, u32 val)
+{
+	struct pnv_phb *phb = pdn->phb->private_data;
+
+	return pnv_pci_cfg_write_raw(phb->opal_id, pdn->busno, pdn->devfn,
+				     where, size, val);
+}
+
 #if CONFIG_EEH
 static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 {
@@ -750,13 +768,15 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 			       int where, int size, u32 *val)
 {
 	struct pci_dn *pdn;
-	struct pnv_phb *phb;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
 	int ret;
 
 	*val = 0xFFFFFFFF;
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
 	if (!pdn)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+		return pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
+					    where, size, val);
 
 	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -779,12 +799,14 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 				int where, int size, u32 val)
 {
 	struct pci_dn *pdn;
-	struct pnv_phb *phb;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
 	int ret;
 
 	pdn = pci_get_pdn_by_devfn(bus, devfn);
 	if (!pdn)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+		return pnv_pci_cfg_write_raw(phb->opal_id, bus->number, devfn,
+					     where, size, val);
 
 	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.17.1
