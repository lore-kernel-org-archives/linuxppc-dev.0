Return-Path: <srs0=epap=2s=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfCtg6NH5zDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:48:11 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vfCtg5F91z8t6c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:48:11 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vfCtf6MHpz9s7l
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2017 01:48:10 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v29EhiR2153122
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 09:48:06 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 292mrkwt4u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Mar 2017 09:48:05 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 20:18:01 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v29Em0RX15466502
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 20:18:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v29Elx6s030189
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 20:17:59 +0530
Subject: [PATCH 1/2] powerpc/fadump: reserve memory at halfway mark
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 09 Mar 2017 20:17:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148907087368.3574.8071537539290192784.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the area to preserve boot memory is reserved at the top of
RAM. This leaves fadump vulnerable to DLPAR memory remove operations.
As memory for fadump needs to be reserved early in the boot process,
fadump can't be registered after a DLPAR memory remove operation.
While this problem can't be eleminated completely, the impact can be
minimized by reserving memory at the halfway mark instead. With this
change, fadump can register successfully after a DLPAR memory remove
operation as long as the sum of the sizes of boot memory and memory
removed is less than half of the total available memory.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ff0dd4..9c85c5a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -319,9 +319,13 @@ int __init fadump_reserve_mem(void)
 		pr_debug("fadumphdr_addr = %p\n",
 				(void *) fw_dump.fadumphdr_addr);
 	} else {
-		/* Reserve the memory at the top of memory. */
+		/*
+		 * Reserve memory at the halfway mark to minimize
+		 * the impact of DLPAR memory remove operation.
+		 */
+		base = PAGE_ALIGN(memory_boundary/2);
 		size = get_fadump_area_size();
-		base = memory_boundary - size;
+		WARN_ON((base + size) > memory_boundary);
 		memblock_reserve(base, size);
 		printk(KERN_INFO "Reserved %ldMB of memory at %ldMB "
 				"for firmware-assisted dump\n",
