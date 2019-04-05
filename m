Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC39C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B3A21726
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3qF148X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B3A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bMzb35DVzDqTC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 01:44:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.66; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=roy.pledge@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="g3qF148X"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30066.outbound.protection.outlook.com [40.107.3.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bMvM4ZJmzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 01:41:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOORwFQGb0vGNffnfDJOVZCKe5E0DYow7+AXqIO52Uc=;
 b=g3qF148X2R6addIjp3Njq4smUk28OLvQmkGX1EFyblr+vxskxnA6KNJaNJ2/SKi0qOWKAemamOe4g0OiKPF9dgpP/BBIk14HH8QrE0rh0JTPQFt29xuompTW/arcbDW+cnAUIL/uH50ExcmS5RiHeFYhQdeb8yf4egeQfVJwLqU=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2805.eurprd04.prod.outlook.com (10.172.245.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 5 Apr 2019 14:41:13 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::18a2:3eae:e7c:4d42%5]) with mapi id 15.20.1750.017; Fri, 5 Apr 2019
 14:41:13 +0000
From: Roy Pledge <roy.pledge@nxp.com>
To: "stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 2/2] soc: fsl: dpio: Add support for memory backed QBMan
 portals
Thread-Topic: [PATCH v2 2/2] soc: fsl: dpio: Add support for memory backed
 QBMan portals
Thread-Index: AQHU672eH0D2CAY4hEeEeNwpO/nZAw==
Date: Fri, 5 Apr 2019 14:41:13 +0000
Message-ID: <1554475256-4805-3-git-send-email-roy.pledge@nxp.com>
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
x-ms-office365-filtering-correlation-id: 78aee7cc-bc2d-456d-6612-08d6b9d4c04e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB6PR0402MB2805; 
x-ms-traffictypediagnostic: DB6PR0402MB2805:
x-microsoft-antispam-prvs: <DB6PR0402MB280562E509101709BB00384686510@DB6PR0402MB2805.eurprd04.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(486006)(105586002)(54906003)(386003)(11346002)(110136005)(52116002)(6116002)(14454004)(66066001)(102836004)(7736002)(97736004)(476003)(2501003)(2616005)(36756003)(71200400001)(71190400001)(8676002)(86362001)(53936002)(6436002)(50226002)(25786009)(316002)(68736007)(6636002)(6486002)(3846002)(81156014)(446003)(76176011)(106356001)(305945005)(4326008)(26005)(43066004)(2906002)(256004)(44832011)(6512007)(14444005)(186003)(30864003)(3450700001)(478600001)(6506007)(99286004)(5660300002)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2805;
 H:DB6PR0402MB2727.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sDc+daXZ/xnrHVNugWeF9i7rhYLNyqh+RGbq0oMAAljwNNO/bQcXT6UQOBPuWZ0nGNIBqS0hwDLZTrfzx2WT8/qWAM5k/4bnSQFvaCwaxFO8uD/Iu/CDqTN3aNXs4k261/b+gB2UW6qM8FspDt243XYIunxWtqQDqjTZc8JTZ5yHoFi17yYz+2H8zgvSvSNrqOtECmHAUb2R5fQPLgGIhBX4vXMnmbR07Q6uhkDPEMbOyvWpfkXYuehKbrOeRAbSlPvjyfXHPxksuODG65LNJxeQb1FhoyexHHlmV4fqSOH5I3ZqrFlvkufZZcbAJhtZab0QAJdvh31+LknVGpO/n5jHIpW4Wt9WGITBpWgW9IhY9kIIK+tSFXsC9OFTr/Amtnu9X//mdyxrldYfKUef7EQqR42P4lsY+xSJsHGKbUc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aee7cc-bc2d-456d-6612-08d6b9d4c04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 14:41:13.3395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2805
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
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Youri Querry <youri.querry_1@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

NXP devices with QBMan version 5 and above can enable software
portals that are memory backed. This allows the portal to be
mapped as cacheable/sharable (same as all normal memory) so
that portals can freely migrate between cores and clusters
in the SoC. The driver will enable this mode by default when
appropriate HW support is detected.

Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
 drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++--=
----
 drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
 3 files changed, 144 insertions(+), 32 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index c0cdc89..70014ec 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -197,13 +197,22 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpi=
o_dev)
 				desc.cpu);
 	}
=20
-	/*
-	 * Set the CENA regs to be the cache inhibited area of the portal to
-	 * avoid coherency issues if a user migrates to another core.
-	 */
-	desc.regs_cena =3D devm_memremap(dev, dpio_dev->regions[1].start,
-				       resource_size(&dpio_dev->regions[1]),
-				       MEMREMAP_WC);
+	if (dpio_dev->obj_desc.region_count < 3) {
+		/* No support for DDR backed portals, use classic mapping */
+		/*
+		 * Set the CENA regs to be the cache inhibited area of the
+		 * portal to avoid coherency issues if a user migrates to
+		 * another core.
+		 */
+		desc.regs_cena =3D devm_memremap(dev, dpio_dev->regions[1].start,
+					resource_size(&dpio_dev->regions[1]),
+					MEMREMAP_WC);
+	} else {
+		desc.regs_cena =3D devm_memremap(dev, dpio_dev->regions[2].start,
+					resource_size(&dpio_dev->regions[2]),
+					MEMREMAP_WB);
+	}
+
 	if (IS_ERR(desc.regs_cena)) {
 		dev_err(dev, "devm_memremap failed\n");
 		err =3D PTR_ERR(desc.regs_cena);
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbm=
an-portal.c
index d020135..c66f5b7 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -15,6 +15,8 @@
 #define QMAN_REV_4000   0x04000000
 #define QMAN_REV_4100   0x04010000
 #define QMAN_REV_4101   0x04010001
+#define QMAN_REV_5000   0x05000000
+
 #define QMAN_REV_MASK   0xffff0000
=20
 /* All QBMan command and result structures use this "valid bit" encoding *=
/
@@ -25,10 +27,17 @@
 #define QBMAN_WQCHAN_CONFIGURE 0x46
=20
 /* CINH register offsets */
+#define QBMAN_CINH_SWP_EQCR_PI      0x800
 #define QBMAN_CINH_SWP_EQAR    0x8c0
+#define QBMAN_CINH_SWP_CR_RT        0x900
+#define QBMAN_CINH_SWP_VDQCR_RT     0x940
+#define QBMAN_CINH_SWP_EQCR_AM_RT   0x980
+#define QBMAN_CINH_SWP_RCR_AM_RT    0x9c0
 #define QBMAN_CINH_SWP_DQPI    0xa00
 #define QBMAN_CINH_SWP_DCAP    0xac0
 #define QBMAN_CINH_SWP_SDQCR   0xb00
+#define QBMAN_CINH_SWP_EQCR_AM_RT2  0xb40
+#define QBMAN_CINH_SWP_RCR_PI       0xc00
 #define QBMAN_CINH_SWP_RAR     0xcc0
 #define QBMAN_CINH_SWP_ISR     0xe00
 #define QBMAN_CINH_SWP_IER     0xe40
@@ -43,6 +52,13 @@
 #define QBMAN_CENA_SWP_RR(vb)  (0x700 + ((u32)(vb) >> 1))
 #define QBMAN_CENA_SWP_VDQCR   0x780
=20
+/* CENA register offsets in memory-backed mode */
+#define QBMAN_CENA_SWP_DQRR_MEM(n)  (0x800 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_RCR_MEM(n)   (0x1400 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_CR_MEM       0x1600
+#define QBMAN_CENA_SWP_RR_MEM       0x1680
+#define QBMAN_CENA_SWP_VDQCR_MEM    0x1780
+
 /* Reverse mapping of QBMAN_CENA_SWP_DQRR() */
 #define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)(p) & 0x1ff) >> 6)
=20
@@ -96,10 +112,13 @@ static inline void *qbman_get_cmd(struct qbman_swp *p,=
 u32 offset)
=20
 #define SWP_CFG_DQRR_MF_SHIFT 20
 #define SWP_CFG_EST_SHIFT     16
+#define SWP_CFG_CPBS_SHIFT    15
 #define SWP_CFG_WN_SHIFT      14
 #define SWP_CFG_RPM_SHIFT     12
 #define SWP_CFG_DCM_SHIFT     10
 #define SWP_CFG_EPM_SHIFT     8
+#define SWP_CFG_VPM_SHIFT     7
+#define SWP_CFG_CPM_SHIFT     6
 #define SWP_CFG_SD_SHIFT      5
 #define SWP_CFG_SP_SHIFT      4
 #define SWP_CFG_SE_SHIFT      3
@@ -125,6 +144,8 @@ static inline u32 qbman_set_swp_cfg(u8 max_fill, u8 wn,=
	u8 est, u8 rpm, u8 dcm,
 		ep << SWP_CFG_EP_SHIFT);
 }
=20
+#define QMAN_RT_MODE	   0x00000100
+
 /**
  * qbman_swp_init() - Create a functional object representing the given
  *                    QBMan portal descriptor.
@@ -146,6 +167,8 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp=
_desc *d)
 	p->sdq |=3D qbman_sdqcr_dct_prio_ics << QB_SDQCR_DCT_SHIFT;
 	p->sdq |=3D qbman_sdqcr_fc_up_to_3 << QB_SDQCR_FC_SHIFT;
 	p->sdq |=3D QMAN_SDQCR_TOKEN << QB_SDQCR_TOK_SHIFT;
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000)
+		p->mr.valid_bit =3D QB_VALID_BIT;
=20
 	atomic_set(&p->vdq.available, 1);
 	p->vdq.valid_bit =3D QB_VALID_BIT;
@@ -163,6 +186,9 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp=
_desc *d)
 	p->addr_cena =3D d->cena_bar;
 	p->addr_cinh =3D d->cinh_bar;
=20
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000)
+		memset(p->addr_cena, 0, 64 * 1024);
+
 	reg =3D qbman_set_swp_cfg(p->dqrr.dqrr_size,
 				1, /* Writes Non-cacheable */
 				0, /* EQCR_CI stashing threshold */
@@ -175,6 +201,10 @@ struct qbman_swp *qbman_swp_init(const struct qbman_sw=
p_desc *d)
 				1, /* dequeue stashing priority =3D=3D TRUE */
 				0, /* dequeue stashing enable =3D=3D FALSE */
 				0); /* EQCR_CI stashing priority =3D=3D FALSE */
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000)
+		reg |=3D 1 << SWP_CFG_CPBS_SHIFT | /* memory-backed mode */
+		       1 << SWP_CFG_VPM_SHIFT |  /* VDQCR read triggered mode */
+		       1 << SWP_CFG_CPM_SHIFT;   /* CR read triggered mode */
=20
 	qbman_write_register(p, QBMAN_CINH_SWP_CFG, reg);
 	reg =3D qbman_read_register(p, QBMAN_CINH_SWP_CFG);
@@ -184,6 +214,10 @@ struct qbman_swp *qbman_swp_init(const struct qbman_sw=
p_desc *d)
 		return NULL;
 	}
=20
+	if ((p->desc->qman_version & QMAN_REV_MASK) >=3D QMAN_REV_5000) {
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_PI, QMAN_RT_MODE);
+		qbman_write_register(p, QBMAN_CINH_SWP_RCR_PI, QMAN_RT_MODE);
+	}
 	/*
 	 * SDQCR needs to be initialized to 0 when no channels are
 	 * being dequeued from or else the QMan HW will indicate an
@@ -278,7 +312,10 @@ void qbman_swp_interrupt_set_inhibit(struct qbman_swp =
*p, int inhibit)
  */
 void *qbman_swp_mc_start(struct qbman_swp *p)
 {
-	return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+	else
+		return qbman_get_cmd(p, QBMAN_CENA_SWP_CR_MEM);
 }
=20
 /*
@@ -289,8 +326,14 @@ void qbman_swp_mc_submit(struct qbman_swp *p, void *cm=
d, u8 cmd_verb)
 {
 	u8 *v =3D cmd;
=20
-	dma_wmb();
-	*v =3D cmd_verb | p->mc.valid_bit;
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		dma_wmb();
+		*v =3D cmd_verb | p->mc.valid_bit;
+	} else {
+		*v =3D cmd_verb | p->mc.valid_bit;
+		dma_wmb();
+		qbman_write_register(p, QBMAN_CINH_SWP_CR_RT, QMAN_RT_MODE);
+	}
 }
=20
 /*
@@ -301,13 +344,27 @@ void *qbman_swp_mc_result(struct qbman_swp *p)
 {
 	u32 *ret, verb;
=20
-	ret =3D qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		ret =3D qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+		/* Remove the valid-bit - command completed if the rest
+		 * is non-zero.
+		 */
+		verb =3D ret[0] & ~QB_VALID_BIT;
+		if (!verb)
+			return NULL;
+		p->mc.valid_bit ^=3D QB_VALID_BIT;
+	} else {
+		ret =3D qbman_get_cmd(p, QBMAN_CENA_SWP_RR_MEM);
+		/* Command completed if the valid bit is toggled */
+		if (p->mr.valid_bit !=3D (ret[0] & QB_VALID_BIT))
+			return NULL;
+		/* Command completed if the rest is non-zero */
+		verb =3D ret[0] & ~QB_VALID_BIT;
+		if (!verb)
+			return NULL;
+		p->mr.valid_bit ^=3D QB_VALID_BIT;
+	}
=20
-	/* Remove the valid-bit - command completed if the rest is non-zero */
-	verb =3D ret[0] & ~QB_VALID_BIT;
-	if (!verb)
-		return NULL;
-	p->mc.valid_bit ^=3D QB_VALID_BIT;
 	return ret;
 }
=20
@@ -384,6 +441,18 @@ void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32=
 qdid,
 #define EQAR_VB(eqar)      ((eqar) & 0x80)
 #define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
=20
+static inline void qbman_write_eqcr_am_rt_register(struct qbman_swp *p,
+						   u8 idx)
+{
+	if (idx < 16)
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT + idx * 4,
+				     QMAN_RT_MODE);
+	else
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT2 +
+				     (idx - 16) * 4,
+				     QMAN_RT_MODE);
+}
+
 /**
  * qbman_swp_enqueue() - Issue an enqueue command
  * @s:  the software portal used for enqueue
@@ -408,9 +477,15 @@ int qbman_swp_enqueue(struct qbman_swp *s, const struc=
t qbman_eq_desc *d,
 	memcpy(&p->dca, &d->dca, 31);
 	memcpy(&p->fd, fd, sizeof(*fd));
=20
-	/* Set the verb byte, have to substitute in the valid-bit */
-	dma_wmb();
-	p->verb =3D d->verb | EQAR_VB(eqar);
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		/* Set the verb byte, have to substitute in the valid-bit */
+		dma_wmb();
+		p->verb =3D d->verb | EQAR_VB(eqar);
+	} else {
+		p->verb =3D d->verb | EQAR_VB(eqar);
+		dma_wmb();
+		qbman_write_eqcr_am_rt_register(s, EQAR_IDX(eqar));
+	}
=20
 	return 0;
 }
@@ -587,17 +662,27 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_=
pull_desc *d)
 		return -EBUSY;
 	}
 	s->vdq.storage =3D (void *)(uintptr_t)d->rsp_addr_virt;
-	p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	else
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR_MEM);
 	p->numf =3D d->numf;
 	p->tok =3D QMAN_DQ_TOKEN_VALID;
 	p->dq_src =3D d->dq_src;
 	p->rsp_addr =3D d->rsp_addr;
 	p->rsp_addr_virt =3D d->rsp_addr_virt;
-	dma_wmb();
=20
-	/* Set the verb byte, have to substitute in the valid-bit */
-	p->verb =3D d->verb | s->vdq.valid_bit;
-	s->vdq.valid_bit ^=3D QB_VALID_BIT;
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		dma_wmb();
+		/* Set the verb byte, have to substitute in the valid-bit */
+		p->verb =3D d->verb | s->vdq.valid_bit;
+		s->vdq.valid_bit ^=3D QB_VALID_BIT;
+	} else {
+		p->verb =3D d->verb | s->vdq.valid_bit;
+		s->vdq.valid_bit ^=3D QB_VALID_BIT;
+		dma_wmb();
+		qbman_write_register(s, QBMAN_CINH_SWP_VDQCR_RT, QMAN_RT_MODE);
+	}
=20
 	return 0;
 }
@@ -655,7 +740,10 @@ const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbma=
n_swp *s)
 				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
 	}
=20
-	p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	else
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR_MEM(s->dqrr.next_idx));
 	verb =3D p->dq.verb;
=20
 	/*
@@ -807,18 +895,28 @@ int qbman_swp_release(struct qbman_swp *s, const stru=
ct qbman_release_desc *d,
 		return -EBUSY;
=20
 	/* Start the release command */
-	p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	else
+		p =3D qbman_get_cmd(s, QBMAN_CENA_SWP_RCR_MEM(RAR_IDX(rar)));
 	/* Copy the caller's buffer pointers to the command */
 	for (i =3D 0; i < num_buffers; i++)
 		p->buf[i] =3D cpu_to_le64(buffers[i]);
 	p->bpid =3D d->bpid;
=20
-	/*
-	 * Set the verb byte, have to substitute in the valid-bit and the number
-	 * of buffers.
-	 */
-	dma_wmb();
-	p->verb =3D d->verb | RAR_VB(rar) | num_buffers;
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		/*
+		 * Set the verb byte, have to substitute in the valid-bit
+		 * and the number of buffers.
+		 */
+		dma_wmb();
+		p->verb =3D d->verb | RAR_VB(rar) | num_buffers;
+	} else {
+		p->verb =3D d->verb | RAR_VB(rar) | num_buffers;
+		dma_wmb();
+		qbman_write_register(s, QBMAN_CINH_SWP_RCR_AM_RT +
+				     RAR_IDX(rar)  * 4, QMAN_RT_MODE);
+	}
=20
 	return 0;
 }
diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbm=
an-portal.h
index fa35fc1..78c700e 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -110,6 +110,11 @@ struct qbman_swp {
 		u32 valid_bit; /* 0x00 or 0x80 */
 	} mc;
=20
+	/* Management response */
+	struct {
+		u32 valid_bit; /* 0x00 or 0x80 */
+	} mr;
+
 	/* Push dequeues */
 	u32 sdq;
=20
--=20
2.7.4

