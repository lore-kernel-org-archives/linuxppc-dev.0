Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:12:43 -0500 (CDT)
Subject: [PATCH 13/15] bootwrapper: attach an empty vmlinux
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-13.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow the boot wrapper code to be linked without an attached vmlinux.

Rather than invent a new syntax to invoke the wrapper, attach the
stripped version of empty.o, which produces the same result.

This new intermediary is called zBoot.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Initial attempts to remove the dependency on vmlinux in the arch Makefile
have lead to multiple make commands competing in the boot directory and
destroying each other.

Index: work.git/arch/powerpc/boot/Makefile
===================================================================
--- work.git.orig/arch/powerpc/boot/Makefile	2007-07-10 16:38:01.000000000 -0500
+++ work.git/arch/powerpc/boot/Makefile	2007-07-10 16:41:01.000000000 -0500
@@ -124,7 +124,8 @@ endif
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
-		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
+		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) \
+		$(if $6,$6,vmlinux)
 
 kexec-$(CONFIG_PPC32)			+= zImage.kexec
 kexec-$(CONFIG_PPC64)			+= zImage.kexec64
@@ -142,6 +143,7 @@ image-$(CONFIG_PPC_PRPMC2800)		+= zImage
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 image-$(CONFIG_KEXEC)			+= $(kexec-y)
+image-$(CONFIG_KEXEC)			+= $(patsubst zImage%,zBoot%,$(kexec-y))
 
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
@@ -190,6 +192,9 @@ $(obj)/vmlinux.strip: vmlinux
 $(obj)/zImage.iseries: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
 
+$(obj)/zBoot.%: $(wrapperbits)
+	$(call if_changed,wrap,$*,,,,$(obj)/empty.o)
+
 $(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts
 	$(STRIP) -s -R .comment $< -o vmlinux.strip
 	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
@@ -227,7 +232,7 @@ clean-files += $(image-) $(initrd-) zIma
 	treeImage.* $(kexec-)
 
 # clean up files cached by wrapper
-clean-kernel := vmlinux.strip vmlinux.bin
+clean-kernel := vmlinux.strip vmlinux.bin empty.o.bin
 clean-kernel += $(addsuffix .gz,$(clean-kernel))
 # If not absolute clean-files are relative to $(obj).
 clean-files += $(addprefix $(objtree)/, $(clean-kernel))
Index: work.git/arch/powerpc/boot/wrapper
===================================================================
--- work.git.orig/arch/powerpc/boot/wrapper	2007-07-10 16:37:30.000000000 -0500
+++ work.git/arch/powerpc/boot/wrapper	2007-07-10 16:41:01.000000000 -0500
@@ -161,6 +161,13 @@ ps3)
     ;;
 esac
 
+if [ "$kernel" = $object/empty.o ] ; then
+    ext=bin
+    objflags="-O binary"
+    gzip=
+fi
+
+
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
 if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then
     ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
