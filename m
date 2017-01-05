Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvkgL6l27zDq5r
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 10:39:58 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05NdC9m076593
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 18:39:56 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27sxsqjr8k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 18:39:56 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Jan 2017 09:39:53 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E36E72CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 10:39:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05NdpuU65863904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 10:39:51 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05NdpZT019637
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 10:39:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Enable IO path on permanent error
Date: Fri,  6 Jan 2017 10:39:49 +1100
Message-Id: <1483659589-23208-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We give up recovery on permanent error, simply shutdown the affected
devices and remove them. If the devices can't be put into quiet state,
they spew more traffic that is likely to cause another unexpected EEH
error. This was observed on "p8dtu2u" machine:

   0002:00:00.0 PCI bridge: IBM Device 03dc
   0002:01:00.0 Ethernet controller: Intel Corporation \
                Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
   0002:01:00.1 Ethernet controller: Intel Corporation \
                Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
   0002:01:00.2 Ethernet controller: Intel Corporation \
                Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
   0002:01:00.3 Ethernet controller: Intel Corporation \
                Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)

On P8 PowerNV platform, the IO path is frozen when shutdowning the
devices, meaning the memory registers are inaccessible. It is why
the devices can't be put into quiet state before removing them.
This fixes the issue by enabling IO path prior to putting the devices
into quiet state.

Link: https://github.com/open-power/supermicro-openpower/issues/419
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 8180bfd..9de7f79 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -298,9 +298,17 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 	 *
 	 * For pHyp, we have to enable IO for log retrieval. Otherwise,
 	 * 0xFF's is always returned from PCI config space.
+	 *
+	 * When the @severity is EEH_LOG_PERM, the PE is going to be
+	 * removed. Prior to that, the drivers for devices included in
+	 * the PE will be closed. The drivers rely on working IO path
+	 * to bring the devices to quiet state. Otherwise, PCI traffic
+	 * from those devices after they are removed is like to cause
+	 * another unexpected EEH error.
 	 */
 	if (!(pe->type & EEH_PE_PHB)) {
-		if (eeh_has_flag(EEH_ENABLE_IO_FOR_LOG))
+		if (eeh_has_flag(EEH_ENABLE_IO_FOR_LOG) ||
+		    severity == EEH_LOG_PERM)
 			eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 
 		/*
-- 
2.7.4
