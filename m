Return-Path: <olaf@aepfle.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAA7AB7D12
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 18:22:42 +1000 (EST)
Date: Sat, 5 Jun 2010 10:10:39 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [powerpc] do not expect executable permissions for in-tree
	shell scripts
Message-ID: <20100605081039.GA21300@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


scripts in the kernel source do not have executable permissions if they were created with patch(1)
run mkuboot.sh with bash, its tagged as bash script.

/opt/cross/kernel/linux-2.6.33-cross-host-kernel-source/arch/powerpc/boot/wrapper: line 273: /opt/cross/kernel/linux-2.6.33-cross-host-kernel-source/scripts/mkuboot.sh: Permission denied

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---

This happens with 2.6.33, other versions have this bug as well.

 arch/powerpc/boot/wrapper |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.33-cross-host-kernel-source.orig/arch/powerpc/boot/wrapper
+++ linux-2.6.33-cross-host-kernel-source/arch/powerpc/boot/wrapper
@@ -270,7 +270,7 @@ membase=`${CROSS}objdump -p "$kernel" |
 case "$platform" in
 uboot)
     rm -f "$ofile"
-    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
+    bash ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
 	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
@@ -330,7 +330,7 @@ coff)
     ;;
 cuboot*)
     gzip -f -9 "$ofile"
-    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
+    bash ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
             $uboot_version -d "$ofile".gz "$ofile"
     ;;
 treeboot*)
