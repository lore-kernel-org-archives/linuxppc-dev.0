Return-Path: <ego@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D86DB6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 22:19:40 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id nBABJc3Z020021
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2009 16:49:38 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBABJctK2490590
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2009 16:49:38 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBABJaDr021617
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2009 22:19:38 +1100
Subject: [PATCH 1/2] pseries: Don't panic when H_PROD fails during cpu-online.
To: linuxppc-dev@lists.ozlabs.org
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Thu, 10 Dec 2009 16:49:37 +0530
Message-ID: <20091210111937.18281.5146.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If an online-attempt on a CPU which has been offlined using H_CEDE
with an appropriate cede latency hint fails, don't panic.

Instead print the error message and let the __cpu_up() code notify the
CPU Hotplug framework of the failure, which in turn can notify the
other subsystem through CPU_UP_CANCELED.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/platforms/pseries/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 8868c01..b488663 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -144,8 +144,8 @@ static void __devinit smp_pSeries_kick_cpu(int nr)
 		hcpuid = get_hard_smp_processor_id(nr);
 		rc = plpar_hcall_norets(H_PROD, hcpuid);
 		if (rc != H_SUCCESS)
-			panic("Error: Prod to wake up processor %d Ret= %ld\n",
-				nr, rc);
+			printk(KERN_ERR "Error: Prod to wake up processor %d\
+						Ret= %ld\n", nr, rc);
 	}
 }
 
