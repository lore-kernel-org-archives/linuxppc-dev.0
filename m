Return-Path: <geliangtang@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFD7f4WZVzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 11:46:54 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id z67so7601982itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 18:46:54 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: use memdup_user_nul
Date: Sat, 29 Apr 2017 09:45:15 +0800
Message-Id: <0b7273a9720afeea6a42a10f38ebb09b6489adc3.1493381148.git.geliangtang@gmail.com>
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

Use memdup_user_nul() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/powerpc/platforms/pseries/reconfig.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index e5bf1e8..431f513 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -367,16 +367,9 @@ static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t coun
 	char *kbuf;
 	char *tmp;
 
-	if (!(kbuf = kmalloc(count + 1, GFP_KERNEL))) {
-		rv = -ENOMEM;
-		goto out;
-	}
-	if (copy_from_user(kbuf, buf, count)) {
-		rv = -EFAULT;
-		goto out;
-	}
-
-	kbuf[count] = '\0';
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
 
 	tmp = strchr(kbuf, ' ');
 	if (!tmp) {
-- 
2.9.3
