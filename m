Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 14:44:17 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/4] powerpc: Remove altivec fix for gcc versions before 4.0
Message-ID: <20120418144417.4ff4454a@kryten>
In-Reply-To: <20120418144254.3286ce94@kryten>
References: <20120418144254.3286ce94@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Now we require gcc 4.0 on 64-bit we can remove the pre gcc 4.0
-maltivec workaround.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/Makefile	2012-04-18 07:49:24.024963656 +1000
+++ linux-build/arch/powerpc/Makefile	2012-04-18 11:58:18.278885496 +1000
@@ -77,18 +77,8 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
 ifeq ($(CONFIG_PPC64),y)
-GCC_BROKEN_VEC	:= $(call cc-ifversion, -lt, 0400, y)
-
 ifeq ($(CONFIG_POWER4_ONLY),y)
-ifeq ($(CONFIG_ALTIVEC),y)
-ifeq ($(GCC_BROKEN_VEC),y)
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=970)
-else
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
-endif
-else
 	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
-endif
 else
 	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
 endif
