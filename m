Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1EB6B7008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 19:18:41 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 1 Mar 2012 13:48:37 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q218IXMF4042830
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2012 13:48:33 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q218IVkH006038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Mar 2012 13:48:33 +0530
Message-ID: <4F4F30D6.3000707@linux.vnet.ibm.com>
Date: Thu, 01 Mar 2012 13:48:30 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 3/3] CPU hotplug,
 arch/sparc: Fix CPU hotplug callback registration
References: <87ehtf3lqh.fsf@rustcorp.com.au>
 <20120227155338.7b5110cd.akpm@linux-foundation.org>
 <20120228084359.GJ21106@elte.hu>
 <20120228132719.f375071a.akpm@linux-foundation.org>
 <4F4DBB26.2060907@linux.vnet.ibm.com> <20120229091732.GA11505@elte.hu>
 <4F4E083A.2080304@linux.vnet.ibm.com> <4F4F2F7F.5040207@linux.vnet.ibm.com>
In-Reply-To: <4F4F2F7F.5040207@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andi Kleen <ak@linux.intel.com>, Nick Piggin <npiggin@kernel.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan.van.de.ven@intel.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Restructure CPU hotplug setup and callback registration in topology_init
so as to be race-free.

---

 arch/sparc/kernel/sysfs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index 654e8aa..22cb881 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -300,16 +300,14 @@ static int __init topology_init(void)
 
 	check_mmu_stats();
 
-	register_cpu_notifier(&sysfs_cpu_nb);
-
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
 		register_cpu(c, cpu);
-		if (cpu_online(cpu))
-			register_cpu_online(cpu);
 	}
 
+	register_allcpu_notifier(&sysfs_cpu_nb, true, NULL);
+
 	return 0;
 }
 
