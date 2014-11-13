Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DECF81A1F0B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 10:47:38 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 165561400B6
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:47:37 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Nov 2014 05:17:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 59595E005A
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 05:17:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADNniq32359552
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 05:19:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADNlW8T024189
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 05:17:32 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/eeh: Recover EEH error on ownership change for
 BCM5719
Date: Fri, 14 Nov 2014 10:47:30 +1100
Message-Id: <1415922450-29581-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415922450-29581-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415922450-29581-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In PCI passthrou scenario, we need simulate EEH recovery for Emulex
adapters when their ownership changes, as we did in commit 5cfb20b96
("powerpc/eeh: Emulate EEH recovery for VFIO devices"). Broadcom
BCM5719 adpaters are facing same problem and needs same cure.

Reported-by: Rajeshkumar Subramanian <rajeshkumars@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index b372bfd..f1c6b11 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1220,6 +1220,7 @@ int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state)
 static struct pci_device_id eeh_reset_ids[] = {
 	{ PCI_DEVICE(0x19a2, 0x0710) },	/* Emulex, BE     */
 	{ PCI_DEVICE(0x10df, 0xe220) },	/* Emulex, Lancer */
+	{ PCI_DEVICE(0x14e4, 0x1657) }, /* Broadcom BCM5719 */
 	{ 0 }
 };
 
-- 
1.8.3.2
