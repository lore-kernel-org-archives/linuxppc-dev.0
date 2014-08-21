Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3289C1A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 18:14:13 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 21 Aug 2014 09:14:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94B75219005E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 09:13:48 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7L8E6Oh31457500
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 08:14:06 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7L8E5xp014131
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 02:14:05 -0600
Message-ID: <1408608842.3003.20.camel@TP420>
Subject: [RFC PATCH powerpc] Fix warning reported by verify_cpu_node_mapping()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 21 Aug 2014 16:14:02 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
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

So I could see something like following reported:
[    0.000000] CPU thread siblings 1/2/3 and 0 don't belong to the same
node!

As we don't actually do the checking during this early stage, so maybe
we could directly call numa_setup_cpu() in do_init_bootmem()?

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d7737a5..9918c02 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1128,8 +1128,7 @@ void __init do_init_bootmem(void)
 	 * early in boot, cf. smp_prepare_cpus().
 	 */
 	for_each_possible_cpu(cpu) {
-		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
-				  (void *)(unsigned long)cpu);
+		numa_setup_cpu((unsigned long)cpu);
 	}
 }
 
