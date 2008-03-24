Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id A02EEDDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 09:52:51 +1100 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JY900M75BK1TT00@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 24 Mar 2008 16:52:49 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JY900B0XBK0JA10@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 24 Mar 2008 16:52:49 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.145.230.108])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JY900IDABJZVE20@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 24 Mar 2008 16:52:47 -0600 (MDT)
Date: Mon, 24 Mar 2008 16:52:46 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] [POWERPC] add target for building .dtb files
To: linuxppc-dev@ozlabs.org, paulus@samba.org, jwboyer@linux.vnet.ibm.com
Message-id: <20080324225024.3450.98918.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Call dtc from the Makefile instead of the wrapper script so that the dt
blobs can be generated with a simple make invocation.

Using this patch allows board ports to trigger automatic building of .dtb
files by adding them to the image-y target list.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
Josh, how does this look to you?  It will give you the ability to build .dtb
files from the command line.  If it looks good, I'd like to get it in when
then merge window opens.

Cheers,
g.


 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |   26 +++++++++++++++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ab5cfe8..dd80825 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -164,7 +164,7 @@ boot := arch/$(ARCH)/boot
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
-bootwrapper_install:
+bootwrapper_install %.dtb:
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 define archhelp
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4974d9e..2f8a9f4 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -285,11 +285,11 @@ $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
-$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
-	$(call if_changed,wrap,$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
+$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
+	$(call if_changed,wrap,$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
-	$(call if_changed,wrap,$*,$(dtstree)/$*.dts)
+$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb
+	$(call if_changed,wrap,$*,,$(obj)/$*.dtb)
 
 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
 # prefix
@@ -302,14 +302,18 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
-$(obj)/cuImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
-	$(call if_changed,wrap,cuboot-$*,$(dtstree)/$*.dts)
+$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
 
-$(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
-	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
+$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/treeImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
-	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts)
+$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
+
+# Rule to build device tree blobs
+$(obj)/%.dtb: $(dtstree)/%.dts $(obj)/dtc
+	$(obj)/dtc -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(dtstree)/$*.dts
 
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
@@ -326,7 +330,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.* \
-	otheros.bld
+	otheros.bld *.dtb
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
