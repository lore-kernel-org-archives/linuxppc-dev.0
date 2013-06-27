Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84A312C0360
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:56:46 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 01:19:41 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B460E125804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:25:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJuxke32178318
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:26:59 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RJudKq032534
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:56:41 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 05/45] CPU hotplug: Protect set_cpu_online() to avoid
 false-positives
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:23:24 +0530
Message-ID: <20130627195324.29830.11378.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When bringing a secondary CPU online, the task running on the CPU coming up
sets itself in the cpu_online_mask. This is safe even though this task is not
the hotplug writer task.

But it is kinda hard to teach this to the CPU hotplug debug infrastructure,
and if we get it wrong, we risk making the debug code too lenient, risking
false-negatives.

Luckily, all architectures use set_cpu_online() to manipulate the
cpu_online_mask. So, to avoid false-positive warnings from the CPU hotplug
debug code, encapsulate the body of set_cpu_online() within
get/put_online_cpus_atomic().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/cpu.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5297ec1..35e7115 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -832,10 +832,14 @@ void set_cpu_present(unsigned int cpu, bool present)
 
 void set_cpu_online(unsigned int cpu, bool online)
 {
+	get_online_cpus_atomic();
+
 	if (online)
 		cpumask_set_cpu(cpu, to_cpumask(cpu_online_bits));
 	else
 		cpumask_clear_cpu(cpu, to_cpumask(cpu_online_bits));
+
+	put_online_cpus_atomic();
 }
 
 void set_cpu_active(unsigned int cpu, bool active)
