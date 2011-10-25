Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AAD5010134C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:59 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id p9PBslpe029423
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 17:24:47 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9PBslY94317294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 17:24:47 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9PBskUJ011316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:47 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2 5/5] [boot] Change the load address for the wrapper to fit
 the kernel
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 25 Oct 2011 17:24:46 +0530
Message-ID: <20111025115437.8183.90057.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Dave Hansen <dave@linux.vnet.ibm.com>
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
index c74531a..213a9fd 100755
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
+round_size=0x$(printf "%x\n" $round_size)
+link_addr=$(printf "%d\n" $link_address)
+
+if [ $link_addr -lt $strip_size ]; then
+    echo "WARN: Uncompressed kernel size(0x$(printf "%x\n" $strip_size))" \
+		" exceeds the address of the wrapper($link_address)"
+    echo "WARN: Fixing the link_address to ($round_size))"
+    link_address=$round_size
 fi
 
 vmz="$vmz$gzip"
