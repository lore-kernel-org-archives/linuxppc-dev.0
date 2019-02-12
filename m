Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60E9C4151A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 02:19:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C50A21B18
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 02:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ozG293VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C50A21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z5v33bJ3zDqSy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:19:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.82.120; helo=nam01-sn1-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="ozG293VS"; 
 dkim-atps=neutral
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820120.outbound.protection.outlook.com [40.107.82.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z5sB13SszDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 13:17:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLNA/8E7XxiU5SNRQ2CEjv6lzgrFvdP2XeYgmRA9AuI=;
 b=ozG293VSNp8I8yx7T3BVAOWNeNHvL2sN0w+HaTqXvDWnouYd91TVzT0ck0bFrJ0PrAdp+SidTNqnMq8BOQHnzm06uhgBw6UIGz5nQhojJwpv4GAy+EMnSSuCO7l3iTEdKPBmUGPIg49G7nbxWfkUdLSw6HLffZD8W5v40wbeHlc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1518.namprd22.prod.outlook.com (10.174.170.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Tue, 12 Feb 2019 02:17:26 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 02:17:26 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Thread-Topic: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Thread-Index: AQHUwg7wztMik5M5KE2guV+HlCSoLKXbbhKA
Date: Tue, 12 Feb 2019 02:17:26 +0000
Message-ID: <20190212021724.cp4snlcqbm3kqtzu@pburton-laptop>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dfcaee2-f573-43f7-6c6f-08d690903b2a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1518; 
x-ms-traffictypediagnostic: MWHPR2201MB1518:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; MWHPR2201MB1518;
 23:azaZ1cGJ61L0XoyxK8Dc51MaxQQ+esp1XB9FDjq?=
 =?us-ascii?Q?/g57vHvs9iwd7Y4e6qa6Ke5f5h8JhfBX4J2Nse+blKx5H8OCQVFdsSobIdjS?=
 =?us-ascii?Q?S6MpFq726gt2YuR+ZVFmw6zrtJ/kLl9Vo7H1XlRuTjI1T7LqewYJPu+6NaPc?=
 =?us-ascii?Q?mseBdhHx5RUxrQ/JKvaigCrQpgYyubrRyjjowsKMwhM3M4mqXtSXxIEPCRD5?=
 =?us-ascii?Q?qphy77CXyNeZhh3BzFLJGFw9mgEGaERS795SKYIwqHlTk9sM4c8sNW27T+s/?=
 =?us-ascii?Q?pJZjMN0mKxXqvoZAJ5K654+c6qCYxBWzgjfb9C620aqhNddnwvWlykOIhaFJ?=
 =?us-ascii?Q?5dlthwGOcEygUN8+08EAtDfG8/cQ/ns2i2jH7Sh09blV0PXufUpXXQGcEwYY?=
 =?us-ascii?Q?rNYTwDp6DmalDvyIt8bZtZSaS0qnvhTYSMB52KGO24XISLlcntBtNNzWlwyD?=
 =?us-ascii?Q?J54Z9wVFVOIr6SB/G13OgvQ1Zba8tCCo5H1Fj0ruc3T8cA3NhLMJHTxULy3E?=
 =?us-ascii?Q?wBHiWE4q+aDS4shd98vjhBjtok09bHCLHtbaR8NR722akgIpXcNUyQmBtFKp?=
 =?us-ascii?Q?zYhrpZjiR9SFDybg3fPnYJEOomkycxGuT5128EvuwtQhy/nrTfNFHhvonQkQ?=
 =?us-ascii?Q?DWQYy5kTpCllgu2MJOfBu07R07qxXi6GeTmuyWxASE+qvJz+QsnE66S5kQYb?=
 =?us-ascii?Q?q4gev4yMehHVxPkFb9QmvW5tFBNwWyYDUsUq4X9OcxVVm2L+zM8hpR6CbJ8b?=
 =?us-ascii?Q?wTQdXXWfvliiNEXOGa7mdTC8ZYj/3SlrPzkmsxbqqLAZGcIzgLY5W5M8E3JM?=
 =?us-ascii?Q?qwoMLf87R8jy3B1LR3ELWl8zA48t5LBl7jDSik1RtIGlhR0gSAdvDQqzCTuW?=
 =?us-ascii?Q?EO0V853Q+Op2iKeBLzKe5fpyNQ/T29OZzALeJwMPtzyEOidmY+4FS/IHBmpa?=
 =?us-ascii?Q?sHI4zxo1J9Tt9uOWkQnjQ3I9f5SI7kj3mpz9zDZQnlF2kusu2jN2vbffMrZ5?=
 =?us-ascii?Q?YaGOvA5WS3NTsLVaADcwm+iF0yxm7hPIMI1HLfOkBOzWL6h7nvA/K9a731M0?=
 =?us-ascii?Q?NY12EfZTmmWK/fYwRPriYOlgUnTfXVHts+TQe/6Ad1HNM4oo6asbhJYJINDh?=
 =?us-ascii?Q?0vTX4PEZKHveyer1zpZ6f4rkSzVMVGVcKsYAN3LXh6AxJQ7xZ0J/yMOCMYe4?=
 =?us-ascii?Q?Oaf2/ueyi57Z6kwQeRitq6Ui7l6EyU+u6WJxA4suWKZ5dgJxq338xs6+oaAo?=
 =?us-ascii?Q?Z8qPH9s+/Lj4M90aPhRPReTey3RjcyIr3yTGs6p6UUqZnrmvUZLHrwaIjpbY?=
 =?us-ascii?Q?gEWB8fGNAzZqkODTRf1uAVec=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB151846352CEF0CE2B38C4092C1650@MWHPR2201MB1518.namprd22.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(396003)(366004)(346002)(376002)(136003)(39850400004)(199004)(189003)(486006)(33716001)(81166006)(2906002)(53936002)(97736004)(68736007)(386003)(8936002)(476003)(44832011)(1076003)(11346002)(14454004)(66066001)(7416002)(6436002)(4744005)(81156014)(446003)(26005)(25786009)(6246003)(6916009)(99286004)(8676002)(42882007)(478600001)(76176011)(54906003)(256004)(52116002)(305945005)(9686003)(7736002)(6512007)(33896004)(71200400001)(316002)(6506007)(71190400001)(6486002)(58126008)(3846002)(6116002)(106356001)(186003)(229853002)(105586002)(4326008)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1518;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4L+haswJ6uv1RBUXPnSknQtUAgOiS3kDE2H/b7RVDbzX1U0BrnWr4lKTJNzelIgvuLllJJQFQLeNqMEzqvm9nUSZjqbWg5Mlplry4uiLrLrInA7v9O61x6nRaVF7fGJ8OBzxOPst8iqgyi5hwXLTbBFfHiHwZ1+fugEpdo6ykVfVPmW641hQ2pdgCOItnm4egE45x7/sOdKdnZgsKmDDsJZOrNcQFfzb1XGF/NyesNPgmmE5pBdTl3c7Da57yLFXgXZ7V7D8cTkxhva2EzB2RoDIYesW8RiAo/SxbQHtrWqhipIa65SHUjAgNw+98zUXJ2g/UIwsb+vFhgUpjzflb9i1cpsjrE64zObzePfVXqgG1LIPVFzI4y4GWO6LDVKbzYW7p326Qx8TEvCeo6V3Hw9fJJ164vVtVW6zl6kUeNk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <101BE7318D87D541944405D342ACE1DB@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfcaee2-f573-43f7-6c6f-08d690903b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 02:17:26.1259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1518
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
Cc: "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On Mon, Feb 11, 2019 at 02:35:48PM +0100, Christoph Hellwig wrote:
> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS

Thanks,
    Paul
