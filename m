Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F26822C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 12:17:35 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v2][PATCH 1/3] kgdb,ppc: do not set kgdb_single_step on ppc
Date: Thu, 23 Aug 2012 10:10:18 +0800
Message-ID: <1345687820-5248-1-git-send-email-tiejun.chen@windriver.com>
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

The kgdb_single_step flag has the possibility to indefinitely
hang the system on an SMP system.

The x86 arch have the same problem, and that problem was fixed by
commit 8097551d9ab9b9e3630(kgdb,x86: do not set kgdb_single_step
on x86). This patch does the same behaviors as x86's patch.

Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
v2: nothing changed.

 arch/powerpc/kernel/kgdb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 782bd0a..bbabc5a 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -410,7 +410,6 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 #else
 			linux_regs->msr |= MSR_SE;
 #endif
-			kgdb_single_step = 1;
 			atomic_set(&kgdb_cpu_doing_single_step,
 				   raw_smp_processor_id());
 		}
-- 
1.5.6
