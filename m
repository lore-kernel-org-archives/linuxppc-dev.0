Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4890AC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 14:42:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B312205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5W6/mXjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B312205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JP4n29GhzDqXB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:42:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5W6/mXjP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=nam05-dm3-obe.outbound.protection.outlook.com
 (client-ip=40.107.73.64; helo=nam05-dm3-obe.outbound.protection.outlook.com;
 envelope-from=thomas.lendacky@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amdcloud.onmicrosoft.com
 header.i=@amdcloud.onmicrosoft.com header.b="5W6/mXjP"; 
 dkim-atps=neutral
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730064.outbound.protection.outlook.com [40.107.73.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JP1W11MSzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 01:39:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozm29GQPMAk3amybCq4gCNvVNYkMAQn3r5adCcyFBIw=;
 b=5W6/mXjPTBizPTTIKlX52yOukNfF4X4JS9WcpDejCGGhx4tnFPEjzdY2AXE90uiUtB+uIjYVou0a1gY9Wghn/uz36aBg73Ecgf+/cRhIPfVPlqp72q4GbRIvIEjsRIpS6lIXwh36uFf6tYb14zD5t+2A9HzVURj5osCDKwWPGE0=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0560.namprd12.prod.outlook.com (10.162.4.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 14:39:18 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:39:17 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [RESEND PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Topic: [RESEND PATCH] kernel/dma/direct: Do not include SME mask in the
 DMA supported check
Thread-Index: AQHUlhZJ5CmG449nwUWjXmZkfFTmrw==
Date: Mon, 17 Dec 2018 14:39:16 +0000
Message-ID: <8e875df2cf082ec6eeaf5e713bf9fa987325308d.1545057470.git.thomas.lendacky@amd.com>
References: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: SN4PR0501CA0077.namprd05.prod.outlook.com
 (2603:10b6:803:22::15) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR12MB0560;
 20:no1sTenOtG11Y0pwCBtojZ6l6gqv0nenW94B8G/QSO3LlDVXlTE5LJXIEzyxvwwwmKcyld9fVWYndSbHpj/YhgPWDfgVycar45lQ1P7V+8PtkyJuCr7h5FdUAqrM4pOfe7aMYIvIf/hZ6lW1EvXnMdUz5p6OBNW7HiAkBUtnZhyquMGn5y+35xBiqpfsnTLW5eO/IMLlka9qL+gRzo7rJwLx45MGLMlmcnH4gGtKFuWcZgXfWckBU2qj7HQWRsn9
x-ms-office365-filtering-correlation-id: b9b291b4-0cd7-4486-1adc-08d6642d5204
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR12MB0560; 
x-ms-traffictypediagnostic: SN1PR12MB0560:
x-microsoft-antispam-prvs: <SN1PR12MB0560EEF895E74C91F0BCB7BDECBC0@SN1PR12MB0560.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR12MB0560; BCL:0; PCL:0; RULEID:; SRVR:SN1PR12MB0560; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(36756003)(6506007)(118296001)(72206003)(97736004)(1730700003)(8676002)(68736007)(14454004)(316002)(81156014)(81166006)(5660300001)(71190400001)(71200400001)(6916009)(8936002)(2351001)(50226002)(54906003)(86362001)(575784001)(486006)(186003)(256004)(14444005)(478600001)(7736002)(25786009)(66066001)(6116002)(106356001)(3846002)(11346002)(446003)(2906002)(53936002)(102836004)(99286004)(6512007)(105586002)(476003)(305945005)(2616005)(2501003)(4326008)(39060400002)(76176011)(52116002)(6486002)(5640700003)(386003)(6436002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB0560;
 H:SN1PR12MB0175.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c8iMMKZ2IdTCnh+9v1ma/lf4Aes0iKVv+HMS9ebKZL6YQHu8rC8b8IIsJ0ZpxEy4ZDHulD817mme2L3P/YFyrXTe9RnqlPv4f6PFCDW4ug8zxoua71oyX8/wh1nUErQVPpBpYru41WIRIapXEPhgZp2WrgbPKIu/9TO10B4oA8BCQSgtAVQd/btZdBI720Y+8N2Q9sv4g9lmI/rLYAF0YD8kFDFFhXYmtAbf61uz+2JUfi4udCL+ECUDXvanhm0NHENDHHvnpx0lBseq0oLZN5mhJplGzBoaL5Bs7+64VTPGtp2ZomaMsVqjWolHtqZs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b291b4-0cd7-4486-1adc-08d6642d5204
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:39:16.8067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0560
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The dma_direct_supported() function intends to check the DMA mask against
specific values. However, the phys_to_dma() function includes the SME
encryption mask, which defeats the intended purpose of the check. This
results in drivers that support less than 48-bit DMA (SME encryption mask
is bit 47) from being able to set the DMA mask successfully when SME is
active, which results in the driver failing to initialize.

Change the function used to check the mask from phys_to_dma() to
__phys_to_dma() so that the SME encryption mask is not part of the check.

Fixes: c1d0af1a1d5d ("kernel/dma/direct: take DMA offset into account in dm=
a_direct_supported")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 kernel/dma/direct.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab..375c77e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -309,7 +309,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
=20
 	min_mask =3D min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
=20
-	return mask >=3D phys_to_dma(dev, min_mask);
+	/*
+	 * This check needs to be against the actual bit mask value, so
+	 * use __phys_to_dma() here so that the SME encryption mask isn't
+	 * part of the check.
+	 */
+	return mask >=3D __phys_to_dma(dev, min_mask);
 }
=20
 int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
--=20
1.9.1

