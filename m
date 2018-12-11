Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0504C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:24:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4702081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4702081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DRfM5YWbzDqss
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 15:24:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DRcB0kP1zDqly
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 15:22:16 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 349672D342DCD656CD41;
 Tue, 11 Dec 2018 12:21:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wBB4KxMV004046;
 Tue, 11 Dec 2018 12:20:59 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018121112211187-15984143 ;
 Tue, 11 Dec 2018 12:21:11 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: Thomas Falcon <tlfalcon@linux.ibm.com>, John Allen <jallen@linux.ibm.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] net/ibmvnic: Remove tests of member address
Date: Tue, 11 Dec 2018 12:20:46 +0800
Message-Id: <20181211042046.64810-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-12-11 12:21:11,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-11 12:20:55
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wBB4KxMV004046
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wen Yang <wen.yang99@zte.com.cn>, cheng.shengyu@zte.com.cn,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The driver was checking for non-NULL address.
- adapter->napi[i]

This is pointless as these will be always non-NULL, since the
'dapter->napi' is allocated in init=5Fnapi().
It is safe to get rid of useless checks for addresses to fix the
coccinelle warning:
>>drivers/net/ethernet/ibm/ibmvnic.c: test of a variable/field address
Since such statements always return true, they are redundant.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Thomas Falcon <tlfalcon@linux.ibm.com>
CC: John Allen <jallen@linux.ibm.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: linuxppc-dev@lists.ozlabs.org
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/ibm/ibmvnic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index ed50b8dee44f..14d00985f087 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -773,11 +773,8 @@ static void release=5Fnapi(struct ibmvnic=5Fadapter *a=
dapter)
 		return;
=20
 	for (i =3D 0; i < adapter->num=5Factive=5Frx=5Fnapi; i++) {
-		if (&adapter->napi[i]) {
-			netdev=5Fdbg(adapter->netdev,
-				   "Releasing napi[%d]\n", i);
-			netif=5Fnapi=5Fdel(&adapter->napi[i]);
-		}
+		netdev=5Fdbg(adapter->netdev, "Releasing napi[%d]\n", i);
+		netif=5Fnapi=5Fdel(&adapter->napi[i]);
 	}
=20
 	kfree(adapter->napi);
--=20
2.19.1

