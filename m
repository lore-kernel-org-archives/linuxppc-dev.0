Return-Path: <linuxppc-dev+bounces-21490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFD4CD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 02:57:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPcqQ1N6Rz2xSb;
	Tue, 26 May 2026 12:57:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:d101::"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779764242;
	cv=fail; b=Ri9DSGoKChEj+yHlFqE5z3+1vmeiOqGQD6VbDS7MScC7c5fCxnnZOScsPiVeJ+zeV8yo6jNFav0MD/8f23fmgACppYcGrLcV/Ge4nFLlKAV15T/GfdH7eS6addVYidrsdasSVJuSLaDdnpz2zIMfVKqH6RW/vpsV/9IBRyOrW/+Leq6goUQYnlElccitcDBt7S4lbqTRiM4sDx2aM8pt7M5porAgVU9hAcVniUNtWtJzi3T/yE87JltL44Wf8zMJjdAtfwjksPEeHXuPu0D8h4QJIE1SXh0snohpJFwZui1wf89hizfEQwTXeZeUbbzwjDucUcMa93booipVOAIFwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779764242; c=relaxed/relaxed;
	bh=yei1BelLDSnmx+IXXDFXNeTDPXNmUmksZlj66ZIIwrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LdGL896hboHlovXqDQtinLSKqujJmyPUEWXb0ltvcOMPsLy4jSsUEdfzlM6cikPCSxRTlBrbvUiZr56j9pYFwzMbQRUF/j+wOkkUKykwX26JJwzrT28SYZKjQExZKt+lO5mhN+nylx14w/QkliDyK33J2bf+yYo5HtpLHTgAoPaBiNp6gXGQg2iPkjBV+IPMWhAq6pbDfOAWpu2KKZhOYnMboTSbhUa+a8Mz3URmFnCYj/WSvizNpt1YZfrH0aVYDno0HngQ/IjphHn7L2jTdA5z0ex7Bq10mHV4RnMkLUjUTRF1rfGkaguSJYvqDh7OO4JfhxSVE2DoHY6OVgxiRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XKW1tuip; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d101::; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=mhklinux@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XKW1tuip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d101::; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=mhklinux@outlook.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn190110000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d101::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPcqN5nXXz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 12:57:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG+HV4rBvsgaGFQFYvLTC8IymqY85LGwBCf9GhKyUBpEYT9rYgSmYQgPZRbQ17epxgc3O6BTZzXadwy3EEd65Sr1Jv9qZHvDqbQhp2wMyanTOgiA529L1qXtEXt8o93kTpnYv/ikWjI/UzRy4xdu/Dm2ub90fgRA0q17e+GOnffrNlS75kEQHBVjYnF0zLV1pQ4Y9KvXEAHUKOGaupfEouAnGyo5kG1da0uFM7SkO/ShSdCtvV0h/fzn+eqKPdIskzGq8Lc/v3BMtAbL7iW/AuYQWuDyEMQMtsJ2esj19yYCeHCXJxh06AYc2o+qWSU3iV6/A4je9efkpRfbB5wCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yei1BelLDSnmx+IXXDFXNeTDPXNmUmksZlj66ZIIwrk=;
 b=KG1DcY0r4gE9+s/e5/R5DM+ydpegUNmI6LQkciytGRJM0dmhdBWyaF8ScpMphwXl+dWpwEdjiGRuglxBz5mHiIdZK/rxz57W7vUNdAe2wL10sZElvEEhAgGnYNjIw25BwoLI3gU8G9Prn3Ab2uQgXtx9sCYCgbSL4bcaHPNfFz9BilueE5nv4T2vwA2AXA872ePWqp0XMoxXEizWWKsxTzBiE+oztWCI1xWM2g/9yHy9QKxHPGMTbEGEZH/fzW1oyB8nVToyfaKH1+nrSk8G+wmRVInekRTO01bNAqTR0gNir6OIr96zZSiXVAzHMwHMcw2/zqdq45eY0O6hoz5ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yei1BelLDSnmx+IXXDFXNeTDPXNmUmksZlj66ZIIwrk=;
 b=XKW1tuipNMOt7J/YR4p+r3x2p3lcvrLFx5MxpaKZ7YCjmQlZbFVioXJgUJu27iRkgx28LZwK2vjPIQF/SefBpJpv03C5l/6n8ZK0IgQzrM9u5K83uNtAKGWW8OXbUf7QTsFpEY4eY/WxVCtgLFbde0mCFK6ce/rii7hYgnDKispi336/Gbzzi5OaaJUhKoGA+l89fjaY0Olfvej/sj2utwi5mjOMAx0+E/oiOeIQQhRby8OVYWoUFVdXpSUv2cX/9XFa9izF19ux4shy0/JkFLyLGzD7bwrbJgTuCKk8xkW6KNYvcsC24NocAYSao3b+pWrw74L15Wmuq0dCfPubnQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9515.namprd02.prod.outlook.com (2603:10b6:610:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:56:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 02:56:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Jiri
 Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy
	<aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Thread-Topic: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Thread-Index: AQHp6tfu5DGfxW+HBL9src0vNhss0QGHKPZ9tflmFZA=
Date: Tue, 26 May 2026 02:56:57 +0000
Message-ID:
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
In-Reply-To: <20260522042815.370873-11-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9515:EE_
x-ms-office365-filtering-correlation-id: aed58040-491f-4983-3c2d-08debad27362
x-ms-exchange-slblob-mailprops:
 9IecXKUgicAz80qrkIsT6kQ0LfhDX2IsWcHQciuYMUrut1JD3mUof57j+ZGnz3BDMJ33pcptrtsNfB1nR5NzG/s8HcaJ99skL679uM847K4aPKuukd9hq3M/QGNNUT+gWarbgXaFClQoghn7unFfS20gn9iH0a97AqGKT/G52fCZ1OUtc3JMcT9Eb8jp7tICa4ma69YE0khDkXYePCpbheB1p5sEZzPldLqSb5NOPNAoz5lScx9/CO58e+Rf6oY3s5klNgj0ws8BG+m6T+dum4SriqLLEOLE6LkHuocLzTQV8tUt8VQSKz8BiNNWgyWIjcUESY8CAPTUo9oNnmhp4EjC+gmA5VtQNVSEK+HJ+9C+ZyLpDioVNcQGZNYdMNTSdhAnsHMFNCZvYKw+f1EOUffAGlnCDI/8TYySm1gmjPN1M0o3Kz/iypldtmkd6Q1+umdZSw61CuMAPBj1Hxs2ZzgzmbyFWAA91YLq/tBdyKu8V8o6YnUDi0CJ4NEwyr1xwwU1ZiW2UTwwpB1cBMRiHMEYhioqnobRnI2CdpLC0UHQkdJ+RnvxU4QDcuhcl3vZwWsZeSy8i/W1Kfq8JjmmEIihMAyA1eeLLm1Me0XOSeBOm23XTLehBrWNjkHtBSIkDj6DNxFqq5qMhVhB3a94VlosU9U7b+kev4mPLh6nvQRTmllmLhdtkxr7sPfKMojxxMN0AHrOX37kF2UwpM/EXJZHdczFym/bGVhpl5pnmcpTyN2lUTKYDg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|13091999003|19110799012|15080799012|41001999006|8060799015|31061999003|19101099003|37011999003|440099028|3412199025|102099032|52005399003|41105399003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wWB0OS3byDqi33lC1+iWyKK/RZkm0JEYuQ9LJJtYNkAQ1C9reKc/yTlmbkjm?=
 =?us-ascii?Q?Y80O5F6uJL4my0BPcvFejtwh7miiM8VIQd7tmWxZBljqM65D2MnYLC4kkKO9?=
 =?us-ascii?Q?Aq1Mz+DVaIFM6vsedPIQ+dvFyouY4hljpCXyYW9Fy+Hcm7vVZWXp5k6beKMs?=
 =?us-ascii?Q?Sx6jcGlcwSZWS8pK7MC4o7f+m7dNvP5bFSW3hVClYYseASlxUoiY1q/Swoj2?=
 =?us-ascii?Q?r1pOp6JAivGauJWOG1Xe85wVZqy0OALOAcHBxcl8hSOYID3StdLFKy5Do6n0?=
 =?us-ascii?Q?TeRP8W0FQR+kA6IRX4YeyzIedbWjzffOSHjIKBLq6Kij3M3MQ0V7xMHA+MC3?=
 =?us-ascii?Q?oPTCLWsokBPJxmlHqkRCNKrD0xUIM5/hv7d+huGxrlgVKRwwfLktU3Hr3Njt?=
 =?us-ascii?Q?Lt20zR/8VVItaHRpKoJut1fqu7LCHoNha6DrXmV0a69BsyktcHWwQJ5mOdGI?=
 =?us-ascii?Q?ca46Rd4Ws9FJJ/q+Vdo54DwQX8gqM6oG5mFFXcrB+xMyR5kOAzJj8O3kgIHY?=
 =?us-ascii?Q?yUb47U0LQp85Kj1SOO+xM2DfmZgOuWMAYuyeVm1RUNEGeMJmEPVytxN9GzcU?=
 =?us-ascii?Q?B3zW5GnHYfmTtH/CjjwOwOERxEkYpspNIgXa8gGQEohevN9maOReIoq2P7af?=
 =?us-ascii?Q?EuSga42HI4g27XigYdzvb/EGTErQiZZNx+ehkoi2db00W0Cwuf9BjJHXiyYm?=
 =?us-ascii?Q?eaVumrmYoiaDvQIg0Cc8O2K1kP3VbU9c+weyMWNKKiGSL1FqZjcfBlORxwqp?=
 =?us-ascii?Q?jZKOjPx4sz2tflbifeRBBIgFhLeADR2SwkGkmytt7mrx86ZP65UfJEJPut8M?=
 =?us-ascii?Q?wzb6WNKswCbVsQ6bXrLcNSo7S9V5o3edvvg9G7UCn5k5EPOZaaEXCWyN3qwx?=
 =?us-ascii?Q?5hxGLJE3w5X8/mVEvMncHAJCKnRedTkJdF2L4joMIBuFzbgkGbtuFsoR7dOE?=
 =?us-ascii?Q?+J7MqvelWt2dwDT0MpPvsocw8k9PfkstPMEPuE8HgTHk213mOr/zdqONFfgL?=
 =?us-ascii?Q?NEONvMup4eAqbbtVyeKU/CdUm0Xly+qrPv5XfO2GsRsk4+SwXA36qoEfAgnf?=
 =?us-ascii?Q?1hwxUD4w?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+WL8doa3bPYcMGNLrhVm7RIh+tVU9VosFxep9HwWXQbVnNwQKLX3iDEP6glH?=
 =?us-ascii?Q?UpBfxKevdgKE/FoCwKX7g+0q6mMCGeD8GUPJ/YS1V6rxF0Rbb+2iLDdJb85c?=
 =?us-ascii?Q?7+PUj801lEqJU/7JSnXQZSV35RH8ejHSkRwZ3g5IDc8MEAdL627Kf2Ah0MPA?=
 =?us-ascii?Q?YPvuTvfLGXtsjvDYCqK88PMMrL7iTAZiHGVCKjBtPiutHlMNg/Zw935r/hWR?=
 =?us-ascii?Q?BarlghhAhEkAgqnKa0enIG3IeLNoDQK5Ry1VTk+xj27NhbSWPXzy/Hv252WF?=
 =?us-ascii?Q?FClpVvpgJB1ka9+vMj4DaL33n2erj0Lee38N6LFwgJGmQJdqgpRMFDLjuSvU?=
 =?us-ascii?Q?54VKzXklGcA4CZwYkr/zk4/n/sOHP+jhgX2vesKDAnPfawjuO6SR4/JdNxXC?=
 =?us-ascii?Q?sEqmW6JhduUt8a5vYqXvTSsmS4ln1fzfY7DAVSXk0+GtFHvGcddUhvGg9zep?=
 =?us-ascii?Q?qO03/WZq49Pr322ZB7keqiDRugIodaOV7V7WO+e6jn1b+xtShLpAjYSWDiVp?=
 =?us-ascii?Q?RJPdz02DCHPH35oUn9k6oGjeUM9xLRTtoaZr18IwEs+HZvWMM4XJ/OSNB53w?=
 =?us-ascii?Q?jK0a2uA45aouvhPzXDV7sd0B+Clf4XMLb0PBjkWq+7WF9gXdNp1jz5xKPb9/?=
 =?us-ascii?Q?6ZFY42NtGv6G1nqZcQWbcZ+nmIDji2qCx0PoPxS+iHI7ykurtwYsmXhITDRX?=
 =?us-ascii?Q?HIpMawfNvRMmj6MMKohpODli29ijx8CULyE5u7ifsmneYUYkiwx9P1k2w+LB?=
 =?us-ascii?Q?eiQ3fksHNTBxE3ACB+HkUyvVHPJ9eUshIUMTMNiESQA+XO0QGNrLGXY52vA8?=
 =?us-ascii?Q?5c767j2+9SEb8G7GitX6ZThhCTVni4vaZme0dJnqGG2FFo69hhb12BMC37dU?=
 =?us-ascii?Q?zIJUsltdZfc+GogtTSW18YFK7qSmmjvl/Tq2RDtyhjVvGkc9So/nN2fz9fMj?=
 =?us-ascii?Q?S5rbJn60emyuJ/cDuo6X6UztH2UNpGrzO9cW+AlypNHXRoK4FmqG8Z2hAJch?=
 =?us-ascii?Q?cj1MWr4iS4K/pdVPinbfejsh0j1bQhB4ZZSyKOm+uUFG1tHYzNuFXnsROxWg?=
 =?us-ascii?Q?B08Q77cj/myMc48JGdwMa8AVrnL/jir7Ukv20LIGBPFdi1+a8zpGumRVGFms?=
 =?us-ascii?Q?ELnZ5DhQjWxuG/bDOWujcldLbqLOZX8rFW7FRULI52g84IYUItjMaMYiiUng?=
 =?us-ascii?Q?wUb4QdOTywlbvhpawLmg5zmJp+PTgJK10RCmlAmzG7OH9D7MahMNwGm4pdoj?=
 =?us-ascii?Q?hpvye+5wpmYodthV4KW7U96iX5u3nSRYN46aCYQUhb4vOHgLpcy1bUJRYxnj?=
 =?us-ascii?Q?SdSavEY2PFUhe7+FJ5GvXX1rsIW32A2X/Fd25mkGi03cVUgLrPjttfQHLyiT?=
 =?us-ascii?Q?2UjobOY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: aed58040-491f-4983-3c2d-08debad27362
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 02:56:57.4661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9515

From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Thursday, May =
21, 2026 9:28 PM
>=20
> Teach dma_direct_map_phys() to select the DMA address encoding based on
> DMA_ATTR_CC_SHARED.
>=20
> Use phys_to_dma_unencrypted() for decrypted mappings and
> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
> but the source physical address is still encrypted, force the mapping
> through swiotlb so the DMA address and backing memory attributes remain
> consistent.
>=20
> Update the arm64, x86, s390 and powerpc secure-guest setup to not use
> swiotlb force option
>=20
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> Changes from v3:
> * Handle DMA_ATTR_MMIO
> ---
>  arch/arm64/mm/init.c                 |  4 +--
>  arch/powerpc/platforms/pseries/svm.c |  2 +-
>  arch/s390/mm/init.c                  |  2 +-
>  arch/x86/kernel/pci-dma.c            |  4 +--
>  kernel/dma/direct.c                  |  4 ++-
>  kernel/dma/direct.h                  | 45 +++++++++++++++-------------
>  6 files changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c1b223e7cc8e..a087ac5b15f7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -340,10 +340,8 @@ void __init arch_mm_preinit(void)
>  	unsigned int flags =3D SWIOTLB_VERBOSE;
>  	bool swiotlb =3D max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>=20
> -	if (is_realm_world()) {
> +	if (is_realm_world())
>  		swiotlb =3D true;
> -		flags |=3D SWIOTLB_FORCE;
> -	}
>=20
>  	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb)
> {
>  		/*
> diff --git a/arch/powerpc/platforms/pseries/svm.c
> b/arch/powerpc/platforms/pseries/svm.c
> index 384c9dc1899a..7a403dbd35ee 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -29,7 +29,7 @@ static int __init init_svm(void)
>  	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
>  	 * otherwise.
>  	 */
> -	ppc_swiotlb_flags |=3D SWIOTLB_ANY | SWIOTLB_FORCE;
> +	ppc_swiotlb_flags |=3D SWIOTLB_ANY;
>=20
>  	/* Share the SWIOTLB buffer with the host. */
>  	swiotlb_update_mem_attributes();
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index ad3c6d92b801..581af1483c42 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -163,7 +163,7 @@ static void __init pv_init(void)
>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>=20
>  	/* make sure bounce buffers are shared */
> -	swiotlb_init(true, SWIOTLB_FORCE | SWIOTLB_VERBOSE);
> +	swiotlb_init(true, SWIOTLB_VERBOSE);
>  	swiotlb_update_mem_attributes();
>  }
>=20
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 6267363e0189..75cf8f6ae8cd 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -59,10 +59,8 @@ static void __init pci_swiotlb_detect(void)
>  	 * bounce buffers as the hypervisor can't access arbitrary VM memory
>  	 * that is not explicitly shared with it.
>  	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		x86_swiotlb_enable =3D true;
> -		x86_swiotlb_flags |=3D SWIOTLB_FORCE;
> -	}

With this patch removing SWIOTLB_FORCE from four places in
kernel code, there are no remaining places where it is set.
The test of SWIOTLB_FORCE could be removed from
swiotlb_init_remap(), and its definition could be deleted
from include/linux/swiotlb.h.

Michael

