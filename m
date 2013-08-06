Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 04/63] powerpc: Remove SAVE_VSRU and REST_VSRU macros
Date: Wed,  7 Aug 2013 02:01:21 +1000
Message-Id: <1375804940-22050-5-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We always use VMX loads and stores to manage the high 32
VSRs. Remove these unused macros.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2f1b6c5..b5c85f1 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -219,19 +219,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
 #define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n+8,b,base)
 #define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n+16,b,base)
-/* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
-#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,R##base,R##b)
-#define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n+1,b,base)
-#define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n+2,b,base)
-#define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n+4,b,base)
-#define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n+8,b,base)
-#define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base); SAVE_16VSRSU(n+16,b,base)
-#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,R##base,R##b)
-#define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n+1,b,base)
-#define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n+2,b,base)
-#define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n+4,b,base)
-#define REST_16VSRSU(n,b,base)	REST_8VSRSU(n,b,base); REST_8VSRSU(n+8,b,base)
-#define REST_32VSRSU(n,b,base)	REST_16VSRSU(n,b,base); REST_16VSRSU(n+16,b,base)
 
 /*
  * b = base register for addressing, o = base offset from register of 1st EVR
-- 
1.8.1.2
