Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F39781A0BDD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 23:42:58 +1100 (AEDT)
From: Michal Marek <mmarek@suse.cz>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Fix make help-XXX on powerpc
Date: Fri, 28 Nov 2014 13:42:43 +0100
Message-Id: <1417178563-28001-1-git-send-email-mmarek@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

make ARCH=powerpc help-<board series> should not require a cofigured
source tree. Also, sort the boards in the output.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 88b7fa5..0cd4e14 100644
--- a/Makefile
+++ b/Makefile
@@ -482,7 +482,7 @@ asm-generic:
 version_h := include/generated/uapi/linux/version.h
 
 no-dot-config-targets := clean mrproper distclean \
-			 cscope gtags TAGS tags help %docs check% coccicheck \
+			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
 
@@ -1323,7 +1323,7 @@ help-board-dirs := $(addprefix help-,$(board-dirs))
 
 help-boards: $(help-board-dirs)
 
-boards-per-dir = $(notdir $(wildcard $(srctree)/arch/$(SRCARCH)/configs/$*/*_defconfig))
+boards-per-dir = $(sort $(notdir $(wildcard $(srctree)/arch/$(SRCARCH)/configs/$*/*_defconfig)))
 
 $(help-board-dirs): help-%:
 	@echo  'Architecture specific targets ($(SRCARCH) $*):'
-- 
2.1.2
