Return-Path: <geliangtang@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFD7Q6v8SzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 11:46:42 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id 70so7562511ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 18:46:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kees Cook <keescook@chromium.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/nvram: use memdup_user
Date: Sat, 29 Apr 2017 09:45:13 +0800
Message-Id: <773c52d0170a3fff971d03fc1ea8411541c4ece7.1493380763.git.geliangtang@gmail.com>
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
 arch/powerpc/kernel/nvram_64.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index eae61b0..496d639 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -792,21 +792,17 @@ static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
 	count = min_t(size_t, count, size - *ppos);
 	count = min(count, PAGE_SIZE);
 
-	ret = -ENOMEM;
-	tmp = kmalloc(count, GFP_KERNEL);
-	if (!tmp)
-		goto out;
-
-	ret = -EFAULT;
-	if (copy_from_user(tmp, buf, count))
+	tmp = memdup_user(buf, count);
+	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
 		goto out;
+	}
 
 	ret = ppc_md.nvram_write(tmp, count, ppos);
 
-out:
 	kfree(tmp);
+out:
 	return ret;
-
 }
 
 static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
-- 
2.9.3
