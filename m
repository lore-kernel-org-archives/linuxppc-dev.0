Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8114C1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 22:48:49 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Fri, 9 Dec 2011 17:18:44 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB9Bmbph2252896
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:18:37 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB9Bmauf028765
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:18:36 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v4 7/7] [boot] Change the load address for the wrapper to fit
 the kernel
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2011 17:18:36 +0530
Message-ID: <20111209114826.16360.58041.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
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

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/powerpc/boot/wrapper |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 14cd4bc..4d625cd 100755
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
+    echo "WARN: Uncompressed kernel size(0x$(printf "%x\n" $strip_size))" \
+		" exceeds the address of the wrapper($link_address)"
+    echo "WARN: Fixing the link_address to ($round_size))"
+    link_address=$round_size
 fi
 
 vmz="$vmz$gzip"
