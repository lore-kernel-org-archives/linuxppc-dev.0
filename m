Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6B67DDF24
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 15:43:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 2/4] [POWERPC] Remove generated files on make clean
Date: Tue, 20 May 2008 00:43:36 -0500
Message-Id: <1211262218-13949-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1211262218-13949-2-git-send-email-galak@kernel.crashing.org>
References: <1211262218-13949-1-git-send-email-galak@kernel.crashing.org>
	<1211262218-13949-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dtbImage.* and several zImage. targets get created but never cleaned up.

Also, moved zImage to the clean-files line associated with all other image
results (was previously duplicated).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7822d25..f5e0b2a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -99,7 +99,7 @@ $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds: $(obj)/%: $(srct
 	@cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		empty.c zImage zImage.coff.lds zImage.ps3.lds zImage.lds
+		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
@@ -339,7 +339,9 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.* \
+clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
+	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
+	zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
 	otheros.bld *.dtb
 
 # clean up files cached by wrapper
-- 
1.5.4.5
