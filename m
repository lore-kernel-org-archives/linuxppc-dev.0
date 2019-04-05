Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:46:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDE621726
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzBNayWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDE621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bN1V3qVgzDqV2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 01:46:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.49; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=roy.pledge@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="LzBNayWx"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60049.outbound.protection.outlook.com [40.107.6.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bMvQ5WZTzDqTx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 01:41:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bIURHQl2kRsIRoLN6ISvHEF/xRK1mnWVDForKcrGME=;
 b=LzBNayWxPvT+ioeSw/sVIOpWcOO6U188HCB8p4pLTF+AJE6pnF/nACajRL5mURajh13F6esJbxiNnZDBiuWNoSmMI3EMDSb8yEdTdiBpw53LKr8FU+XqFFBWiRkY6SpbEq3llEV16iIvl29StZedZ3rPO7N8gh2UFGuNtoYGMd4=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2870.eurprd04.prod.outlook.com (10.172.248.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 14:41:11 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42%5]) with mapi id 15.20.1750.017; Fri, 5 Apr 2019
 14:41:11 +0000
From: Roy Pledge <roy.pledge@nxp.com>
To: "stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 1/2] bus: mc-bus: Add support for mapping shareable portals
Thread-Topic: [PATCH v2 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Index: AQHU672cmaLY5f5uKUqtMFuQfHjSxQ==
Date: Fri, 5 Apr 2019 14:41:11 +0000
Message-ID: <1554475256-4805-2-git-send-email-roy.pledge@nxp.com>
References: <1554475256-4805-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1554475256-4805-1-git-send-email-roy.pledge@nxp.com>
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
x-ms-office365-filtering-correlation-id: a3733e95-7535-4582-54d0-08d6b9d4bf20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:DB6PR0402MB2870; 
x-ms-traffictypediagnostic: DB6PR0402MB2870:
x-microsoft-antispam-prvs: <DB6PR0402MB2870B92FB96F2C8B2930D8AC86510@DB6PR0402MB2870.eurprd04.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(305945005)(25786009)(44832011)(446003)(486006)(11346002)(66066001)(14454004)(2616005)(478600001)(476003)(110136005)(26005)(6636002)(50226002)(71190400001)(6436002)(86362001)(316002)(4326008)(186003)(5660300002)(54906003)(71200400001)(6506007)(386003)(256004)(14444005)(36756003)(3846002)(6116002)(6512007)(2906002)(53936002)(76176011)(97736004)(8936002)(3450700001)(43066004)(6486002)(7736002)(2501003)(81166006)(106356001)(68736007)(105586002)(81156014)(99286004)(52116002)(102836004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2870;
 H:DB6PR0402MB2727.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aUKexKAA/14MJ3gvyjiLIhAdON1Xb5qryzSE5v84r3XDz3tOR4zyo8M/hifB26xCL8LMiAPf0MPyVeQ1RX/rQFMwv49vnTyhwcZUzjjsIuh+O9GYPks42RO9t3+TpMti3sxgv1l4qY8BfGl/1AOKEWNeucxCBOJXeMvJby3ggG0rpQ1y1WcxCO27bnm6IC43wl16/GsjrKwbxPcOhyu6+nopw57eItbW10QKNkaUWAZ/VgMM6tfmRwj6cxtlBiOpRHaD4rD1oIsfDQSqIZJkXZ36qPqVPsrbTXK3SOs3taUftbxd1pTxsbi9QISTYqPOyHNfDt5bbwRX1MXazGwUp+hFORsj3ukJsEaP7BpswFAbUNO2UtwgbRyoKnIAOvuuFUsIK8h7bwG4GsBvErpbzp6lhvEn9umuzsebhC+MRe8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3733e95-7535-4582-54d0-08d6b9d4bf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 14:41:11.3689 (UTC)
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

Starting with v5 of NXP QBMan devices the hardware supports using
regular cacheable/shareable memory as the backing store for the
portals.

This patch adds support for the new portal mode by switching to
use the DPRC get object region v2 command which returns both
a base address and offset for the portal memory. The new portal
region is identified as shareable through the addition of a new
flag.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           | 30 +++++++++++++++++++++++++++---
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 15 +++++++++++++--
 drivers/bus/fsl-mc/fsl-mc-private.h | 17 +++++++++++++++--
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 1c3f621..0fe3f52 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -443,11 +443,31 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	struct fsl_mc_command cmd =3D { 0 };
 	struct dprc_cmd_get_obj_region *cmd_params;
 	struct dprc_rsp_get_obj_region *rsp_params;
+	u16 major_ver, minor_ver;
 	int err;
=20
 	/* prepare command */
-	cmd.header =3D mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
-					  cmd_flags, token);
+	err =3D dprc_get_api_version(mc_io, 0,
+				     &major_ver,
+				     &minor_ver);
+	if (err)
+		return err;
+
+	/**
+	 * MC API version 6.3 introduced a new field to the region
+	 * descriptor: base_address. If the older API is in use then the base
+	 * address is set to zero to indicate it needs to be obtained elsewhere
+	 * (typically the device tree).
+	 */
+	if (major_ver > 6 || (major_ver =3D=3D 6 && minor_ver >=3D 3))
+		cmd.header =3D
+			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
+					     cmd_flags, token);
+	else
+		cmd.header =3D
+			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
+					     cmd_flags, token);
+
 	cmd_params =3D (struct dprc_cmd_get_obj_region *)cmd.params;
 	cmd_params->obj_id =3D cpu_to_le32(obj_id);
 	cmd_params->region_index =3D region_index;
@@ -461,8 +481,12 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
=20
 	/* retrieve response parameters */
 	rsp_params =3D (struct dprc_rsp_get_obj_region *)cmd.params;
-	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_addr);
+	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_offset);
 	region_desc->size =3D le32_to_cpu(rsp_params->size);
+	if (major_ver > 6 || (major_ver =3D=3D 6 && minor_ver >=3D 3))
+		region_desc->base_address =3D le64_to_cpu(rsp_params->base_addr);
+	else
+		region_desc->base_address =3D 0;
=20
 	return 0;
 }
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bu=
s.c
index f0404c6..5c9bf2e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -487,10 +487,19 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_=
mc_device *mc_dev,
 				"dprc_get_obj_region() failed: %d\n", error);
 			goto error_cleanup_regions;
 		}
-
-		error =3D translate_mc_addr(mc_dev, mc_region_type,
+		/*
+		 * Older MC only returned region offset and no base address
+		 * If base address is in the region_desc use it otherwise
+		 * revert to old mechanism
+		 */
+		if (region_desc.base_address)
+			regions[i].start =3D region_desc.base_address +
+						region_desc.base_offset;
+		else
+			error =3D translate_mc_addr(mc_dev, mc_region_type,
 					  region_desc.base_offset,
 					  &regions[i].start);
+
 		if (error < 0) {
 			dev_err(parent_dev,
 				"Invalid MC offset: %#x (for %s.%d\'s region %d)\n",
@@ -504,6 +513,8 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc=
_device *mc_dev,
 		regions[i].flags =3D IORESOURCE_IO;
 		if (region_desc.flags & DPRC_REGION_CACHEABLE)
 			regions[i].flags |=3D IORESOURCE_CACHEABLE;
+		if (region_desc.flags & DPRC_REGION_SHAREABLE)
+			regions[i].flags |=3D IORESOURCE_MEM;
 	}
=20
 	mc_dev->regions =3D regions;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-m=
c-private.h
index ea11b4f..020fcc0 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -79,9 +79,11 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
=20
 /* DPRC command versioning */
 #define DPRC_CMD_BASE_VERSION			1
+#define DPRC_CMD_2ND_VERSION			2
 #define DPRC_CMD_ID_OFFSET			4
=20
 #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION=
)
+#define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VERSI=
ON)
=20
 /* DPRC command IDs */
 #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
@@ -100,6 +102,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 #define DPRC_CMDID_GET_OBJ_COUNT                DPRC_CMD(0x159)
 #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)
 #define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)
+#define DPRC_CMDID_GET_OBJ_REG_V2               DPRC_CMD_V2(0x15E)
 #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)
=20
 struct dprc_cmd_open {
@@ -199,9 +202,16 @@ struct dprc_rsp_get_obj_region {
 	/* response word 0 */
 	__le64 pad;
 	/* response word 1 */
-	__le64 base_addr;
+	__le64 base_offset;
 	/* response word 2 */
 	__le32 size;
+	__le32 pad2;
+	/* response word 3 */
+	__le32 flags;
+	__le32 pad3;
+	/* response word 4 */
+	/* base_addr may be zero if older MC firmware is used */
+	__le64 base_addr;
 };
=20
 struct dprc_cmd_set_obj_irq {
@@ -334,6 +344,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 /* Region flags */
 /* Cacheable - Indicates that region should be mapped as cacheable */
 #define DPRC_REGION_CACHEABLE	0x00000001
+#define DPRC_REGION_SHAREABLE	0x00000002
=20
 /**
  * enum dprc_region_type - Region type
@@ -342,7 +353,8 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
  */
 enum dprc_region_type {
 	DPRC_REGION_TYPE_MC_PORTAL,
-	DPRC_REGION_TYPE_QBMAN_PORTAL
+	DPRC_REGION_TYPE_QBMAN_PORTAL,
+	DPRC_REGION_TYPE_QBMAN_MEM_BACKED_PORTAL
 };
=20
 /**
@@ -360,6 +372,7 @@ struct dprc_region_desc {
 	u32 size;
 	u32 flags;
 	enum dprc_region_type type;
+	u64 base_address;
 };
=20
 int dprc_get_obj_region(struct fsl_mc_io *mc_io,
--=20
2.7.4

