Return-Path: <galak@gate.crashing.org>
Date: Fri, 13 Jan 2006 10:16:24 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add CONFIG_DEFAULT_UIMAGE to build a uImage by
	default for a board
Message-ID: <Pine.LNX.4.44.0601131015180.18314-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Embedded boards that u-boot require a kernel image in the uImage format.
This allows a given board to specify it wants a uImage built by default.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 461d4edf6f4a1950a94a190f1fc3a4b9e692453e
tree 40b6d33d95a56e0bd8f71bb74320adb79c1fc5b2
parent be64cad3bdcae667f790fcf6f3e066be498baa83
author Kumar Gala <galak@kernel.crashing.org> Fri, 13 Jan 2006 09:56:34 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 13 Jan 2006 09:56:34 -0600

 arch/powerpc/Kconfig  |    6 ++++++
 arch/powerpc/Makefile |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 01feed0..a8d2f2d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -94,6 +94,12 @@ config GENERIC_TBSYNC
 	default y if PPC32 && SMP
 	default n
 
+config DEFAULT_UIMAGE
+	bool
+	help
+	  Used to allow a board to specify it wants a uImage built by default
+	default n
+
 menu "Processor support"
 choice
 	prompt "Processor Type"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index d3654a2..63eeaee 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -142,6 +142,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/power
 defaultimage-$(CONFIG_PPC32)	:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
 defaultimage-$(CONFIG_PPC_PSERIES) := zImage
+defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
 
