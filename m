Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF89C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:12:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469582082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvkSu0ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469582082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tV5X3L5HzDqHh
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="gvkSu0ci"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tV3N1B7czDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:10:23 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x14E8xdT027994;
 Mon, 4 Feb 2019 14:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=JPYLcAP4VkvLUtdSN+MQh/nNpzonf9onT0VM4MS/sso=;
 b=gvkSu0cihfJrrxz5V76J8jOoPChR8dGQ/3YvKyZlO0IdkCqP27xjO+RYLo5/udQUlpUR
 USN3IS32Vh/Ta1In8vOhhaOhnkOnAPJIRFDUBB68hFCerPw7sVQULSv4ZjsWw7+i+fkm
 DiHLQE4UXnpCUsrpMJX8jkXlwuNZjbBAuM9LsZ7d+IkERt5bantqoEFV1tgLCj3X+Z5i
 MlO1xmdAWBR64SnhaYlmDO4GUIJ13jOARvWUn4AlNa1HU2wpMary0zq2z6xyw90wYHrm
 AhUV2HjnOh4p/dS8IkKu+HRnoqDkXyVOgrdL7YSIiM4D1nh27y97MUVmKMQcHGSnvGFv qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qd97enagy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Feb 2019 14:10:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x14EAEoA025591
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Feb 2019 14:10:14 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x14EACST021055;
 Mon, 4 Feb 2019 14:10:12 GMT
Received: from kadam (/197.157.0.20) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 04 Feb 2019 14:10:12 +0000
Date: Mon, 4 Feb 2019 17:10:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Roy Pledge <Roy.Pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] soc: fsl: dpio: Use after free in dpaa2_dpio_remove()
Message-ID: <20190204141005.GA915@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9156
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=959 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902040113
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
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The dpaa2_io_down(priv->io) call frees "priv->io" so I've shifted the
code around a little bit to avoid the use after free.

Fixes: 991e873223e9 ("soc: fsl: dpio: use a cpumask to identify which cpus are unused")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 2d4af32a0dec..a28799b62d53 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -220,12 +220,12 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	dev = &dpio_dev->dev;
 	priv = dev_get_drvdata(dev);
+	cpu = dpaa2_io_get_cpu(priv->io);
 
 	dpaa2_io_down(priv->io);
 
 	dpio_teardown_irqs(dpio_dev);
 
-	cpu = dpaa2_io_get_cpu(priv->io);
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-- 
2.17.1

