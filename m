Return-Path: <segher@gcc12.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id A54EEDDEDA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:58:57 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: Don't run prom_init_check for arch/ppc builds
Date: Wed,  7 May 2008 00:58:50 +0200
Message-Id: <d65aa60aa955433e26e1791e197c533e7a0cd8c4.1210114487.git.segher@kernel.crashing.org>
In-Reply-To: <3b9b7dce6551e43c8fca4a1a3d4bff5a5b78312b.1210114487.git.segher@kernel.crashing.org>
References: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
	<cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
	<3b9b7dce6551e43c8fca4a1a3d4bff5a5b78312b.1210114487.git.segher@kernel.crashing.org>
In-Reply-To: <cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
References: <cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/ppc doesn't have prom_init.o (anymore).

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index d14cebf..2346d27 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -105,6 +105,9 @@ PHONY += systbl_chk
 systbl_chk: $(src)/systbl_chk.sh $(obj)/systbl_chk.i
 	$(call cmd,systbl_chk)
 
+
+ifeq ($(CONFIG_PPC_MERGE),y)
+
 $(obj)/built-in.o:		prom_init_check
 
 quiet_cmd_prom_init_check = CALL    $<
@@ -114,4 +117,7 @@ PHONY += prom_init_check
 prom_init_check: $(src)/prom_init_check.sh $(obj)/prom_init.o
 	$(call cmd,prom_init_check)
 
+endif
+
+
 clean-files := vmlinux.lds
-- 
1.5.5.23.g2a5f.dirty
