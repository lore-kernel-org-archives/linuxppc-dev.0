Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2F1BC10080C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 20:00:31 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 15 Dec 2011 14:30:29 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBF901uB4444276
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:30:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBF8xvsa006754
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:30:00 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v5 7/7] [boot] Change the load address for the wrapper to fit
 the kernel
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 15 Dec 2011 14:29:57 +0530
Message-ID: <20111215085942.3404.98212.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
References: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wrapper code which uncompresses the kernel in case of a 'ppc' boot
is by default loaded at 0x00400000 and the kernel will be uncompressed
to fit the location 0-0x00400000. But with dynamic relocations, the size
of the kernel may exceed 0x00400000(4M). This would cause an overlap
of the uncompressed kernel and the boot wrapper, causing a failure in
boot.

The message looks like :


   zImage starting: loaded at 0x00400000 (sp: 0x0065ffb0)
   Allocating 0x5ce650 bytes for kernel ...
   Insufficient memory for kernel at address 0! (_start=00400000, uncompressed size=00591a20)

This patch shifts the load address of the boot wrapper code to the next higher MB,
according to the size of  the uncompressed vmlinux.

With the patch, we get the following message while building the image :

 WARN: Uncompressed kernel (size 0x5b0344) overlaps the address of the wrapper(0x400000)
 WARN: Fixing the link_address of wrapper to (0x600000)


Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/powerpc/boot/wrapper |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 14cd4bc..c8d6aaf 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -257,6 +257,8 @@ vmz="$tmpdir/`basename \"$kernel\"`.$ext"
 if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then
     ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
 
+    strip_size=$(stat -c %s $vmz.$$)
+
     if [ -n "$gzip" ]; then
         gzip -n -f -9 "$vmz.$$"
     fi
@@ -266,6 +268,24 @@ if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then
     else
 	vmz="$vmz.$$"
     fi
+else
+    # Calculate the vmlinux.strip size
+    ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
+    strip_size=$(stat -c %s $vmz.$$)
+    rm -f $vmz.$$
+fi
+
+# Round the size to next higher MB limit
+round_size=$(((strip_size + 0xfffff) & 0xfff00000))
+
+round_size=0x$(printf "%x" $round_size)
+link_addr=$(printf "%d" $link_address)
+
+if [ $link_addr -lt $strip_size ]; then
+    echo "WARN: Uncompressed kernel (size 0x$(printf "%x\n" $strip_size))" \
+		"overlaps the address of the wrapper($link_address)"
+    echo "WARN: Fixing the link_address of wrapper to ($round_size)"
+    link_address=$round_size
 fi
 
 vmz="$vmz$gzip"
