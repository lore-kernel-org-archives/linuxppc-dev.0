Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FAC62C0342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:56:00 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 23:55:58 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id F324E3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:05 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tPJt141658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:25 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tOYc026216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:25 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/10] powerpc/eeh: Support blocked IO access
Date: Tue, 25 Jun 2013 13:55:13 +0800
Message-Id: <1372139717-14885-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to support blocking IO access. Basically, if
the EEH core detects that the IO access has been blocked on one
specific PHB, we will simply return 0xFF's for reading and drop
writing.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  231 +++++++++++++++++++++-----
 arch/powerpc/include/asm/io.h                |   67 +++++---
 arch/powerpc/kernel/eeh.c                    |   50 ++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c |    4 +-
 4 files changed, 269 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index de821c1..a8dd983 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -211,7 +211,9 @@ void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int __init eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
-unsigned long eeh_check_failure(const volatile void __iomem *token,
+int eeh_check_blocked_io(const volatile void __iomem *token,
+			 void **pedev);
+unsigned long eeh_check_failure(struct eeh_dev *edev,
 				unsigned long val);
 int eeh_dev_check_failure(struct eeh_dev *edev);
 void __init eeh_addr_cache_build(void);
@@ -249,7 +251,13 @@ static inline void *eeh_dev_init(struct device_node *dn, void *data)
 
 static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
 
-static inline unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
+int eeh_check_blocked_io(const volatile void __iomem *token,
+			 void **pedev)
+{
+	return 0;
+}
+
+static inline unsigned long eeh_check_failure(void *data, unsigned long val)
 {
 	return val;
 }
@@ -276,57 +284,99 @@ static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
  */
 static inline u8 eeh_readb(const volatile void __iomem *addr)
 {
-	u8 val = in_8(addr);
-	if (EEH_POSSIBLE_ERROR(val, u8))
-		return eeh_check_failure(addr, val);
+	u8 val = 0xFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_8(addr);
+		if (EEH_POSSIBLE_ERROR(val, u8))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
 static inline u16 eeh_readw(const volatile void __iomem *addr)
 {
-	u16 val = in_le16(addr);
-	if (EEH_POSSIBLE_ERROR(val, u16))
-		return eeh_check_failure(addr, val);
+	u16 val = 0xFFFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_le16(addr);
+		if (EEH_POSSIBLE_ERROR(val, u16))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
 static inline u32 eeh_readl(const volatile void __iomem *addr)
 {
-	u32 val = in_le32(addr);
-	if (EEH_POSSIBLE_ERROR(val, u32))
-		return eeh_check_failure(addr, val);
+	u32 val = 0xFFFFFFFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_le32(addr);
+		if (EEH_POSSIBLE_ERROR(val, u32))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
 static inline u64 eeh_readq(const volatile void __iomem *addr)
 {
-	u64 val = in_le64(addr);
-	if (EEH_POSSIBLE_ERROR(val, u64))
-		return eeh_check_failure(addr, val);
+	u64 val = 0xFFFFFFFFFFFFFFFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_le64(addr);
+		if (EEH_POSSIBLE_ERROR(val, u64))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
 static inline u16 eeh_readw_be(const volatile void __iomem *addr)
 {
-	u16 val = in_be16(addr);
-	if (EEH_POSSIBLE_ERROR(val, u16))
-		return eeh_check_failure(addr, val);
+	u16 val = 0xFFFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_be16(addr);
+		if (EEH_POSSIBLE_ERROR(val, u16))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
 static inline u32 eeh_readl_be(const volatile void __iomem *addr)
 {
-	u32 val = in_be32(addr);
-	if (EEH_POSSIBLE_ERROR(val, u32))
-		return eeh_check_failure(addr, val);
+	u32 val = 0xFFFFFFFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_be32(addr);
+		if (EEH_POSSIBLE_ERROR(val, u32))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
 static inline u64 eeh_readq_be(const volatile void __iomem *addr)
 {
-	u64 val = in_be64(addr);
-	if (EEH_POSSIBLE_ERROR(val, u64))
-		return eeh_check_failure(addr, val);
+	u64 val = 0xFFFFFFFFFFFFFFFF;
+	void *edev;
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		val = in_be64(addr);
+		if (EEH_POSSIBLE_ERROR(val, u64))
+			return eeh_check_failure(edev, val);
+	}
+
 	return val;
 }
 
@@ -334,40 +384,145 @@ static inline void eeh_memcpy_fromio(void *dest, const
 				     volatile void __iomem *src,
 				     unsigned long n)
 {
-	_memcpy_fromio(dest, src, n);
+	void *edev;
+
+	memset(dest, 0xFF, n);
+
+	if (!eeh_check_blocked_io(src, &edev)) {
+		_memcpy_fromio(dest, src, n);
 
-	/* Look for ffff's here at dest[n].  Assume that at least 4 bytes
-	 * were copied. Check all four bytes.
-	 */
-	if (n >= 4 && EEH_POSSIBLE_ERROR(*((u32 *)(dest + n - 4)), u32))
-		eeh_check_failure(src, *((u32 *)(dest + n - 4)));
+		/*
+		 * Look for ffff's here at dest[n]. Assume that at
+		 * least 4 bytes were copied. Check all four bytes.
+		 */
+		if (n >= 4 && EEH_POSSIBLE_ERROR(*((u32 *)(dest + n - 4)), u32))
+			eeh_check_failure(edev, *((u32 *)(dest + n - 4)));
+	}
 }
 
 /* in-string eeh macros */
 static inline void eeh_readsb(const volatile void __iomem *addr, void * buf,
 			      int ns)
 {
-	_insb(addr, buf, ns);
-	if (EEH_POSSIBLE_ERROR((*(((u8*)buf)+ns-1)), u8))
-		eeh_check_failure(addr, *(u8*)buf);
+	void *edev;
+
+	memset(buf, 0xFF, ns);
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		_insb(addr, buf, ns);
+		if (EEH_POSSIBLE_ERROR((*(((u8*)buf)+ns-1)), u8))
+			eeh_check_failure(edev, *(u8*)buf);
+	}
 }
 
 static inline void eeh_readsw(const volatile void __iomem *addr, void * buf,
 			      int ns)
 {
-	_insw(addr, buf, ns);
-	if (EEH_POSSIBLE_ERROR((*(((u16*)buf)+ns-1)), u16))
-		eeh_check_failure(addr, *(u16*)buf);
+	void *edev;
+
+	memset(buf, 0xFF, ns * sizeof(u16));
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		_insw(addr, buf, ns);
+		if (EEH_POSSIBLE_ERROR((*(((u16*)buf)+ns-1)), u16))
+			eeh_check_failure(edev, *(u16*)buf);
+	}
 }
 
 static inline void eeh_readsl(const volatile void __iomem *addr, void * buf,
 			      int nl)
 {
-	_insl(addr, buf, nl);
-	if (EEH_POSSIBLE_ERROR((*(((u32*)buf)+nl-1)), u32))
-		eeh_check_failure(addr, *(u32*)buf);
+	void *edev;
+
+	memset(buf, 0xFF, nl * sizeof(u32));
+
+	if (!eeh_check_blocked_io(addr, &edev)) {
+		_insl(addr, buf, nl);
+		if (EEH_POSSIBLE_ERROR((*(((u32*)buf)+nl-1)), u32))
+			eeh_check_failure(edev, *(u32*)buf);
+	}
+}
+
+/* MMIO write */
+static inline void eeh_writeb(volatile u8 __iomem *addr, u8 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_8(addr, val);
+}
+
+static inline void eeh_writew(volatile u16 __iomem *addr, u16 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_le16(addr, val);
 }
 
+static inline void eeh_writel(volatile u32 __iomem *addr, u32 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_le32(addr, val);
+}
+
+static inline void eeh_writeq(volatile u64 __iomem *addr, u64 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_le64(addr, val);
+}
+
+static inline void eeh_writew_be(volatile u16 __iomem *addr, u16 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_be16(addr, val);
+}
+
+static inline void eeh_writel_be(volatile u32 __iomem *addr, u32 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_be32(addr, val);
+}
+
+static inline void eeh_writeq_be(volatile u64 __iomem *addr, u64 val)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		out_be64(addr, val);
+}
+
+static inline void eeh_writesb(volatile u8 __iomem *addr,
+			       const void *buf, long count)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		_outsb(addr, buf, count);
+}
+
+static inline void eeh_writesw(volatile u16 __iomem *addr,
+			       const void *buf, long count)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		_outsw(addr, buf, count);
+}
+
+static inline void eeh_writesl(volatile u32 __iomem *addr,
+			       const void *buf, long count)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		_outsl(addr, buf, count);
+}
+
+static inline void eeh_memset_io(volatile void __iomem *addr,
+				 int c, unsigned long n)
+{
+	if (!eeh_check_blocked_io(addr, NULL))
+		_memset_io(addr, c, n);
+}
+
+static inline void eeh_memcpy_toio(volatile void __iomem *dest,
+				   const void *src, unsigned long n)
+{
+	if (!eeh_check_blocked_io(dest, NULL))
+		_memcpy_toio(dest, src, n);
+}
+
+
+
 #endif /* CONFIG_PPC64 */
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_EEH_H */
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index dd15e5e..fa58c45 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -412,30 +412,37 @@ __do_out_asm(_rec_outl, "stwbrx")
  * possible to hook directly at the toplevel PIO operation if they have to
  * be handled differently
  */
-#define __do_writeb(val, addr)	out_8(PCI_FIX_ADDR(addr), val)
-#define __do_writew(val, addr)	out_le16(PCI_FIX_ADDR(addr), val)
-#define __do_writel(val, addr)	out_le32(PCI_FIX_ADDR(addr), val)
-#define __do_writeq(val, addr)	out_le64(PCI_FIX_ADDR(addr), val)
-#define __do_writew_be(val, addr) out_be16(PCI_FIX_ADDR(addr), val)
-#define __do_writel_be(val, addr) out_be32(PCI_FIX_ADDR(addr), val)
-#define __do_writeq_be(val, addr) out_be64(PCI_FIX_ADDR(addr), val)
 
 #ifdef CONFIG_EEH
-#define __do_readb(addr)	eeh_readb(PCI_FIX_ADDR(addr))
-#define __do_readw(addr)	eeh_readw(PCI_FIX_ADDR(addr))
-#define __do_readl(addr)	eeh_readl(PCI_FIX_ADDR(addr))
-#define __do_readq(addr)	eeh_readq(PCI_FIX_ADDR(addr))
-#define __do_readw_be(addr)	eeh_readw_be(PCI_FIX_ADDR(addr))
-#define __do_readl_be(addr)	eeh_readl_be(PCI_FIX_ADDR(addr))
-#define __do_readq_be(addr)	eeh_readq_be(PCI_FIX_ADDR(addr))
+#define __do_readb(addr)		eeh_readb(PCI_FIX_ADDR(addr))
+#define __do_readw(addr)		eeh_readw(PCI_FIX_ADDR(addr))
+#define __do_readl(addr)		eeh_readl(PCI_FIX_ADDR(addr))
+#define __do_readq(addr)		eeh_readq(PCI_FIX_ADDR(addr))
+#define __do_readw_be(addr)		eeh_readw_be(PCI_FIX_ADDR(addr))
+#define __do_readl_be(addr)		eeh_readl_be(PCI_FIX_ADDR(addr))
+#define __do_readq_be(addr)		eeh_readq_be(PCI_FIX_ADDR(addr))
+#define __do_writeb(val, addr)		eeh_writeb(PCI_FIX_ADDR(addr), val)
+#define __do_writew(val, addr)          eeh_writew(PCI_FIX_ADDR(addr), val)
+#define __do_writel(val, addr)          eeh_writel(PCI_FIX_ADDR(addr), val)
+#define __do_writeq(val, addr)          eeh_writeq(PCI_FIX_ADDR(addr), val)
+#define __do_writew_be(val, addr)       eeh_writew_be(PCI_FIX_ADDR(addr), val)
+#define __do_writel_be(val, addr)       eeh_writel_be(PCI_FIX_ADDR(addr), val)
+#define __do_writeq_be(val, addr)       eeh_writeq_be(PCI_FIX_ADDR(addr), val)
 #else /* CONFIG_EEH */
-#define __do_readb(addr)	in_8(PCI_FIX_ADDR(addr))
-#define __do_readw(addr)	in_le16(PCI_FIX_ADDR(addr))
-#define __do_readl(addr)	in_le32(PCI_FIX_ADDR(addr))
-#define __do_readq(addr)	in_le64(PCI_FIX_ADDR(addr))
-#define __do_readw_be(addr)	in_be16(PCI_FIX_ADDR(addr))
-#define __do_readl_be(addr)	in_be32(PCI_FIX_ADDR(addr))
-#define __do_readq_be(addr)	in_be64(PCI_FIX_ADDR(addr))
+#define __do_readb(addr)		in_8(PCI_FIX_ADDR(addr))
+#define __do_readw(addr)		in_le16(PCI_FIX_ADDR(addr))
+#define __do_readl(addr)		in_le32(PCI_FIX_ADDR(addr))
+#define __do_readq(addr)		in_le64(PCI_FIX_ADDR(addr))
+#define __do_readw_be(addr)		in_be16(PCI_FIX_ADDR(addr))
+#define __do_readl_be(addr)		in_be32(PCI_FIX_ADDR(addr))
+#define __do_readq_be(addr)		in_be64(PCI_FIX_ADDR(addr))
+#define __do_writeb(val, addr)		out_8(PCI_FIX_ADDR(addr), val)
+#define __do_writew(val, addr)		out_le16(PCI_FIX_ADDR(addr), val)
+#define __do_writel(val, addr)		out_le32(PCI_FIX_ADDR(addr), val)
+#define __do_writeq(val, addr)		out_le64(PCI_FIX_ADDR(addr), val)
+#define __do_writew_be(val, addr)	out_be16(PCI_FIX_ADDR(addr), val)
+#define __do_writel_be(val, addr)	out_be32(PCI_FIX_ADDR(addr), val)
+#define __do_writeq_be(val, addr)	out_be64(PCI_FIX_ADDR(addr), val)
 #endif /* !defined(CONFIG_EEH) */
 
 #ifdef CONFIG_PPC32
@@ -458,14 +465,17 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_readsb(a, b, n)	eeh_readsb(PCI_FIX_ADDR(a), (b), (n))
 #define __do_readsw(a, b, n)	eeh_readsw(PCI_FIX_ADDR(a), (b), (n))
 #define __do_readsl(a, b, n)	eeh_readsl(PCI_FIX_ADDR(a), (b), (n))
+#define __do_writesb(a, b, n)   eeh_writesb(PCI_FIX_ADDR(a),(b),(n))
+#define __do_writesw(a, b, n)   eeh_writesw(PCI_FIX_ADDR(a),(b),(n))
+#define __do_writesl(a, b, n)   eeh_writesl(PCI_FIX_ADDR(a),(b),(n))
 #else /* CONFIG_EEH */
 #define __do_readsb(a, b, n)	_insb(PCI_FIX_ADDR(a), (b), (n))
 #define __do_readsw(a, b, n)	_insw(PCI_FIX_ADDR(a), (b), (n))
 #define __do_readsl(a, b, n)	_insl(PCI_FIX_ADDR(a), (b), (n))
-#endif /* !CONFIG_EEH */
 #define __do_writesb(a, b, n)	_outsb(PCI_FIX_ADDR(a),(b),(n))
 #define __do_writesw(a, b, n)	_outsw(PCI_FIX_ADDR(a),(b),(n))
 #define __do_writesl(a, b, n)	_outsl(PCI_FIX_ADDR(a),(b),(n))
+#endif /* !CONFIG_EEH */
 
 #define __do_insb(p, b, n)	readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
 #define __do_insw(p, b, n)	readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
@@ -474,17 +484,20 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_outsw(p, b, n)	writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
 #define __do_outsl(p, b, n)	writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
 
-#define __do_memset_io(addr, c, n)	\
-				_memset_io(PCI_FIX_ADDR(addr), c, n)
-#define __do_memcpy_toio(dst, src, n)	\
-				_memcpy_toio(PCI_FIX_ADDR(dst), src, n)
-
 #ifdef CONFIG_EEH
 #define __do_memcpy_fromio(dst, src, n)	\
 				eeh_memcpy_fromio(dst, PCI_FIX_ADDR(src), n)
+#define __do_memset_io(addr, c, n)	\
+				eeh_memset_io(PCI_FIX_ADDR(addr), c, n)
+#define __do_memcpy_toio(dst, src, n)	\
+				eeh_memcpy_toio(PCI_FIX_ADDR(dst), src, n)
 #else /* CONFIG_EEH */
 #define __do_memcpy_fromio(dst, src, n)	\
 				_memcpy_fromio(dst,PCI_FIX_ADDR(src),n)
+#define __do_memset_io(addr, c, n)	\
+				_memset_io(PCI_FIX_ADDR(addr), c, n)
+#define __do_memcpy_toio(dst, src, n)	\
+				_memcpy_toio(PCI_FIX_ADDR(dst), src, n)
 #endif /* !CONFIG_EEH */
 
 #ifdef CONFIG_PPC_INDIRECT_PIO
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 65320fd..b46f1ca 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -464,39 +464,57 @@ dn_unlock:
 EXPORT_SYMBOL_GPL(eeh_dev_check_failure);
 
 /**
- * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
- * @token: I/O token, should be address in the form 0xA....
- * @val: value, should be all 1's (XXX why do we need this arg??)
- *
- * Check for an EEH failure at the given token address.  Call this
- * routine if the result of a read was all 0xff's and you want to
- * find out if this is due to an EEH slot freeze event.  This routine
- * will query firmware for the EEH status.
+ * eeh_check_blocked_io - Check if the I/O access has been blocked
+ * @token: I/O token
+ * @pedev: EEH device
  *
- * Note this routine is safe to call in an interrupt context.
+ * Check if the I/O access has been blocked. If that's the case, we
+ * should return 0xFF's on read, or sliently drop the write.
  */
-unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
+int eeh_check_blocked_io(const volatile void __iomem *token,
+			 void **pedev)
 {
-	unsigned long addr;
 	struct eeh_dev *edev;
+	unsigned long addr;
+	int rc;
 
-	/* Finding the phys addr + pci device; this is pretty quick. */
+	/* Don't block I/O ranges which aren't traced by cache */
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	edev = eeh_addr_cache_get_dev(addr);
 	if (!edev) {
+		if (pedev) *pedev = NULL;
 		eeh_stats.no_device++;
-		return val;
+		return 0;
 	}
 
-	eeh_dev_check_failure(edev);
+	if (pedev) *pedev = edev;
+	eeh_ops->get_setting(EEH_SETTING_BLOCK_IO, &rc, edev->phb);
+	return rc;
+}
+
+EXPORT_SYMBOL(eeh_check_blocked_io);
+
+/**
+ * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
+ * @edev: EEH device
+ * @val: value
+ *
+ * Check if the EEH device has been frozen.
+ *
+ * Note this routine is safe to call in an interrupt context.
+ */
+unsigned long eeh_check_failure(struct eeh_dev *edev, unsigned long val)
+{
+	if (edev) {
+		eeh_dev_check_failure(edev);
+		pci_dev_put(eeh_dev_to_pci_dev(edev));
+	}
 
-	pci_dev_put(eeh_dev_to_pci_dev(edev));
 	return val;
 }
 
 EXPORT_SYMBOL(eeh_check_failure);
 
-
 /**
  * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
  * @pe: EEH PE
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index cac5e18..20a7865 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -367,7 +367,7 @@ static int powernv_eeh_set_setting(int option, int value, void *data)
 	struct pci_controller *hose = data;
 	struct pnv_phb *phb = hose->private_data;
 
-	return phb->set_setting(option, value, data);
+	return phb->eeh_ops->set_setting(option, value, data);
 }
 
 /**
@@ -383,7 +383,7 @@ static int powernv_eeh_get_setting(int option, int *value, void *data)
 	struct pci_controller *hose = data;
 	struct pnv_phb *phb = hose->private_data;
 
-	return phb->get_setting(option, value, data);
+	return phb->eeh_ops->get_setting(option, value, data);
 }
 
 /**
-- 
1.7.5.4
