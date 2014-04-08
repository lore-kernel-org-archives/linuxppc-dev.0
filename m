Return-Path: <anton@samba.org>
Date: Tue, 8 Apr 2014 17:20:22 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/le: Fix module build error
Message-ID: <20140408172022.5b6305d1@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Tony Breeds <tonyb@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I made a cleanup suggestion on 27143b9a0 (powerpc/le: Avoid creatng
R_PPC64_TOCSAVE relocations for modules) that had a stupid typo. Fix
it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a9f814a..4c0cedf 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -74,7 +74,7 @@ override CROSS32AS += -mlittle-endian
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
-KBUILD_CFLAGS_MODULE += $(call cc-option-yn,-mno-save-toc-indirect)
+KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
 else
 ifeq ($(call cc-option-yn,-mbig-endian),y)
 override CC	+= -mbig-endian
