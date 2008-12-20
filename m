Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id BAC25DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 11:57:25 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1921972rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 16:57:24 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Copy bootable images in the default install script
Date: Fri, 19 Dec 2008 17:57:20 -0700
Message-ID: <20081220005720.23861.18505.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch makes the default install script (arch/powerpc/boot/install.sh)
copy the bootable image files into the install directory.  Before this
patch only the vmlinux image file was copied.

This patch makes the default 'make install' command useful for embedded
development when $(INSTALL_PATH) is set in the environment.

As a side effect, this patch changes the calling convention of the
install.sh script.  Instead of a single 5th parameter, the script is now
passed a list of all the target images stored in the $(image-y) Makefile
variable.  This should be backwards compatible with existing install scripts
since it just adds additional arguments and does not change existing ones.

CC: Kumar Gala <galak@kernel.crashing.org>
CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>
CC: Paul Mackerras <paulus@samba.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile   |    2 +-
 arch/powerpc/boot/install.sh |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 3d3daa6..b6187ca 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -355,7 +355,7 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
 
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
+	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
 
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
index b002bfd..51b2387 100644
--- a/arch/powerpc/boot/install.sh
+++ b/arch/powerpc/boot/install.sh
@@ -15,7 +15,7 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
-#   $5 - kernel boot file, the zImage
+#   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
 #
 
 # User may have a custom install script
@@ -38,3 +38,15 @@ fi
 
 cat $2 > $4/$image_name
 cp $3 $4/System.map
+
+# Copy all the bootable image files
+path=$4
+shift 4
+while [ $# -ne 0 ]; do
+	image_name=`basename $1`
+	if [ -f $path/$image_name ]; then
+		mv $path/$image_name $path/$image_name.old
+	fi
+	cat $1 > $path/$image_name
+	shift
+done;
