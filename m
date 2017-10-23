Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL6v727TZzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 18:08:35 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id l24so11059464pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 00:08:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] powerpc/powernv: Use FIXUP_ENDIAN_HV in OPAL return
Date: Mon, 23 Oct 2017 17:08:15 +1000
Message-Id: <20171023070815.19803-4-npiggin@gmail.com>
In-Reply-To: <20171023070815.19803-1-npiggin@gmail.com>
References: <20171023070815.19803-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Close the recoverability gap for OPAL calls by using FIXUP_ENDIAN_HV
in the return path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 37cd170201a2..6f4b00a2ac46 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -94,7 +94,7 @@ opal_return:
 	 * bytes (always BE) since MSR:LE will end up fixed up as a side
 	 * effect of the rfid.
 	 */
-	FIXUP_ENDIAN
+	FIXUP_ENDIAN_HV
 	ld	r2,PACATOC(r13);
 	lwz	r4,8(r1);
 	ld	r5,PPC_LR_STKOFF(r1);
@@ -120,7 +120,7 @@ opal_real_call:
 	hrfid
 
 opal_return_realmode:
-	FIXUP_ENDIAN
+	FIXUP_ENDIAN_HV
 	ld	r2,PACATOC(r13);
 	lwz	r11,8(r1);
 	ld	r12,PPC_LR_STKOFF(r1)
-- 
2.13.3
