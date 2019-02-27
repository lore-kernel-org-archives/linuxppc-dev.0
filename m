Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 05:03:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94B0218E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 05:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94B0218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448NqB1FCwzDqDt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 16:03:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448NhS0Ws3zDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 15:57:11 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 8E9CD2854E3034C164C2;
 Wed, 27 Feb 2019 12:41:05 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1R4etdZ003794;
 Wed, 27 Feb 2019 12:40:55 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022712411629-2029149 ;
 Wed, 27 Feb 2019 12:41:16 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: benh@kernel.crashing.org
Subject: [PATCH 8/8] PCI: rpadlpar: fix a leaked reference by adding missing
 of_node_put
Date: Wed, 27 Feb 2019 12:40:43 +0800
Message-Id: <1551242443-27300-8-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-27 12:41:16,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:48, Serialize complete at 2019-02-27 12:40:48
X-MAIL: mse01.zte.com.cn x1R4etdZ003794
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
Cc: heiko@sntech.de, hayashi.kunihiko@socionext.com, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, minghuan.Lian@nxp.com, paulus@samba.org,
 thomas.petazzoni@bootlin.com, Wen Yang <wen.yang99@zte.com.cn>,
 ryder.lee@mediatek.com, kishon@ti.com, linux-rockchip@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 wang.yi59@zte.com.cn, rjui@broadcom.com, lorenzo.pieralisi@arm.com,
 linux-mediatek@lists.infradead.org, tyreld@linux.vnet.ibm.com,
 matthias.bgg@gmail.com, linux-omap@vger.kernel.org, mingkai.hu@nxp.com,
 roy.zang@nxp.com, sbranden@broadcom.com, yamada.masahiro@socionext.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pci/hotplug/rpadlpar_core.c:55:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 42, but without a corresponding object release within this function

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/hotplug/rpadlpar_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e2356a9..f3f42ff 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -52,6 +52,7 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 			break;
 	}
 
+	of_node_put(parent);
 	return dn;
 }
 
-- 
2.9.5

