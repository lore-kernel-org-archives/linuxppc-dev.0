Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 49/63] powerpc: Remove open coded byte swap macro in alignment
 handler
Date: Wed,  7 Aug 2013 02:02:06 +1000
Message-Id: <1375804940-22050-50-git-send-email-anton@samba.org>
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

Use swab64/32/16 instead of open coding it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/align.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 52e5758..573728b 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -54,8 +54,6 @@ struct aligninfo {
 /* DSISR bits reported for a DCBZ instruction: */
 #define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */
 
-#define SWAP(a, b)	(t = (a), (a) = (b), (b) = t)
-
 /*
  * The PowerPC stores certain bits of the instruction that caused the
  * alignment exception in the DSISR register.  This array maps those
@@ -458,7 +456,7 @@ static struct aligninfo spe_aligninfo[32] = {
 static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 		       unsigned int instr)
 {
-	int t, ret;
+	int ret;
 	union {
 		u64 ll;
 		u32 w[2];
@@ -581,24 +579,18 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 	if (flags & SW) {
 		switch (flags & 0xf0) {
 		case E8:
-			SWAP(data.v[0], data.v[7]);
-			SWAP(data.v[1], data.v[6]);
-			SWAP(data.v[2], data.v[5]);
-			SWAP(data.v[3], data.v[4]);
+			data.ll = swab64(data.ll);
 			break;
 		case E4:
-
-			SWAP(data.v[0], data.v[3]);
-			SWAP(data.v[1], data.v[2]);
-			SWAP(data.v[4], data.v[7]);
-			SWAP(data.v[5], data.v[6]);
+			data.w[0] = swab32(data.w[0]);
+			data.w[1] = swab32(data.w[1]);
 			break;
 		/* Its half word endian */
 		default:
-			SWAP(data.v[0], data.v[1]);
-			SWAP(data.v[2], data.v[3]);
-			SWAP(data.v[4], data.v[5]);
-			SWAP(data.v[6], data.v[7]);
+			data.h[0] = swab16(data.h[0]);
+			data.h[1] = swab16(data.h[1]);
+			data.h[2] = swab16(data.h[2]);
+			data.h[3] = swab16(data.h[3]);
 			break;
 		}
 	}
@@ -706,7 +698,7 @@ int fix_alignment(struct pt_regs *regs)
 	unsigned int dsisr;
 	unsigned char __user *addr;
 	unsigned long p, swiz;
-	int ret, t;
+	int ret;
 	union {
 		u64 ll;
 		double dd;
@@ -911,17 +903,13 @@ int fix_alignment(struct pt_regs *regs)
 	if (flags & SW) {
 		switch (nb) {
 		case 8:
-			SWAP(data.v[0], data.v[7]);
-			SWAP(data.v[1], data.v[6]);
-			SWAP(data.v[2], data.v[5]);
-			SWAP(data.v[3], data.v[4]);
+			data.ll = swab64(data.ll);
 			break;
 		case 4:
-			SWAP(data.v[4], data.v[7]);
-			SWAP(data.v[5], data.v[6]);
+			data.x32.low32 = swab32(data.x32.low32);
 			break;
 		case 2:
-			SWAP(data.v[6], data.v[7]);
+			data.x16.low16 = swab16(data.x16.low16);
 			break;
 		}
 	}
-- 
1.8.1.2
