Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44EC4DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 07:31:01 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH v2] powerpc: add setmaskedbits macros
Date: Wed, 15 Aug 2007 16:30:50 -0500
Message-Id: <11872134502476-git-send-email-timur@freescale.com>
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

These new macros are useful because the setbits macros can only be used 
to set single-bit fields.  For example, if you have a 32-bit register 
where bits 17-20 need to be set to 0100, you would do  
setmaskedbits_be32(p, 4 << 11, 0xF << 11).

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Updated the changelog to include a reason why you'd want these macros.
I have a number of new SOC device drivers coming up that will use these
macros, if this patch is accepted.

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
