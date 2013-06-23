Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B09BB2C07DC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:43:03 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 23:28:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 38F6D2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:43:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDS38a6619350
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:28:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDgvi4028242
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:42:59 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 07/45] CPU hotplug: Expose the new debug config option
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:09:31 +0530
Message-ID: <20130623133928.19094.8259.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, Michel Lespinasse <walken@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Akinobu Mita <akinobu.mita@gmail.com>, wangyun@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paul.mckenney@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have all the pieces of the CPU hotplug debug infrastructure
in place, expose the feature by growing a new Kconfig option,
CONFIG_DEBUG_HOTPLUG_CPU.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michel Lespinasse <walken@google.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 lib/Kconfig.debug |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 566cf2b..6be1e72 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -512,6 +512,15 @@ config DEBUG_PREEMPT
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+config DEBUG_HOTPLUG_CPU
+	bool "Debug CPU hotplug"
+	depends on HOTPLUG_CPU
+	default n
+	help
+	  If you say Y here, the kernel will check all the accesses of
+	  cpu_online_mask from atomic contexts, and will print warnings if
+	  the task lacks appropriate synchronization with CPU hotplug.
+
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	depends on DEBUG_KERNEL && RT_MUTEXES
