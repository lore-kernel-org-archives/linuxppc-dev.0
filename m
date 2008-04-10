Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17DBDDDDED
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:53:24 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 11/12] [POWERPC] bootwrapper: use physical address in PHDR for
	uImage
Date: Thu, 10 Apr 2008 05:48:50 -0500
Message-Id: <1207824531-27168-12-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we properly set the physical address in the program header of the
vmlinux ELF we can extract it to properly set the load and entry point for
u-boot uImages.  Before we always hard coded the laod & entry point to 0.
However there are situations that the kernel may be built with a non-zero
physical address.

We use objdump to extract the PHDR.  We assume that there is only one
PHDR in the vmlinux of type LOAD.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/wrapper |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 14a0182..d6c96d9 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -230,10 +230,13 @@ if [ -n "$version" ]; then
     uboot_version="-n Linux-$version"
 fi
 
+# physical offset of kernel image
+membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
+
 case "$platform" in
 uboot)
     rm -f "$ofile"
-    mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
+    mkimage -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
 	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
-- 
1.5.4.1
