Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 03/39] powerpc: Fix offset of FPRs in VSX registers in little
 endian builds
Date: Mon, 23 Sep 2013 12:04:37 +1000
Message-Id: <1379901913-5945-4-git-send-email-anton@samba.org>
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

The FPRs overlap the high doublewords of the first 32 VSX registers.
Fix TS_FPROFFSET and TS_VSRLOWOFFSET so we access the correct fields
in little endian mode.

If VSX is disabled the FPRs are only one doubleword in length so
TS_FPROFFSET needs adjusting in little endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/processor.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e378ccc..634e2b2 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -14,8 +14,18 @@
 
 #ifdef CONFIG_VSX
 #define TS_FPRWIDTH 2
+
+#ifdef __BIG_ENDIAN__
+#define TS_FPROFFSET 0
+#define TS_VSRLOWOFFSET 1
+#else
+#define TS_FPROFFSET 1
+#define TS_VSRLOWOFFSET 0
+#endif
+
 #else
 #define TS_FPRWIDTH 1
+#define TS_FPROFFSET 0
 #endif
 
 #ifdef CONFIG_PPC64
@@ -142,8 +152,6 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
-#define TS_FPROFFSET 0
-#define TS_VSRLOWOFFSET 1
 #define TS_FPR(i) fpr[i][TS_FPROFFSET]
 #define TS_TRANS_FPR(i) transact_fpr[i][TS_FPROFFSET]
 
-- 
1.8.1.2
