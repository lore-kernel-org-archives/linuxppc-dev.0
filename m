Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E711C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:38:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E478520844
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jV/Y9knU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E478520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qLwC6mp5zDqTd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 22:38:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.47; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="jV/Y9knU"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150047.outbound.protection.outlook.com [40.107.15.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qLqy11xkzDqTN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 22:34:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TL88tDdhMmXhdJnfw7o2ml8v1NJyE6HHM/Z05C8noE=;
 b=jV/Y9knUvIV9cPR/JhgQGKcKgfkEVIv1kz8fCj3OzvtRRPRQsQi/irOkPYLtTAlNaN7BDaPOD/lDlDsTL7/ppskNmedL52ptBLC+igdvXftmi3s+FGRYTLHJmvkHkrUg1fBXPNfpQqCO7KsvFFNtddtuklVg94b55KkxGN0B1pM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2365.eurprd04.prod.outlook.com (10.169.134.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 11:34:31 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 11:34:31 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 2/2] fsl: add i2c controlled qixis driver
Thread-Topic: [PATCH v2 2/2] fsl: add i2c controlled qixis driver
Thread-Index: AQHUuI/ERBDW6FFeH0Gz/bX0qdGRlQ==
Date: Wed, 30 Jan 2019 11:34:31 +0000
Message-ID: <20190130165916.8628-3-pankaj.bansal@nxp.com>
References: <20190130165916.8628-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190130165916.8628-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27)
 To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2365;
 6:bIl1CdFjBAUkeKg+JJcJDK59RQsey5d5lCMlT8o4UswL8kGn1JoxtvY+WaYDava/lATSLrr/mOYtywVrgN4UXXguAx0X0mRay4LaqHSr0HmxnHbfH5RGLbYx1veWZrp7DXB05WQLVrCMmxwJdMhfmE25ciFWOMk9TGHFtjHvPcQ27KDryoFgdeLot3BqIN90iODOGxjD5eA2/wJsCKknq4VJXbEitak5/t/YRoiGjb5bOEhycpRlBi+ZByVRxrzELIYjGmNg/gHkwjD0gw31r6QCEkZR33IuVfDfW89UYHZp7skmZykgUZpidso3szbRrUyYGOHXUSLZtr4pAL4fl/qcvOa9H+M+gKMSGyy9mHAg9loX0PV4xFCCIHHWJDSmBQUttEpMUdLk5ZtbzjWlE3UDY4LrMgCTimcaN12Ued7oqx/tTM0/L07ZLN5ZxsFzrmn//oR79B81OgcrLJszbA==;
 5:Xo3Hu+CD268CZ6KxiLGL856euGrTgGRgv5OZmRhPanu198/oM3l/OLkTu4kJiIt8IKkY3uu10kld7i8Oc8+9VMoLP7HhzTryN5ztcmFHHqjIpEAUhj3o77fYwEvH8KSxe8BLCHIEmEoRzSmlNdvQ32JXe8C7tw3ncAKwSrZ+DGySCnH6uv6Kx5MjJa5rJeiCP13W0Y1GOLdmIMlg5yQvSg==;
 7:bfGesAX/UA64tfYt0vUBnDzm4/xXDqSGrjRkYcVkOrZJNspQk+/iGgNLh4vJHOzyrhuOUitoJTAjHf3JBk0y+ecgEK06XgtThG5XbG45NYG9pXo71UkyyYTV9G+Wfc1dAxVflsZo1svIGVV4LmSKDw==
x-ms-office365-filtering-correlation-id: bc517950-722c-4b2c-a483-08d686a6e665
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2365; 
x-ms-traffictypediagnostic: VI1PR0401MB2365:
x-microsoft-antispam-prvs: <VI1PR0401MB2365BCCE097098602C5067AAF1900@VI1PR0401MB2365.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(105586002)(478600001)(6862004)(2906002)(68736007)(25786009)(14454004)(86362001)(66066001)(6306002)(6436002)(6486002)(966005)(6512007)(97736004)(106356001)(4326008)(26005)(52116002)(186003)(99286004)(256004)(6506007)(386003)(54906003)(102836004)(486006)(446003)(44832011)(81156014)(7736002)(11346002)(476003)(81166006)(8676002)(2616005)(3846002)(8936002)(76176011)(37006003)(305945005)(6636002)(53936002)(50226002)(1076003)(71200400001)(71190400001)(6116002)(107886003)(36756003)(316002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2365;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f4ZmAAZqXGbc5QfbCB4GcJeFbynwiooZRQPA0mVXzyPBokB40NfHNRXkf8/lnxaQkXfpZRqJqFaEGyBAYZorrdnPJ8d0mjKRF/qLAh+fkFanYJPLJQ13ekhutZxyKAtztkBy6C2jMwVmD/Lon8JhnKWlxqaGxfCxEFi+20DvfCJdAn795U/JP0l1sEKNPHCSOrijTO8kjoyjdkF2II6KA2I+KKbUVplX22ZS0F0VuEsvUeRHVI/t5VHOpjoZG5HkM59PwanQgsc5zJ/UjevMZssxA2XzWLebvX9mLB4n1NV/6l1H0W5FzQ/LiTRpgNvllGAnIjzmXHG3Gbw+eE5fKnTRB7wLD6804rAQ1PTthi5PVzd+5yPOS7gBmVWYfD4fGO8SgB4MQcH1+02mjEiLBXajAYNuxIwKU1mhIEOPrNM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc517950-722c-4b2c-a483-08d686a6e665
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 11:34:29.1680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2365
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
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
driver which is basically an i2c client driver to control FPGA.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    V2:
    - Modify the driver to not create platform devices corresponding to sub=
nodes.
      because the subnodes are not actual devices.
    - Use mdio_mux_regmap_init/mdio_mux_regmap_uninit
    - Remove header file from include folder, as no qixis api is called fro=
m outside
    - Add regmap_exit in driver's remove function
    Dendencies:
	- https://www.mail-archive.com/netdev@vger.kernel.org/msg281274.html

 drivers/soc/fsl/Kconfig      |   8 +++
 drivers/soc/fsl/Makefile     |   1 +
 drivers/soc/fsl/qixis_ctrl.c | 121 +++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 8a0ba6da6f8a..e787d3e637a4 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -36,6 +36,14 @@ config FSL_SLEEP_FSM
 	  The FSM is used to finish clean-ups at the last stage of system enterin=
g deep
 	  sleep, and also wakes up system when a wake up event happens.
=20
+config FSL_QIXIS
+	tristate "QIXIS system controller driver"
+	depends on REGMAP_I2C
+	default n
+	help
+	  Say y here to enable QIXIS system controller api. The qixis driver
+	  provides FPGA functions to control system.
+
 if ARM || ARM64
 source "drivers/soc/fsl/Kconfig.arm"
 endif
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index ffdf93b34501..db7b09bfbd91 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_FSL_DPAA)                 +=3D qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/
 obj-$(CONFIG_CPM)			+=3D qe/
+obj-$(CONFIG_FSL_QIXIS) 		+=3D qixis_ctrl.o
 obj-$(CONFIG_FSL_GUTS)			+=3D guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+=3D dpio/
 obj-$(CONFIG_FSL_LS2_CONSOLE)		+=3D ls2-console/
diff --git a/drivers/soc/fsl/qixis_ctrl.c b/drivers/soc/fsl/qixis_ctrl.c
new file mode 100644
index 000000000000..336f366e228e
--- /dev/null
+++ b/drivers/soc/fsl/qixis_ctrl.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/* Freescale QIXIS system controller driver.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mdio-mux.h>
+
+/* QIXIS MAP */
+struct fsl_qixis_regs {
+	u8		id;		/* Identification Registers */
+	u8		version;	/* Version Register */
+	u8		qixis_ver;	/* QIXIS Version Register */
+	u8		reserved1[0x1f];
+};
+
+struct mdio_mux_data {
+	void			*data;
+	struct list_head	link;
+};
+
+struct qixis_priv {
+	struct regmap		*regmap;
+	struct list_head	mdio_mux_list;
+};
+
+static struct regmap_config qixis_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+};
+
+static int fsl_qixis_i2c_probe(struct i2c_client *client)
+{
+	struct device_node *child;
+	struct qixis_priv *priv;
+	int ret;
+	u32 qver;
+	struct mdio_mux_data *mux_data;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	priv =3D devm_kzalloc(&client->dev, sizeof(struct qixis_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap =3D regmap_init_i2c(client, &qixis_regmap_config);
+	INIT_LIST_HEAD(&priv->mdio_mux_list);
+
+	regmap_read(priv->regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
+		    &qver);
+	pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
+
+	for_each_child_of_node(client->dev.of_node, child) {
+		if (of_node_name_prefix(child, "mdio-mux")) {
+			mux_data =3D devm_kzalloc(&client->dev,
+						sizeof(struct mdio_mux_data),
+						GFP_KERNEL);
+			if (!mux_data)
+				return -ENOMEM;
+			ret =3D mdio_mux_regmap_init(&client->dev, child,
+						   &mux_data->data);
+			if (ret)
+				return ret;
+			list_add(&mux_data->link, &priv->mdio_mux_list);
+		}
+	};
+
+	i2c_set_clientdata(client, priv);
+
+	return 0;
+}
+
+static int fsl_qixis_i2c_remove(struct i2c_client *client)
+{
+	struct qixis_priv *priv;
+	struct list_head *pos;
+	struct mdio_mux_data *mux_data;
+
+	priv =3D i2c_get_clientdata(client);
+	list_for_each(pos, &priv->mdio_mux_list) {
+		mux_data =3D list_entry(pos, struct mdio_mux_data, link);
+		mdio_mux_regmap_uninit(mux_data->data);
+	}
+	regmap_exit(priv->regmap);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_qixis_of_match[] =3D {
+	{ .compatible =3D "fsl,fpga-qixis-i2c" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_qixis_of_match);
+
+static struct i2c_driver fsl_qixis_i2c_driver =3D {
+	.driver =3D {
+		.name	=3D "qixis_ctrl",
+		.owner	=3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(fsl_qixis_of_match),
+	},
+	.probe_new	=3D fsl_qixis_i2c_probe,
+	.remove		=3D fsl_qixis_i2c_remove,
+};
+module_i2c_driver(fsl_qixis_i2c_driver);
+
+MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
+MODULE_DESCRIPTION("Freescale QIXIS system controller driver");
+MODULE_LICENSE("GPL v2");
--=20
2.17.1

