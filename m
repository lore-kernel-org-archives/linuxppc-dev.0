Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21802B72A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:44:41 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 14 Nov 2011 05:39:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAE5fLdd2666628
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:41:21 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAE5iNqt010003
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:44:26 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v3 8/8] [boot] Change the load address for the wrapper to fit
 the kernel
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Nov 2011 11:14:21 +0530
Message-ID: <20111114054413.23410.79498.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>
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
