Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B56D72C03E7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:35 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:08:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4B2441258051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:12:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICfRH233816686
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:11:27 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICfStR020309
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:30 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 09/46] CPU hotplug: Convert preprocessor macros to static
 inline functions
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:09:32 +0530
Message-ID: <20130218123932.26245.15573.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2012 06:10 AM, Andrew Morton wrote:
"static inline C functions would be preferred if possible.  Feel free to
fix up the wrong crufty surrounding code as well ;-)"

Convert the macros in the CPU hotplug code to static inline C functions.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 include/linux/cpu.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index cf24da1..eb79f47 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -198,10 +198,10 @@ static inline void cpu_hotplug_driver_unlock(void)
 
 #else		/* CONFIG_HOTPLUG_CPU */
 
-#define get_online_cpus()	do { } while (0)
-#define put_online_cpus()	do { } while (0)
-#define get_online_cpus_atomic()	do { } while (0)
-#define put_online_cpus_atomic()	do { } while (0)
+static inline void get_online_cpus(void) {}
+static inline void put_online_cpus(void) {}
+static inline void get_online_cpus_atomic(void) {}
+static inline void put_online_cpus_atomic(void) {}
 #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 /* These aren't inline functions due to a GCC bug. */
 #define register_hotcpu_notifier(nb)	({ (void)(nb); 0; })
