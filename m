Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F06C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:47:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175F0222A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175F0222A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynCg0yTMzDqT1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 00:47:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymw04n4czDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:33:52 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1BDWInY074183
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 08:33:50 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qk6katb5y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 08:33:50 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 11 Feb 2019 13:33:49 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 11 Feb 2019 13:33:46 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1BDXjNe9502730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 13:33:45 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A396B124053;
 Mon, 11 Feb 2019 13:33:45 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01B1F12405A;
 Mon, 11 Feb 2019 13:33:43 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.73.133])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 11 Feb 2019 13:33:43 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Alban Bedel <albeu@free.fr>, linuxppc-dev@lists.ozlabs.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-mtd@lists.infradead.org
Subject: [PATCH v3 2/2] drivers/mtd: Fix device registration error
Date: Mon, 11 Feb 2019 19:03:38 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133338.30399-1-aneesh.kumar@linux.ibm.com>
References: <20190211133338.30399-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021113-0052-0000-0000-00000388877C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010576; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159515; UDB=6.00605100; IPR=6.00940061; 
 MB=3.00025525; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-11 13:33:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021113-0053-0000-0000-00005FCF2394
Message-Id: <20190211133338.30399-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110106
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This change helps me to get multiple mtd device registered. Without this
I get

sysfs: cannot create duplicate filename '/bus/nvmem/devices/flash0'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2-00557-g1ef20ef21f22 #13
Call Trace:
[c0000000b38e3220] [c000000000b58fe4] dump_stack+0xe8/0x164 (unreliable)
[c0000000b38e3270] [c0000000004cf074] sysfs_warn_dup+0x84/0xb0
[c0000000b38e32f0] [c0000000004cf6c4] sysfs_do_create_link_sd.isra.0+0x114/0x150
[c0000000b38e3340] [c000000000726a84] bus_add_device+0x94/0x1e0
[c0000000b38e33c0] [c0000000007218f0] device_add+0x4d0/0x830
[c0000000b38e3480] [c0000000009d54a8] nvmem_register.part.2+0x1c8/0xb30
[c0000000b38e3560] [c000000000834530] mtd_nvmem_add+0x90/0x120
[c0000000b38e3650] [c000000000835bc8] add_mtd_device+0x198/0x4e0
[c0000000b38e36f0] [c00000000083619c] mtd_device_parse_register+0x11c/0x280
[c0000000b38e3780] [c000000000840830] powernv_flash_probe+0x180/0x250
[c0000000b38e3820] [c00000000072c120] platform_drv_probe+0x60/0xf0
[c0000000b38e38a0] [c0000000007283c8] really_probe+0x138/0x4d0
[c0000000b38e3930] [c000000000728acc] driver_probe_device+0x13c/0x1b0
[c0000000b38e39b0] [c000000000728c7c] __driver_attach+0x13c/0x1c0
[c0000000b38e3a30] [c000000000725130] bus_for_each_dev+0xa0/0x120
[c0000000b38e3a90] [c000000000727b2c] driver_attach+0x2c/0x40
[c0000000b38e3ab0] [c0000000007270f8] bus_add_driver+0x228/0x360
[c0000000b38e3b40] [c00000000072a2e0] driver_register+0x90/0x1a0
[c0000000b38e3bb0] [c00000000072c020] __platform_driver_register+0x50/0x70
[c0000000b38e3bd0] [c00000000105c984] powernv_flash_driver_init+0x24/0x38
[c0000000b38e3bf0] [c000000000010904] do_one_initcall+0x84/0x464
[c0000000b38e3cd0] [c000000001004548] kernel_init_freeable+0x530/0x634
[c0000000b38e3db0] [c000000000011154] kernel_init+0x1c/0x168
[c0000000b38e3e20] [c00000000000bed4] ret_from_kernel_thread+0x5c/0x68
mtd mtd1: Failed to register NVMEM device

With the change we now have

root@(none):/sys/bus/nvmem/devices# ls -al
total 0
drwxr-xr-x 2 root root 0 Feb  6 20:49 .
drwxr-xr-x 4 root root 0 Feb  6 20:49 ..
lrwxrwxrwx 1 root root 0 Feb  6 20:49 flash@0 -> ../../../devices/platform/ibm,opal:flash@0/mtd/mtd0/flash@0
lrwxrwxrwx 1 root root 0 Feb  6 20:49 flash@1 -> ../../../devices/platform/ibm,opal:flash@1/mtd/mtd1/flash@1

Fixes: acfe63ec1c59 ("mtd: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/mtd/devices/powernv_flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 22f753e555ac..83f88b8b5d9f 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -212,7 +212,7 @@ static int powernv_flash_set_driver_info(struct device *dev,
 	 * Going to have to check what details I need to set and how to
 	 * get them
 	 */
-	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
+	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_WRITEABLE;
 	mtd->size = size;
-- 
2.20.1

