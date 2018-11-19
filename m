Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234C8C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 21:16:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A82320851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 21:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YCv1CWHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A82320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zM805jxGzF3Ws
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YCv1CWHl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.81.129; helo=nam01-by2-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="YCv1CWHl"; 
 dkim-atps=neutral
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr810129.outbound.protection.outlook.com [40.107.81.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zM5G1nvQzF3Jy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 08:13:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFrZnnSCW0M69MoOPURhPUKtM4maqeOX5Dq5QPqadVs=;
 b=YCv1CWHlUYbkV6QLleQsonGR5+YfEiKJ+Lh7LOJ3fcioOYIY6jJyVrNErcIRTdvThqDDaEIDSLeZBg2271SgMYkYXlvtJyxI1Z8LHtNDKkfih6kdsnLV0SL8cP6l3OIk+FUERTS2Rez9gSTUgM93tCm3wT7ePmMzOh8cmbJFjKU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1184.namprd22.prod.outlook.com (10.174.171.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Mon, 19 Nov 2018 21:13:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 21:13:29 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/9] PCI: consolidate PCI config entry in drivers/pci
Thread-Topic: [PATCH 4/9] PCI: consolidate PCI config entry in drivers/pci
Thread-Index: AQHUgEy2/aQpdqgEI0evkqFV+gobGg==
Date: Mon, 19 Nov 2018 21:13:29 +0000
Message-ID: <20181119211327.h2lugf2ttuiz3fp6@pburton-laptop>
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-5-hch@lst.de>
In-Reply-To: <20181115190538.17016-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0008.namprd02.prod.outlook.com
 (2603:10b6:301:74::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1184;
 6:F0I/vVZmXUO2jLYA70f2nMKLrTWNJfe0XLGKFqU1MdV6U4+L++bhuXBq+ezPp+A2fUpnY7J/8FAOYks/UNpK29ThPh3WnVUyZpX5i6G4VyAnN0ojTz47H9FX5LYbbmn/LX3j2/gy7a+5onw1z90NutEy/HT5sCBi4dsr4+TWls+kMjFBtyd0JsRIRGVC69Y6KdDyO6na9UezcVkNGMIAmKyLXPbaf/RasHTP27VzkRg1kd/U8xXDvGvVMQGgrPtzQrO01sYmcPe51kBJh4E3+sXzbVAeSuMvyX0cpzxR6dtML/FeFHLQ9iZbI8+XmY2S2CKdzWz/veo8jaYEK3Y8Bp1YVQ83wW9SAoU4fiJtFNrrafc3H2mRKSR860pIklFo5e6ADkvutp++PmMx0MXCMSqTyPP/iuNp0kHBqMXZ5dvMLzl9cduUtE1FLDX0/qU+b+/ivH4POvzVz8kT6xz1yw==;
 5:8lNGrQ8Gv17qIYhlASRvFyj3y6q0Ls/fw04iIfdKiHU0N8OxwIvOPExhtVfDDu9bMtDkG9x6iAs5l5d7XfJp38VfQysZ/pRzjAXQ+Ztsy3QwQDjdlYXUqVkRpr628n5/IMwicnzP93b7yYYTQoSbsvYxdL2CrAsel7uuC/rp+o0=;
 7:WVu2yNo3oExUBkZvoc8f6Mioe/3JIlkkTYJNvbe8GNJLD98efT/UPR9cfYprX0Qc93wIdzG2tjnicIfKZtBMtqUvSwIh8aEWmvxhYQNEudhWIjyGNftx03K9GskRHup/+ab+ZZv3VoIjBVWMtdDtNQ==
x-ms-office365-filtering-correlation-id: 9d389792-daf5-4377-6faa-08d64e63da3c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1184; 
x-ms-traffictypediagnostic: MWHPR2201MB1184:
x-microsoft-antispam-prvs: <MWHPR2201MB1184CDAB3282B5DCB11A3650C1D80@MWHPR2201MB1184.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR2201MB1184; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2201MB1184; 
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(136003)(376002)(346002)(39840400004)(396003)(366004)(189003)(199004)(111086002)(102836004)(25786009)(44832011)(71200400001)(71190400001)(6486002)(2906002)(486006)(386003)(6506007)(53936002)(476003)(4326008)(6246003)(305945005)(7736002)(3846002)(14454004)(446003)(39060400002)(1076002)(33896004)(6116002)(76176011)(11346002)(5660300001)(7416002)(2900100001)(6436002)(316002)(186003)(99286004)(256004)(42882007)(66066001)(68736007)(52116002)(26005)(97736004)(33716001)(229853002)(106356001)(105586002)(8936002)(9686003)(6512007)(81166006)(54906003)(58126008)(6916009)(81156014)(8676002)(508600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1184;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +z+lBhWGG+vFUwdSiGNfTHA4WZ1SQin4ksbAixyLT4N/wM/zZPJ3l/k+N8rk+aNt+2lN/h8XHbIxI4AOYDeU3Ftc98qWFjpasycr2EDPKw+ErzSaHXrB0e+74CrFToePLeIxs8bYXV9Ajj7Ns1uETV/MpcJwcY8Mx96dVncMAaCwUbLpO84XoA3AAVD0LTNfEW6e92nQWOlNvCKTJ3zq469RmkNbWrIiq8sq++emlTVcNGVIgTpH+2SW7Yfhm2TRi1Ycs4Kt1WMQdmRmKcpHCdHDmxq9KVOwNNs6e4G/pdvlEgBWcSXIjHw5mhuZOsugmlyH4o4payANUPE9Qe6CNC9lQPqMx9+vhPlcgXoOBsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3555B391B5C5094C84F54A5D1FC10A55@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d389792-daf5-4377-6faa-08d64e63da3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 21:13:29.3850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1184
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alexandre Bounine <alex.bou9@gmail.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On Thu, Nov 15, 2018 at 08:05:32PM +0100, Christoph Hellwig wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support, and a FORCE_PCI symbol to for PCI on and the handle the
> rest in drivers/pci.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

For patches 4, 5, 7, 8 & 9:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
