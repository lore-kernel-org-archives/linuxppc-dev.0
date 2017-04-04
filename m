Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxxWY1hHNzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:56:09 +1000 (AEST)
Date: Tue, 4 Apr 2017 14:56:05 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Don't try to fix up misaligned
 load-with-reservation instructions
Message-ID: <20170404045605.gmr2uqelm3uxouwt@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the past, there was only one load-with-reservation instruction,
lwarx, and if a program attempted a lwarx on a misaligned address, it
would take an alignment interrupt and the kernel handler would emulate
it as though it was lwzx, which was not really correct, but benign
since it is loading the right amount of data, and the lwarx should be
paired with a stwcx. to the same address, which would also cause an
alignment interrupt which would result in a SIGBUS being delivered to
the process.

We now have 5 different sizes of load-with-reservation instruction.
Of those, lharx and ldarx cause an immediate SIGBUS by luck since
their entries in aligninfo[] overlap instructions which were not
fixed up, but lqarx overlaps with lhz and will be emulated as such.
lbarx can never generate an alignment interrupt since it only
operates on 1 byte.

To straighten this out and fix the lqarx case, this adds code to
detect the l[hwdq]arx instructions and return without fixing them
up, resulting in a SIGBUS being delivered to the process.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kernel/align.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index cbc7c42cdb74..ec7a8b099dd9 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -807,14 +807,25 @@ int fix_alignment(struct pt_regs *regs)
 	nb = aligninfo[instr].len;
 	flags = aligninfo[instr].flags;
 
-	/* ldbrx/stdbrx overlap lfs/stfs in the DSISR unfortunately */
-	if (IS_XFORM(instruction) && ((instruction >> 1) & 0x3ff) == 532) {
-		nb = 8;
-		flags = LD+SW;
-	} else if (IS_XFORM(instruction) &&
-		   ((instruction >> 1) & 0x3ff) == 660) {
-		nb = 8;
-		flags = ST+SW;
+	/*
+	 * Handle some cases which give overlaps in the DSISR values.
+	 */
+	if (IS_XFORM(instruction)) {
+		switch (get_xop(instruction)) {
+		case 532:	/* ldbrx */
+			nb = 8;
+			flags = LD+SW;
+			break;
+		case 660:	/* stdbrx */
+			nb = 8;
+			flags = ST+SW;
+			break;
+		case 20:	/* lwarx */
+		case 84:	/* ldarx */
+		case 116:	/* lharx */
+		case 276:	/* lqarx */
+			return 0;	/* not emulated ever */
+		}
 	}
 
 	/* Byteswap little endian loads and stores */
-- 
2.11.0
