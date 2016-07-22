Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwxqR4vjbzDqQd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 03:05:39 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6MH3rx4113800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 13:05:36 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24bhv1d00b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 13:05:35 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Fri, 22 Jul 2016 14:05:33 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 943781DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 13:05:22 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6MH5UZi4059144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 14:05:30 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6MH5UMX012810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 14:05:30 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 gwshan@linux.vnet.ibm.com
Subject: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
Date: Fri, 22 Jul 2016 14:05:29 -0300
Message-Id: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a very minor/trivial fix for the output of PCI address on EEH logs.
The PCI address on "OF node" field currently is using ":" as a separator
for the function, but the usual separator is ".". This patch changes the
separator for dot, so the PCI address is printed as usual.

No functional changes were introduced.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c9bc78e..7429556 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -168,10 +168,10 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 	int n = 0, l = 0;
 	char buffer[128];
 
-	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x:%01x\n",
+	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
 		       edev->phb->global_number, pdn->busno,
 		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
-	pr_warn("EEH: of node=%04x:%02x:%02x:%01x\n",
+	pr_warn("EEH: of node=%04x:%02x:%02x.%01x\n",
 		edev->phb->global_number, pdn->busno,
 		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
 
-- 
2.1.0
