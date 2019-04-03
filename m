Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B348C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:53:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAA02075D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Jh7aiZ4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAA02075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZLwK0hbfzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.69.128; helo=nam04-co1-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="Jh7aiZ4c"; 
 dkim-atps=neutral
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690128.outbound.protection.outlook.com [40.107.69.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZLtY1lD8zDqJP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 09:52:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48CSLD+3H6IfiAlQmIjLMGeA8ey37rhCUmwzu0OhZ98=;
 b=Jh7aiZ4ccmvOIT/zz2NYbzF2zvB0h/i/GaHu4C67deKJ0gfeq54GPU3x5R9dVazWw9Bx9aLPZiMx8c37aXwyoMFp10OT+4EkGi+rLZ6tEoyGlW+yV8iTt4YMJN+A/PT4/HcjAKiiVnYht1iXhzuVHduVSAddqPjNTUHt7SIFwPE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 3 Apr 2019 22:51:57 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 22:51:57 +0000
From: Paul Burton <paul.burton@mips.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
Thread-Topic: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
Thread-Index: AQHU6JENRdUQHD2V6UStclirymCe56YrDoSA
Date: Wed, 3 Apr 2019 22:51:56 +0000
Message-ID: <20190403225151.s5suxxmu6b2c4svt@pburton-laptop>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.278590567@goodmis.org>
In-Reply-To: <20190401134421.278590567@goodmis.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d0bc1b3-4a1a-4e3a-212a-08d6b886f8d2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MWHPR2201MB1581; 
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB1581F396BFB8DE3952D0BB66C1570@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(376002)(396003)(136003)(39840400004)(366004)(346002)(189003)(199004)(76176011)(3846002)(8936002)(102836004)(6506007)(26005)(42882007)(99286004)(486006)(11346002)(66066001)(58126008)(44832011)(446003)(966005)(6512007)(52116002)(54906003)(6916009)(476003)(97736004)(305945005)(6436002)(256004)(71190400001)(71200400001)(14454004)(316002)(6246003)(6306002)(1076003)(53936002)(33716001)(7416002)(81156014)(386003)(6116002)(68736007)(81166006)(7736002)(186003)(106356001)(2906002)(7406005)(229853002)(6486002)(5660300002)(25786009)(105586002)(9686003)(8676002)(478600001)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1581;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pjMl+TNtDiGvNZn/Hxh0vmvCkU1X2ClaeQnAUFviiSsuR+dTqfcci2ed3vv9t9O9HYH3b0zBDvemfKcFwD0+ouivIArkdZ9uz6E1wV4F8Dv+Pqhg/HSipwf6pDH4BdmU5mkHOLOM6PnOIROz0N7k5mSW9zmn4TpSi0hPwDitXdIxekZfuC84dnQgJexjuURdz6KoqA05RYzyVxpLUHQnYn+KQRFGTLlYYLnUft+XfwPbv0+cqhJXvYb4pssMIThEAz7I7rt4aMMAYqJnbFccuWkaLrSARvSly6UJmGhvv5bF9KKrRbOPcFViwKIteicQmj5Rl7LEbk4Dx2qYWgRt4aGFGCKseirhmZHC5ZSlD3iOdr/j1YVKCrveG/ci/a8IOPqk+qBsY8qe/mqa3MO1ADuzzAuwVBurVSX1cOaCvhc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E78680F2A383A49931E90A79241CAA3@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0bc1b3-4a1a-4e3a-212a-08d6b886f8d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 22:51:56.5618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
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
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@sifive.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 Dave Martin <dave.martin@arm.com>, "uclinux-h8-devel@lists.sourceforge.jp"
 <uclinux-h8-devel@lists.sourceforge.jp>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Kees Cook <keescook@chromium.org>, Roland McGrath <roland@hack.frob.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Dmitry V. Levin" <ldv@altlinux.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Steven,

On Mon, Apr 01, 2019 at 09:41:09AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>=20
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in o=
nly
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the firs=
t 6
> arguments of a system call.
>=20
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.
>=20
> Link: http://lkml.kernel.org/r/20161107213233.754809394@goodmis.org
>=20
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: "Dmitry V. Levin" <ldv@altlinux.org>
> Cc: x86@kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-arch@vger.kernel.org
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
