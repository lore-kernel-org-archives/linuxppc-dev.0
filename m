Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95D9FB7049
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:42 +1000 (EST)
Received: by mail-fx0-f42.google.com with SMTP id 1so1329329fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:42 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 5/7] powerpc: Consider a non-zero boot address when
	computing the bootwrapper start
Date: Thu, 16 Jun 2011 16:14:26 +0200
Message-Id: <1308233668-24166-6-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-5-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
	<1308233668-24166-3-git-send-email-monstr@monstr.eu>
	<1308233668-24166-4-git-send-email-monstr@monstr.eu>
	<1308233668-24166-5-git-send-email-monstr@monstr.eu>
Cc: arnd@arndb.de, tmarri@apm.com, suzuki@in.ibm.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Williams <john.williams@petalogix.com>

There's no fundamental reason the bootwrapper can't boot off a non-zero base,
we just need to make sure we account for it in the link.

Do this by adding the (up-aligned) kernel size to membase, and using that as
the link address.

Signed-off-by: John Williams <john.williams@petalogix.com>
---
 arch/powerpc/boot/wrapper |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index e148053..594aa02 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -139,9 +139,16 @@ tmp=$tmpdir/zImage.$$.o
 ksection=.kernel:vmlinux.strip
 isection=.kernel:initrd
 
-# default auto-calculate link_address to make room for the kernel
+# physical offset of kernel image
+membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
+
+# auto-calculate link_address to make room for the kernel
 # round up kernel image size to nearest megabyte
-link_address=`${CROSS}size -x ${kernel} | grep ${kernel} | awk '{printf("0x%08x", and($4 + 0x0fffff, 0xfffe0000))}'`
+
+# don't forget to add membase for non-zero kernel boot
+membase_dec=`printf "%d" $membase`
+
+link_address=`${CROSS}size -x ${kernel} | grep ${kernel} | awk -v membase=$membase_dec '{printf("0x%08x", membase + and($4 + 0x0fffff, 0xfffe0000))}'`
 
 case "$platform" in
 pseries)
@@ -259,9 +266,6 @@ if [ -n "$version" ]; then
     uboot_version="-n Linux-$version"
 fi
 
-# physical offset of kernel image
-membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
-
 case "$platform" in
 uboot)
     rm -f "$ofile"
-- 
1.5.5.6
