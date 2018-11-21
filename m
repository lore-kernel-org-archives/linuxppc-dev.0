Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE792C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 18:42:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6344C214DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 18:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="p9UO919Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6344C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430Wf62wFLzF3L5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 05:42:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="p9UO919Z";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.82.97; helo=nam01-sn1-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="p9UO919Z"; 
 dkim-atps=neutral
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820097.outbound.protection.outlook.com [40.107.82.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430WbL31xYzF3Dt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 05:40:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj6NIwOwDYiM8EmGFNjdseiFCv3nZaiMd/nWclCQeQU=;
 b=p9UO919Zy24E888qHWVGpN64uG89VePsQae2CZE7CVE269a5fMLRGmnfDe0xIRXOTrOm/byfhQCziyucnSI7u8q1nH0K+w6ZG2RQh9TXu3q22/3HNgHyKTtEY6A9JC0Iw8mSltTkJOP2F697E5K05Nkl16xyDuDrfoW1UMb492o=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1037.namprd22.prod.outlook.com (10.174.167.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Wed, 21 Nov 2018 18:40:06 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 18:40:06 +0000
From: Paul Burton <paul.burton@mips.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Thread-Topic: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Thread-Index: AQHUgTPej1Tu6sDbakGRWZwZX+XXZ6VakNQA
Date: Wed, 21 Nov 2018 18:40:06 +0000
Message-ID: <20181121184004.jro532jopnbmru2m@pburton-laptop>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
In-Reply-To: <20181121004422.GA29053@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0043.namprd21.prod.outlook.com
 (2603:10b6:300:129::29) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1037;
 6:ifOXk1KgjdvPxfOglNMokjnimTpY++iZm9wnYEmaysabdKLUTN8hzWjg3iIM80eU9pieBT78PpCyIfwUuZGt3MmMmBRFzISJ+tU20TVdmxtDhcV64CagwpVPhLVbJdmgD1ePedA5HPDIY9Osjo5FMSX+gqwXkYEkHE4U6ALpR1yTNsdouc2KkhI722iAMNrbvzCMomwTzhkU0o8O+RAVy9POOOTCicx6KG2BMmStZYLU6CFDWJNCw1uw+aDH4L02hleNuzEl8QQYRI8oao866ckaWXwJkHtB/sGPlocbYK2Zve6VrzC3hiHQW65ZowejEcoysNYt0oCE4Zlu9U4IIxxv5cLs5QCrJ3WvDObLABp/X6iJh5UIpfYQBJSd0AVCOJQZ4yGdNRB+TRkJtmfhuzTb3L7pNwoaHoOoPGWi9IDFXj8cme38UQKyOOF3bMiBhlzSwPP2mBIqTnLeS58IGA==;
 5:H5+Ojo+jjM2KVTUHjThJ51t7hS8ThqHlQzcxRH8VnfpNcx0e550lBap+2OOGt4k1eThD8FLhlVRUDg7wSan9BrvLauifc8z857Bf963Cr1V2UHHePFL4eusxbFoVLRw58P9Exhnby2o8i1vwB0rIje+Ppbs+vMX+FA2LoCnDRk4=;
 7:NUHfDgar8+RSiZDXuUgVr6g6FD56K5hdVtMQQNWDO9YNUJOct0tBJ5UKf4gKJbxyixa6OMzWOa4WfDlVj1B5tRWAKHDI+m8E24jgT/a6IJ5lRH+nG6+Kis2LmmWHCiZK9gwzf7v3aZe8gkY/S9ypsA==
x-ms-office365-filtering-correlation-id: cd7e7d8b-b793-4428-c375-08d64fe0c160
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1037; 
x-ms-traffictypediagnostic: MWHPR2201MB1037:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB10374E87FA65950BA576AF1FC1DA0@MWHPR2201MB1037.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(10201501046)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR2201MB1037; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2201MB1037; 
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(136003)(346002)(376002)(39840400004)(366004)(396003)(199004)(189003)(6436002)(42882007)(97736004)(508600001)(7736002)(14454004)(58126008)(33716001)(93886005)(305945005)(111086002)(1076002)(316002)(6512007)(486006)(9686003)(8936002)(5660300001)(4326008)(476003)(44832011)(8676002)(81166006)(81156014)(7416002)(66066001)(2900100001)(71190400001)(71200400001)(11346002)(6916009)(6116002)(3846002)(2906002)(446003)(14444005)(53936002)(25786009)(6486002)(229853002)(256004)(99286004)(106356001)(68736007)(6506007)(386003)(102836004)(52116002)(105586002)(76176011)(33896004)(26005)(54906003)(6246003)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1037;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GXgddRJjvbjVPkkuuEr64xHVYrr8c6ZDU6HlJiGDproEHfLtnoROHshJFehSmKyfmHF/ZnrL430sMYgPW2/TWGEqtODfHApBN67a0zJa8VXVlpMpeGW7LnWpsTi6T9BBCC1uPl2++G++cZWwBf572p0YcjHlBc5gOaPE30aD/dKH9Ir8r9hrpx+1yXdgTkr96QGGU/QkPqNYDRgFwj4xkLQnCTUgYDqjYdlNoL8kKa4qwBo+1GSiuxlOAokj4cs7z0qbGVWfs5H6buTaYRR9pzS9I2EMUOeGRbB+gs4vBXShwkz3lEMj+6XPkEPzZvEOZeaTAzxjXIWqtTj+0mBo4H7MAfR2FkY3xXyCoB8grzY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F706FB6922E03E429949DE755647EBBE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7e7d8b-b793-4428-c375-08d64fe0c160
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 18:40:06.1081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1037
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
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "uclinux-h8-devel@lists.sourceforge.jp"
 <uclinux-h8-devel@lists.sourceforge.jp>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 Andy Lutomirski <luto@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>,
 "linux-audit@redhat.com" <linux-audit@redhat.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dmitry,

On Wed, Nov 21, 2018 at 03:44:22AM +0300, Dmitry V. Levin wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>=20
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>=20
>%
>=20
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/sysc=
all.h
> index 0170602a1e4e..52b633f20abd 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -73,7 +73,7 @@ static inline unsigned long mips_get_syscall_arg(unsign=
ed long *arg,
>  #ifdef CONFIG_64BIT
>  	case 4: case 5: case 6: case 7:
>  #ifdef CONFIG_MIPS32_O32
> -		if (test_thread_flag(TIF_32BIT_REGS))
> +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS))
>  			return get_user(*arg, (int *)usp + n);
>  		else
>  #endif

This ought to be test_tsk_thread_flag(task, TIF_32BIT_REGS) instead of
open-coding test_tsk_thread_flag.

More fundamentally though, this change doesn't seem to be (directly)
related to the change you describe in the commit message - it's not
syscall_get_arch being modified here. I suspect this should be a
separate commit, or if not please explain in the commit message why this
change is included.

Compounding the lack of clarity is the fact that I only received this
patch, not the whole series, so I can't view the change in the context
of the rest of the series.

> @@ -140,14 +140,14 @@ extern const unsigned long sys_call_table[];
>  extern const unsigned long sys32_call_table[];
>  extern const unsigned long sysn32_call_table[];
> =20
> -static inline int syscall_get_arch(void)
> +static inline int syscall_get_arch(struct task_struct *task)
>  {
>  	int arch =3D AUDIT_ARCH_MIPS;
>  #ifdef CONFIG_64BIT
> -	if (!test_thread_flag(TIF_32BIT_REGS)) {
> +	if (!test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS)) {
>  		arch |=3D __AUDIT_ARCH_64BIT;
>  		/* N32 sets only TIF_32BIT_ADDR */
> -		if (test_thread_flag(TIF_32BIT_ADDR))
> +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_ADDR))
>  			arch |=3D __AUDIT_ARCH_CONVENTION_MIPS64_N32;
>  	}
>  #endif

This does seem like the described change, but there are 2 more instances
of open-coding test_tsk_thread_flag which ought to be cleaned up.

Thanks,
    Paul
