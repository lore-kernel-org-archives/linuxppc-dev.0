Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4DDA52C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 02:19:56 +1100 (EST)
Date: Fri, 8 Feb 2013 07:18:56 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <tip-02fc8d37229d15c654876cf9ce56b5c1cf7945d7@git.kernel.org>
In-Reply-To: <20130208141938.f31b7b9e1acac5bbe769ee4c@canb.auug.org.au>
References: <20130208141938.f31b7b9e1acac5bbe769ee4c@canb.auug.org.au>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cputime:
 Restore CPU_ACCOUNTING config defaults for PPC64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: namhyung.kim@lge.com, zhong@linux.vnet.ibm.com, sfr@canb.auug.org.au,
 peterz@infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 fweisbec@gmail.com, paul.gortmaker@windriver.com, hpa@zytor.com,
 tglx@linutronix.de, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, namhyung.kim@lge.com,
 zhong@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, fweisbec@gmail.com,
 benh@kernel.crashing.org, rostedt@goodmis.org, sfr@canb.auug.org.au,
 tglx@linutronix.de, paul.gortmaker@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  02fc8d37229d15c654876cf9ce56b5c1cf7945d7
Gitweb:     http://git.kernel.org/tip/02fc8d37229d15c654876cf9ce56b5c1cf7945d7
Author:     Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate: Fri, 8 Feb 2013 14:19:38 +1100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 8 Feb 2013 15:23:12 +0100

cputime: Restore CPU_ACCOUNTING config defaults for PPC64

Commit abf917cd91cb ("cputime: Generic on-demand virtual cputime
accounting") inadvertantly changed the default CPU_ACCOUNTING
config for PPC64.  Repair that.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung.kim@lge.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Link: http://lkml.kernel.org/r/20130208141938.f31b7b9e1acac5bbe769ee4c@canb.auug.org.au
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index a05f843..ccb9f8f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -332,7 +332,7 @@ config VIRT_CPU_ACCOUNTING
 choice
 	prompt "Cputime accounting"
 	default TICK_CPU_ACCOUNTING if !PPC64
-	default VIRT_CPU_ACCOUNTING if PPC64
+	default VIRT_CPU_ACCOUNTING_NATIVE if PPC64
 
 # Kind of a stub config for the pure tick based cputime accounting
 config TICK_CPU_ACCOUNTING
