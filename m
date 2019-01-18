Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC7C07EBF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 18:03:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326D020850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 18:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JvNQZwf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326D020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h82X0crczDrBJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 05:03:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.81.92; helo=nam01-by2-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="JvNQZwf6"; 
 dkim-atps=neutral
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr810092.outbound.protection.outlook.com [40.107.81.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h80d6NB9zDqsd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 05:02:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5NWazDTmeGYAYdRDVqWTFJDL8Hi++4oaTpYIJrLhak=;
 b=JvNQZwf6URSu8rSIpz4mfhxqinA373rumfuPVzkqDKb28e2NPsQhKrDMuZR+CudTS3so8H9dmDxaWHv8otgLgpbSLa/qLXHGqlPsw/4DucTnHdVfc6YQhAzlKe66lfOTwaQ6/ILUincSBi0BCEBm0mw8n/8NIvswildvha7dStI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1039.namprd22.prod.outlook.com (10.174.167.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Fri, 18 Jan 2019 18:02:03 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:02:03 +0000
From: Paul Burton <paul.burton@mips.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
Thread-Topic: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
Thread-Index: AQHUraHd8jRLB7x3YEeU6EKybqgDLKW1VI6A
Date: Fri, 18 Jan 2019 18:02:03 +0000
Message-ID: <20190118180201.uva5nhf2g23uamkn@pburton-laptop>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:300:93::31) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1039;
 6:eg8jrLQMI9BOqMPMBOvVQtsnp7IiFlJhkWuQkSM4lOXplOC6jGV0iw0ey+aOodRQK+FaoMV61ipPC3ZuUloRY+aWk9apMzvf/IlCGsaM3SrUhIYk1lRxFC5YGT2j6MLQvfxcdlatSTHM3fflmSxOOSoXzeWODZhi5c65cnCmOFRiV+DYeVulQqHLirdvWhL7WUk//L5vRTsDuENvDjZAZL4ytfVMbTlvcAvD2wNNZZHaiYr4r0iqxzgD6BiDYMiXSary8ZklIhydZaDqdNOEhmzjZ6PKT0gYTDjLYjq85FHDoO8DSqo1aLBUXb6S70vTR2BQLVmqdXKYSFw0arHgYcJi4ErN6dqZvavfr/yQI+6TjVWfvVSTEaxbE0w3oPh+9opM5GpEQdGrYnav2RRtEs66eGHohRMJs//QJF3VZdNUMOgwlcEGZnaUYiP+7p4kpxMCeutK6QDA4cM01HLERA==;
 5:V4uHkcsFXpdbjZ8TpiP4mG8ngHygafY+qapdBlYEX1jQ2PuNXYWuq1zVSTnxv8IXfTtu68aebzZglc1I2i1j08cR2IwzWql5jSF2VzkqZF/ZZioWwdUK+h/irxKQS19UKX9vaSKzki9iS5FJdYDj7V5SOuqtsV2R9D9i6XxQUA3T2ZNsWnJ0IqCrSewQLhpVDf7pSCU4NWt465FHC8Z3aQ==;
 7:9zSUn2KF4Lz9GDZ4fXiDBrkc2+BlNu5pVDiM8UtW8Oac51/eCbXL+kdsIvOeoUGytRe/ADQb9QDErl9DPxpmJH6jJRJRVCyCIGV9sX4looGK3W8fJWnsKa0QCKv5bUx7vPCD3xJidJ7QW7pX13WRsA==
x-ms-office365-filtering-correlation-id: 096921e6-6149-4482-5a4f-08d67d6f0cb9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1039; 
x-ms-traffictypediagnostic: MWHPR2201MB1039:
x-microsoft-antispam-prvs: <MWHPR2201MB10394CAEBE094B6FA9F41410C19C0@MWHPR2201MB1039.namprd22.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(39840400004)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(3846002)(66066001)(478600001)(52116002)(71200400001)(71190400001)(76176011)(7736002)(305945005)(1076003)(102836004)(186003)(26005)(256004)(42882007)(111086002)(81166006)(25786009)(11346002)(446003)(6916009)(8676002)(81156014)(476003)(8936002)(6486002)(6436002)(105586002)(6246003)(6512007)(33716001)(106356001)(7406005)(7416002)(54906003)(58126008)(229853002)(486006)(44832011)(6506007)(99286004)(5660300001)(33896004)(316002)(2906002)(97736004)(53936002)(14454004)(386003)(68736007)(39060400002)(4326008)(6116002)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1039;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uw3MyYOEWlVwYdAqkG3cRBimsfyCI9GHacSbNASN7RklAm2TDFzqUZpxBz/lDepbY4Z1DDMInYrofktkmPhY5svckQhV/fqfEg1zbLbaqIeZUOKKkbzw1QPdpiX3kI281LhhTgTcOZmD8+XOOJHix13XfFbIHtZoI2gtZ/XKEOxICcZZnajhWZSTr6m1FySawt8j8pjlu4QaHaV8cf+kUjc+LNAGYHgSVsZ0awnYgiEkfP6SiODy1TVnuJzdut7Sq7UXRahsqYQWpsjUBcCJeO4J0mKrXT1XvR9SxYUpppKD95LLHaI7r+AQ96JQAYui16Hp50Q648XWFOIirOPboVejYiv4/U4azmNVbEAYbL/d71jS42Y7zTPZQ6EQ5gk9lPrHDzBr9DYCl+15YEkp84bisGlEdNHsixF8mIIBieQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8AB5FF9934BD5A4E822E85B3C315428B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096921e6-6149-4482-5a4f-08d67d6f0cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:02:02.6648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1039
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "uclinux-h8-devel@lists.sourceforge.jp"
 <uclinux-h8-devel@lists.sourceforge.jp>, Petr Mladek <pmladek@suse.com>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vineet Gupta <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mike,

On Wed, Jan 16, 2019 at 03:44:19PM +0200, Mike Rapoport wrote:
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators wi=
th
> adjustment of parameters to include only relevant ones.
>=20
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
>=20
> @@
> expression ptr, size, align;
> @@
> ptr =3D memblock_alloc(size, align);
> + if (!ptr)
> + 	panic("%s: Failed to allocate %lu bytes align=3D0x%lx\n", __func__,
> size, align);
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>%
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octe=
on/dma-octeon.c
> index e8eb60e..db1deb2 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -245,6 +245,9 @@ void __init plat_swiotlb_setup(void)
>  	swiotlbsize =3D swiotlb_nslabs << IO_TLB_SHIFT;
> =20
>  	octeon_swiotlb =3D memblock_alloc_low(swiotlbsize, PAGE_SIZE);
> +	if (!octeon_swiotlb)
> +		panic("%s: Failed to allocate %lu bytes align=3D%lx\n",
> +		      __func__, swiotlbsize, PAGE_SIZE);
> =20
>  	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) =3D=3D -EN=
OMEM)
>  		panic("Cannot allocate SWIOTLB buffer");

That one should be %zu rather than %lu. The rest looks good, so with
that one tweak:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
