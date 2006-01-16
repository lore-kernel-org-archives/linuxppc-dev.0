Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C9926891D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 04:00:04 +1100 (EST)
Date: Mon, 16 Jan 2006 10:53:22 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH][UPDATE] powerpc: Add CONFIG_DEFAULT_UIMAGE to build a uImage
	by default for a board
Message-ID: <Pine.LNX.4.44.0601161052560.30647-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
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
commit dc9904232f13395c8aa3a46a3cce759c82c03278
tree 7f2d49a2bfffdfb5eaae3693fb749a1243a94c1c
parent 7ba6450ca6461a19638f963af152e0b5ab00ef15
author Kumar Gala <galak@kernel.crashing.org> Mon, 16 Jan 2006 10:58:51 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 16 Jan 2006 10:58:51 -0600

 arch/powerpc/Kconfig  |    6 ++++++
 arch/powerpc/Makefile |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index df338c5..80d114a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -83,6 +83,12 @@ config GENERIC_TBSYNC
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
index 44dd82b..15fc3e9 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -142,6 +142,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/power
 # Default to zImage, override when needed
 defaultimage-y			:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
+defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
 
