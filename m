Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD48AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 21:08:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EE220851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 21:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="L97bbCID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EE220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zLyv13LqzF3W3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="L97bbCID";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.73.116; helo=nam05-dm3-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="L97bbCID"; 
 dkim-atps=neutral
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730116.outbound.protection.outlook.com [40.107.73.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zLwC00MtzDrPx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 08:05:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFSz3b6qzVvIYpbC4LVu7XMyBvyhP1Zmll554gEw2Lo=;
 b=L97bbCIDwN8dYg1R5UumF0gcwsG3z2nuEqQkOEwjdw2a2+YciUxjgK3aa78eClImIXmp7D4pIJ4mxxrXlcPgaoPWYBxgBSHBz7KbsqCqoQIdd0QRxGaoMODJ1z1GGWAt5NGbVbWXCGhNt953qC7aKyp2YPyssSXWen2GNij9nuw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1549.namprd22.prod.outlook.com (10.174.170.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Mon, 19 Nov 2018 21:05:39 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 21:05:39 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/9] MIPS: remove the HT_PCI config option
Thread-Topic: [PATCH 3/9] MIPS: remove the HT_PCI config option
Thread-Index: AQHUgEsSui+JPzSoxUeZ8Yhne3ADk6VXlqcA
Date: Mon, 19 Nov 2018 21:05:39 +0000
Message-ID: <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-4-hch@lst.de>
 <20181119210141.nissqr6zaldt23xg@pburton-laptop>
In-Reply-To: <20181119210141.nissqr6zaldt23xg@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:301:3a::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1549;
 6:0T0VG4pkzhhO5FdEciiJMOZ8CpcjQlsnPMBEBiYcbtTh77mE3/RsRDVIx9OvWTNMoYTb8+FUDpqDXEJkMzMIBLEk6oI1t8w+/6VLdk76lzayc9J0B6Gmfgd2/j69SMVbUSPnW+3OvjcnegNKkBSsVmsR17bahtD28Zb7hAOh0JgJmSJOHesH4Xnk2r6RQgQoVCycSqbN5GvdAqSQX+MQ0mHtgn+pc4/yJ2+sKzblXw8vtifFv39vJEDj2JYyj05J/isolpx91qQnLlWOpC5rF6d0WB557aXJhNdFCKOAUpoIOkZCi2Opjc6d3ZbZZ/WjCqcPiy+k5oHqY0dL00Jl2VVEU9Cw3VuezGRpqJf7ms2EEUSNq43cKxSCGKr0ny8UzrYE3yNfykjQYVddHJl/9EkqrcdHSVR0XP6FkV1E7U9xRJnAws64Xqt2CMb/yL88L7fBzaxhT5OerR93+sS5BQ==;
 5:UE5vsTH/H5Dq//y2RrqLgucv24RiU7RAdFSt80xZB9lwE3eUakP1Zo61qeIrk8WYGXGfdqGDJujP1quVcXXiYL2V4KeAYzbFGsFfTFc9QHyDGbbomLa/q9w5s15szT0nXuxxEP71aIW4NcMvEMZ6tzKbpvNzNt59HF/wMtuJeG0=;
 7:dCy+pXNOUXX9gQ0Gm99sJqO2dKbFGwiTAzFEt/WWkWgUoe4Gur91dDV9RDqOU069a4MflhjcVEhpfNZ9fbeDBqmwCi0XEtzcqJO+q7PJD1sEgmdtakUph9dUOWRditfzVHhx0OCNea7xLz4ewA+pWA==
x-ms-office365-filtering-correlation-id: f729e736-46ca-4892-8372-08d64e62c248
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1549; 
x-ms-traffictypediagnostic: MWHPR2201MB1549:
x-microsoft-antispam-prvs: <MWHPR2201MB1549037E4279CDDCF4AB2EF6C1D80@MWHPR2201MB1549.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231438)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR2201MB1549; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2201MB1549; 
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(366004)(346002)(39840400004)(136003)(376002)(396003)(189003)(199004)(5660300001)(99286004)(14454004)(52116002)(508600001)(7416002)(186003)(386003)(6506007)(316002)(26005)(305945005)(7736002)(6916009)(446003)(2906002)(42882007)(6116002)(3846002)(66066001)(111086002)(105586002)(106356001)(81156014)(2900100001)(81166006)(8936002)(68736007)(476003)(6246003)(11346002)(25786009)(256004)(4326008)(39060400002)(44832011)(229853002)(6512007)(8676002)(33896004)(33716001)(76176011)(71190400001)(71200400001)(58126008)(102836004)(97736004)(54906003)(53936002)(1076002)(486006)(9686003)(6436002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1549;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DaBgx/ppVHwUQZP2l+ePBPw8ur5VkronHOvua57ECm6HNLo3atXuaKroagOaQ866mBP9h3BfkDIkUvVZ42wGnVqEsiwF9VpukafDlPrHdvChJdvgWN6Ifzb+IK2LobdXet++XdhPBi+H7h3/lzzPTua8Eo68bBPeqNb+cLDr5AlSJjtjaNQekx+lphEMJ8KhOGtB8eHqaFhJx42mT6kuqAZAI9cVth7XfixQN43DN3EeZcJRYlvVXlnItH/hs86UTkumw1DjFCAxsTKpv62fZgqyut0SDxyWhMLdSbjbO8lRLqn2oKdhnqJdydHYCD+5ajc+sEDgA6wOKilRuxWuyi/5EoHr3SI4syLhqWRdkmg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC927875E6C6E54FBD90D6D3F816A9AB@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f729e736-46ca-4892-8372-08d64e62c248
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 21:05:39.4759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1549
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

On Mon, Nov 19, 2018 at 01:01:41PM -0800, Paul Burton wrote:
> On Thu, Nov 15, 2018 at 08:05:31PM +0100, Christoph Hellwig wrote:
> > This option is always selected from LOONGSON_MACH3X.  Switch to just
> > seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
> > on CONFIG_LOONGSON_MACH3X.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/mips/Kconfig                                | 11 -----------
> >  arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
> >  arch/mips/loongson64/Kconfig                     |  2 +-
> >  3 files changed, 2 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 8272ea4c7264..7d28c9dd75d0 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -3040,17 +3040,6 @@ config PCI
> >  	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI=
,
> >  	  say Y, otherwise N.
> > =20
> > -config HT_PCI
> > -	bool "Support for HT-linked PCI"
> > -	default y
> > -	depends on CPU_LOONGSON3
> > -	select PCI
> > -	select PCI_DOMAINS
> > -	help
> > -	  Loongson family machines use Hyper-Transport bus for inter-core
> > -	  connection and device connection. The PCI bus is a subordinate
> > -	  linked at HT. Choose Y for Loongson-3 based machines.
> > -
> >  config PCI_DOMAINS
> >  	bool
> > =20
> > diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfi=
g
> > index c865b4b9b775..781a5156ab21 100644
> > --- a/arch/mips/loongson64/Kconfig
> > +++ b/arch/mips/loongson64/Kconfig
> > @@ -76,7 +76,7 @@ config LOONGSON_MACH3X
> >  	select CPU_HAS_WB
> >  	select HW_HAS_PCI
> >  	select ISA
> > -	select HT_PCI
> > +	select PCI
> >  	select I8259
> >  	select IRQ_MIPS_CPU
> >  	select NR_CPUS_DEFAULT_4
>=20
> Should this also select PCI_DOMAINS to preserve the existing behavior?
>=20
> If not, could you explain why in the commit message?

Ah, I see - PCI already selects PCI_DOMAINS. I think it would have been
worth mentioning but I don't mind if you don't think it a big enough
deal to respin the patch, so:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
