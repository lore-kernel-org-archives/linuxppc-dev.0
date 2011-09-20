Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70B7FB735A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:45:25 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/20] powerpc/powernv: Don't clobber r9 in relative_toc()
Date: Tue, 20 Sep 2011 13:44:51 +1000
Message-Id: <1316490307-28030-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With OPAL, r8 and r9 will be used to pass the OPAL base and entry
for debugging purposes (those informations are also in the
device-tree). We don't want to clobber those registers that
early.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/head_64.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 3564c49..e708abe 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -674,9 +674,9 @@ _GLOBAL(enable_64b_mode)
 _GLOBAL(relative_toc)
 	mflr	r0
 	bcl	20,31,$+4
-0:	mflr	r9
-	ld	r2,(p_toc - 0b)(r9)
-	add	r2,r2,r9
+0:	mflr	r11
+	ld	r2,(p_toc - 0b)(r11)
+	add	r2,r2,r11
 	mtlr	r0
 	blr
 
-- 
1.7.4.1
