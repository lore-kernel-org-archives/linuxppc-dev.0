Return-Path: <horia.geanta@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0040.outbound.protection.outlook.com [104.47.41.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLx6Q2qSQzDqG3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 18:50:38 +1000 (AEST)
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: Nicholas Piggin <npiggin@gmail.com>, Mircea Pop <mircea.pop@nxp.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: fix distclean with Makefile.postlink
Date: Mon, 8 May 2017 11:50:16 +0300
Message-ID: <20170508085016.32601-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Makefile.postlink always includes include/config/auto.conf, however
this file is not present in a clean kernel tree, causing make to fail:

arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such file or directory
make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.
make: *** [vmlinuxclean] Error 2

Change the inclusion such that file not being found does not trigger
an error.

Fixes: f188d0524d7e ("powerpc: Use the new post-link pass to check relocations")
Reported-by: Mircea Pop <mircea.pop@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/powerpc/Makefile.postlink | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index 3c22d64b2de9..eccfcc88afae 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -7,7 +7,7 @@
 PHONY := __archpost
 __archpost:
 
-include include/config/auto.conf
+-include include/config/auto.conf
 include scripts/Kbuild.include
 
 quiet_cmd_relocs_check = CHKREL  $@
-- 
2.12.0.264.gd6db3f216544
