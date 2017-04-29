Return-Path: <geliangtang@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFD7X128hzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 11:46:48 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id x86so14600490ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 18:46:48 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powernv: use memdup_user
Date: Sat, 29 Apr 2017 09:45:14 +0800
Message-Id: <82dff48f45f609c00bcf78810742e2702446dddd.1493380967.git.geliangtang@gmail.com>
In-Reply-To: <4db2a0ba17dc68d7bcfbd7d47b0eb22ad9a220c2.1493381463.git.geliangtang@gmail.com>
References: <4db2a0ba17dc68d7bcfbd7d47b0eb22ad9a220c2.1493381463.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use memdup_user() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-prd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 2d6ee1c..de4dd09 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -241,15 +241,9 @@ static ssize_t opal_prd_write(struct file *file, const char __user *buf,
 
 	size = be16_to_cpu(hdr.size);
 
-	msg = kmalloc(size, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	rc = copy_from_user(msg, buf, size);
-	if (rc) {
-		size = -EFAULT;
-		goto out_free;
-	}
+	msg = memdup_user(buf, size);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
 
 	rc = opal_prd_msg(msg);
 	if (rc) {
@@ -257,7 +251,6 @@ static ssize_t opal_prd_write(struct file *file, const char __user *buf,
 		size = -EIO;
 	}
 
-out_free:
 	kfree(msg);
 
 	return size;
-- 
2.9.3
