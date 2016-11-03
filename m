Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8Y8Z653JzDvQQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:15:58 +1100 (AEDT)
Date: Thu, 3 Nov 2016 16:15:42 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/64: Use optimized checksum routines on
 little-endian
Message-ID: <20161103051542.GB8368@fergus.ozlabs.ibm.com>
References: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we have optimized hand-coded assembly checksum routines
for big-endian 64-bit systems, but for little-endian we use the
generic C routines.  This modifies the optimized routines to work
for little-endian.  With this, we no longer need to enable
CONFIG_GENERIC_CSUM.  This also fixes a couple of comments
in checksum_64.S so they accurately reflect what the associated
instruction does.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/Kconfig                |  2 +-
 arch/powerpc/include/asm/checksum.h |  4 ++++
 arch/powerpc/lib/Makefile           |  2 --
 arch/powerpc/lib/checksum_64.S      | 12 ++++++++++--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c..514e6dd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,7 +164,7 @@ config PPC
 	select HAVE_KERNEL_GZIP
 
 config GENERIC_CSUM
-	def_bool CPU_LITTLE_ENDIAN
+	def_bool n
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index c16c6f8..5f8297b 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -72,7 +72,11 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 
 	s += (__force u32)saddr;
 	s += (__force u32)daddr;
+#ifdef __BIG_ENDIAN
 	s += proto + len;
+#else
+	s += (proto + len) << 8;
+#endif
 	return (__force __wsum) from64to32(s);
 #else
     __asm__("\n\
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 309361e8..0e649d7 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -21,9 +21,7 @@ obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 
-ifeq ($(CONFIG_GENERIC_CSUM),)
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o
-endif
 
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
 
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index fd91766..4dd2761 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -36,7 +36,7 @@ _GLOBAL(__csum_partial)
 	 * work to calculate the correct checksum, we ignore that case
 	 * and take the potential slowdown of unaligned loads.
 	 */
-	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 & 0x3) >> 1 */
+	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 >> 1) & 0x3 */
 	beq	.Lcsum_aligned
 
 	li	r7,4
@@ -168,8 +168,12 @@ _GLOBAL(__csum_partial)
 	beq	.Lcsum_finish
 
 	lbz	r6,0(r3)
+#ifdef __BIG_ENDIAN
 	sldi	r9,r6,8			/* Pad the byte out to 16 bits */
 	adde	r0,r0,r9
+#else
+	adde	r0,r0,r6
+#endif
 
 .Lcsum_finish:
 	addze	r0,r0			/* add in final carry */
@@ -236,7 +240,7 @@ _GLOBAL(csum_partial_copy_generic)
 	 * If the source and destination are relatively unaligned we only
 	 * align the source. This keeps things simple.
 	 */
-	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 & 0x3) >> 1 */
+	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 >> 1) & 0x3 */
 	beq	.Lcopy_aligned
 
 	li	r9,4
@@ -398,8 +402,12 @@ dstnr;	sth	r6,0(r4)
 	beq	.Lcopy_finish
 
 srcnr;	lbz	r6,0(r3)
+#ifdef __BIG_ENDIAN
 	sldi	r9,r6,8			/* Pad the byte out to 16 bits */
 	adde	r0,r0,r9
+#else
+	adde	r0,r0,r6
+#endif
 dstnr;	stb	r6,0(r4)
 
 .Lcopy_finish:
-- 
2.10.1
