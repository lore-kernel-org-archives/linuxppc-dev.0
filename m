Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D7C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 05:14:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CE1206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 05:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O2C92bNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CE1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dM865kHgzDqRD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 16:13:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe06::607;
 helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=bharat.bhushan@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="O2C92bNB"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe06::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dM6922cqzDqRC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 16:12:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfp5DM7bQiq35wf+mlByfZd52IzYVeJWWPblxgYPipY=;
 b=O2C92bNBpJqVps4exj3fPrp4ctDfhLJNESOGNdy+qsn38ZGtqIc3mb1OYqRFHUZNIYPz3KbSHx/X9IeBgOV/hPhLEmB+27eLBCJL69msK9scAIGFBTpfOna5L0Uo1YZP5CYVFlFSLKrIgzGfGIx+jokYMgBNRyrlj7cXxkH/4Ts=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB5038.eurprd04.prod.outlook.com (20.177.50.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 05:12:08 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::a13c:ebf5:6fb5:8c7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::a13c:ebf5:6fb5:8c7%2]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 05:12:08 +0000
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: fsl: dpio: fix cpu range check
Thread-Topic: [PATCH] soc: fsl: dpio: fix cpu range check
Thread-Index: AQHUq8eyjXksS82nRkmGUg0ZzKV3Dg==
Date: Mon, 14 Jan 2019 05:12:08 +0000
Message-ID: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: BM1PR01CA0113.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::29)
 To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:54::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5038;
 6:P5k3tMpxjjKRh2dMyMWtcXYTbE4kwPt6dyx20s7V6VKOapOx3nIuF+uMUAme6D6rU05UDIBQFj5GTPNUKsf3O7c1QRPmPjca70nU4HEmuFzUv2iDs1H6Tw2/K4aipKaHtY9ksgSFZoQntN4C+Nn5FnD3/V8AR1lEKneiix6JjFkrW61WOl8qrtK5iacDXI7p8td0zfZPWjrKkCkVPRdh5WC7I7Z5/eo+KFeNl9n7OBg7tahYP+QgeH8cZQNb4hOUeXveAyrk9bTIfXdVjGfqoBfmQKDDtpsjebnjxvaR5LC808uAiNXy/j7ohPRErAVuJkaJ54i55szu4/Dl4OSMtq163I7xnZ9dxhWa+EOStFCi2LNmYE/6Wx2WFWx54eilgDWAq+WfP8ZMaQgsXKF4BzYJNdDXi+6OM0EtDRGwZLjIjjo+Pb/1WMZOmQbmHXRNRo5noTBCYWPsF4ONGUkLqA==;
 5:XccgK3V1u04zieokYIPCDKi6dkeYV8QIVU9KOOmgKG65wA7D9W4lrlwS7XOGLGe654nv7KavHOQnljIJEsB2vxC47CPbLHmcf419paXE0t2zN7qmwqI8C3W6i1bBrv+M/NrhAMTTuQT5E9Z0g6/zB8jRne8O+aQHW57uP9EPKDJEwgKqHOzPhPxJMcjrSIjANycwz/BYScJgezmZLVxiaQ==;
 7:vMQf+XMF8Ge5RQXUwkHl054qMCOIU7zfSr6vyntatNq7HIQwS3FwLzflOA0yp2IvTIc2qy72eLCrBqmG+pOvIfsHvsjB/bgoxfpUtROatjhXr/rQH2SNyxcIU1C8D1EumUCALeJ2OMR5PqF55AFUiA==
x-ms-office365-filtering-correlation-id: 61a4e7e0-58fa-420e-b5f2-08d679ded4b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5038; 
x-ms-traffictypediagnostic: VI1PR04MB5038:
x-microsoft-antispam-prvs: <VI1PR04MB50386E95ED5CE89607AA35DB9A800@VI1PR04MB5038.eurprd04.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(71200400001)(53936002)(14444005)(305945005)(6486002)(6436002)(4326008)(71190400001)(256004)(99286004)(4744005)(97736004)(7736002)(476003)(2616005)(486006)(50226002)(1076003)(78486014)(478600001)(8936002)(6512007)(81156014)(81166006)(8676002)(110136005)(6506007)(386003)(316002)(52116002)(2201001)(575784001)(86362001)(54906003)(3846002)(6116002)(2501003)(105586002)(2906002)(36756003)(14454004)(66066001)(39060400002)(26005)(55236004)(5660300001)(68736007)(102836004)(106356001)(186003)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5038;
 H:VI1PR04MB4845.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t1R0p6LJwFAXtLr2boopCsYeEfvifzRlIviTfmCxpv2a4U8ciObV9kPJHbXKJ0aAbBM/YaJD1N7BF6oC1JCKqqXrNlTtwsYhuu+AbXehoTJSTBf+ZYuQnMN6+87CluCLIM/SL43k50WsCqwfSADNcbeprhdNCXf6X2g1yLykoGOcvOZdK6hmeMDB5MjNPwjCVXeE4/9mJ/fi0Be9wXrC8M/MvNzJDEMZaCBhKmjC0ZeJDK6LE4eBNQjm8V4PTGLiYZUAfl/HmfvM4tPFuwqvxbx4sKCUMx7SZYtBbZ0etM+MHj9gN1GGESiNp7jlpE6uTRf94UjzY2NwD8EwiUEzjW8O769uZjPuh9B2v2kHopNrQs9Ybw7F+uE97rydJv0fYSL2KFHdFrld1Bwcr7u6fyW5TmsHEC9hXKZvkHSugao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a4e7e0-58fa-420e-b5f2-08d679ded4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 05:12:06.3023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5038
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
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>,
 "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

cpu_possible(cpu) will always return true when cpu parameter
is from cpumask_next().
Check for nr_cpu_ids rather than !cpu_possible(cpu).

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index e58fcc9096e8..eb369dd9e0a7 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -133,7 +133,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_=
dev)
 	else
 		next_cpu =3D cpumask_next(next_cpu, cpu_online_mask);
=20
-	if (!cpu_possible(next_cpu)) {
+	if (next_cpu >=3D nr_cpu_ids) {
 		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
 		err =3D -ERANGE;
 		goto err_allocate_irqs;
--=20
2.20.1

