Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CB982C037A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 20:20:03 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v1][PATCH 7/7] book3e/kexec/kdump: recover "r4 = 0" to create the
 initial TLB
Date: Tue, 26 Feb 2013 17:19:42 +0800
Message-ID: <1361870382-743-8-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1361870382-743-1-git-send-email-tiejun.chen@windriver.com>
References: <1361870382-743-1-git-send-email-tiejun.chen@windriver.com>
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
index 038e81d..e60f078 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -129,6 +129,10 @@ __secondary_hold:
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
