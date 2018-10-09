Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C68C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C632087D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EfdnyWPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C632087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VCTy4XshzF33P
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 10:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EfdnyWPz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=104.47.36.115; helo=nam02-sn1-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="EfdnyWPz"; 
 dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0115.outbound.protection.outlook.com [104.47.36.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VCR330GCzF2Dy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 10:01:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+HhjWAMCdXZohntLO9fRopZreqMCdmZG2vRYZta1Kc=;
 b=EfdnyWPzzDMBnFTOgK2eTA7Ccrdf4wqPWM+c7MxgF/bFrenm3rBJzGAEcK8koONFOwpDzsbnvUG1lzuiy5l1y+9hYMmtKckflLW/fuA9qS3D9nQ+/ZFiyaCrH2MBukhX0nF93qd2OuUOMyBc29XZcj2/jrvVcbzz+47oAzNY/OA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1181.namprd22.prod.outlook.com (10.174.169.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Tue, 9 Oct 2018 23:01:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.020; Tue, 9 Oct 2018
 23:01:41 +0000
From: Paul Burton <paul.burton@mips.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
Thread-Topic: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
Thread-Index: AQHUXCY/RflcQuwjxk6Km8qdVUMh/KUXj8OA
Date: Tue, 9 Oct 2018 23:01:40 +0000
Message-ID: <20181009230137.rju3lm2saou5xsa4@pburton-laptop>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0025.prod.exchangelabs.com (2603:10b6:805:1::38)
 To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1181;
 6:gE0TJRoEjPWm6K8r4aVdQ5ub749GUBvebh3oAJRbOgmcF79A3M056LIulOy0AML0q2DvnzT5E2UG22YNBfWWgX6ipSmoVZ8RQwRwHZLxyhYQhRiTYk8byk9USHjAm/EE5tyBKQltsa0MYs/enWT4IOJLpQG/RElTahYAxXqhh00Uvtr6jUTnA+0jdzBTA7m1IM6J82lh+1miRtJjEs2K4iDGnh56pRw7eCqiXk+tiAc15vSOj8lXQhyb8uLxleHOBA0gr5xFe0Q+jKbaGqNV19MdXh4VfCojTpbR9cMoWP/c8pGw/9jWSZKz0UanEwGv0G5j9rCDN4lBLxRuE8RI4ldV+aRaNTIzi+NzgJKVZR4de4P6BhBzJAk0PjTMDGt0YXhelq+2xiZzWypOE3dh1Sb4V5SJQ85I9JyOdPvzHDLJIiNooTmtjIBMr1lWzBWIwN/25wDwQwdeYnBDnF5GYA==;
 5:n9CYNnQply5QBqok1gMTvLCkmCwVWX4V+9tGr1/aeitTaCaoU5JAsa6G7MM2t5DnPP1MHfn9vB6H3Ai0ktZpJaOIjtQLyqcAU5sEI4mFu/Ut5NDXcrdAALzDjBl6fzuut1DHKinCpNLuCvsJwVnI7cIfZI1FhZHtsUPeExNYRC4=;
 7:RMqlqCHYIRdnjUhSQH76ftPgvxQtizaicZEdWG2107NqPmz9h1JwW9fJx2jZIYZjYmkMpZzNi2kcIgJboPYUVBZ4MYhJJvPaNJ8dzyZF+P6Ps/Cp11kQCqFXBAosXeHtHYM/Z8u6weAA/i26PctdYVl5xurOF+zHTvZAE4AMsfa9j1JU5y1UhDSFOOyTf2jN/P+qYF2uGhKhD+UaTxUoGXdXD5LD49LftEn/jZhGK3qf4SRjDqBkO4qfwOdr2hUl
x-ms-office365-filtering-correlation-id: 1dd53e6a-d129-467b-6207-08d62e3b2bff
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1181; 
x-ms-traffictypediagnostic: MWHPR2201MB1181:
x-microsoft-antispam-prvs: <MWHPR2201MB1181628E9AF119B0FEB27F30C1E70@MWHPR2201MB1181.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);
 SRVR:MWHPR2201MB1181; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2201MB1181; 
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(68736007)(486006)(446003)(7416002)(11346002)(476003)(46003)(42882007)(7736002)(305945005)(256004)(316002)(6116002)(5660300001)(44832011)(102836004)(6916009)(186003)(8676002)(4326008)(6486002)(81156014)(33716001)(14454004)(2900100001)(8936002)(6436002)(39060400002)(33896004)(386003)(58126008)(99286004)(6512007)(81166006)(6506007)(53936002)(76176011)(9686003)(229853002)(25786009)(54906003)(97736004)(105586002)(2906002)(1076002)(106356001)(71190400001)(71200400001)(5250100002)(52116002)(508600001)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1181;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V7/fkerKu+UAYOeNyNcoG+j0JGxrX/PMDxDqCpFtGPgGsNosdiyH/sHGuhQnJUELdHTfHaT8E7u6WaSxB5orSLHIoNI2FTfNmg2937YG/fnzKv0GuhMbceZYDTS0le3yp6wv7R+L6RdEWYJWlrO78uyMHW5ocskZvB5Zi92g8rPrrAr8V+k5YLTbQKhpCafz7meRgm1XkTidSrygQxNb89RuuojFFxxtddLGJ6mCmOp3vcG62URYK+46quEQLJX2C2CMJdtIQRNxAnnaYFJ7ikGgEhXDYcC2y3FXXLBXyBWY04KVVeQfD4g9+Tdse1wzjhSG61Q7oF6TI+mbgyePIIGSqNDH5Q674CkQUriYSiI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3554E11A6C0914FA9C02D46ED897C1C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd53e6a-d129-467b-6207-08d62e3b2bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 23:01:40.6702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1181
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
 Michal Hocko <mhocko@suse.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mike,

On Fri, Oct 05, 2018 at 12:07:04AM +0300, Mike Rapoport wrote:
> When a memblock allocation APIs are called with align =3D 0, the alignmen=
t is
> implicitly set to SMP_CACHE_BYTES.
>=20
> Replace all such uses of memblock APIs with the 'align' parameter explici=
tly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
>=20
>%
>=20
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

  Acked-by: Paul Burton <paul.burton@mips.com> # MIPS part

Thanks,
    Paul
