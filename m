Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJXpj6rhwzDvdP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 16:28:13 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tJXpj2GpCz9t1B
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2016 16:28:13 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG5Nq1w027331
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2016 00:28:11 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rd5gqyjs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2016 00:28:10 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 15:28:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CB0112BB0055
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2016 16:28:04 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAG5S4Oi48496668
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2016 16:28:04 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAG5S4kN019956
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2016 16:28:04 +1100
Subject: [PATCH] powernv/hmi: Display the correct error info for CAPP errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>
Date: Wed, 16 Nov 2016 10:58:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147927393883.28364.12544121254023856142.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On some CAPP errors we see console messages that prints unknown HMIs for
which CAPI recovery is in progress. This patch fixes this by printing
correct error info for HMI generated due to CAPP recovery.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-hmi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index c0a8201..0d0d5f7 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -180,7 +180,8 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 		"An XSCOM operation completed",
 		"SCOM has set a reserved FIR bit to cause recovery",
 		"Debug trigger has set a reserved FIR bit to cause recovery",
-		"A hypervisor resource error occurred"
+		"A hypervisor resource error occurred",
+		"CAPP recovery process is in progress"
 	};
 
 	/* Print things out */
