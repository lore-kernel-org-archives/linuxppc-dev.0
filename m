Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B06C432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 07:47:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7804E21850
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 07:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7804E21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HHwW28P5zDqfZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 18:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=zhengbin13@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HG3c1vHlzDqcT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 17:23:24 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E29F7632BA2E181F2397;
 Tue, 19 Nov 2019 14:07:21 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 14:07:13 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/5] powerpc/powernv: Remove set but not used variable 'parent'
Date: Tue, 19 Nov 2019 14:14:34 +0800
Message-ID: <1574144074-142032-6-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574144074-142032-1-git-send-email-zhengbin13@huawei.com>
References: <1574144074-142032-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 19 Nov 2019 18:35:41 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: zhengbin13@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes gcc '-Wunused-but-set-variable' warning:

arch/powerpc/platforms/powernv/pci-ioda.c: In function pnv_ioda_configure_pe:
arch/powerpc/platforms/powernv/pci-ioda.c:867:18: warning: variable parent set but not used [-Wunused-but-set-variable]

It is not used since commit b131a8425c34 ("powerpc/powernv:
Set PELTV for compound PEs")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 47ed443..ae2db65 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -862,7 +862,6 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)

 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
-	struct pci_dev *parent;
 	uint8_t bcomp, dcomp, fcomp;
 	long rc, rid_end, rid;

@@ -872,7 +871,6 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)

 		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
 		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
-		parent = pe->pbus->self;
 		if (pe->flags & PNV_IODA_PE_BUS_ALL)
 			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
 		else
@@ -893,12 +891,6 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		}
 		rid_end = pe->rid + (count << 8);
 	} else {
-#ifdef CONFIG_PCI_IOV
-		if (pe->flags & PNV_IODA_PE_VF)
-			parent = pe->parent_dev;
-		else
-#endif /* CONFIG_PCI_IOV */
-			parent = pe->pdev->bus->self;
 		bcomp = OpalPciBusAll;
 		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
 		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
--
2.7.4

