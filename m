Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC6C433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 15:17:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBAB206E3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 15:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBAB206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BB2Jq1xKCzDqY4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 01:17:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=weiyongjun1@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BB25y03L2zDqf5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 01:08:00 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 67FEC4F408849D84850E;
 Tue, 21 Jul 2020 23:07:47 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 23:07:38 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Hulk Robot <hulkci@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH -next] PCI: rpadlpar: Make some functions static
Date: Tue, 21 Jul 2020 23:17:35 +0800
Message-ID: <20200721151735.41181-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
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
Cc: linux-pci@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sparse tool report build warnings as follows:

drivers/pci/hotplug/rpadlpar_core.c:355:5: warning:
 symbol 'dlpar_remove_pci_slot' was not declared. Should it be static?
drivers/pci/hotplug/rpadlpar_core.c:461:12: warning:
 symbol 'rpadlpar_io_init' was not declared. Should it be static?
drivers/pci/hotplug/rpadlpar_core.c:473:6: warning:
 symbol 'rpadlpar_io_exit' was not declared. Should it be static?

Those functions are not used outside of this file, so marks them
static.
Also mark rpadlpar_io_exit() as __exit.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index c5eb509c72f0..f979b7098acf 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -352,7 +352,7 @@ static int dlpar_remove_vio_slot(char *drc_name, struct device_node *dn)
  * -ENODEV		Not a valid drc_name
  * -EIO			Internal PCI Error
  */
-int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
+static int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 {
 	struct pci_bus *bus;
 	struct slot *slot;
@@ -458,7 +458,7 @@ static inline int is_dlpar_capable(void)
 	return (int) (rc != RTAS_UNKNOWN_SERVICE);
 }
 
-int __init rpadlpar_io_init(void)
+static int __init rpadlpar_io_init(void)
 {
 
 	if (!is_dlpar_capable()) {
@@ -470,7 +470,7 @@ int __init rpadlpar_io_init(void)
 	return dlpar_sysfs_init();
 }
 
-void rpadlpar_io_exit(void)
+static void __exit rpadlpar_io_exit(void)
 {
 	dlpar_sysfs_exit();
 }

