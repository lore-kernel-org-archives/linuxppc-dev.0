Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CC522C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:28:51 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v5][PATCH 4/6] powerpc/book3e: support kgdb for kernel space
Date: Thu, 20 Jun 2013 18:28:28 +0800
Message-ID: <1371724110-8250-5-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
index 07cf657..a286b51 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -639,11 +639,13 @@ kernel_dbg_exc:
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
