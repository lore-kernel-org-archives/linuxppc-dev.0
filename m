Return-Path: <rcjenn@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0966CDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 09:07:40 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAEM78Ll023505
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:07:08 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAEM7Zh9131308
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:07:35 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAEM7Y7K031144
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:07:35 -0700
Date: Fri, 14 Nov 2008 16:07:34 -0600
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH] powerpc: Correct page-in counter for CMM
Message-ID: <20081114220734.GA26013@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Theurer <habanero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linux will report the number of page-ins so that the hypervisor can
better determine partition memory pressure.  The hardware page size and
the OS page size can be different.  In the case where the hardware page
size is 4k and the OS is running with 64k pages the prior patch would
under-report the number of pages. This patch uses PAGE_FACTOR to correct
the reporting to the hypervisor.

Reported-by: Andrew Theurer <habanero@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/mm/fault.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/arch/powerpc/mm/fault.c
===================================================================
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -324,7 +324,7 @@ good_area:
 #ifdef CONFIG_PPC_SMLPAR
 		if (firmware_has_feature(FW_FEATURE_CMO)) {
 			preempt_disable();
-			get_lppaca()->page_ins++;
+			get_lppaca()->page_ins += (1 << PAGE_FACTOR);
 			preempt_enable();
 		}
 #endif
