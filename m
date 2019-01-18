Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B49AC07EBF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:55:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209E920850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="oEIVoFNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209E920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h7sM0W3gzDr6b
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 04:55:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=wavecomp.com
 (client-ip=40.107.71.138; helo=nam05-by2-obe.outbound.protection.outlook.com;
 envelope-from=pburton@wavecomp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=wavesemi.onmicrosoft.com
 header.i=@wavesemi.onmicrosoft.com header.b="oEIVoFNO"; 
 dkim-atps=neutral
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710138.outbound.protection.outlook.com [40.107.71.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h7pv0Bd4zDr6x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 04:53:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMOM8O196eAFagU4Ul/4cB40eaDuvSu+yFz6aQcvq2g=;
 b=oEIVoFNOUSYW53tuMbQclAnHJB9YaEYV5vpwumGQNifk5gmo8THc6Pw8wFXn5YlGF3s68xqjT2OFAYeZ6hsIxsynLEK8f7HBTdZd/M4FalYNobCb57oFtPIrVHL2hqbaen204MTl+KtLt5JArP4KM8Aiw1aEFT4FHzI6BNoh8QE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1231.namprd22.prod.outlook.com (10.174.162.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 17:53:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 17:53:36 +0000
From: Paul Burton <paul.burton@mips.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 12/21] arch: use memblock_alloc() instead of
 memblock_alloc_from(size, align, 0)
Thread-Topic: [PATCH 12/21] arch: use memblock_alloc() instead of
 memblock_alloc_from(size, align, 0)
Thread-Index: AQHUraHHZvb7YTdQl0W4aFhrq8SopqW1UjIA
Date: Fri, 18 Jan 2019 17:53:36 +0000
Message-ID: <20190118175334.mj2mahbf4onhujgz@pburton-laptop>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-13-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-13-git-send-email-rppt@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2201MB1231;
 6:NBGsuzCLbpnGBREiCv95ZgVrJU5j8ZQ9vCKPHnZknrPfEGffTUSMoBXjYsOWlhWawru5fUfulHtzXt55vPdRctZVDcfxMlEUU4CuwFEoWh3TdFvp1EKFOlAtY6v7V3l0A/vdU0GmtbIh6sSvfYDopgGNkSN3HlUPvS7bm0ZZF2wptRWPfqnK2GbIq5BA3WC4/lS9YyLgtzyFOvEwdLmJA+coyMqGXjFTSWAyx00d1tvp3F7xW+2uteqeGGGYHO5L79lTU+fKC7pMgIYQQXLKhXXBZibd3fdMehslc2ZhpPRz7xNR8ymQMdHEfPis4aI0+kP2GByDd8JDN0/iNiBBy9KwVvueJVTDtzfpSC1YreT8IsqT7CCychNyRfGqyJahZcOhr6HA9JIxo+MXzwriYMaHFLQHCcANiBGxhP7JjNPK9eWooJP7v7Lo7t5Ow+QlVUN3AnqbJRbgOT92jgP03w==;
 5:Y311Ud4YaSAauPgF33PFLaGepapHkekvgpT7SrbnfAETIcUUe96moTmIrnF06nfAxT4oYXRDltcEcHK87xIiFI+Xdxp4YadnS+t3Xn250np6u1q4UYnQ1as0FKHvy1+v+RwMXcC3cdUdgUi3qHy+yd5Vp5dy+i9y2MeTl6Y67+XtT3N87Q+2ZPpiacepLngyyh2nHIvTYPu1R2hOUDTJNA==;
 7:pvyiJb2aUGlD4fByuour+k6vAnC/BnqGCG/alnrpmwlYqBhAkhozGIbbJipjRLbnjEeLB6B0zTx9cTTtiK122ftBZWmCqSsWso17L2sHIgBUzTo8w+NYU/Q10qxWRwEpKyen7GwmKxqto2IzAEtehA==
x-ms-office365-filtering-correlation-id: 389a8a4b-e155-413f-1b2b-08d67d6dde5e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR2201MB1231; 
x-ms-traffictypediagnostic: MWHPR2201MB1231:
x-microsoft-antispam-prvs: <MWHPR2201MB12315AB7DF0C62E827467DD6C19C0@MWHPR2201MB1231.namprd22.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(376002)(396003)(366004)(39850400004)(346002)(136003)(199004)(189003)(14454004)(8936002)(39060400002)(81166006)(106356001)(81156014)(8676002)(105586002)(7736002)(478600001)(305945005)(229853002)(97736004)(44832011)(68736007)(66066001)(6512007)(53936002)(111086002)(9686003)(4744005)(6916009)(3846002)(6116002)(71200400001)(7416002)(7406005)(102836004)(71190400001)(5660300001)(33716001)(11346002)(2906002)(58126008)(6246003)(99286004)(386003)(6506007)(4326008)(476003)(76176011)(54906003)(33896004)(486006)(42882007)(1076003)(186003)(316002)(26005)(6436002)(14444005)(256004)(25786009)(446003)(6486002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1231;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NY1b0/PAR1jaYy+VdOqE5Zd+AWe18eiUot7zGf9rnxubu+jl7MfET07t2IH3lPL15xtQ9Bg+uVDrZPnmtZ8fLFb7BMXthSWiNqlSoJYOH4fkzxc7TEa/n5ZkJEO+JFpwIKOJAxPi5qEZeDraBO9zLXoNQrl1QUY7tfzq+WueItwcBwwQT9zvHmeFJ8UkwCpVyTFB0kNrmULUIOM1CKOlRRz/1w+LYapkLftXUKJrWoDYTScs02StJPDa8FbDjT39Rv06khzaMrIjqW4OuQR7Bb6Z6xS+3ye2JMorL1VYKq7PuJ1une2uOqrBJKxelUHe5bF1wscI8YZCADV3cw/G7jjK0e5UuwMztJ08nPGPCf9RuBupBn+BdKY2yaPlSDzje16YSIDdAByTQAHGasb9Nk/Wx9lfX/BxzWDVEgiYo8A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27E0FF00A643614DAB51ABA4F92A557E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389a8a4b-e155-413f-1b2b-08d67d6dde5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 17:53:35.3869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1231
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

On Wed, Jan 16, 2019 at 03:44:12PM +0200, Mike Rapoport wrote:
> The last parameter of memblock_alloc_from() is the lower limit for the
> memory allocation. When it is 0, the call is equivalent to
> memblock_alloc().
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS part

Thanks,
    Paul
