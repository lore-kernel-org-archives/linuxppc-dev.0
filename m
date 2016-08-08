Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7C2f345xzDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 19:35:54 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id vy10so5181756pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 02:35:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: rebuild vdsos correctly
Date: Mon,  8 Aug 2016 19:35:43 +1000
Message-Id: <1470648943-15643-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using if_changed, we need to add FORCE to dependencies, otherwise
we don't get command line change checking amongst other things. This
has resulted in vdsos not being rebuilt when switching between big and
little endian.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

There look to be some other cases in arch/powerpc/ of if_changed
being used without FORCE too, which should also be investigated.
Also, why are we using if_changed_deps?
---
 arch/powerpc/kernel/vdso32/Makefile | 8 ++++----
 arch/powerpc/kernel/vdso64/Makefile | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index cbabd14..ae1f245 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -30,7 +30,7 @@ CPPFLAGS_vdso32.lds += -P -C -Upowerpc
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32)
+$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) FORCE
 	$(call if_changed,vdso32ld)
 
 # strip rule for the .so file
@@ -39,14 +39,14 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # assembly rules for the .S files
-$(obj-vdso32): %.o: %.S
+$(obj-vdso32): %.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
 
 # actual build commands
 quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
 quiet_cmd_vdso32as = VDSO32A $@
-      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
+      cmd_vdso32as = $(CROSS32CC) $(a_flags) -o $@ -c $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index c710802..0d5f04a 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -23,7 +23,7 @@ CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64)
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
 	$(call if_changed,vdso64ld)
 
 # strip rule for the .so file
@@ -32,14 +32,14 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # assembly rules for the .S files
-$(obj-vdso64): %.o: %.S
+$(obj-vdso64): %.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 
 # actual build commands
 quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso64ld = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
 quiet_cmd_vdso64as = VDSO64A $@
-      cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
+      cmd_vdso64as = $(CC) $(a_flags) -o $@ -c $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
-- 
2.8.1
