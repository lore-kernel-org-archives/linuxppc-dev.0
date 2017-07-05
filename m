Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2S1r2pXqzDqyc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:04:48 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id z6so33066417pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 21:04:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powernv/pseries: machine check use kernel crash path
Date: Wed,  5 Jul 2017 14:04:21 +1000
Message-Id: <20170705040422.20933-4-npiggin@gmail.com>
In-Reply-To: <20170705040422.20933-1-npiggin@gmail.com>
References: <20170705040422.20933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similarly to the powernv patch, pseries can recover from and/or
print more error details from a recovered machine check if it
goes via the kernel crash path rather than panic()ing in the case
of MCE in kernel mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/pseries/ras.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 4923ffe230cf..eeac00160de0 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -436,19 +436,19 @@ static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
 		       "be degraded\n");
 		recovered = 1;
 
-	} else if (user_mode(regs) && !is_global_init(current) &&
-		   rtas_error_severity(err) == RTAS_SEVERITY_ERROR_SYNC) {
-
+	} else if (rtas_error_severity(err) == RTAS_SEVERITY_ERROR_SYNC) {
 		/*
-		 * If we received a synchronous error when in userspace
-		 * kill the task. Firmware may report details of the fail
-		 * asynchronously, so we can't rely on the target and type
-		 * fields being valid here.
+		 * Firmware may report details of the fail asynchronously, so
+		 * we can't rely on the target and type fields being valid
+		 * here.
 		 */
-		printk(KERN_ERR "MCE: uncorrectable error, killing task "
-		       "%s:%d\n", current->comm, current->pid);
-
-		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+		if ((user_mode(regs))) {
+			printk(KERN_ERR "MCE: uncorrectable error, killing task"
+				" %s:%d\n", current->comm, current->pid);
+			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+		} else {
+			die("Machine check", regs, SIGBUS);
+		}
 		recovered = 1;
 	}
 
-- 
2.11.0
