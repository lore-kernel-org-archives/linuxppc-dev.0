Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BFDF2B7101
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 18:20:51 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 21 Dec 2011 12:50:45 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBL7KemM2969650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:50:41 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBL7KdZF019714
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:50:40 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] [boot] Change the WARN to INFO for boot wrapper overlap
 message
To: Josh Boyer <jwboyer@gmail.com>, Stephen Rothwell<sfr@canb.auug.org.au>
Date: Wed, 21 Dec 2011 12:50:38 +0530
Message-ID: <20111221072034.12043.62801.stgit@suzukikp.in.ibm.com>
In-Reply-To: <CA+5PVA7NhzxwxR5WGDmUQ432NehNnzRT+y05wve+FBXHyGaiwA@mail.gmail.com>
References: <CA+5PVA7NhzxwxR5WGDmUQ432NehNnzRT+y05wve+FBXHyGaiwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit c55aef0e5bc6 ("powerpc/boot: Change the load address
for the wrapper to fit the kernel") introduced a WARNING to
inform the user that the uncompressed kernel would overlap
the boot uncompressing wrapper code. Change it to an INFO.

I initially thought, this would be a 'WARNING' for the those
boards, where the link_address should be fixed, so that the
user can take actions accordingly.

Changing the same to INFO.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/powerpc/boot/wrapper |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index c8d6aaf..2b171cd 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -282,9 +282,9 @@ round_size=0x$(printf "%x" $round_size)
 link_addr=$(printf "%d" $link_address)
 
 if [ $link_addr -lt $strip_size ]; then
-    echo "WARN: Uncompressed kernel (size 0x$(printf "%x\n" $strip_size))" \
+    echo "INFO: Uncompressed kernel (size 0x$(printf "%x\n" $strip_size))" \
 		"overlaps the address of the wrapper($link_address)"
-    echo "WARN: Fixing the link_address of wrapper to ($round_size)"
+    echo "INFO: Fixing the link_address of wrapper to ($round_size)"
     link_address=$round_size
 fi
 
