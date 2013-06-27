Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1577E2C06BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:03:52 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:49:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 724E63578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:03:49 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJmmPx8454476
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:48:48 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RK3ks1023078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:03:48 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 42/45] powerpc: Use get/put_online_cpus_atomic() to avoid
 false-positive warning
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:30:18 +0530
Message-ID: <20130627200017.29830.7532.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Paul Mackerras <paulus@samba.org>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bringing a secondary CPU online is a special case in which, accessing
the cpu_online_mask is safe, even though that task (which running on the
CPU coming online) is not the hotplug writer.

It is a little hard to teach this to the debugging checks under
CONFIG_DEBUG_HOTPLUG_CPU. But luckily powerpc is one of the few places
where the CPU coming online traverses the cpu_online_mask before fully
coming online. So wrap that part under get/put_online_cpus_atomic(), to
avoid false-positive warnings from the CPU hotplug debug code.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/smp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2123bec..59c9a09 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -657,6 +657,7 @@ __cpuinit void start_secondary(void *unused)
 		cpumask_set_cpu(base + i, cpu_core_mask(cpu));
 	}
 	l2_cache = cpu_to_l2cache(cpu);
+	get_online_cpus_atomic();
 	for_each_online_cpu(i) {
 		struct device_node *np = cpu_to_l2cache(i);
 		if (!np)
@@ -667,6 +668,7 @@ __cpuinit void start_secondary(void *unused)
 		}
 		of_node_put(np);
 	}
+	put_online_cpus_atomic();
 	of_node_put(l2_cache);
 
 	local_irq_enable();
