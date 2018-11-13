Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A06BC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 22:48:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BC222360
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mGHnIzJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC222360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vjTL42TFzF3Bg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:48:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mGHnIzJe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.69.110; helo=nam04-co1-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="mGHnIzJe"; 
 dkim-atps=neutral
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690110.outbound.protection.outlook.com [40.107.69.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vjQc4pYrzF3JH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 09:46:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcPiwqOz4u9BuQ67POvi3mkxRXF2TJM3x1PcwoJ3l8=;
 b=mGHnIzJe84mTIGS4XKxI6gP5i7iUU62005i9lZw6ut1ptCzTmy/++zzz+oRwS4dkKbGojI13/ptOPTsaALYD7EdLdw3hO8GWopuP4RcNS9q8g9WuO+O1EitaZgoH3IilhbFNRr34TGL+6ejMIIgU5RUDuTOJJOQpB3NnCW1WGf8=
Received: from BN6PR2201MB1266.namprd22.prod.outlook.com (10.174.81.142) by
 BN6PR2201MB1059.namprd22.prod.outlook.com (10.174.90.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Tue, 13 Nov 2018 22:45:54 +0000
Received: from BN6PR2201MB1266.namprd22.prod.outlook.com
 ([fe80::2590:763f:1a88:c9ec]) by BN6PR2201MB1266.namprd22.prod.outlook.com
 ([fe80::2590:763f:1a88:c9ec%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:45:54 +0000
From: Paul Burton <paul.burton@mips.com>
To: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH 05/17] mips: Remove support for BZIP2 and LZMA compressed
 kernel
Thread-Topic: [PATCH 05/17] mips: Remove support for BZIP2 and LZMA compressed
 kernel
Thread-Index: AQHUeF7mOa3hFP+NiE6vOtJJlRFe06VOVHyA
Date: Tue, 13 Nov 2018 22:45:54 +0000
Message-ID: <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-5-kilobyte@angband.pl>
In-Reply-To: <20181109190304.8573-5-kilobyte@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:300:94::28) To BN6PR2201MB1266.namprd22.prod.outlook.com
 (2603:10b6:405:23::14)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR2201MB1059;
 6:Pr08n6iPZrN8zN+5JkHT+MtgAuc5lxe+UUjOlU9frsI1OdMKJIhx3hsQDiD4lwRI5eXgLeXJuiWUCu566qJR+3xC6aGuSzozRN+GImlweE3beQSppzyfhLnupSzT8B4y1be9KoByB5t65XtczQLrB2frmuCef5Adxcv/5xzEDCpAd636bUqiiol4VHEehf+uGAfIrolkg7RWtxv4nFvtG3TuLC82yehA7hmXgx7nQLpFHZ4UawAYdt3jgJuLrPK71aKny8BZtOAROyiVRRz9aMmYzTlpNa1+kI+nmVQ1JutIF+aBN7CsRm+v5bypsyqBNy4Nghe9egP7dCZzy3YnwcVEy5mWn7Xdw6E9AqrGz0p2cudt0aG7stEhBT7zoOCTsEQbOlA809cRN1yWAqSUXG+9yJpgojvsvocECidUtp9yr//iyZOMBbOttVIFmByaWUicvGH+pkrsy60M7ff5lw==;
 5:sWk+b10D/0G9wFFIyhKHT0CEVf73J7vTU1LywSukcw9ZlnDQKXWr6BvXHV1CYeX5Fj9Fr7FOQ3QOeDy+FNgI7Zyr5Ws4wlzDvTIgTPJoQ1u5HVgnVDou4b/fzR9Ay2T5nHz37ZByjGK/UCm8n0ajFezZdqwJzLeF7+B3vjQ0X8U=;
 7:o7/9uWPjVleRXz7svySoxfGqs22cE8981qLoaEBZGzzQg5FzkU+FR8DUnQtLKthG6NyrID5DzsQvtHvHSwlGdZAXIgk66UaWlo9oWHyp7/TgYJp0x+QQ8qSsEXTi3yDWW/SeQW+mmg5ujGLoc5PJag==
x-ms-office365-filtering-correlation-id: bdf20cfc-0c0c-47ff-2d5c-08d649b9c0eb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR2201MB1059; 
x-ms-traffictypediagnostic: BN6PR2201MB1059:
x-microsoft-antispam-prvs: <BN6PR2201MB1059B02B2E409812E19ED6C1C1C20@BN6PR2201MB1059.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR2201MB1059; BCL:0; PCL:0; RULEID:; SRVR:BN6PR2201MB1059; 
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(39840400004)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(52116002)(9686003)(6512007)(7406005)(7416002)(2900100001)(229853002)(99286004)(105586002)(53936002)(6506007)(305945005)(106356001)(186003)(26005)(508600001)(386003)(39060400002)(76176011)(7736002)(102836004)(8936002)(33896004)(6436002)(5660300001)(6486002)(14454004)(97736004)(68736007)(33716001)(8676002)(1076002)(3846002)(25786009)(6116002)(71190400001)(71200400001)(81166006)(81156014)(4326008)(66066001)(2906002)(6246003)(6916009)(11346002)(54906003)(44832011)(256004)(316002)(42882007)(58126008)(476003)(446003)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1059;
 H:BN6PR2201MB1266.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 08ia23I/mbtO69ty+PPs/t/kjD83rwvhawv5Coze7mm1+YdVUYVt+ptB+YjPBf2rLJ/DFJAgnzaezz/DaWoZmVzduV8N1Hnqv6y2dYQ4QCMuWBvLMZZdtuiF26q7Ji37xaSKPJSBcX0TJ8Taq3s7/Xq3+H4Bt8QYlMRj++ioRTun8gLvZiZSXZajlZ0MjaEhtb7wizIVTNtvT1//uPS5/BrVYo8OGMsiAmQDUJb08qpXp0V4Oi/ga7LbiP4SBH2vIS7UabcRICkEv37jAqyi8S7giqlslg1YwwuvA1IlPXZASc0Dg6lQliie57cCPfUSYwvYYqqFo8aDjQkJPdsSVLWN2iSnDwBylCgBFSZUAqA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFC22DE242750042A617941EFADC35F1@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf20cfc-0c0c-47ff-2d5c-08d649b9c0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:45:54.2013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1059
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
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Rich Felker <dalias@libc.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>,
 "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Nick Terrell <terrelln@fb.com>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 Borislav Petkov <bp@alien8.de>, Stafford Horne <shorne@gmail.com>,
 Chris Zankel <chris@zankel.net>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Adam,

On Fri, Nov 09, 2018 at 08:02:52PM +0100, Adam Borowski wrote:
> @@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mip=
s/$(PLATFORM)/,$(ITS_INPUTS
> =20
>  targets +=3D vmlinux.its
>  targets +=3D vmlinux.gz.its
> -targets +=3D vmlinux.bz2.its
>  targets +=3D vmlinux.lzmo.its
>  targets +=3D vmlinux.lzo.its

It looks to me like this "vmlinux.lzmo.its" was a typo & ought to have
been vmlinux.lzma.its, and thus ought to be removed.

Apart from that I'm fine with this in general:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
