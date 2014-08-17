Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0F141A04AE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 13:02:46 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sun, 17 Aug 2014 08:32:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 28FE4E001B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 08:34:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7H3312757606346
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 08:33:01 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7H32cPh007058
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 08:32:38 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/eeh: Drop unused argument in eeh_check_failure()
Date: Sun, 17 Aug 2014 13:02:25 +1000
Message-Id: <1408244549-10221-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1408244549-10221-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1408244549-10221-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Vishal Mansur <vmansur@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh_check_failure() is used to check frozen state of the PE which
owns the indicated I/O address. The argument "val" of the function
isn't used. The patch drops it and return the frozen state of the
PE as expected.

Cc: Vishal Mansur <vmansur@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 29 ++++++++++++++---------------
 arch/powerpc/kernel/eeh.c      | 15 ++++++---------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9983c3d..adcddb1 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -269,8 +269,7 @@ void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
-unsigned long eeh_check_failure(const volatile void __iomem *token,
-				unsigned long val);
+int eeh_check_failure(const volatile void __iomem *token);
 int eeh_dev_check_failure(struct eeh_dev *edev);
 void eeh_addr_cache_build(void);
 void eeh_add_device_early(struct device_node *);
@@ -321,9 +320,9 @@ static inline void *eeh_dev_init(struct device_node *dn, void *data)
 
 static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
 
-static inline unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
+static inline int eeh_check_failure(const volatile void __iomem *token)
 {
-	return val;
+	return 0;
 }
 
 #define eeh_dev_check_failure(x) (0)
@@ -354,7 +353,7 @@ static inline u8 eeh_readb(const volatile void __iomem *addr)
 {
 	u8 val = in_8(addr);
 	if (EEH_POSSIBLE_ERROR(val, u8))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -362,7 +361,7 @@ static inline u16 eeh_readw(const volatile void __iomem *addr)
 {
 	u16 val = in_le16(addr);
 	if (EEH_POSSIBLE_ERROR(val, u16))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -370,7 +369,7 @@ static inline u32 eeh_readl(const volatile void __iomem *addr)
 {
 	u32 val = in_le32(addr);
 	if (EEH_POSSIBLE_ERROR(val, u32))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -378,7 +377,7 @@ static inline u64 eeh_readq(const volatile void __iomem *addr)
 {
 	u64 val = in_le64(addr);
 	if (EEH_POSSIBLE_ERROR(val, u64))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -386,7 +385,7 @@ static inline u16 eeh_readw_be(const volatile void __iomem *addr)
 {
 	u16 val = in_be16(addr);
 	if (EEH_POSSIBLE_ERROR(val, u16))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -394,7 +393,7 @@ static inline u32 eeh_readl_be(const volatile void __iomem *addr)
 {
 	u32 val = in_be32(addr);
 	if (EEH_POSSIBLE_ERROR(val, u32))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -402,7 +401,7 @@ static inline u64 eeh_readq_be(const volatile void __iomem *addr)
 {
 	u64 val = in_be64(addr);
 	if (EEH_POSSIBLE_ERROR(val, u64))
-		return eeh_check_failure(addr, val);
+		eeh_check_failure(addr);
 	return val;
 }
 
@@ -416,7 +415,7 @@ static inline void eeh_memcpy_fromio(void *dest, const
 	 * were copied. Check all four bytes.
 	 */
 	if (n >= 4 && EEH_POSSIBLE_ERROR(*((u32 *)(dest + n - 4)), u32))
-		eeh_check_failure(src, *((u32 *)(dest + n - 4)));
+		eeh_check_failure(src);
 }
 
 /* in-string eeh macros */
@@ -425,7 +424,7 @@ static inline void eeh_readsb(const volatile void __iomem *addr, void * buf,
 {
 	_insb(addr, buf, ns);
 	if (EEH_POSSIBLE_ERROR((*(((u8*)buf)+ns-1)), u8))
-		eeh_check_failure(addr, *(u8*)buf);
+		eeh_check_failure(addr);
 }
 
 static inline void eeh_readsw(const volatile void __iomem *addr, void * buf,
@@ -433,7 +432,7 @@ static inline void eeh_readsw(const volatile void __iomem *addr, void * buf,
 {
 	_insw(addr, buf, ns);
 	if (EEH_POSSIBLE_ERROR((*(((u16*)buf)+ns-1)), u16))
-		eeh_check_failure(addr, *(u16*)buf);
+		eeh_check_failure(addr);
 }
 
 static inline void eeh_readsl(const volatile void __iomem *addr, void * buf,
@@ -441,7 +440,7 @@ static inline void eeh_readsl(const volatile void __iomem *addr, void * buf,
 {
 	_insl(addr, buf, nl);
 	if (EEH_POSSIBLE_ERROR((*(((u32*)buf)+nl-1)), u32))
-		eeh_check_failure(addr, *(u32*)buf);
+		eeh_check_failure(addr);
 }
 
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 59a64f8..17cf52ba 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -542,17 +542,16 @@ EXPORT_SYMBOL_GPL(eeh_dev_check_failure);
 
 /**
  * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
- * @token: I/O token, should be address in the form 0xA....
- * @val: value, should be all 1's (XXX why do we need this arg??)
+ * @token: I/O address
  *
- * Check for an EEH failure at the given token address.  Call this
+ * Check for an EEH failure at the given I/O address. Call this
  * routine if the result of a read was all 0xff's and you want to
- * find out if this is due to an EEH slot freeze event.  This routine
+ * find out if this is due to an EEH slot freeze event. This routine
  * will query firmware for the EEH status.
  *
  * Note this routine is safe to call in an interrupt context.
  */
-unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
+int eeh_check_failure(const volatile void __iomem *token)
 {
 	unsigned long addr;
 	struct eeh_dev *edev;
@@ -562,13 +561,11 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 	edev = eeh_addr_cache_get_dev(addr);
 	if (!edev) {
 		eeh_stats.no_device++;
-		return val;
+		return 0;
 	}
 
-	eeh_dev_check_failure(edev);
-	return val;
+	return eeh_dev_check_failure(edev);
 }
-
 EXPORT_SYMBOL(eeh_check_failure);
 
 
-- 
1.8.3.2
