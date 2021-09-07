Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803D2C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 09:15:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696A361051
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 09:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 696A361051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3fkN46yzz2ypM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 19:15:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.23; helo=cstnet.cn;
 envelope-from=vulab@iscas.ac.cn; receiver=<UNKNOWN>)
X-Greylist: delayed 896 seconds by postgrey-1.36 at boromir;
 Tue, 07 Sep 2021 19:14:59 AEST
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
 by lists.ozlabs.org (Postfix) with ESMTP id 4H3fjv2qMvz2xXy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2021 19:14:58 +1000 (AEST)
Received: from localhost.localdomain (unknown [124.16.141.241])
 by APP-03 (Coremail) with SMTP id rQCowAAXOREEKjdhJZhwAA--.33777S2;
 Tue, 07 Sep 2021 16:59:48 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 bhelgaas@google.com
Subject: [PATCH] pci/hotplug/pnv-php: Remove probable double put
Date: Tue,  7 Sep 2021 08:59:46 +0000
Message-Id: <20210907085946.21694-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAAXOREEKjdhJZhwAA--.33777S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw17uFyrAr15JrykXry7KFg_yoWxCFc_WF
 48WFZrWr4FyF1Sgrs0gryrZrWSya4DWrs5Aw4Iq3Zaya1xXr17CFWYvr98Jasrur43Xr95
 Ar9FqF45Ar15CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2kYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr
 1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ldgJUUUUU==
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwoRA1z4kZHFJgAAsU
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
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Device node iterators put the previous value of the index variable,
so an explicit put causes a double put.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/pci/hotplug/pnv_php.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 04565162a449..ed4d1a2c3f22 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -158,7 +158,6 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
 	for_each_child_of_node(parent, dn) {
 		pnv_php_detach_device_nodes(dn);
 
-		of_node_put(dn);
 		of_detach_node(dn);
 	}
 }
-- 
2.17.1

