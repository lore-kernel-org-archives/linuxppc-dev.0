Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 08:50:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E1764F59
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 08:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E1764F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsLzT3z1Qz3dFt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 19:50:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d2r1GH0E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.13; helo=m12-13.163.com; envelope-from=angkery@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=d2r1GH0E; dkim-atps=neutral
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by lists.ozlabs.org (Postfix) with SMTP id 4DsLz00pLGz2xb2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 19:50:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=84Sfy
 PNBxHgq99YUnviXVMgxuSif+wV/5LOoOlGrFtQ=; b=d2r1GH0EG/1ZtieJlsl8k
 dgGT32KnYEgdiprQHHc5E2UbtwQWmq/DJPV1GQTRmm1AOuO8oAp3dxb4P3IzwHcF
 lPcs7r1lDODuRyuHp8QHDLE/ut/x0YeOob749j/pOBPBuxKcDvrhSwSWXLNWUdzr
 STn/9KJa4Glhyp9RkIJBuM=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
 by smtp9 (Coremail) with SMTP id DcCowAAnd5Ns8EFgtBCrhw--.51670S2;
 Fri, 05 Mar 2021 16:48:46 +0800 (CST)
From: angkery <angkery@163.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 drt@linux.ibm.com, ljp@linux.ibm.com, sukadev@linux.ibm.com,
 davem@davemloft.net, kuba@kernel.org
Subject: [PATCH v1] ibmvnic: remove excessive irqsave
Date: Fri,  5 Mar 2021 16:48:39 +0800
Message-Id: <20210305084839.2405-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnd5Ns8EFgtBCrhw--.51670S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13Xr4fKFy5Ar4UZF47urg_yoW8CFykpF
 4fWFy3Gw1vqw1jqa9rXw18AFs3C39YgrW8u34kCws3ur98Ar1rXFn5tFy29rWDG3ySkan8
 ZF1UZ393AFn8C3DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b58n5UUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBFA5MI1aD+lj1pQAAsS
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Junlin Yang <yangjunlin@yulong.com>

ibmvnic_remove locks multiple spinlocks while disabling interrupts:
spin_lock_irqsave(&adapter->state_lock, flags);
spin_lock_irqsave(&adapter->rwi_lock, flags);

As reported by coccinelle, the second _irqsave() overwrites the value
saved in 'flags' by the first _irqsave(),   therefore when the second
_irqrestore() comes,the value in 'flags' is not valid,the value saved
by the first _irqsave() has been lost.
This likely leads to IRQs remaining disabled. So remove the second
_irqsave():
spin_lock_irqsave(&adapter->state_lock, flags);
spin_lock(&adapter->rwi_lock);

Generated by: ./scripts/coccinelle/locks/flags.cocci
./drivers/net/ethernet/ibm/ibmvnic.c:5413:1-18:
ERROR: nested lock+irqsave that reuses flags from line 5404.

Fixes: 4a41c421f367 ("ibmvnic: serialize access to work queue on remove")
Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
Changes in v1:
	a.According to Christophe Leroy's explanation, update the commit information.
	b.Add fixes tags.

 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 2464c8a..a52668d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5408,9 +5408,9 @@ static void ibmvnic_remove(struct vio_dev *dev)
 	 * after setting state, so __ibmvnic_reset() which is called
 	 * from the flush_work() below, can make progress.
 	 */
-	spin_lock_irqsave(&adapter->rwi_lock, flags);
+	spin_lock(&adapter->rwi_lock);
 	adapter->state = VNIC_REMOVING;
-	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
+	spin_unlock(&adapter->rwi_lock);
 
 	spin_unlock_irqrestore(&adapter->state_lock, flags);
 
-- 
1.9.1


