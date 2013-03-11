Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D601C2C0348
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 22:02:59 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v4][PATCH 4/7] powerpc/book3e: support kgdb for kernel space
Date: Mon, 11 Mar 2013 19:02:43 +0800
Message-ID: <1362999766-20897-5-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1362999766-20897-1-git-send-email-tiejun.chen@windriver.com>
References: <1362999766-20897-1-git-send-email-tiejun.chen@windriver.com>
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
 arch/powerpc/kernel/exceptions-64e.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 7df9a1f..fd5d61b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -598,11 +598,13 @@ kernel_dbg_exc:
 	rfdi
 
 	/* Normal debug exception */
+1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
+#ifndef CONFIG_KGDB
 	/* XXX We only handle coming from userspace for now since we can't
 	 *     quite save properly an interrupted kernel state yet
 	 */
-1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
 	beq	kernel_dbg_exc;		/* if from kernel mode */
+#endif
 
 	/* Now we mash up things to make it look like we are coming on a
 	 * normal exception
-- 
1.7.9.5
