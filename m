Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328F9C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:20:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1302183F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GSy7QBTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1302183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jZyv12LMzDqHf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 03:20:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.74.119; helo=nam01-bn3-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="GSy7QBTo"; 
 dkim-atps=neutral
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740119.outbound.protection.outlook.com [40.107.74.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jZx44WB7zDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 03:19:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0LkaZmIAoSPOG2sRgQfljHs///NujAgFS3mww58ebs=;
 b=GSy7QBTorNHx7h1o9R7BBTfbPWD5W0Hh4sk9HweHDaKDieGzXtOa6UV9/aOCPBL6QbIOnkl/FCf0GwTx0XomV547kMBtrK+ZKTH+Pn8jd3dV1qydvJtoX3ObhZ1r78hP1HcNGMNvx6IBDE/MPGzo+2zQT85jh8v1fhPUrLWX/FU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1646.namprd22.prod.outlook.com (10.174.167.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 17:19:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:19:12 +0000
From: Paul Burton <paul.burton@mips.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v2] arch: add pidfd and io_uring syscalls everywhere
Thread-Topic: [PATCH] [v2] arch: add pidfd and io_uring syscalls everywhere
Thread-Index: AQHU85fL+gHE1wPf2UOG9gtYUzAhTqY9d30A
Date: Mon, 15 Apr 2019 17:19:11 +0000
Message-ID: <20190415171910.ezhsqmncj2eiw7cc@pburton-laptop>
References: <20190415143007.2989285-1-arnd@arndb.de>
In-Reply-To: <20190415143007.2989285-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23d9f8d4-b650-473a-1b69-08d6c1c679ef
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MWHPR2201MB1646; 
x-ms-traffictypediagnostic: MWHPR2201MB1646:
x-microsoft-antispam-prvs: <MWHPR2201MB1646ADBF62B1169D5E73A3E1C12B0@MWHPR2201MB1646.namprd22.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(136003)(376002)(346002)(39840400004)(366004)(396003)(189003)(199004)(6916009)(58126008)(6116002)(478600001)(3846002)(33716001)(99286004)(4744005)(476003)(4326008)(486006)(1076003)(316002)(68736007)(44832011)(106356001)(256004)(229853002)(305945005)(7406005)(7416002)(97736004)(54906003)(14454004)(2906002)(105586002)(52116002)(6486002)(6436002)(7736002)(9686003)(71200400001)(71190400001)(5660300002)(81156014)(81166006)(8936002)(26005)(102836004)(8676002)(386003)(6506007)(186003)(76176011)(25786009)(6246003)(446003)(66066001)(42882007)(111086002)(53936002)(6512007)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1646;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpBqeD+nrjxZrmDBgVYdlzMv3Ori84Z8WZXFjtdtBEY4O/gMbjknOXRN27CYFaEIO5eG6P5vRwzaydf5wY4HmzBN1l/aD+qU55yo2pKuHEB6shPbJOcEB1rgVNiQREayqm0Yt/ZHCLdhPNHJpG3ObmUHYme2UwlNPbhm/28/KG/TcZYmZAkDY1n4HfL1m1yzRCThBShIndORvvNJ3+0jN6vFtYzEy5yXQyd80es6PgnMqfnIn14Nhi2L9mW10gi/FpldSr8TQdPDyrmZrkBGvVqxB4Qqa4Lac/V/aBMvczHQ5lyAhs+LKkS0rY5f56rcVofw/V9x82q3sa77wdShen4rp7/P8B57G7/abKImYLHuY6gUqxDNZ3YrGcjdfqsPzmr8w2F7tkV5CPNH4J8CY2v1+97I+s641jrpbVQgt0M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BFCBE85B6EE3C42A598251C8BA649BF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d9f8d4-b650-473a-1b69-08d6c1c679ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:19:11.9918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1646
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,

On Mon, Apr 15, 2019 at 04:22:57PM +0200, Arnd Bergmann wrote:
> Add the io_uring and pidfd_send_signal system calls to all architectures.
>=20
> These system calls are designed to handle both native and compat tasks,
> so all entries are the same across architectures, only arm-compat and
> the generic tale still use an old format.
>=20
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> (s390)
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes since v1:
> - fix s390 table
> - use 'n64' tag in mips-n64 instead of common.

Thanks for taking care of this:

  Acked-by: Paul Burton <paul.burton@mips.com> # MIPS

Thanks,
    Paul
