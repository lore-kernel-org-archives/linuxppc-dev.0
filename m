Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znCYW4VdzzF1QR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 22:58:39 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MBwX1j100730
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 06:58:36 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9rcv3p4t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 06:58:36 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 11:58:33 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH] PCI/AER: Add a null check before eeh_ops->notify_resume
 callback.
Date: Thu, 22 Feb 2018 17:28:03 +0530
Message-Id: <20180222115803.21738-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch puts a NULL check before branching to the address pointed
to by eeh_ops->notify_resume in eeh_report_resume(). The callback
is used to notify the arch EEH code that a pci device is back
online.

For PPC64 presently, only an implementation for pseries platform is
available and not for powernv. Hence without this patch EEH recovery
on all non-virtualized hosts is causing a kernel panic when
CONFIG_PCI_IOV is set. The panic is usually is of the form:

EEH: Notify device driver to resume
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
<snip>
LR eeh_report_resume+0x218/0x220
Call Trace:
 eeh_report_resume+0x1f0/0x220 (unreliable)
 eeh_pe_dev_traverse+0x98/0x170
 eeh_handle_normal_event+0x3f4/0x650
 eeh_handle_event+0x188/0x380
 eeh_event_handler+0x208/0x210
 kthread+0x168/0x1b0
 ret_from_kernel_thread+0x5c/0xb4

Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Fixes: 856e1eb9bdd4("PCI/AER: Add uevents in AER and EEH error/resume")
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index beea2182d754..932858a293ea 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -384,7 +384,8 @@ static void *eeh_report_resume(void *data, void *userdata)
 	eeh_pcid_put(dev);
 	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 #ifdef CONFIG_PCI_IOV
-	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
+	if (eeh_ops->notify_resume)
+		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
 #endif
 	return NULL;
 }
-- 
2.14.3
