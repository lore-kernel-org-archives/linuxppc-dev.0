Return-Path: <anton@samba.org>
Date: Fri, 13 Dec 2013 15:53:43 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/powernv: Fix endian issue in opal_xscom_read
Message-ID: <20131213155343.51002455@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


opal_xscom_read uses a pointer to return the data so we need
to byteswap it on LE builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index aded1b8..9873a26 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -811,7 +811,7 @@ int64_t opal_pci_next_error(uint64_t phb_id, uint64_t *first_frozen_pe,
 int64_t opal_pci_poll(uint64_t phb_id);
 int64_t opal_return_cpu(void);
 
-int64_t opal_xscom_read(uint32_t gcid, uint32_t pcb_addr, uint64_t *val);
+int64_t opal_xscom_read(uint32_t gcid, uint32_t pcb_addr, __be64 *val);
 int64_t opal_xscom_write(uint32_t gcid, uint32_t pcb_addr, uint64_t val);
 
 int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 4d99a8f..4fbf276 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -96,9 +96,11 @@ static int opal_scom_read(scom_map_t map, u64 reg, u64 *value)
 {
 	struct opal_scom_map *m = map;
 	int64_t rc;
+	__be64 v;
 
 	reg = opal_scom_unmangle(reg);
-	rc = opal_xscom_read(m->chip, m->addr + reg, (uint64_t *)__pa(value));
+	rc = opal_xscom_read(m->chip, m->addr + reg, (__be64 *)__pa(&v));
+	*value = be64_to_cpu(v);
 	return opal_xscom_err_xlate(rc);
 }
 
