Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE458DDF02
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 11:07:36 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l7N17UVx022849
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 18:07:31 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] add clrsetbits macros
Date: Wed, 22 Aug 2007 20:07:28 -0500
Message-Id: <11878312483155-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the clrsetbits_xxx() macros, which are used to set and clear
multiple bits in a single read-modify-write operation.  Specify the bits to
clear in the 'clear' parameter and the bits to set in the 'set' parameter.
These macros can also be used to set a multiple-bit bit pattern using a mask,
by specifying the mask in the 'clear' parameter and the new bit pattern in the
'set' parameter.  There are big-endian and little-endian versions for 8, 16,
32, and 64 bits.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

put back the original functions and just based them off clrsetbits().

 include/asm-powerpc/io.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 4c0b550..38f03bc 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -737,6 +737,29 @@ static inline void * bus_to_virt(unsigned long address)
 #define setbits8(_addr, _v) out_8((_addr), in_8(_addr) |  (_v))
 #define clrbits8(_addr, _v) out_8((_addr), in_8(_addr) & ~(_v))
 
+/* Clear and set bits in one shot.  These macros can be used to clear and
+ * set multiple bits in a register using a single read-modify-write.  These
+ * macros can also be used to set a multiple-bit bit pattern using a mask,
+ * by specifying the mask in the 'clear' parameter and the new bit pattern
+ * in the 'set' parameter.
+ */
+
+#define clrsetbits(type, addr, clear, set) \
+	out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
+
+#ifdef __powerpc64__
+#define clrsetbits_be64(addr, clear, set) clrsetbits(be64, addr, clear, set)
+#define clrsetbits_le64(addr, clear, set) clrsetbits(le64, addr, clear, set)
+#endif
+
+#define clrsetbits_be32(addr, clear, set) clrsetbits(be32, addr, clear, set)
+#define clrsetbits_le32(addr, clear, set) clrsetbits(le32, addr, clear, set)
+
+#define clrsetbits_be16(addr, clear, set) clrsetbits(be16, addr, clear, set)
+#define clrsetbits_le16(addr, clear, set) clrsetbits(le32, addr, clear, set)
+
+#define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_IO_H */
-- 
1.5.2.4
