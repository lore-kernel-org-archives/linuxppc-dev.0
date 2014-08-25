Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2B331A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 17:22:46 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 25 Aug 2014 08:22:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 963AF17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 08:24:33 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7P7Md3028508174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 07:22:39 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7P7Mcus002486
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 01:22:39 -0600
Message-ID: <1408951355.2477.8.camel@TP420>
Subject: [PATCH v2] powerpc: Fix warning reported by verify_cpu_node_mapping()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Mon, 25 Aug 2014 15:22:35 +0800
In-Reply-To: <20140822220406.GA20951@linux.vnet.ibm.com>
References: <1408608842.3003.20.camel@TP420>
 <20140821154529.GB10478@linux.vnet.ibm.com> <1408673576.2448.6.camel@TP420>
 <20140822220406.GA20951@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit 2fabf084b, during boottime, cpu_numa_callback() is called
earlier(before their online) for each cpu, and verify_cpu_node_mapping()
uses cpu_to_node() to check whether siblings are in the same node. 

It skips the checking for siblings that are not online yet. So the only
check done here is for the bootcpu, which is online at that time. But
the per-cpu numa_node cpu_to_node() uses hasn't been set up yet (which
will be set up in smp_prepare_cpus()).

So I saw something like following reported:
[    0.000000] CPU thread siblings 1/2/3 and 0 don't belong to the same
node!

As we don't actually do the checking during this early stage, so maybe
we could directly call numa_setup_cpu() in do_init_bootmem().

Also, as Nish suggested, here it's better to use present cpu mask
instead of possible mask to avoid warning in numa_setup_cpu().

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d7737a5..3a9061e 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1127,9 +1127,8 @@ void __init do_init_bootmem(void)
 	 * even before we online them, so that we can use cpu_to_{node,mem}
 	 * early in boot, cf. smp_prepare_cpus().
 	 */
-	for_each_possible_cpu(cpu) {
-		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
-				  (void *)(unsigned long)cpu);
+	for_each_present_cpu(cpu) {
+		numa_setup_cpu((unsigned long)cpu);
 	}
 }
 
