Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F4D51A0BEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 17:27:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Reject binutils 2.24 when building little endian
Date: Thu, 23 Apr 2015 17:27:12 +1000
Message-Id: <1429774032-3546-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a bug in binutils 2.24 which causes miscompilation if we're
building little endian and using weak symbols (which the kernel does).

It is fixed in binutils commit 57fa7b8c7e59 "Correct elf_merge_st_other
arguments for weak symbols", which is in binutils 2.25 and has been
backported to the binutils 2.24 branch and has been picked up by most
distros it seems.

However if we're running stock 2.24 (no extra version) then the bug is
present, so check for that and bail.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 07a480861f78..f1ed279e3ea6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -336,6 +336,14 @@ checkbin:
 		echo 'disable kernel modules' ; \
 		false ; \
 	fi
+	@if test "x${CONFIG_CPU_LITTLE_ENDIAN}" = "xy" \
+	    && $(LD) --version | head -1 | grep ' 2\.24$$' >/dev/null ; then \
+		echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
+		echo 'in some circumstances.' ; \
+		echo -n '*** Please use a different binutils version.' ; \
+		false ; \
+	fi
+
 
 CLEAN_FILES += $(TOUT)
 
-- 
2.1.0
