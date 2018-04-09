Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KPQp0GTszDrpY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 19:00:33 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w398wrWv126361
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Apr 2018 05:00:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h84u68vak-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 05:00:30 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 9 Apr 2018 10:00:28 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH 0/4] powerpc/perf: IMC Cleanups                              
Date: Mon,  9 Apr 2018 14:30:21 +0530
Message-Id: <1523264425-19544-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes some cleanups and Unregistration of                  
thread-imc pmu, if the kernel does not have core-imc registered.                
                                                                                
The entire patch set has been verified using the static checker smatch.         
Command used:                                                                   
$ make ARCH=powerpc CHECK="<path>/smatch -p=kernel"  C=1 vmlinux | tee warns.txt
                                                                                
Tests Done:                                                                     
                                                                                
* Fail core-imc at init:                                                        
nest-imc - working                                                              
cpuhotplug - works as expected                                                  
thread-imc - not registered                                                     
                                                                                
* Fail thread-imc at init:                                                      
nest-imc - works                                                                
core-imc - works                                                                
cpuhotplug - works                                                              
                                                                                
* Fail nest-imc at init                                                         
                                                                                
core-imc - works                                                                
thread-imc -works                                                               
cpuhotplug - works                                                              
                                                                                
* Fail only one nest unit (say for mcs23)                                       
                                                                                
Other nest-units - works                                                        
core-imc - works                                                                
thread-imc - works                                                              
cpuhotplug - works.                                                             
                                                                                
                                                                                
* Kexec works                                                                   
                                                                                
The first three patches in this series addresses the comments by Dan Carpenter. 


Anju T Sudhakar (4):
  powerpc/perf: Rearrange memory freeing in imc init
  powerpc/perf: Replace the direct return with goto statement
  powerpc/perf: Return appropriate value for unknown domain
  powerpc/perf: Unregister thread-imc if core-imc not supported

 arch/powerpc/include/asm/imc-pmu.h        |  1 +
 arch/powerpc/perf/imc-pmu.c               | 64 +++++++++++++++++++------------
 arch/powerpc/platforms/powernv/opal-imc.c | 22 +++++++++--
 3 files changed, 60 insertions(+), 27 deletions(-)

-- 
2.7.4
