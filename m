Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA59C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:43:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EAE20663
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YBnTKNbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bMxh3gszzDqTp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 01:43:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.49; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=roy.pledge@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YBnTKNbB"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60049.outbound.protection.outlook.com [40.107.6.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bMvM4Bt3zDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 01:41:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TIXsyknO/vrmlrqvap11iuJFWe0GSysbAW9tyzzk7I=;
 b=YBnTKNbB5QcMBf1b9yjOJFJgLL90f27mtFNuDZSjS9I3G7nYV28pemwCM0f9DSOcA9+IGQFAaNuTcb7Vd6ISQARXBbGLocmKEd2XvItbspDLRigHrgtTt5qsOMCgK1ONKU7EvYxfhSZHuiGGH2sANhZ5HCGkyIWGd9/5mSzUgQ0=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2870.eurprd04.prod.outlook.com (10.172.248.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 14:41:09 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42%5]) with mapi id 15.20.1750.017; Fri, 5 Apr 2019
 14:41:09 +0000
From: Roy Pledge <roy.pledge@nxp.com>
To: "stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 0/2] soc: fsl: dpio: Add support for memory backed QBMan
 portals
Thread-Topic: [PATCH v2 0/2] soc: fsl: dpio: Add support for memory backed
 QBMan portals
Thread-Index: AQHU672bycR9r5FSNkKRXvfe1VcPhw==
Date: Fri, 5 Apr 2019 14:41:09 +0000
Message-ID: <1554475256-4805-1-git-send-email-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:98::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54bfc088-5bcc-4629-9be3-08d6b9d4bdf7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:DB6PR0402MB2870; 
x-ms-traffictypediagnostic: DB6PR0402MB2870:
x-microsoft-antispam-prvs: <DB6PR0402MB2870D630F9399176A09EDF6986510@DB6PR0402MB2870.eurprd04.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(305945005)(25786009)(44832011)(486006)(66066001)(14454004)(2616005)(478600001)(476003)(110136005)(26005)(6636002)(50226002)(71190400001)(6436002)(86362001)(316002)(4326008)(186003)(5660300002)(54906003)(71200400001)(6506007)(386003)(256004)(36756003)(3846002)(6116002)(6512007)(2906002)(53936002)(97736004)(8936002)(3450700001)(43066004)(6486002)(7736002)(2501003)(81166006)(106356001)(68736007)(105586002)(81156014)(99286004)(52116002)(102836004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2870;
 H:DB6PR0402MB2727.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cet4GOMXmMiKuLbVt6DZ7ITqJLBPnltEOO949+QXIhvHEVZhE9Xzutjy2EZP02oMs/TjVI1KvSalvsR5/5aGFmlPLmtbVgrO+J/V4vFFdvpexNAcMRvfHF1pcgcMlkYGoWP36Pv5wnePzhNQVfdddFA3mX7ZHIjlhosHq79af2Le5RV0saoqHjGRbEnovCoW6wQPGEcUShcPDQbsN6CnAw5X93yhqA/QqrfXd/CYLj8Qa5Yhf/S3mCIZbytaXxQNbx5w5GG8rm6hPY38D+iNTlnsbDTDSzi1vF8VAsRAbXyFNISIJbEKCpQBqnDgF2arqGAG7FUoMu1RflP3eOQYYk3S+2lvrYzlB09alzYdwlu0/B/ut1OsspbDNf52hW/qf0oIKtZgpVMmWxmK/7VVZRGJ49uE1Js5WjwWeeUKq8E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bfc088-5bcc-4629-9be3-08d6b9d4bdf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 14:41:09.5324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2870
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
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Cc: Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series adds support for QBMan memory backed portals which is
avaialble in devices containing QBMan verion 5.0 and above (for example
NXP's LX2160A SoC).

Memory backed portals can be mapped as normal cacheable/shareable memory
which allows the portals to migrate between cores without needing manual
cache manipulations by the CPU.

The patches add support for the new portal attributes in the fsl-mc bus
drivers as well as modifying the QBMan driver to use the new portal read
trigger mechanism.

Changes since v1:
 * Support older DPRC command in case of older MC firmware
 * Fix issue with padding in command


Roy Pledge (2):
  bus: mc-bus: Add support for mapping shareable portals
  soc: fsl: dpio: Add support for memory backed QBMan portals

 drivers/bus/fsl-mc/dprc.c           |  30 +++++++-
 drivers/bus/fsl-mc/fsl-mc-bus.c     |  15 +++-
 drivers/bus/fsl-mc/fsl-mc-private.h |  17 ++++-
 drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
 drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++--=
----
 drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
 6 files changed, 199 insertions(+), 39 deletions(-)

--
2.7.4

