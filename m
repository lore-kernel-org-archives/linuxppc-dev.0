Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8387F1A0417
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 18:04:02 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Sep 2014 13:33:54 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id F3DED125804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 13:34:32 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8T868PA47055096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 13:36:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8T82gNe012850
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 13:32:42 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: HV: CMA: Reserve cma region only in
 hypervisor mode
Date: Mon, 29 Sep 2014 13:32:38 +0530
Message-Id: <1411977758-24506-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use cma reserved area for creating guest hash page table.
Don't do the reservation in non-hypervisor mode. This avoids unnecessary
CMA reservation when booting with limited memory configs like
fadump and kdump.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index b9615ba5b083..4fdc27c80f4c 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -163,6 +163,12 @@ void __init kvm_cma_reserve(void)
 	unsigned long align_size;
 	struct memblock_region *reg;
 	phys_addr_t selected_size = 0;
+
+	/*
+	 * We need CMA reservation only when we are in HV mode
+	 */
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return;
 	/*
 	 * We cannot use memblock_phys_mem_size() here, because
 	 * memblock_analyze() has not been called yet.
-- 
1.9.1
