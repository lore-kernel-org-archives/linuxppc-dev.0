Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Sat, 30 Sep 2006 11:54:09 +1000
Subject: [PATCH] Fix boot wrapper invocation if CROSS_COMPILE contains spaces
Message-Id: <20060930015412.0EA3A67B6D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My CROSS_COMPILE is "ccache /opt/compilers/blah", which confuses
the boot wrapper script. Quote CROSS_COMPILE and CROSS32_COMPILE
so they can safely contain spaces.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/boot/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: to-merge/arch/powerpc/boot/Makefile
===================================================================
--- to-merge.orig/arch/powerpc/boot/Makefile
+++ to-merge/arch/powerpc/boot/Makefile
@@ -105,10 +105,10 @@ wrapperbits	:= $(extra-y) $(addprefix $(
 # Bits for building various flavours of zImage
 
 ifneq ($(CROSS32_COMPILE),)
-CROSSWRAP := -C $(CROSS32_COMPILE)
+CROSSWRAP := -C "$(CROSS32_COMPILE)"
 else
 ifneq ($(CROSS_COMPILE),)
-CROSSWRAP := -C $(CROSS_COMPILE)
+CROSSWRAP := -C "$(CROSS_COMPILE)"
 endif
 endif
 
