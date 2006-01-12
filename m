Return-Path: <trini@kernel.crashing.org>
Date: Thu, 12 Jan 2006 16:55:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <20060112235557.GK27215@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH powerpc.git] Better use defaultimage-
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ Please disregard the patch to make zImage & uImage the default, Paul
has NAK'd this on IRC ]

The following reworks how defaultimage- is used.  We default to zImage
here and then override it on platforms that need something more (uImage
in the future) or less (vmlinux on iSeries).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 5f80e58..cb6e3ca 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -140,8 +140,8 @@ drivers-$(CONFIG_CPM2)		+= arch/ppc/8260
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
-defaultimage-$(CONFIG_PPC32)	:= zImage
+# Default to zImage, override when needed
+defaultimage-y			:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
-defaultimage-$(CONFIG_PPC_PSERIES) := zImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
 
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
