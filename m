Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 33/33] powerpc: Build little endian ppc64 kernel with ABIv2
Date: Tue, 25 Mar 2014 22:44:39 +1100
Message-Id: <1395747879-5948-34-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build the little endian ppc64 kernel with ABIv2 if the toolchain
supports it. We can identify an ABIv2 capable toolchain by the
-mabi=elfv2 compiler flag.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0f4344e..411db45 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -112,8 +112,12 @@ else
 endif
 endif
 
-CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no -mcall-aixdesc
-CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
+CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,-mcall-aixdesc)
+else
+CFLAGS-$(CONFIG_PPC64)	+= -mcall-aixdesc
+endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,-mminimal-toc)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
-- 
1.8.3.2
