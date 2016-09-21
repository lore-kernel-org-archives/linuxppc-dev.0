Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfJVJ2CngzDsgg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 22:15:20 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sfJVH5Qgjz9svs
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:19 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LCDIM5032517
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:15:17 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25khtdcv3f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:15:16 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 22:15:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 01F6F2CE8046
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LCFBO463307900
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LCFBL6011278
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/eeh: Export eeh_pe_state_mark()
Date: Wed, 21 Sep 2016 22:15:28 +1000
In-Reply-To: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1474460130-8316-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports eeh_pe_state_mark(). It will be used to mark the surprise
hot removed PE as isolated to avoid unexpected EEH error reporting in
surprise remove path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f0520da..de7d091 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -581,6 +581,7 @@ void eeh_pe_state_mark(struct eeh_pe *pe, int state)
 {
 	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
 }
+EXPORT_SYMBOL_GPL(eeh_pe_state_mark);
 
 static void *__eeh_pe_dev_mode_mark(void *data, void *flag)
 {
-- 
2.1.0
