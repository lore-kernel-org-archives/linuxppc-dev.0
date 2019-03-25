Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:38:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B32205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ainsoJHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B32205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ShMM0tQWzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 04:38:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.75.121; helo=nam02-bl2-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="ainsoJHS"; 
 dkim-atps=neutral
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750121.outbound.protection.outlook.com [40.107.75.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ShKZ0XtDzDqFC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 04:37:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxdGHDqM2Hob1Ge4ufd+xg2dLJBLXLGIts1F7o/D6L0=;
 b=ainsoJHSuV4wQILShvNFOJKL3XQ5olD9sSMos4w92z0ZAEx9VxfDXjIU5Hs6RXlY13RVBEd2eRDcTdczi690f2Rgxpd4lunYwEQPsrkliqCKuZZDndAjxEKz0Y9tnWOP8HMDgxjHwH+5Kg4DJfJbJdFYnnijGu12VCfH87Aj+fg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1392.namprd22.prod.outlook.com (10.172.63.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 17:37:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:37:12 +0000
From: Paul Burton <paul.burton@mips.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Thread-Topic: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Thread-Index: AQHU4xnDP1dzfUK3kECwl5vlzfGO86YcnIQA
Date: Mon, 25 Mar 2019 17:37:11 +0000
Message-ID: <20190325173704.mun2cj2ulswv7s3i@pburton-laptop>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
In-Reply-To: <20190325144737.703921-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b77b85e2-738a-4beb-6f17-08d6b14882f6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1392; 
x-ms-traffictypediagnostic: MWHPR2201MB1392:
x-microsoft-antispam-prvs: <MWHPR2201MB139298757EF5E1EE94647489C15E0@MWHPR2201MB1392.namprd22.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(39840400004)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(1076003)(68736007)(478600001)(6486002)(14454004)(256004)(4326008)(52116002)(6506007)(386003)(106356001)(66066001)(102836004)(76176011)(8936002)(71190400001)(71200400001)(186003)(105586002)(26005)(99286004)(305945005)(54906003)(486006)(81156014)(6512007)(9686003)(446003)(25786009)(6246003)(42882007)(6916009)(81166006)(58126008)(33716001)(97736004)(8676002)(11346002)(44832011)(476003)(111086002)(7416002)(316002)(7406005)(53936002)(229853002)(3846002)(6116002)(2906002)(5660300002)(7736002)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1392;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2+cUWKxJxdo+gG43J3egSpOoVxfSvfkRRxwHFW1Gcf5cr74uFP4A1HnuCcCx0BVWC9Nm0DI8GfbgBWCfCIjk99T6WqqS29wa7CIo0Ddnac3kM0SXjo9cfXnsqT+qa7uu8Mw5KMLyvOEcF3HzGV95rei1eHjMwb8voN9KgI0pzquq0mU919nohnWilH6h4PqCBb3rWtFiLS1yH9/s0qVv47dFfjoLMhv+l9YBrQPLOVggTkNpLJ7Aaaw1hH+046Ld34QD62zFd7XwrAl500gW4RRk3nppWyI6t3TBQVSLMjBVGfGAFKGeqDIbwm4YAb1W6HKwOLsh8M4B/pW7ZwEBdZ6E1QL0CjNhpMcS3qtSOx+un62AqkL6jaRx3vjYApk/0RLbyWEnKOA3sQ/yQtKHqnmnVNDvzpaKqC0/18le5ic=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <925CEF0D081FD04088D61AE526A67361@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77b85e2-738a-4beb-6f17-08d6b14882f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:37:11.6927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1392
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
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "James E . J .
 Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S .
 Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,

On Mon, Mar 25, 2019 at 03:47:37PM +0100, Arnd Bergmann wrote:
> Add the io_uring and pidfd_send_signal system calls to all architectures.
>=20
> These system calls are designed to handle both native and compat tasks,
> so all entries are the same across architectures, only arm-compat and
> the generic tale still use an old format.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>%
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index c85502e67b44..c4a49f7d57bb 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -338,3 +338,7 @@
>  327	n64	rseq				sys_rseq
>  328	n64	io_pgetevents			sys_io_pgetevents
>  # 329 through 423 are reserved to sync up with other architectures
> +424	common	pidfd_send_signal		sys_pidfd_send_signal
> +425	common	io_uring_setup			sys_io_uring_setup
> +426	common	io_uring_enter			sys_io_uring_enter
> +427	common	io_uring_register		sys_io_uring_register

Shouldn't these declare the ABI as "n64"?

I don't see anywhere that it would actually change the generated code,
but a comment at the top of the file says that every entry should use
"n64" and so far they all do. Did you have something else in mind here?

Thanks,
    Paul
