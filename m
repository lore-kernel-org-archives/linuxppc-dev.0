Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lRGc030126@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:56 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 41/43] ppc64: change name of target file during make install
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

'make install' creates a /boot/zImage[.vmode] file when the defconfig is used.

It uses the second arg as file content, which is the vmlinux, and the 5th
arg as file name, which is the BOOTIMAGE name.

A comment in an earlier patch to install.sh states that yaboot can not load
a zImage+initrd combo.  This was true in kernel 2.6.5 because it did use
bi_recs to pass the initrd info.  But this concept was always broken. 
Register r3 holds the initrd address and r4 holds the initrd size.  This
works with all kernel versions.  The current code in main.c leaves r3 and
r4 alone, so the kernel should be able to see and use the memory range with
the initrd content.

If one wants to rerun mkinitrd, it is currently hard to get the uname -r
value for the installed zImage.  Without this info, mkinitrd can not know
what modules to use.  This would be fixable by including the /proc/version
output of the new kernel.  But it is simpler to just use the plain vmlinux.

So all this patch does is to write to /boot/vmlinux instead to /boot/zImage

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/install.sh |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc64/boot/install.sh~ppc64-change-name-of-target-file-during-make-install arch/ppc64/boot/install.sh
--- devel/arch/ppc64/boot/install.sh~ppc64-change-name-of-target-file-during-make-install	2005-10-28 17:44:05.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/install.sh	2005-10-28 17:44:05.000000000 -0700
@@ -28,7 +28,7 @@ if [ -x /sbin/${CROSS_COMPILE}installker
 # Default install
 
 # this should work for both the pSeries zImage and the iSeries vmlinux.sm
-image_name=`basename $5`
+image_name=`basename $2`
 
 if [ -f $4/$image_name ]; then
 	mv $4/$image_name $4/$image_name.old
_
