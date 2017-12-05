Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrVhS5psYzF06Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 16:30:48 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB55TPff064990
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 00:30:45 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eng4q2j13-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 00:30:44 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 5 Dec 2017 05:30:43 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/perf: Fix nest-imc cpuhotplug callback failure
Date: Tue,  5 Dec 2017 11:00:38 +0530
Message-Id: <1512451838-10456-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call trace observed during boot:                                                
                                                                                
Faulting instruction address: 0xc000000000248340                                
cpu 0x0: Vector: 380 (Data Access Out of Range) at [c000000ff66fb850]           
    pc: c000000000248340: event_function_call+0x50/0x1f0                        
    lr: c00000000024878c: perf_remove_from_context+0x3c/0x100                   
    sp: c000000ff66fbad0                                                        
   msr: 9000000000009033                                                        
   dar: 7d20e2a6f92d03c0                                                        
  current = 0xc000000ff6679200                                                  
  paca    = 0xc00000000fd40000   softe: 0  irq_happened: 0x01                   
    pid   = 14, comm = cpuhp/0                                                  
Linux version 4.14.0-rc2-42789-ge8eae4b (rgrimm@XXXX) (gcc version 5.4.0        
20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4)) #1 SMP Thu Nov 16 14:35:14 CST    
2017                                                                            
enter ? for help                                                                
[c000000ff66fbb80] c00000000024878c perf_remove_from_context+0x3c/0x100         
[c000000ff66fbbc0] c00000000024e84c perf_pmu_migrate_context+0x10c/0x380        
[c000000ff66fbc60] c0000000000ca050 ppc_nest_imc_cpu_offline+0x1b0/0x210        
[c000000ff66fbcb0] c0000000000d5d54 cpuhp_invoke_callback+0x194/0x620           
[c000000ff66fbd20] c0000000000d702c cpuhp_thread_fun+0x7c/0x1b0                 
[c000000ff66fbd60] c00000000010ad90 smpboot_thread_fn+0x290/0x2a0               
[c000000ff66fbdc0] c000000000104818 kthread+0x168/0x1b0                         
[c000000ff66fbe30] c00000000000b5a0 ret_from_kernel_thread+0x5c/0xbc            
                                                                                
While registering the cpuhotplug callbacks for nest-imc, if we fail in the      
cpuhotplug online path for any random node in a multi node system (because      
the opal call to stop nest-imc counters fails for that node),                   
ppc_nest_imc_cpu_offline() will get invoked for other nodes who successfully    
returned from cpuhotplug online path.                                           
                                                                                
This call trace is generated since in the ppc_nest_imc_cpu_offline()            
path we are trying to migrate the event context, when nest-imc counters are     
not even initialized.                                                           
                                                                                
Patch to add a check to ensure that nest-imc is registered before migrating     
the event context.                                     

Note:                                                                           
Madhavan Srinivasan has recently send a skiboot patch to have a check in the    
skiboot code to make sure that the  microcode is initialized in all the chips,  
before enabling the nest units.                                                 
https://patchwork.ozlabs.org/patch/844047/ (v2)
                                                                                
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>  
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 0ead3cd..9daa1c3 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -309,6 +309,20 @@ static int ppc_nest_imc_cpu_offline(unsigned int cpu)
 	if (!cpumask_test_and_clear_cpu(cpu, &nest_imc_cpumask))
 		return 0;
 
+       /*
+	* Check whether nest_imc is registered. We could end up here
+	* if the cpuhotplug callback registration fails. i.e, callback
+	* invokes the offline path for all successfully registered nodes.
+	* At this stage, nest_imc pmu will not be registered and we
+	* should return here.
+	*
+	* We return with a zero since this is not an offline failure.
+	* And cpuhp_setup_state() returns the actual failure reason
+	* to the caller, which inturn will call the cleanup routine.
+	*/
+	if (!nest_pmus)
+		return 0;
+
 	/*
 	 * Now that this cpu is one of the designated,
 	 * find a next cpu a) which is online and b) in same chip.
-- 
2.7.4
