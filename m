Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vh2pjJzF3FW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1JCWS028147
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2memwr8q0r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:41 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1Nb2F60358684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 459BA52057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F17E55204F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B81C0A03B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/14] powerpc/eeh: Cleanup unnecessary
 eeh_pe_state_mark_with_cfg()
Date: Wed, 12 Sep 2018 11:23:30 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <83e84657541fb1b68c1fc22932435919db493daa.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_pe_state_mark_with_cfg() just performs the work of
eeh_pe_state_mark() and then, conditionally, the work of
eeh_pe_state_clear(). However it is only ever called with a constant
state such that the condition is always true, so replace it by direct
calls.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh.c    |  6 ++++--
 arch/powerpc/kernel/eeh_pe.c | 22 ----------------------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 25e7384fdaba..dd5ac2ad141e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -830,7 +830,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 		break;
 	case pcie_hot_reset:
-		eeh_pe_state_mark_with_cfg(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		if (!(pe->type & EEH_PE_VF))
@@ -838,7 +839,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
-		eeh_pe_state_mark_with_cfg(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		if (!(pe->type & EEH_PE_VF))
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 78f125d24bd0..2b376718237f 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -670,28 +670,6 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
 }
 
-/**
- * eeh_pe_state_mark_with_cfg - Mark PE state with unblocked config space
- * @pe: PE
- * @state: PE state to be set
- *
- * Set specified flag to PE and its child PEs. The PCI config space
- * of some PEs is blocked automatically when EEH_PE_ISOLATED is set,
- * which isn't needed in some situations. The function allows to set
- * the specified flag to indicated PEs without blocking their PCI
- * config space.
- */
-void eeh_pe_state_mark_with_cfg(struct eeh_pe *pe, int state)
-{
-	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
-	if (!(state & EEH_PE_ISOLATED))
-		return;
-
-	/* Clear EEH_PE_CFG_BLOCKED, which might be set just now */
-	state = EEH_PE_CFG_BLOCKED;
-	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
-}
-
 /*
  * Some PCI bridges (e.g. PLX bridges) have primary/secondary
  * buses assigned explicitly by firmware, and we probably have
-- 
2.19.0.2.gcad72f5712
