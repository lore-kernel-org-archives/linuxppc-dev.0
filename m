From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 16 Apr 2003 11:38:30 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Fix prep boot in linuxppc_2_4_devel
Message-ID: <20030416173830.GM20197@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This fixes the prep boot code so it will actually create a good SMP boot
image.  The wrong variable was being used.

diff -Nru a/arch/ppc/boot/prep/Makefile b/arch/ppc/boot/prep/Makefile
--- a/arch/ppc/boot/prep/Makefile	Wed Apr 16 11:37:10 2003
+++ b/arch/ppc/boot/prep/Makefile	Wed Apr 16 11:37:10 2003
@@ -19,7 +19,7 @@

 TFTPIMAGE			= /tftpboot/zImage.prep
 ifeq ($(CONFIG_SMP),y)
-TFTPIMAGE			= $(TFTPBOOT).smp
+TFTPIMAGE			:= $(TFTPIMAGE).smp
 endif

 LD_ARGS				= -T ../ld.script -Ttext 0x00800000 -Bstatic

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
