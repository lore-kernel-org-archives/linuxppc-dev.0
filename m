Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B98622C0390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:57:36 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 01:19:30 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6BA03394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:27:28 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJvPcD27263206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:27:25 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RJvQBZ013390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:57:29 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 09/45] CPU hotplug: Convert preprocessor macros to static
 inline functions
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:24:11 +0530
Message-ID: <20130627195411.29830.50898.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, "Rafael J. Wysocki" <rjw@sisk.pl>,
 sbw@mit.edu, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the macros in the CPU hotplug code to static inline C functions.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/cpu.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index a57b25a..85431a0 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -202,10 +202,8 @@ static inline void cpu_hotplug_driver_unlock(void)
 
 #else		/* CONFIG_HOTPLUG_CPU */
 
-#define get_online_cpus()	do { } while (0)
-#define put_online_cpus()	do { } while (0)
-#define cpu_hotplug_disable()	do { } while (0)
-#define cpu_hotplug_enable()	do { } while (0)
+static inline void get_online_cpus(void) {}
+static inline void put_online_cpus(void) {}
 
 static inline unsigned int get_online_cpus_atomic(void)
 {
@@ -222,6 +220,9 @@ static inline void put_online_cpus_atomic(void)
 	preempt_enable();
 }
 
+static inline void cpu_hotplug_disable(void) {}
+static inline void cpu_hotplug_enable(void) {}
+
 #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 /* These aren't inline functions due to a GCC bug. */
 #define register_hotcpu_notifier(nb)	({ (void)(nb); 0; })
