Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8yB2725rzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:03:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/5] powerpc/vdso64: Drop vdso64as
Date: Thu, 11 Aug 2016 16:03:12 +1000
Message-Id: <1470895395-10007-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
References: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can just use the standard .S -> .o rule, cmd_as_o_S.

That also fixes the bug we had in the vdso64as rule which is that it
didn't depend on FORCE, which it should have because it used
if_changed_dep.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso64/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index c710802b8fb6..1cf554258eb0 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -31,15 +31,9 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-# assembly rules for the .S files
-$(obj-vdso64): %.o: %.S
-	$(call if_changed_dep,vdso64as)
-
 # actual build commands
 quiet_cmd_vdso64ld = VDSO64L $@
       cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
-quiet_cmd_vdso64as = VDSO64A $@
-      cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
-- 
2.7.4
