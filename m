Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8F832C0343
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 18:03:03 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v3][PATCH 8/8] book3e/kexec/kdump: recover "r4 = 0" to create the
 initial TLB
Date: Tue, 9 Jul 2013 16:03:27 +0800
Message-ID: <1373357007-30785-9-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
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

In commit 96f013f, "powerpc/kexec: Add kexec "hold" support for Book3e
processors", requires that GPR4 survive the "hold" process, for IBM Blue
Gene/Q with with some very strange firmware. But for FSL Book3E, r4 = 1
to indicate that the initial TLB entry for this core already exists so
we still should set r4 with 0 to create that initial TLB.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/head_64.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 0b46c9d..d546c5e 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -127,6 +127,10 @@ __secondary_hold:
 	/* Grab our physical cpu number */
 	mr	r24,r3
 	/* stash r4 for book3e */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	/* we need to setup initial TLB entry. */
+	li	r4,0
+#endif
 	mr	r25,r4
 
 	/* Tell the master cpu we're here */
-- 
1.7.9.5
