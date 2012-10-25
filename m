Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 384AB2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 17:43:47 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/book3e: support kgdb for kernel space
Date: Thu, 25 Oct 2012 14:43:29 +0800
Message-ID: <1351147410-17452-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1351147410-17452-1-git-send-email-tiejun.chen@windriver.com>
References: <1351147410-17452-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we need to skip this for supporting KGDB.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 43b654a..c5564d4 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -566,11 +566,14 @@ kernel_dbg_exc:
 	rfdi
 
 	/* Normal debug exception */
+1:
+#ifndef CONFIG_KGDB
 	/* XXX We only handle coming from userspace for now since we can't
 	 *     quite save properly an interrupted kernel state yet
 	 */
-1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
+	andi.	r14,r11,MSR_PR;		/* check for userspace again */
 	beq	kernel_dbg_exc;		/* if from kernel mode */
+#endif
 
 	/* Now we mash up things to make it look like we are coming on a
 	 * normal exception
-- 
1.7.9.5
