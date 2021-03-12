Return-Path: <SRS0=42OU=IK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 02:27:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CD364F87
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 02:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CD364F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DxV8G18Ryz3dGr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 13:27:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=59.111.176.35; helo=mail-m17635.qiye.163.com;
 envelope-from=wangqing@vivo.com; receiver=<UNKNOWN>)
X-Greylist: delayed 467 seconds by postgrey-1.36 at boromir;
 Fri, 12 Mar 2021 13:27:08 AEDT
Received: from mail-m17635.qiye.163.com (mail-m17635.qiye.163.com
 [59.111.176.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DxV7w2yXlz3cGK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Mar 2021 13:27:07 +1100 (AEDT)
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown
 [58.250.176.228])
 by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 8ACA940022B;
 Fri, 12 Mar 2021 10:18:58 +0800 (CST)
From: Wang Qing <wangqing@vivo.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ibmvscsi: delete the useless casting value returned
Date: Fri, 12 Mar 2021 10:18:53 +0800
Message-Id: <1615515534-1250-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGkhITxgeSkJKSB5CVkpNSk5OSk5OSENCT0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6ESo4Tj8IEwIzDzE0Eyw3
 TiEwCzpVSlVKTUpOTkpOTkhCQ0tNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
 SU5LVUpMTVVJSUNZV1kIAVlBSUtDSzcG
X-HM-Tid: 0a78243ad5abd991kuws8aca940022b
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
Cc: Wang Qing <wangqing@vivo.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix the following coccicheck warning:
WARNING: casting value returned by memory allocation function is useless.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 29fcc44..f084ca10
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -717,8 +717,7 @@ static int map_sg_data(struct scsi_cmnd *cmd,
 
 	/* get indirect table */
 	if (!evt_struct->ext_list) {
-		evt_struct->ext_list = (struct srp_direct_buf *)
-			dma_alloc_coherent(dev,
+		evt_struct->ext_list = dma_alloc_coherent(dev,
 					   SG_ALL * sizeof(struct srp_direct_buf),
 					   &evt_struct->ext_list_token, 0);
 		if (!evt_struct->ext_list) {
-- 
2.7.4

