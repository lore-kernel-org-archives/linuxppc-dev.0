Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 772572C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 18:31:37 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Tiejun Chen <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: add a missing label in resume_kernel
Date: Wed, 10 Apr 2013 16:31:24 +0800
Message-ID: <1365582684-11136-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A label 0 was missed in the patch a9c4e541 (powerpc/kprobe: Complete
kprobe and migrate exception frame). This will cause the kernel
branch to an undetermined address if there really has a conflict when
updating the thread flags.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 256c5bf..ab079ed 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -657,7 +657,7 @@ resume_kernel:
 	/* Clear _TIF_EMULATE_STACK_STORE flag */
 	lis	r11,_TIF_EMULATE_STACK_STORE@h
 	addi	r5,r9,TI_FLAGS
-	ldarx	r4,0,r5
+0:	ldarx	r4,0,r5
 	andc	r4,r4,r11
 	stdcx.	r4,0,r5
 	bne-	0b
-- 
1.8.1.4
