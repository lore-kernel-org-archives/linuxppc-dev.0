Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38DC0DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:43:38 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, Geert.Uytterhoeven@sonycom.com,
	michael@ellerman.id.au, paulus@samba.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc: add setclrbits macros
Date: Thu, 16 Aug 2007 17:43:19 -0500
Message-Id: <11873041991712-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the setclrbits_xxx() macros, which are used to set and clear
multiple bits in a single read-modify-write operation.  Specify the bits
to set in the 'set' parameter and the bits to clear in the 'clear' parameter.
These macros can also be used to set a multiple-bit bit pattern using a mask,
by specifying the mask in the 'clear' parameter and the new bit pattern in the
'set' parameter.  There are big-endian and little-endian versions for 8, 16,
32, and 64 bits.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Changed the macros from setmaskedbits_xxx to setclrbits_xxx and added a comment
indicating the expanded functionality.

 include/asm-powerpc/io.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index bb8d965..58c8b96 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -734,6 +734,33 @@ static inline void * bus_to_virt(unsigned long address)
 #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
 #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
 
+/* Set and clear bits in one shot.  These macros can be used to clear and
+ * set multiple bits in a register using a single read-modify-write.  These
+ * macros can also be used to set a multiple-bit bit pattern using a mask,
+ * by specifying the mask in the 'clear' parameter and the new bit pattern
+ * in the 'set' parameter.
+ */
+
+#ifdef __powerpc64__
+#define setclrbits_be64(addr, set, clear) \
+	out_be64((addr), (in_be64(addr) & ~(clear)) | (set))
+#define setclrbits_le64(addr, set, clear) \
+	out_le64((addr), (in_le64(addr) & ~(clear)) | (set))
+#endif
+
+#define setclrbits_be32(addr, set, clear) \
+	out_be32((addr), (in_be32(addr) & ~(clear)) | (set))
+#define setclrbits_be16(addr, set, clear) \
+	out_be16((addr), (in_be16(addr) & ~(clear)) | (set))
+
+#define setclrbits_le32(addr, set, clear) \
+	out_le32((addr), (in_le32(addr) & ~(clear)) | (set))
+#define setclrbits_le16(addr, set, clear) \
+	out_le16((addr), (in_le16(addr) & ~(clear)) | (set))
+
+#define setclrbits_8(addr, set, clear) \
+	out_8((addr), (in_8(addr) & ~(clear)) | (set))
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_IO_H */
-- 
1.5.2.4
