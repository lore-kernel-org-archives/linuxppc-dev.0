Return-Path: <geliangtang@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKtDt24JPzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 May 2017 01:37:34 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id q4so1256851pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 May 2017 08:37:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/cell: set no_llseek in spufs_cntl_fops
Date: Sat,  6 May 2017 23:37:20 +0800
Message-Id: <2b82a1562fc18d9cef80ad2481957ea2f30f9825.1493799907.git.geliangtang@gmail.com>
In-Reply-To: <ad61d4443d93fcfb442bd6367eefde3e04201bef.1493801155.git.geliangtang@gmail.com>
References: <ad61d4443d93fcfb442bd6367eefde3e04201bef.1493801155.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In spufs_cntl_fops, since we use nonseekable_open() to open, we
should use no_llseek() to seek, not generic_file_llseek().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index ae2f740..738ef8d 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -456,7 +456,7 @@ static const struct file_operations spufs_cntl_fops = {
 	.release = spufs_cntl_release,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
-	.llseek	= generic_file_llseek,
+	.llseek	= no_llseek,
 	.mmap = spufs_cntl_mmap,
 };
 
-- 
2.9.3
