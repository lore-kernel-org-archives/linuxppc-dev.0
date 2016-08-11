Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8yB50XzwzDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:03:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 5/5] powerpc/Makefile: Construct the UTS_MACHINE value more
 concisely
Date: Thu, 11 Aug 2016 16:03:15 +1000
Message-Id: <1470895395-10007-5-git-send-email-mpe@ellerman.id.au>
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

Use the standard Kbuild trick of foo-y to make the construction of
UTC_MACHINE less verbose.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c941d5360366..50d020ac0f48 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -43,20 +43,6 @@ NM		:= $(NM) --synthetic
 endif
 endif
 
-ifeq ($(CONFIG_PPC64),y)
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-OLDARCH	:= ppc64le
-else
-OLDARCH	:= ppc64
-endif
-else
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-OLDARCH	:= ppcle
-else
-OLDARCH	:= ppc
-endif
-endif
-
 # BITS is used as extension for files which are available in a 32 bit
 # and a 64 bit version to simplify shared Makefiles.
 # e.g.: obj-y += foo_$(BITS).o
@@ -68,7 +54,10 @@ else
         BITS := 32
 endif
 
-UTS_MACHINE := $(OLDARCH)
+machine-y = ppc
+machine-$(CONFIG_PPC64) += 64
+machine-$(CONFIG_CPU_LITTLE_ENDIAN) += le
+UTS_MACHINE := $(subst $(space),,$(machine-y))
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 override LD	+= -EL
-- 
2.7.4
