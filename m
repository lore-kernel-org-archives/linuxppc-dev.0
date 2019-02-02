Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27BC282D7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 21:22:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A938B20855
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="srdGZ3qW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A938B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sRkX4fXQzDqD7
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 08:22:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=hotmail.com
 (client-ip=40.92.255.70; helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=yellowriver2010@hotmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="srdGZ3qW"; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-oln040092255070.outbound.protection.outlook.com [40.92.255.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sH5w56PYzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2019 01:53:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBX/b7FDrGDeNymzrl8vXnNgYH6oaUOxZPNd9g1b9To=;
 b=srdGZ3qWs3B2QwnIc/t5KRmUopFR0U8Eyg6VkROckKGRzlvA/nv5fqPb1SJyyjIulfbUC3Sx8USSl4JuS/f8GppK8FWej84aFJAYpQgRknhORmjXGo0fh/Km5HekoI5Qabfw7RVnbUOzOndr9Crn6Q3rwxPOUMGHbsW0s3JyajakGWXfkycocPELr/uT+r1LywEzYC6ObkKWi2Q87APYc6Yt8JZXRjT2k9nUROIAd45sOHc+mPd9kSGuQ1VdU5L9CG1UwTn0ANvHcTdByiKEBzXAqgEAVZNq14xePlf7KJCtzeAqSOrg0DnPY67BkZ3PY9qtoZukF/IZvfFoASaoGg==
Received: from SG2APC01FT042.eop-APC01.prod.protection.outlook.com
 (10.152.250.52) by SG2APC01HT180.eop-APC01.prod.protection.outlook.com
 (10.152.251.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 2 Feb
 2019 14:53:16 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.250.52) by
 SG2APC01FT042.mail.protection.outlook.com (10.152.251.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 2 Feb 2019 14:53:16 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 14:53:16 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: [PATCH] ASoC: fsl-asoc-card: fix object reference leaks in
 fsl_asoc_card_probe
Thread-Topic: [PATCH] ASoC: fsl-asoc-card: fix object reference leaks in
 fsl_asoc_card_probe
Thread-Index: AQHUuwcHc2EgeT3L+EyE3/rHliwXIA==
Date: Sat, 2 Feb 2019 14:53:16 +0000
Message-ID: <HK0PR02MB36342EB29AC03A7BE4EB44B8B2930@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:C79B53D005D6DB53784A0FF9DC5E86CF1185F3D7612F302E8C08DBED10DA9A88;
 UpperCasedChecksum:87473CF4E8A150B30C2FB790DF09E0BF0883E7D04480361A6F1DBB50AFDCB4B1;
 SizeAsReceived:9015; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [CqFvKAlht5upTb62EfTE6mOXSS5xhyWW]
x-microsoft-original-message-id: <1549119027-31919-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SG2APC01HT180;
 6:HCcZszwGYN+FP5u2qetBMt6w4mCG88cGiYwEYnXhMrDWDl6zfKt2Dkr2AZ6HK6sNcF3h/Pi0Cy3ySe5J2k+cvCnEwZCrFLmatc7L9Xu3ruxiFNwKWYVQSPNpae2ZmOdYJb60WWXi0cRACBaRFXxxgF18kb05Wn+cVmhrGlfaPTqKL+QM83YL1gQEkBfQZtKx861v7mkpUgKFT60QSRfQyYUqGN5Ie9NtZ6sQe72JsI6o3WAEoSbG6QOeS4MOJ5PxY3B2MvMX4+Xs7YDy1L52AGUXLCNRbFC6LvYwiq1ZdvnmW/HIQ3oyCWQNrSgdZeD81JdwytyLMP9zjgkH5qvpB7z+bQaX7maI3qv2uz36Ic6oeJMgRJnSI1OkmJyh8kH+VbPbGShzbWCeipUPGdYmdrzb39ysVOJZtStTUVX+R+mEWa4GCiqdQHobB4VJyM4tyFqCyz7xi68BmKBefvhHPQ==;
 5:GtBG4GHfilNocDxYzdA08xH6Xl4rMrrxbMU8ZYMuGcurymXVaVa3TfHTCge2a59ndERw15VvxCkuBN7QRV5iRS5t+NHsFLD4KNWOrAQT1YgC5mfSsSl5eJu7aLavvyOqQ27OrArhRocKd4MmmU4MEaryHqTLZEUmjMYNsvfbOD638cpEozKvmeouMke8BarwRhhM6yXLQAxN/1m/g9WqFA==;
 7:buBRYXWCJteRhZ8+nfeauAw9FRIlbwY4LJ9h5EO0dz3i8L6TYYJrJltrjz27m8FupGaM2QZUYXVE4MVb2Jmr0BJksW3afMnkLVQ0g11l/TYFoM/mIC13IaxXZAvAAbVuKXeXhu6zbwetduTIU60h8g==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 7MJMDUNTCtz4oVbBjKUKY9bzavrGWT4EpeMG9XHo6M2qjnYi4Q/xa8a+4sA2o0OsqNoEde0QPjlq/SpI040ovWp6FgUKqNT4kzTGgXsga66/nH62Znz/eJq4bs+e8r15myuvTOXIYPr7fIMCwn9fitEM8Pizr0hIPUSsI6ktRNIlbMMCoY47Zen/WUQjgY3eH2jpmF4FLuJAPIdyXmmdB3ANRuixFjeOG7v1D363VZ6iWDBHn/0GYpMhfkXbkGA0piZIXD2p4MVoMB5OMX/yi+3VA3wGYEBef0Keu0kF76BefJAkDi/9dvogcu0VmwMOjFKGx9FvPC/l2vinVe1BMg9GH47AmwkQEpgZw6Z5uD7yemQpfFJ1eNES8nMDn8uM0vBLwYPQ0RB541ri5HCl3jisMtMnUUI8CoOGnH/4R9btF053rM66MycUxHwE7wJTzN70SHluAxe5d4ADiL2f67ZSISzfEKY90IEmNZG9IPOFzcGfLYP9DfjDpZGAeww9XLyzI1Nbpr+m5K+ZDFvalmKg70bmxsljYWo4uz0dodmLMfEtEy1oQwEISpdYrMMTaTJ/geoFXDi9v+H2SyAAUDKHr1vyr2LJKKCiXQF4n5zUCaaH2oVyT8wJ8V1cPJZw/BQ+arAvWGLq8ObdHqsbcK3BdT7DFgA0GJuANYQS980nkH2tcpeTrdFzdco2KJcrXcKmgWPksgFYmH8zFO5ELJTLjs1Drmk8wzu3zMUWYAb+kzTk3wvLhQ==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SG2APC01HT180; 
x-ms-traffictypediagnostic: SG2APC01HT180:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SG2APC01HT180; BCL:0; PCL:0; RULEID:; SRVR:SG2APC01HT180; 
x-microsoft-antispam-message-info: LzhMgRVKF3jDSjRzHlIFncw/S/NT6GqxkfT9PVjG+5Bi01gKpmeLE7urjl4uqTWq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a37251-b303-448a-e36f-08d6891e29f5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 14:53:15.8433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT180
X-Mailman-Approved-At: Sun, 03 Feb 2019 08:18:51 +1100
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 wen yang <yellowriver2010@hotmail.com>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Wen
 Yang <yellowriver2010@hotmil.com>, "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Wen Yang <yellowriver2010@hotmil.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 81f2fe2..60f87a0 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -689,6 +689,7 @@ static int fsl_asoc_card_probe(struct platform_device *=
pdev)
 asrc_fail:
 	of_node_put(asrc_np);
 	of_node_put(codec_np);
+	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
=20
--=20
2.7.4

