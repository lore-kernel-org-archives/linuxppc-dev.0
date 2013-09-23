Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 05/39] powerpc: Little endian builds double word swap VSX
 state during context save/restore
Date: Mon, 23 Sep 2013 12:04:39 +1000
Message-Id: <1379901913-5945-6-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The elements within VSX loads and stores are big endian ordered
regardless of endianness. Our VSX context save/restore code uses
lxvd2x and stxvd2x which is a 2x doubleword operation. This means
the two doublewords will be swapped and we have to perform another
swap to undo it.

We need to do this on save and restore.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc-opcode.h |  3 +++
 arch/powerpc/include/asm/ppc_asm.h    | 21 +++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index d7fe9f5..ad5fcf5 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -181,6 +181,7 @@
 #define PPC_INST_TLBIVAX		0x7c000624
 #define PPC_INST_TLBSRX_DOT		0x7c0006a5
 #define PPC_INST_XXLOR			0xf0000510
+#define PPC_INST_XXSWAPD		0xf0000250
 #define PPC_INST_XVCPSGNDP		0xf0000780
 #define PPC_INST_TRECHKPT		0x7c0007dd
 #define PPC_INST_TRECLAIM		0x7c00075d
@@ -344,6 +345,8 @@
 					       VSX_XX1((s), a, b))
 #define XXLOR(t, a, b)		stringify_in_c(.long PPC_INST_XXLOR | \
 					       VSX_XX3((t), a, b))
+#define XXSWAPD(t, a)		stringify_in_c(.long PPC_INST_XXSWAPD | \
+					       VSX_XX3((t), a, a))
 #define XVCPSGNDP(t, a, b)	stringify_in_c(.long (PPC_INST_XVCPSGNDP | \
 					       VSX_XX3((t), (a), (b))))
 
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 5995457..0c51fb4 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -180,9 +180,20 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define REST_32VRS_TRANSACT(n,b,base)	REST_16VRS_TRANSACT(n,b,base);	\
 					REST_16VRS_TRANSACT(n+16,b,base)
 
+#ifdef __BIG_ENDIAN__
+#define STXVD2X_ROT(n,b,base)		STXVD2X(n,b,base)
+#define LXVD2X_ROT(n,b,base)		LXVD2X(n,b,base)
+#else
+#define STXVD2X_ROT(n,b,base)		XXSWAPD(n,n);		\
+					STXVD2X(n,b,base);	\
+					XXSWAPD(n,n)
+
+#define LXVD2X_ROT(n,b,base)		LXVD2X(n,b,base);	\
+					XXSWAPD(n,n)
+#endif
 
 #define SAVE_VSR_TRANSACT(n,b,base)	li b,THREAD_TRANSACT_VSR0+(16*(n)); \
-					STXVD2X(n,R##base,R##b)
+					STXVD2X_ROT(n,R##base,R##b)
 #define SAVE_2VSRS_TRANSACT(n,b,base)	SAVE_VSR_TRANSACT(n,b,base);	\
 	                                SAVE_VSR_TRANSACT(n+1,b,base)
 #define SAVE_4VSRS_TRANSACT(n,b,base)	SAVE_2VSRS_TRANSACT(n,b,base);	\
@@ -195,7 +206,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	                                SAVE_16VSRS_TRANSACT(n+16,b,base)
 
 #define REST_VSR_TRANSACT(n,b,base)	li b,THREAD_TRANSACT_VSR0+(16*(n)); \
-					LXVD2X(n,R##base,R##b)
+					LXVD2X_ROT(n,R##base,R##b)
 #define REST_2VSRS_TRANSACT(n,b,base)	REST_VSR_TRANSACT(n,b,base);    \
 	                                REST_VSR_TRANSACT(n+1,b,base)
 #define REST_4VSRS_TRANSACT(n,b,base)	REST_2VSRS_TRANSACT(n,b,base);	\
@@ -208,13 +219,15 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	                                REST_16VSRS_TRANSACT(n+16,b,base)
 
 /* Save the lower 32 VSRs in the thread VSR region */
-#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,R##base,R##b)
+#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); \
+				STXVD2X_ROT(n,R##base,R##b)
 #define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
 #define SAVE_4VSRS(n,b,base)	SAVE_2VSRS(n,b,base); SAVE_2VSRS(n+2,b,base)
 #define SAVE_8VSRS(n,b,base)	SAVE_4VSRS(n,b,base); SAVE_4VSRS(n+4,b,base)
 #define SAVE_16VSRS(n,b,base)	SAVE_8VSRS(n,b,base); SAVE_8VSRS(n+8,b,base)
 #define SAVE_32VSRS(n,b,base)	SAVE_16VSRS(n,b,base); SAVE_16VSRS(n+16,b,base)
-#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,R##base,R##b)
+#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); \
+				LXVD2X_ROT(n,R##base,R##b)
 #define REST_2VSRS(n,b,base)	REST_VSR(n,b,base); REST_VSR(n+1,b,base)
 #define REST_4VSRS(n,b,base)	REST_2VSRS(n,b,base); REST_2VSRS(n+2,b,base)
 #define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
-- 
1.8.1.2
