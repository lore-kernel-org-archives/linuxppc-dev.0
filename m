Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6B17DE040
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:47 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 18/22] [POWERPC] add clrsetbits macros
Date: Thu, 13 Sep 2007 16:07:56 -0500
Message-Id: <11897177091972-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897177071168-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
	<11897177032288-git-send-email-galak@kernel.crashing.org>
	<11897177042582-git-send-email-galak@kernel.crashing.org>
	<11897177052448-git-send-email-galak@kernel.crashing.org>
	<11897177071168-git-send-email-galak@kernel.crashing.org>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

This patch adds the clrsetbits_xxx() macros, which are used to set and clear
multiple bits in a single read-modify-write operation.  Specify the bits to
clear in the 'clear' parameter and the bits to set in the 'set' parameter.
These macros can also be used to set a multiple-bit bit pattern using a mask,
by specifying the mask in the 'clear' parameter and the new bit pattern in the
'set' parameter.  There are big-endian and little-endian versions for 8, 16,
32, and 64 bits.

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/io.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 4c0b550..6805efb 100644
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
