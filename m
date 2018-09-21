Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H0fS6shRzF3QR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 03:17:52 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8LH9t3d061136
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 13:17:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mn3snk1hb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 13:17:49 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Sep 2018 13:17:49 -0400
Date: Fri, 21 Sep 2018 22:47:40 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <1537464159-25919-2-git-send-email-ego@linux.vnet.ibm.com>
 <d1cf1628ed2641140d3508d355cdc172d6b145e9.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d1cf1628ed2641140d3508d355cdc172d6b145e9.camel@neuling.org>
Message-Id: <20180921171740.GA12919@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On Fri, Sep 21, 2018 at 01:02:45PM +1000, Michael Neuling wrote:
> This doesn't compile for me with:
> 
> arch/powerpc/kernel/smp.c: In function ‘smp_prepare_cpus’:
> arch/powerpc/kernel/smp.c:812:23: error: ‘tg.threads_per_group’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   struct thread_groups tg;
>                        ^
> arch/powerpc/kernel/smp.c:812:23: error: ‘tg.nr_groups’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> cc1: all warnings being treated as errors
> /home/mikey/src/linux-ozlabs/scripts/Makefile.build:305: recipe for target 'arch/powerpc/kernel/smp.o' failed
>

I couldn't get this error with gcc 4.8.5 and 8.1.1 with
pseries_defconfig and powernv_defconfig with CONFIG_PPC_WERROR=y.

Does the following the following delta patch make it work?

-----------------------------X8----------------------------------

>From 6699ce20573dddd0d3d45ea79015751880740e9b Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Fri, 21 Sep 2018 22:43:05 +0530
Subject: [PATCH] powerpc/smp: Initialize thread_groups local variable

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5cdcf44..356751e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -809,8 +809,9 @@ static int init_cpu_l1_cache_map(int cpu)
 
 {
 	struct device_node *dn = of_get_cpu_node(cpu, NULL);
-	struct thread_groups tg;
-
+	struct thread_groups tg = {.property = 0,
+				   .nr_groups = 0,
+				   .threads_per_group = 0};
 	int first_thread = cpu_first_thread_sibling(cpu);
 	int i, cpu_group_start = -1, err = 0;
 
-- 
1.9.4
