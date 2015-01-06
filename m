Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89D081A0780
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 21:12:10 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powernv: Fix OPAL tracepoint code
Date: Tue,  6 Jan 2015 21:12:08 +1100
Message-Id: <1420539128-17010-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch c49f63530bb6 ("powernv: Add OPAL tracepoints") has a spurious
store to the stack:

	ld      r12,opal_tracepoint_refcount@toc(r2);           \
	std     r12,32(r1);                                     \

The store was originally used to save the current tracepoint status
so the entry and the exit tracepoints were always balanced. In the
end I just created a separate path when tracepoints are enabled.

The offset on the stack used for this store is not valid for ABIv2
and it causes strange issues. I noticed it because OPAL console input
was broken.

Fixes: c49f63530bb6 ("powernv: Add OPAL tracepoints")
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 54eca8b..0509bca 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -40,7 +40,6 @@ BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
 	ld	r12,opal_tracepoint_refcount@toc(r2);		\
-	std	r12,32(r1);					\
 	cmpdi	r12,0;						\
 	bne-	LABEL;						\
 1:
-- 
2.1.0
