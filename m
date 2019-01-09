Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D20C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 10:25:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E578E20652
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 10:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NGLDXAxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E578E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZQHb3H8kzDqd1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 21:25:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="NGLDXAxF"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZQFy23m3zDqYh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 21:23:49 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x09AJASi117344;
 Wed, 9 Jan 2019 10:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=b04tn+a2JDvR0+f3DT1avMgIdzv0yD7/vyLSahdiEr4=;
 b=NGLDXAxFhLA0AYAH+yQsC326lbIwfkB+0YGr5ZBYdnpVgDHiTbEp4z2Bw+L0YCoxdgz1
 GSApxhLHyYIAqx+rSfLp8wCtj/3i8B6bJdUz3feMccu76epb5M4l/CbUEoo+TTZk3q5w
 xAOTNVZY7JhZ5hqY3wQHfQsgpta0zK/nuSYFglNZ46zS6I85jAiffTcJv4VhReLLQuaf
 4lGdJliRUv19xfSHVzp/A7iyaqVFSMfjjBc5zrXn0dsLirMLQr87IcC8v6P4DSM8qp3Z
 G09HyfAwoWiDsXOCL8u+yMXKP6NJJ65X6TRG+SLBNVb3xjjHGcAzYn4UiQhUbg7nA17o eA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2ptn7r0dhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jan 2019 10:23:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x09ANdN1023355
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jan 2019 10:23:39 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x09ANclQ007273;
 Wed, 9 Jan 2019 10:23:38 GMT
Received: from kadam (/10.175.15.235) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 09 Jan 2019 02:23:38 -0800
Date: Wed, 9 Jan 2019 13:23:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH] powerpc/powernv/npu: Allocate enough memory in
 pnv_try_setup_npu_table_group()
Message-ID: <20190109102328.GB5476@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090088
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mark Hairgrove <mhairgrove@nvidia.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is a typo so we accidentally allocate enough memory for a pointer
when we wanted to allocate enough for a struct.

Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index d7f742ed48ba..3f58c7dbd581 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -564,7 +564,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 		}
 	} else {
 		/* Create a group for 1 GPU and attached NPUs for POWER8 */
-		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
+		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
 		table_group = &pe->npucomp->table_group;
 		table_group->ops = &pnv_npu_peers_ops;
 		iommu_register_group(table_group, hose->global_number,
-- 
2.17.1

