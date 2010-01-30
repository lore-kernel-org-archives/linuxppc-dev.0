Return-Path: <minyard@acm.org>
Received: from vms173019pub.verizon.net (vms173019pub.verizon.net
	[206.46.173.19]) by ozlabs.org (Postfix) with ESMTP id CC5E2B7D26
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jan 2010 11:18:38 +1100 (EST)
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
	by vms173019.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0KX1002BIA6MJ9X4@vms173019.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Fri, 29 Jan 2010 18:18:22 -0600 (CST)
Received: from i2 (i2.minyard.local [192.168.27.126])
	by wf-rch.minyard.local (Postfix) with ESMTP id 86B7B1F849	for
	<linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 18:18:21 -0600 (CST)
Date: Fri, 29 Jan 2010 18:18:20 -0600
From: Corey Minyard <minyard@acm.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add a new platform for maple so a different link
	address can be set
Message-id: <20100130001820.GA25629@minyard.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Corey Minyard <cminyard@mvista.com>

The maple platform failed to load because it's firmware could not take a
link address of 0x4000000.  A new platform type with a link address of
0x400000 had to be created for the maple.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
Without this patch the firmware loader says it is unable to parse the
ELF header and dies.  This patch lets 2.6.31 boot without issue.  At
the current head of k.org git, at least with an NFS mount, I'm getting:
  Kernel panic - not syncing: No init found
So I'm not sure what the deal is there, but this patch is still required
to get the firmware to load the kernel.

Index: linux-2.6.31/arch/powerpc/boot/wrapper
===================================================================
--- linux-2.6.31.orig/arch/powerpc/boot/wrapper
+++ linux-2.6.31/arch/powerpc/boot/wrapper
@@ -145,6 +145,10 @@ pseries)
     platformo=$object/of.o
     link_address='0x4000000'
     ;;
+maple)
+    platformo=$object/of.o
+    link_address='0x400000'
+    ;;
 pmac|chrp)
     platformo=$object/of.o
     ;;
@@ -313,7 +319,7 @@ fi
 
 # post-processing needed for some platforms
 case "$platform" in
-pseries|chrp)
+pseries|chrp|maple)
     $objbin/addnote "$ofile"
     ;;
 coff)
Index: linux-2.6.31/arch/powerpc/boot/Makefile
===================================================================
--- linux-2.6.31.orig/arch/powerpc/boot/Makefile
+++ linux-2.6.31/arch/powerpc/boot/Makefile
@@ -167,7 +167,7 @@ quiet_cmd_wrap	= WRAP    $@
 		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
-image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
+image-$(CONFIG_PPC_MAPLE)		+= zImage.maple
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
 image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
@@ -346,7 +346,7 @@ install: $(CONFIGURE) $(addprefix $(obj)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
 	zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
-	simpleImage.* otheros.bld *.dtb
+	zImage.maple simpleImage.* otheros.bld *.dtb
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
