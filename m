Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6RPg3wqPzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 17:51:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v946ndTb043384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 02:51:01 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dckeru4qu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Oct 2017 02:51:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 4 Oct 2017 16:50:57 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v946ou9J37879822
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 17:50:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v946oltt014350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 17:50:47 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Fix for core/nest imc call trace on cpuhotplug
Date: Wed,  4 Oct 2017 12:20:52 +0530
Message-Id: <1507099852-28004-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nest/core pmu units are enabled only when it is used. A reference count is      
maintained for the events which uses the nest/core pmu units. Currently in      
*_imc_counters_release function a WARN() is used for notification of any        
underflow of ref count.                                                         
                                                                                
The case where event ref count hit a negative value is, when perf session is    
started, followed by offlining of all cpus in a given core.                     
i.e. in cpuhotplug offline path ppc_core_imc_cpu_offline() function set the     
ref->count to zero, if the current cpu which is about to offline is the last    
cpu in a given core and make an OPAL call to disable the engine in that core.   
And on perf session termination, perf->destroy (core_imc_counters_release) will 
first decrement the ref->count for this core and based on the ref->count value  
an opal call is made to disable the core-imc engine.                            
Now, since cpuhotplug path already clears the ref->count for core and disabled  
the engine, perf->destroy() decrementing again at event termination make it     
negative which in turn fires the WARN_ON. The same happens for nest units.      
                                                                                
Add a check to see if the reference count is alreday zero, before decrementing  
the count, so that the ref count will not hit a negative value.                 
                                                                                
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>                
---
 arch/powerpc/perf/imc-pmu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9ccac86f3463..e3a1f65933b5 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -399,6 +399,20 @@ static void nest_imc_counters_release(struct perf_event *event)
 
 	/* Take the mutex lock for this node and then decrement the reference count */
 	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		/*
+		 * The scenario where this is true is, when perf session is
+		 * started, followed by offlining of all cpus in a given node.
+		 *
+		 * In the cpuhotplug offline path, ppc_nest_imc_cpu_offline()
+		 * function set the ref->count to zero, if the cpu which is
+		 * about to offline is the last cpu in a given node and make
+		 * an OPAL call to disable the engine in that node.
+		 *
+		 */
+		mutex_unlock(&ref->lock);
+		return;
+	}
 	ref->refc--;
 	if (ref->refc == 0) {
 		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
@@ -646,6 +660,20 @@ static void core_imc_counters_release(struct perf_event *event)
 		return;
 
 	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		/*
+		 * The scenario where this is true is, when perf session is
+		 * started, followed by offlining of all cpus in a given core.
+		 *
+		 * In the cpuhotplug offline path, ppc_core_imc_cpu_offline()
+		 * function set the ref->count to zero, if the cpu which is
+		 * about to offline is the last cpu in a given core and make
+		 * an OPAL call to disable the engine in that core.
+		 *
+		 */
+		mutex_unlock(&ref->lock);
+		return;
+	}
 	ref->refc--;
 	if (ref->refc == 0) {
 		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
-- 
2.14.1
