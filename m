Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2E661A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:13:12 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 410D1140DA6
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 7 Oct 2015 13:13:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E31A73578056
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t973D0aA14549030
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:13:08 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t973CasQ025520
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:12:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 4/5] powerpc/eeh: More relxed condition for enabled IO path
Date: Wed,  7 Oct 2015 14:12:08 +1100
Message-Id: <1444187529-32217-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When one of below two flags or both of them are marked in the PE
state, the PE's IO path is regarded as enabled: EEH_STATE_MMIO_ACTIVE
or EEH_STATE_MMIO_ENABLED.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e968533..ddbf406 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -630,7 +630,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 	 */
 	switch (function) {
 	case EEH_OPT_THAW_MMIO:
-		active_flag = EEH_STATE_MMIO_ACTIVE;
+		active_flag = EEH_STATE_MMIO_ACTIVE | EEH_STATE_MMIO_ENABLED;
 		break;
 	case EEH_OPT_THAW_DMA:
 		active_flag = EEH_STATE_DMA_ACTIVE;
-- 
2.1.0
