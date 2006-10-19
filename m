Return-Path: <mgreer@mvista.com>
Date: Wed, 18 Oct 2006 17:26:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
Message-ID: <20061019002635.GA2356@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, et. al.,

Currently, platforms that don't have a dt-aware firmware need to
manually run the wrapper script to wrap a dtb into the zImage that
was just built.  This is a PITA and is guaranteed to mess up people
who just want to build a zImage and have it work.

To address this, I added a couple new rules to arch/powerpc/boot/Makefile
so that the dtb is automatically wrapped for "reference" platforms.
"reference" meaning a platform that has its dts in
arch/powerpc/boot/dts/<platform>.dts.  It won't work for non-reference
platforms.

The patch is attached below with a header in case it is acceptable, as
is.

This would be used by the sandpoint, say, by adding the following rules
to the Makefile in the appropriate places:

	$(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
		$(call cmd,wrap_dts,sandpoint)

	$(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
		$(call cmd,wrap_dts_initrd,sandpoint)

and:

	image-$(CONFIG_SANDPOINT)               += zImage.sandpoint

Comments?

Mark
---

[PATCH] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile

Add cmd_wrap_dts rules to bootwrapper Makefile so "make zImage" and
"make zImage.initrd" will wrap the platform's dtb in the zImage.
This eliminates the need to manually run the wrapper script a
second time just to add the dtb to the zImage.

This only works for reference platforms that have their dts files
in arch/powerpc/boot/dts/<platform>.dts.

Depends-on: http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027003.html

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+)
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4b2be61..3dc4e55 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -117,6 +117,13 @@ quiet_cmd_wrap	= WRAP    $@
 quiet_cmd_wrap_initrd = WRAP    $@
       cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
+quiet_cmd_wrap_dts = WRAP_DTS    $@
+      cmd_wrap_dts =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-s $(obj)/dts/$2.dts vmlinux
+quiet_cmd_wrap_dts_initrd = WRAP_DTS    $@
+      cmd_wrap_dts_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 \
+				$(CROSSWRAP) -s $(obj)/dts/$2.dts \
+				-i $(obj)/ramdisk.image.gz vmlinux
 
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
 	$(call cmd,wrap,chrp)
