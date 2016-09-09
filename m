Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVmcb4tqkzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 15:54:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org,
	glaubitz@physik.fu-berlin.de
Subject: [PATCH] powerpc/xmon: Don't use ld on 32-bit
Date: Fri,  9 Sep 2016 15:54:37 +1000
Message-Id: <1473400477-23548-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 31cdd0c39c75 ("powerpc/xmon: Fix SPR read/write commands and
add command to dump SPRs") I added two uses of the "ld" instruction in
spr_access.S. "ld" is a 64-bit instruction, so shouldn't be used on
32-bit CPUs.

Replace it with PPC_LL which is a macro that gives us either "ld" or
"lwz" depending on whether we're 64 or 32-bit.

Fixes: 31cdd0c39c75 ("powerpc/xmon: Fix SPR read/write commands and add command to dump SPRs")
Cc: stable@vger.kernel.org # v4.7+
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/spr_access.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/spr_access.S b/arch/powerpc/xmon/spr_access.S
index 84ad74213c83..7d8b0e8ed6d9 100644
--- a/arch/powerpc/xmon/spr_access.S
+++ b/arch/powerpc/xmon/spr_access.S
@@ -2,12 +2,12 @@
 
 /* unsigned long xmon_mfspr(sprn, default_value) */
 _GLOBAL(xmon_mfspr)
-	ld	r5, .Lmfspr_table@got(r2)
+	PPC_LL	r5, .Lmfspr_table@got(r2)
 	b	xmon_mxspr
 
 /* void xmon_mtspr(sprn, new_value) */
 _GLOBAL(xmon_mtspr)
-	ld	r5, .Lmtspr_table@got(r2)
+	PPC_LL	r5, .Lmtspr_table@got(r2)
 	b	xmon_mxspr
 
 /*
-- 
2.7.4
