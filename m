Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E91C2C0D45
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:46:51 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:08:15 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4FF443940057
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:16:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDl1DQ22347858
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:17:01 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDkk0s026286
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:46:48 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 25/45] staging/octeon: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:13:33 +0530
Message-ID: <20130623134331.19094.80396.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, devel@driverdev.osuosl.org,
 nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 fweisbec@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, wangyun@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/staging/octeon/ethernet-rx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 34afc16..8588b4d 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -36,6 +36,7 @@
 #include <linux/prefetch.h>
 #include <linux/ratelimit.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <net/dst.h>
 #ifdef CONFIG_XFRM
@@ -97,6 +98,7 @@ static void cvm_oct_enable_one_cpu(void)
 		return;
 
 	/* ... if a CPU is available, Turn on NAPI polling for that CPU.  */
+	get_online_cpus_atomic();
 	for_each_online_cpu(cpu) {
 		if (!cpu_test_and_set(cpu, core_state.cpu_state)) {
 			v = smp_call_function_single(cpu, cvm_oct_enable_napi,
@@ -106,6 +108,7 @@ static void cvm_oct_enable_one_cpu(void)
 			break;
 		}
 	}
+	put_online_cpus_atomic();
 }
 
 static void cvm_oct_no_more_work(void)
