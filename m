Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DBC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 14:51:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70722082F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 14:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ektQwxGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70722082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437nyK1dHYzDqVS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:51:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="ektQwxGj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="ektQwxGj"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437nv83gRnzDqT4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 01:49:08 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3EmrGB004114;
 Mon, 3 Dec 2018 14:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=O/w1aZZVNrJDrKELqQe78AmZ3FE2eSiTA/e9hi+v6yo=;
 b=ektQwxGjT3n6I7ro/cSHg51T0aQpDPoLKhj4ccRRhOXI3Wa/rg74d54g89erTsUJr8QG
 4oyVAIoYQlPrLgZZaumxEUj8w22RqDCAnIXUBElc0sMa3zIPdi90sr2rOiSu+43jHW4N
 4UbXL1CEYzxZOovKpGCU0fKojFBOwqcSQj9GwYsGML8VirrPheaULwBf9UX0dnSvKki8
 /3hGXBLydOAeIoLOvZDnMavneNirPo0+bsfEDE+pdIVIojNczxv2UvaZeuO0LnP2bdQP
 chG7Y6l2LURSRRdeXdc7/sIM0sEJq3zwm26G7gPOmOlZ15OrJNrkEm1AMGpCiANkm4fN 8Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2p3jxr6puw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Dec 2018 14:48:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3Emk6M010126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Dec 2018 14:48:47 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3EmiBw025382;
 Mon, 3 Dec 2018 14:48:44 GMT
Received: from kili.mountain (/197.157.0.63)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 03 Dec 2018 06:48:43 -0800
Date: Mon, 3 Dec 2018 17:48:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kim Phillips <kim.phillips@freescale.com>
Subject: [PATCH] powerpc/ipic: Fix a bounds check in ipic_set_priority()
Message-ID: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030140
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
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ipic_info[] array only has 95 elements so I have made the bounds
check smaller to prevent a read overflow.  It was Smatch that found
this issue:

    arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
    error: buffer overflow 'ipic_info' 95 <= 127

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I wasn't able to find any callers of this code.  Maybe we removed the
last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
should just remove it.  I'm not really comfortable doing that myself,
because I don't know the code well enough and can't build test
it properly.

 arch/powerpc/sysdev/ipic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 6300123ce965..9d70d0687cd9 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -779,7 +779,7 @@ int ipic_set_priority(unsigned int virq, unsigned int priority)
 
 	if (priority > 7)
 		return -EINVAL;
-	if (src > 127)
+	if (src >= ARRAY_SIZE(ipic_info))
 		return -EINVAL;
 	if (ipic_info[src].prio == 0)
 		return -EINVAL;
-- 
2.11.0

