Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44E30DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 22:07:35 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l7FC7TlK024611
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 05:07:29 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add setmaskedbits macros
Date: Wed, 15 Aug 2007 07:07:26 -0500
Message-Id: <11871796461560-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the setmaskedbits_xxx() macros, which are used to set a
multiple-bit bit pattern in a register.  The macros include a mask, which
zeros the respective bits before applying the value via a bitwise-OR.
There are big-endian and little-endian versions for 8, 16, 32, and 64 bits.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Fixed the changelog.

 include/asm-powerpc/io.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index bb8d965..ac3defb 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -734,6 +734,19 @@ static inline void * bus_to_virt(unsigned long address)
 #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
 #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
 
+#ifdef __powerpc64__
+#define setmaskedbits_be64(a, v, m) out_be64((a), (in_be64(a) & ~(m)) | (v))
+#define setmaskedbits_le64(a, v, m) out_le64((a), (in_le64(a) & ~(m)) | (v))
+#endif
+
+#define setmaskedbits_be32(a, v, m) out_be32((a), (in_be32(a) & ~(m)) | (v))
+#define setmaskedbits_be16(a, v, m) out_be16((a), (in_be16(a) & ~(m)) | (v))
+
+#define setmaskedbits_le32(a, v, m) out_le32((a), (in_le32(a) & ~(m)) | (v))
+#define setmaskedbits_le16(a, v, m) out_le16((a), (in_le16(a) & ~(m)) | (v))
+
+#define setmaskedbits_8(a, v, m) out_8((a), (in_8(a) & ~(m)) | (v))
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_IO_H */
-- 
1.5.2.4
