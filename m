Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B0F5DDF42
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 03:47:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l7MHlJ2C029207
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 10:47:20 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] add clrsetbits macros
Date: Wed, 22 Aug 2007 12:47:16 -0500
Message-Id: <11878048362390-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the clrsetbits() macro, which is used to set and clear
multiple bits in a single read-modify-write operation.  Specify the bits to
clear in the 'clear' parameter and the bits to set in the 'set' parameter.
These macros can also be used to set a multiple-bit bit pattern using a mask,
by specifying the mask in the 'clear' parameter and the new bit pattern in the
'set' parameter.  The 'type' parameter is used to specify the size and endian.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Replace multiple macros with a single one that uses macro concatenation to
handle the endian/size.

 include/asm-powerpc/io.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 4c0b550..030ed4e 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -737,6 +737,19 @@ static inline void * bus_to_virt(unsigned long address)
 #define setbits8(_addr, _v) out_8((_addr), in_8(_addr) |  (_v))
 #define clrbits8(_addr, _v) out_8((_addr), in_8(_addr) & ~(_v))
 
+/* Clear and set bits in one shot.  This macrocan be used to clear and set
+ * multiple bits in a register using a single read-modify-write.  It can
+ * also be used to set a multiple-bit bit pattern using a mask, by
+ * specifying the mask in the 'clear' parameter and the new bit pattern in
+ * the 'set' parameter.
+ *
+ * For 'type', specify 8, le16, be16, le32, be32, le64, or be64.  The latter
+ * two only work on 64-bit PowerPC (__powerpc64__ is defined).
+ */
+
+#define clrsetbits(type, addr, clear, set) \
+	out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_IO_H */
-- 
1.5.2.4
