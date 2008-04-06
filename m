Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D351DDE01
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 06:23:32 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] make help: Show defconfig subdirs
Date: Sun,  6 Apr 2008 22:16:07 +0200
Message-Id: <f70d44df351c88b7754e2ca93c6075f9660d3a40.1207512931.git.segher@kernel.crashing.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC will start moving board defconfigs into subarch-specific
subdirs soon.  "make help" currently does not look in subdirs to
find the defconfigs to show.  This is partially a good thing,
since there are way too many defconfigs for one list.

This patch makes the main "make help" display something like

  help-40x         - Show 40x-specific targets
  help-44x         - Show 44x-specific targets
  help-boards      - Show all of the above

and wires up stuff so those new help-* commands actually work.

Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 Makefile |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index fec2a12..05d9fda 100644
--- a/Makefile
+++ b/Makefile
@@ -1172,6 +1172,8 @@ rpm: include/config/kernel.release FORCE
 
 boards := $(wildcard $(srctree)/arch/$(ARCH)/configs/*_defconfig)
 boards := $(notdir $(boards))
+board-dirs := $(dir $(wildcard $(srctree)/arch/$(ARCH)/configs/*/*_defconfig))
+board-dirs := $(sort $(notdir $(board-dirs:/=)))
 
 help:
 	@echo  'Cleaning targets:'
@@ -1225,6 +1227,11 @@ help:
 		$(foreach b, $(boards), \
 		printf "  %-24s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
 		echo '')
+	@$(if $(board-dirs), \
+		$(foreach b, $(board-dirs), \
+		printf "  %-16s - Show %s-specific targets\\n" help-$(b) $(b);) \
+		printf "  %-16s - Show all of the above\\n" help-boards; \
+		echo '')
 
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
 	@echo  '  make V=2   [targets] 2 => give reason for rebuild of target'
@@ -1236,6 +1243,20 @@ help:
 	@echo  'For further info see the ./README file'
 
 
+help-board-dirs := $(addprefix help-,$(board-dirs))
+
+help-boards: $(help-board-dirs)
+
+boards-per-dir = $(notdir $(wildcard $(srctree)/arch/$(ARCH)/configs/$*/*_defconfig))
+
+$(help-board-dirs): help-%:
+	@echo  'Architecture specific targets ($(ARCH) $*):'
+	@$(if $(boards-per-dir), \
+		$(foreach b, $(boards-per-dir), \
+		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));) \
+		echo '')
+
+
 # Documentation targets
 # ---------------------------------------------------------------------------
 %docs: scripts_basic FORCE
-- 
1.5.3.4.208.g805a
