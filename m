Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A19C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:08:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104B1206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="pEc1b1rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104B1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hxhn4vJgzDqGG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 23:08:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="pEc1b1rg"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HxLW6M53zDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 22:52:51 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B5121419AF;
 Mon, 11 Mar 2019 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552305164; x=1554119565; bh=jT1cbkurPuy7aqFjOnySUP0t9JaJnoAV6A3
 D1832R8s=; b=pEc1b1rguu9K559N+GjevOZKfcJCR891StvWQRx/YerbS4hIXPG
 a4LOghDLLNcowVljwz0yb+emJ6C2OiRnDjqOzAIlqVw4kF8z0EDnnmZSACyxXn2G
 N1b5IQxP5SxWqQDBmfvSHmD6o2Uq0GN1duwZwoDeHlpp8GVOSS+vhHJs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y4oDEFtd5Eft; Mon, 11 Mar 2019 14:52:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id E39BD41992;
 Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 14:52:41 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 6/8] powerpc/pci: Don't rely on DT is the
 PCI_REASSIGN_ALL_BUS is set
Date: Mon, 11 Mar 2019 14:52:31 +0300
Message-ID: <20190311115233.6514-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, linux@yadro.com,
 Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If supported by the platform, endpoint's pci_dn can be created dynamically,
without need to wait for DT updates from the firmware.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c                 | 6 ++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 7fa362f8038d..17362a9b4678 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -555,8 +555,10 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 		phb->pci_data = pdn;
 	}
 
-	/* Update dn->phb ptrs for new phb and children devices */
-	pci_traverse_device_nodes(dn, add_pdn, phb);
+	if (!pci_has_flag(PCI_REASSIGN_ALL_BUS)) {
+		/* Update dn->phb ptrs for new phb and children devices */
+		pci_traverse_device_nodes(dn, add_pdn, phb);
+	}
 }
 
 /** 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index f38078976c5d..40feff2653a0 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -47,7 +47,7 @@ void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
 
-	if (!pdev->is_virtfn)
+	if (!pci_has_flag(PCI_REASSIGN_ALL_BUS) && !pdev->is_virtfn)
 		return;
 
 	/*
-- 
2.20.1

