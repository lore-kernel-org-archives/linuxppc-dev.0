Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6143B1A191C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 09:03:40 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 17:03:38 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 974271FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 16:54:45 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62N3Ykg48758986
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 16:03:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62N3YMc005888
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 17:03:34 -0600
Date: Thu, 2 Jul 2015 16:03:32 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: David Rientjes <rientjes@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] powerpc/smp: use early_cpu_to_node() instead of
 direct references to numa_cpu_lookup_table
Message-ID: <20150702230332.GB2807@linux.vnet.ibm.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150702230202.GA2807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A simple move to a wrapper function to numa_cpu_lookup_table, now that
power has the early_cpu_to_node() API.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ec9ec20..7bf333b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -381,9 +381,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		 * numa_node_id() works after this.
 		 */
 		if (cpu_present(cpu)) {
-			set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
+			set_cpu_numa_node(cpu, early_cpu_to_node(cpu));
 			set_cpu_numa_mem(cpu,
-				local_memory_node(numa_cpu_lookup_table[cpu]));
+				local_memory_node(early_cpu_to_node(cpu)));
 		}
 	}
 
@@ -400,7 +400,7 @@ void smp_prepare_boot_cpu(void)
 #ifdef CONFIG_PPC64
 	paca[boot_cpuid].__current = current;
 #endif
-	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
+	set_numa_node(early_cpu_to_node(boot_cpuid));
 	current_set[boot_cpuid] = task_thread_info(current);
 }
 
