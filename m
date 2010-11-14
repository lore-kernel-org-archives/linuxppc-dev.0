Return-Path: <jkenisto@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2243B712A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:15:55 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE3sES7024037
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 22:54:14 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAE4FjU8314224
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:15:45 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAE4FjS6032487
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Nov 2010 02:15:45 -0200
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4Fjpg032475
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Nov 2010 02:15:45 -0200
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 6/6] nvram: Shrink our zlib_deflate workspace from 268K to 24K
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 13 Nov 2010 20:15:44 -0800
Message-ID: <20101114041544.9457.7748.stgit@localhost.localdomain>
In-Reply-To: <20101114041510.9457.92921.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Exploit zlib_deflate_workspacesize2() to create a much smaller
zlib_deflate workspace when capturing oops/panic reports to NVRAM.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/platforms/pseries/nvram.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 8e5ed74..6409cb6 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/ctype.h>
 #include <linux/kmsg_dump.h>
 #include <linux/zlib.h>
@@ -94,6 +93,8 @@ static struct oops_parition_data {
 } *little_oops_buf;
 
 #define COMPR_LEVEL 6
+#define WINDOW_BITS 12
+#define MEM_LEVEL 4
 static struct z_stream_s stream;
 
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
@@ -408,7 +409,8 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 	big_oops_buf_sz = (little_oops_buf_sz * 100) / 45;
 	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
 	if (big_oops_buf) {
-		stream.workspace = vmalloc(zlib_deflate_workspacesize());
+		stream.workspace = kmalloc(zlib_deflate_workspacesize2(
+				WINDOW_BITS, MEM_LEVEL), GFP_KERNEL);
 		if (!stream.workspace) {
 			pr_err("nvram: No memory for compression workspace; "
 				"skipping compression of %s partition data\n",
@@ -427,7 +429,7 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 		pr_err("nvram: kmsg_dump_register() failed; returned %d\n", rc);
 		kfree(little_oops_buf);
 		kfree(big_oops_buf);
-		vfree(stream.workspace);
+		kfree(stream.workspace);
 	}
 }
 
@@ -625,7 +627,8 @@ static int nvram_compress(const void *in, void *out, size_t inlen,
 	int err, ret;
 
 	ret = -EIO;
-	err = zlib_deflateInit(&stream, COMPR_LEVEL);
+	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
+						MEM_LEVEL, Z_DEFAULT_STRATEGY);
 	if (err != Z_OK)
 		goto error;
 
