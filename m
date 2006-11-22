Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 6BC0267BCD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:17:17 +1100 (EST)
Date: Wed, 22 Nov 2006 05:17:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org
Subject: [2.6 patch] include/asm-powerpc/: "extern inline" -> "static inline"
Message-ID: <20061122041717.GZ5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"extern inline" generates a warning with -Wmissing-prototypes and I'm
currently working on getting the kernel cleaned up for adding this to
the CFLAGS since it will help us to avoid a nasty class of runtime
errors.

If there are places that really need a forced inline, __always_inline
would be the correct solution.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-powerpc/io.h      |    4 ++--
 include/asm-powerpc/tsi108.h  |    4 ++--
 include/asm-powerpc/uaccess.h |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.19-rc5-mm2/include/asm-powerpc/io.h.old	2006-11-22 01:46:28.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-powerpc/io.h	2006-11-22 01:47:08.000000000 +0100
@@ -304,7 +304,7 @@ do {									\
 #ifdef CONFIG_PPC32
 
 #define __do_in_asm(name, op)				\
-extern __inline__ unsigned int name(unsigned int port)	\
+static inline unsigned int name(unsigned int port)	\
 {							\
 	unsigned int x;					\
 	__asm__ __volatile__(				\
@@ -331,7 +331,7 @@ extern __inline__ unsigned int name(unsi
 }
 
 #define __do_out_asm(name, op)				\
-extern __inline__ void name(unsigned int val, unsigned int port) \
+static inline void name(unsigned int val, unsigned int port) \
 {							\
 	__asm__ __volatile__(				\
 		"sync\n"				\
--- linux-2.6.19-rc5-mm2/include/asm-powerpc/tsi108.h.old	2006-11-22 01:47:17.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-powerpc/tsi108.h	2006-11-22 01:47:26.000000000 +0100
@@ -98,12 +98,12 @@ typedef struct {
 extern u32 get_vir_csrbase(void);
 extern u32 tsi108_csr_vir_base;
 
-extern inline u32 tsi108_read_reg(u32 reg_offset)
+static inline u32 tsi108_read_reg(u32 reg_offset)
 {
 	return in_be32((volatile u32 *)(tsi108_csr_vir_base + reg_offset));
 }
 
-extern inline void tsi108_write_reg(u32 reg_offset, u32 val)
+static inline void tsi108_write_reg(u32 reg_offset, u32 val)
 {
 	out_be32((volatile u32 *)(tsi108_csr_vir_base + reg_offset), val);
 }
--- linux-2.6.19-rc5-mm2/include/asm-powerpc/uaccess.h.old	2006-11-22 01:47:33.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-powerpc/uaccess.h	2006-11-22 01:47:38.000000000 +0100
@@ -304,7 +304,7 @@ extern unsigned long __copy_tofrom_user(
 
 #ifndef __powerpc64__
 
-extern inline unsigned long copy_from_user(void *to,
+static inline unsigned long copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
 	unsigned long over;
@@ -319,7 +319,7 @@ extern inline unsigned long copy_from_us
 	return n;
 }
 
-extern inline unsigned long copy_to_user(void __user *to,
+static inline unsigned long copy_to_user(void __user *to,
 		const void *from, unsigned long n)
 {
 	unsigned long over;
