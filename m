Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102F2C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 19:32:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6673E218C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 19:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="NCjj78+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6673E218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43btLN1BRKzDr3T
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 06:32:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.73.123; helo=nam05-dm3-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="NCjj78+q"; 
 dkim-atps=neutral
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730123.outbound.protection.outlook.com [40.107.73.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bt9x6H2vzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 06:25:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH+nqXecd4XJOdhRgHxpM/1XQtILUU9L91QvDoEgzww=;
 b=NCjj78+qHrdaWHvF36kvYcifQwiTlShNqitusFWX8FlkfYZYnVZlu0TgAx0Nyp59H7hnbCOMXriPBOXL/YJ/njF7TKOdelFamkHdOCkef6z+AFnvVirKghfw1XhJZOhPk59leKyLIgS+m+4lRG6dn1VIDiD3535x5xk0R+3/pII=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHSPR00MB2400.namprd22.prod.outlook.com (10.171.151.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 19:25:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 19:25:18 +0000
From: Paul Burton <paul.burton@mips.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
Thread-Topic: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
Thread-Index: AQHUqQEbv9GqBtrBzEy9nMrieVYZQaWqdMAA
Date: Fri, 11 Jan 2019 19:25:17 +0000
Message-ID: <MWHPR2201MB12776696BE1B1E8EF4A90DA1C1850@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190110162435.309262-12-arnd@arndb.de>
In-Reply-To: <20190110162435.309262-12-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHSPR00MB2400;
 6:SomTMk/mVKaMESAK/AXinLQxx/KsR+jQ6+cxfWH8/DfmPdFYzDy2DiA6f4gQ1FwZCI/dh9I4muNf/2q8fl8IclVtFDPXv2DMMgNQT5I4IsbqRtnZFuQGEPk0Kv/6RGt23rVnVrJEFemySL/Er1wWL+DKDfrgNcYoloJlqOVoEpYkK2obzaT4+XP4Kj3Vawu2WwvfJo7Grmd1gKFodNktqz5XC7pkq+Sna74Pu6FtQg/8y0B6sE+w/rBOIbmRpSrAT2szZpgZFLGjBdYHOkEkvXeXmHU3Q+HMvGYF9SvOWvEX6xx2m6ZMsc+F2TabJ9/6XeXPLnbUNRPZb3Q9YbnWJFpbN9aB8PHatcHh2wxfAjKFZ/CmVk2Dx0TJ2kHhH4ecXpOP9CUFTJVt7Lyrt9O0jvBJoKavrioaSZQRdECEvqq0i/CPzMcGTixmC3q75ltXKw2j1ceS4vrMRDO7EWNPPQ==;
 5:vkBX1ZtpLgkD7z9AqqBKAMMYvw5lqig9JV5hKLvl+zWhOGJ7boU73g7EQMYZ0dm9DUwQRNeffzJ2A7wepWq8MuEgPLo/szTOUNx8gCDBSUhsjYkbsxkZkdU2KVU6yzeDalr0WvzBGWs9du30ECUkTUYXCPLkYDC4NoOYXf73wqDzj3Sd1QcFWMM/Y36TE9PjVFlvNgJJPbRmVbqbVXFqtg==;
 7:CdVq2cvIX4pqHNIEaQbWsYCjeHWu9/WRBUQijm+nLmdBKrOr7zwjWjx10H0q4Jm25V41smG8SjfCItF7vRK1ftjDCE6uI8KrlzuuJu3haojImZp+rmSWfl9700ptp6UcHj6LLYx4zlRh78ScfCzmEA==
x-ms-office365-filtering-correlation-id: 8dfe35c1-c55c-4d6f-ca7d-08d677fa84ec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHSPR00MB2400; 
x-ms-traffictypediagnostic: MWHSPR00MB2400:
x-microsoft-antispam-prvs: <MWHSPR00MB2400D3A06B87CF91EBC600A5C1850@MWHSPR00MB2400.namprd22.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(346002)(396003)(366004)(136003)(199004)(189003)(102836004)(229853002)(8676002)(74316002)(7416002)(305945005)(81166006)(5660300001)(81156014)(7736002)(6116002)(68736007)(8936002)(3846002)(6246003)(478600001)(7406005)(55016002)(9686003)(25786009)(2906002)(6916009)(53936002)(66066001)(6436002)(97736004)(4326008)(11346002)(446003)(476003)(39060400002)(4744005)(186003)(256004)(26005)(42882007)(33656002)(71200400001)(71190400001)(44832011)(316002)(486006)(54906003)(14454004)(111086002)(52116002)(6506007)(106356001)(386003)(76176011)(105586002)(7696005)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHSPR00MB2400;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aY2u+5Lnnma1NCwo4chyHeUpst2HmyyPHtyLbO13mo/vsrZbHvvSgCPRDP3xa8hlorcUc7R9v6F2g5g1JDCfcfheS/olYUY0kWLBJIQ20bvhVHJDvxUkJ71LaPTHnpeWBQDz7ybmb5xdIJSkM7zov8T28EU7rXBati2rlnlYS0tTsifbnFSoZsPF1OkWLuKS5/nzzLEtTy9WQfP1yPSQLCo6JHizqVnDMc9X1MIhEuJd+gHtiUHV/2CAOh+aPyRypXZtCOBAl+mDvv4DGTd8+J6rfyqpc32Uue+UEkT7AA59RCCkt1UvRwChgsz9U6/mIHh1txZWoKT4Hx+XuqlcdnO7Ez3X54h63bIPcDF6fKfDghqstBD0fFk3kDzGtLB0QkIgmfxA2tOdUSfvj5ixSaos0UBNaeWm/nEPwN7Zctg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfe35c1-c55c-4d6f-ca7d-08d677fa84ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 19:25:17.8656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB2400
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
Cc: Paul Burton <pburton@wavecomp.com>, "dalias@libc.org" <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
 "deller@gmx.de" <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "firoz.khan@linaro.org" <firoz.khan@linaro.org>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

Arnd Bergmann wrote:
> While reading through the sysvipc implementation, I noticed that the n32
> semctl/shmctl/msgctl system calls behave differently based on whether
> o32 support is enabled or not: Without o32, the IPC_64 flag passed by
> user space is rejected but calls without that flag get IPC_64 behavior.
>=20
> As far as I can tell, this was inadvertently changed by a cleanup patch
> but never noticed by anyone, possibly nobody has tried using sysvipc
> on n32 after linux-3.19.
>=20
> Change it back to the old behavior now.
>=20
> Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMP=
AT but no compat ABI.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
