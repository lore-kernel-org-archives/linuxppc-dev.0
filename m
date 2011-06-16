Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB589B7548
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:15:13 +1000 (EST)
Received: by mail-fx0-f42.google.com with SMTP id 1so1329329fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:15:13 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 6/7] powerpc: Update the default FIT image to use the
	correct load/boot addresses
Date: Thu, 16 Jun 2011 16:14:27 +0200
Message-Id: <1308233668-24166-7-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-6-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
	<1308233668-24166-3-git-send-email-monstr@monstr.eu>
	<1308233668-24166-4-git-send-email-monstr@monstr.eu>
	<1308233668-24166-5-git-send-email-monstr@monstr.eu>
	<1308233668-24166-6-git-send-email-monstr@monstr.eu>
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

The default kernel_fdt.its hard codes zero load/start addresses, but this may
no longer be true.

As we copy the FIT tree descriptor, update these values based on the incoming
ELF payload.

Signed-off-by: John Williams <john.williams@petalogix.com>
---
 arch/powerpc/boot/wrapper |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 594aa02..54fbc2e 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -281,7 +281,11 @@ uboot-fit)
     rm -f "$ofile"
     #[ "$vmz" != vmlinux.bin.gz ] && mv "$vmz" "vmlinux.bin.gz"
     mv "$dtb" "target.dtb"
-    cp arch/powerpc/boot/kernel_fdt.its .
+    # Check the ELF file for a non-zero load/entry address
+    membase=${membase:2:8}
+    sed -e "s/load = <.*$/load = <${membase}>;/g" \
+        -e "s/entry = <.*$/entry = <${membase}>;/g" \
+            arch/powerpc/boot/kernel_fdt.its > kernel_fdt.its
     mkimage -f kernel_fdt.its "$ofile"
     #rm kernet_fdt.its
     exit 0
-- 
1.5.5.6
