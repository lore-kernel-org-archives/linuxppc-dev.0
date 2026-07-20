Return-Path: <linuxppc-dev+bounces-24477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E130C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:53:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3cmq3vhTz2yXj;
	Mon, 20 Jul 2026 20:52:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784540317;
	cv=pass; b=UQokBU2hluxdk23GI9kkIjwyj5d9BjTDff5mvi1eC7g2ScZQEBVXAOW4pf5FaTcffon268TOVsRHjpvomCTq4tPh/dHPrsmAjhO5vehckDznC1NALZyTNcPQ2fWXe/RAOodGl1X1HOGY6tLLNDeoDquLH/zjG8/NniGgCooEaSrHNOmCBysBdKQsllG08TNWguiaysp8afUf9qoj7zW2h3wbak/QyNAbhoNT5uQh2fCMKK7E+baUu7kc8TDgVtvJHJELcTJkTYA2ldFH7gnOO9BUKphhbCwE1oFX21kABCxHRAlSGoR/ImDePjfH3uvYgX0is1lYvKSmwkDxXoEtfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784540317; c=relaxed/relaxed;
	bh=S0tdWGsY8ovK8tJeJyM3lFSP9EHZNI48Z0Uy16r6Azs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fEVYW+wQG9Nfk0KIaq5fJCe/DqLz25FWF1qYZi6xLVOz93VotgCoHhc4NI4Vpgg14MAI4OBUwzI/bqIFDjGq5jEVUyedNggIVVq6C6zODT7MOiGf2vk0Rc33wR21d/nm+hu3CmJBGiBxkXOoO25MCxE7WntwazB7HJHPUhTuJ6Tul5wIwcu9gow1TMih9sAwraP8oST4FHvA8Ynm1/wRStVktsaJfoII878HM9AsZCXfiFNKxg52xT4saYbxaRnk5+SeA9rsrB69J6V7w+sS1+YM5XHCim3+X0PBYSykS0aqsSL2p+8U+dSVJWZ27gO4StCBhdXU5JrbHK6HHkFI2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=transsion.com; dkim=pass (1024-bit key; unprotected) header.d=transsion.com header.i=@transsion.com header.a=rsa-sha256 header.s=selector1 header.b=UWH7Mfa2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=hongyan.xia@transsion.com; receiver=lists.ozlabs.org) smtp.mailfrom=transsion.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=transsion.com header.i=@transsion.com header.a=rsa-sha256 header.s=selector1 header.b=UWH7Mfa2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=transsion.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=hongyan.xia@transsion.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3b6z6yjXz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:38:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYQFWwU4BhmfJKviDLZGgEgrjOyJ+2Kovi4iEAGG/TbAHrmiyVh217EI+RIi1AFmj9vP8dEUlkqSY97qUB4pci07pKAqCFLH6R6HI/37wXr15XY35WDl9PY/rywFB8GRgcUgMQ4oL8a/MEcwrQhq/6ucoaocb96oCV539xORC0SI93WHkMffH3ufF2v7P32MxjPNmmJNuv6xFyDUbV3owU9ZdMv8Yw6UrgWpmEuitGfD2cuXYbwhO7Iob0t8HVSiKh0ytHare30w62ALyQ6NOemlPBxD0bHO3l3tUFmPXPWA4k6/zvvc64+R1kkW5ICJiy0obpKGYUmLN+V916RAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0tdWGsY8ovK8tJeJyM3lFSP9EHZNI48Z0Uy16r6Azs=;
 b=KvOeDp4or4NHf3vkt+CvwU8QCX+OQz23zdo/nGiE4hEHtZ8IYanCl+xawHths7oDR7NAGXP2yIfqBLnPFSS+7/ucLmuI2l3lZpL90EGsKb3YGThAq+ao7S8kiMrxmyx6E+E2IXqXLjXRZ18hbL1rnRViEi9LmHTkBPbTfvgo7a4A3I6jbAlBLwtGxSgm6esKpSKbX9JtZLnaLL/SFsXMOIu8gQk1qiLJ+4S+Kp0EHeuV1plZNw20eyFw/LHxZo1QKxljKjsIOFM9zZAWanuUSPR6VvFwVF8PAEniiHzlFAG8rhEKXcGUZgQLoiM9JBQV805wtMAXn6JmZRxuM2mYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0tdWGsY8ovK8tJeJyM3lFSP9EHZNI48Z0Uy16r6Azs=;
 b=UWH7Mfa20aRABHcBN1gY0dimzV9YAvCxgfcai7PVU+DoZgHr5bwVKoag4Xef+2N9eEhhC3NReSxtiVjsnG0WoWMK3XnVYNpFibMNmNE2P/ReIuhlhihfdlPZ+/9FD9COTBdIYnlT86LPtuCMYbJn9vKKnDuyz9yHqgnxwSfLi48=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by TYSPR04MB7923.apcprd04.prod.outlook.com
 (2603:1096:405:8f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.6; Mon, 20 Jul
 2026 09:38:10 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0245.009; Mon, 20 Jul 2026
 09:38:10 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner
	<tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: Jiazi Li <jiazi.li@transsion.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>
Subject: [PATCH 2/3] sched: Convert paravirt_steal to new static key APIs
Thread-Topic: [PATCH 2/3] sched: Convert paravirt_steal to new static key APIs
Thread-Index: AQHdGCt41jgQ0Gd26kKdzbVxHXHoxA==
Date: Mon, 20 Jul 2026 09:38:07 +0000
Message-ID:
 <773bbd8fcd5ef2ebfe1c64303c7a71a56368de69.1784538478.git.hongyan.xia@transsion.com>
References: <cover.1784538478.git.hongyan.xia@transsion.com>
In-Reply-To: <cover.1784538478.git.hongyan.xia@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|TYSPR04MB7923:EE_
x-ms-office365-filtering-correlation-id: 63fea150-c8cb-4d86-a7ac-08dee6429caa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|10067099003|56012099006|11063799006|38070700021|6133799003|22082099003|18002099003|921020;
x-microsoft-antispam-message-info:
 yh5mlue1Iw8cl0uEdIvMARq0emXCCTnLQUzpkmJ/bGuZg1DAJNMCdD0eZgjEQ5YoKdbt7wJiu4uINN5s8w4qI32lIAA1yhm8hecS/eyEPjlvFfcmTgExOVgF7SvRQAeK3uweD05fpdKR24cNVFSWdU2LCCJgMPO5YfERS25h7q52/esYgCQnbLJ0uMZ+6gCTVAWbBuW2o86hVWqRWZnsRJEAtpQd1bXSkchaN0T7/G6CMUXOMzmJpNwXj7Msp52kdHyi8Pl/5e8NB5PcF8jbI9HuJ4T5ik5D45L6MH2wze+PHtqytWSUWQG02n5TxSFbVAv0DCSS21XwoX4LjOU60NlnZmmhEG96wz8pboybvvI80Z5esLacGPji0hypFz5EHkR4awn3Z2qhFwd/NWgfuN1JbXjejzQdbEwOtBaNOvX0gPNpZ1lp0pOk30I+BzDJ1MorSb+TWs/3ETgleLUFFusDOj2kaVtBhV7oWFYgfswVIYhF8XG6KnRIhCUoOcXkv2bqdOiIA5geQdGwf7Oc6sbLGpqBopRbOWa37Isf7/J378wzb+HiXcGk8elu0UY7O+S1gOe8c9HlmfyIG5Jbu7DjGUW1Lw1IvNrx+rSrVx2fr324geruXdtX2JzpAIvSMSodSKwaLnpGDV3Cf9heUhlIL7lFQtCbphC9qfMwQuDCZSU6JIili1Ki9Wnsk0AKlOKIVaP+PgISQjz5tzaMuxrOocKEA75LyQBhnQkF2IPcosfvF2E+y1cKRjKZsMId
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(10067099003)(56012099006)(11063799006)(38070700021)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eBUVMW7/w2cI/IxTnB8SV7GR+w1qa7lThnaWmawlaQG7fv5lnQhEw/06Hk?=
 =?iso-8859-1?Q?A20S/9p8yJp8vMFMFBt64Q+ktwMGf5YzVjOdUJUZWUywbOOGQQ6Xd8SOlx?=
 =?iso-8859-1?Q?RviphnmYISWfbpOlM6wuN9IKxvjiPPcNDLm7oy4CQ7+vRl0+nkJfyzVtIe?=
 =?iso-8859-1?Q?0/c9DLzDaxMb1SnDc0KgeXxo0Zhcztbuw33qtKBiNypfFOLK46wosVUpcI?=
 =?iso-8859-1?Q?UOwCPMou35+Ax8fJPfNnS7eEAX5kFsROGoeZoqt87hX59FLl89nn/n0727?=
 =?iso-8859-1?Q?ce79hLA4m3GOWMdqm+NZINaIOYBoA+zMjvJO60NzkwIc29xiKE6hFvMOG2?=
 =?iso-8859-1?Q?PV1oLK6NXsnR2GYRGStPQhnfRnhFuYBBy+tpyAazgCfPpRirt6mKTpc48L?=
 =?iso-8859-1?Q?rK/SsL5N4AqYpitxTM+NZr/pWYU6GrzZ+BAZdVmh7IPo1LTS92Eoau8FTV?=
 =?iso-8859-1?Q?qdCT6a1CMLBVjqNWT6lJvXb8fdElZCPHHghvLyzqtNme8Bv95swiP8fJvm?=
 =?iso-8859-1?Q?ENEqgzaASdoWVTfIWJeONkB7QltIG8krk4kU0KgaQHq3tsTPeLOdOTtpsK?=
 =?iso-8859-1?Q?dvqj8Jo1IBAdeneHidkf1yXY6x7BDJRTeqDNu/QTLsUTz/JCPuU5pxU3xD?=
 =?iso-8859-1?Q?6mY7C+Jv8P86aLqEVNGgq/mz7wukYbhepaOuLfB7j8oM47XCTbkvW5QvC7?=
 =?iso-8859-1?Q?a39sOPR64joC5WttLC9a9BRIcj9JZuWyc7j9BYYKPtrYCA9ThPuFan2gI9?=
 =?iso-8859-1?Q?1R3bnKS6WeAkjsgz4Kvqp9AErbttAWgSEx+uMz7jB2rIsL9XKMWwpsz/UQ?=
 =?iso-8859-1?Q?3PzcqhENmQ19aWZknX0ceaNxsB1muHeiD5THFa+/VNsELRIde7PofXo3SJ?=
 =?iso-8859-1?Q?fL3tNtiAK0buMdj9AhRJX6Tr03vdCVB1DHCPgw0JXpPkF3saJ7PC1hN4ze?=
 =?iso-8859-1?Q?/7EKK5OpK0ZJAk8/0fhxf58v5hUU3bYMe43UsQZ7q7Jt7QMgTsaFkV/E4a?=
 =?iso-8859-1?Q?XLSy+IcwA+duL52gB+3N+MAHZ6GW3KLVjmIPZsOIPSOW3A51HoyA2XEk9G?=
 =?iso-8859-1?Q?Hu4xF8MWvCTdAV9gXB66bUtFUSODAwVnPUmM4OHCBY38y7MjhJ0W84P2B7?=
 =?iso-8859-1?Q?PLxfEy4nc4nT3juDVA0PgTR47otXzvqOu0q6Zse9qdgNDh3ynLKBdwXD7i?=
 =?iso-8859-1?Q?95p/uQKUrXqJADAdYHA5A3h5sxRWbQ643qfBP1R6Yk5hvPBT0AF0yP7xVb?=
 =?iso-8859-1?Q?RoQAigoZK0MiIvisRFMKldDLnd5xcEEEk9GHj25Okd6hUa++CGMLY9a+xI?=
 =?iso-8859-1?Q?XF5MZT6FtNwYMN8pperlWmmaP1gEGVg0nHj5+1nNiDpbfonE0KRo3DfBe3?=
 =?iso-8859-1?Q?HDdmPLiqv6ZAAi+GstAc8xUvkfV7LUrtHMs2f61KRsNL5S4asGVjr6oCar?=
 =?iso-8859-1?Q?uYn/uPai2zvo+zUDaTDWOd/o2ggmoE3UeqsTWGfxjekNxEbMS1lXt9zXND?=
 =?iso-8859-1?Q?wZm0OqEcDec2LUHyk6wyHCoTyVVixmL3eUQOjO7+/1z4WzMe7OwM6FSOyV?=
 =?iso-8859-1?Q?4WB8GwXVKp2BNQKVNGV6TC0eg48ph/XC0/AuxCxwtOWFKIb4wzrNp4bk0m?=
 =?iso-8859-1?Q?iNEZa/d9+1EQ5XCy/bYoVFNte9DEkJ2t1EzMmsmIXom5fR2o2x5lL5RL5Z?=
 =?iso-8859-1?Q?19/kFehHikj4+xEeCu/8nJPXEwkup2SrDquFZ0RDJfY1WpzRsr+zGk2ESe?=
 =?iso-8859-1?Q?mF7JqZFjwzKdT2wu8cgUO8JEEtwfzVrPPUZAAGouRnAqacoprVJoH3AE9l?=
 =?iso-8859-1?Q?Oh1w4/zEdg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fea150-c8cb-4d86-a7ac-08dee6429caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:38:07.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iL3zE7b8rMUVTzwzyUk7DRTgOGTS2BPssQcGsgjIRskDDC2269Ewz5hnWQ43ECc/YJhsXvWGFpyzWFVs5qeCW6ZWLNABU9tWKNQnzoaHuJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7923

From: Hongyan Xia <hongyan.xia@transsion.com>=0A=
=0A=
paravirt_steal_rq_enabled and paravirt_steal_enabled use raw static_key=0A=
APIs which are now deprecated. Use the new API instead.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>=0A=
---=0A=
 arch/arm64/kernel/paravirt.c           | 4 ++--=0A=
 arch/loongarch/kernel/paravirt.c       | 4 ++--=0A=
 arch/powerpc/platforms/pseries/setup.c | 4 ++--=0A=
 arch/riscv/kernel/paravirt.c           | 4 ++--=0A=
 arch/x86/kernel/cpu/vmware.c           | 4 ++--=0A=
 arch/x86/kernel/kvm.c                  | 4 ++--=0A=
 drivers/xen/time.c                     | 4 ++--=0A=
 include/linux/sched/cputime.h          | 6 +++---=0A=
 kernel/sched/core.c                    | 4 ++--=0A=
 kernel/sched/cputime.c                 | 4 ++--=0A=
 10 files changed, 21 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c=0A=
index 572efb96b23f..30bf61d031eb 100644=0A=
--- a/arch/arm64/kernel/paravirt.c=0A=
+++ b/arch/arm64/kernel/paravirt.c=0A=
@@ -157,9 +157,9 @@ int __init pv_time_init(void)=0A=
 =0A=
 	static_call_update(pv_steal_clock, para_steal_clock);=0A=
 =0A=
-	static_key_slow_inc(&paravirt_steal_enabled);=0A=
+	static_branch_inc(&paravirt_steal_enabled);=0A=
 	if (steal_acc)=0A=
-		static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+		static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 =0A=
 	pr_info("using stolen time PV\n");=0A=
 =0A=
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/parav=
irt.c=0A=
index 10821cce554c..e8965a3f8082 100644=0A=
--- a/arch/loongarch/kernel/paravirt.c=0A=
+++ b/arch/loongarch/kernel/paravirt.c=0A=
@@ -308,10 +308,10 @@ int __init pv_time_init(void)=0A=
 =0A=
 	static_call_update(pv_steal_clock, paravt_steal_clock);=0A=
 =0A=
-	static_key_slow_inc(&paravirt_steal_enabled);=0A=
+	static_branch_inc(&paravirt_steal_enabled);=0A=
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING=0A=
 	if (steal_acc)=0A=
-		static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+		static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 #endif=0A=
 =0A=
 	if (static_key_enabled(&virt_preempt_key))=0A=
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platform=
s/pseries/setup.c=0A=
index 1223dc961242..8dcbc4bb7025 100644=0A=
--- a/arch/powerpc/platforms/pseries/setup.c=0A=
+++ b/arch/powerpc/platforms/pseries/setup.c=0A=
@@ -852,9 +852,9 @@ static void __init pSeries_setup_arch(void)=0A=
 			static_branch_enable(&shared_processor);=0A=
 			pv_spinlocks_init();=0A=
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING=0A=
-			static_key_slow_inc(&paravirt_steal_enabled);=0A=
+			static_branch_inc(&paravirt_steal_enabled);=0A=
 			if (steal_acc)=0A=
-				static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+				static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 #endif=0A=
 		}=0A=
 =0A=
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c=0A=
index 5f56be79cd06..9c13a6f1ea2a 100644=0A=
--- a/arch/riscv/kernel/paravirt.c=0A=
+++ b/arch/riscv/kernel/paravirt.c=0A=
@@ -116,9 +116,9 @@ int __init pv_time_init(void)=0A=
 =0A=
 	static_call_update(pv_steal_clock, pv_time_steal_clock);=0A=
 =0A=
-	static_key_slow_inc(&paravirt_steal_enabled);=0A=
+	static_branch_inc(&paravirt_steal_enabled);=0A=
 	if (steal_acc)=0A=
-		static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+		static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 =0A=
 	pr_info("Computing paravirt steal-time\n");=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c=0A=
index 34b73573b108..f7ab9e7902cf 100644=0A=
--- a/arch/x86/kernel/cpu/vmware.c=0A=
+++ b/arch/x86/kernel/cpu/vmware.c=0A=
@@ -328,9 +328,9 @@ static int vmware_cpu_down_prepare(unsigned int cpu)=0A=
 static __init int activate_jump_labels(void)=0A=
 {=0A=
 	if (has_steal_clock) {=0A=
-		static_key_slow_inc(&paravirt_steal_enabled);=0A=
+		static_branch_inc(&paravirt_steal_enabled);=0A=
 		if (steal_acc)=0A=
-			static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+			static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c=0A=
index dcef84da304b..d3dcd64f22c2 100644=0A=
--- a/arch/x86/kernel/kvm.c=0A=
+++ b/arch/x86/kernel/kvm.c=0A=
@@ -1052,9 +1052,9 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm=
 =3D {=0A=
 static __init int activate_jump_labels(void)=0A=
 {=0A=
 	if (has_steal_clock) {=0A=
-		static_key_slow_inc(&paravirt_steal_enabled);=0A=
+		static_branch_inc(&paravirt_steal_enabled);=0A=
 		if (steal_acc)=0A=
-			static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+			static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
diff --git a/drivers/xen/time.c b/drivers/xen/time.c=0A=
index a2be0a4d45b0..a02d48a2aa68 100644=0A=
--- a/drivers/xen/time.c=0A=
+++ b/drivers/xen/time.c=0A=
@@ -169,7 +169,7 @@ void __init xen_time_setup_guest(void)=0A=
 =0A=
 	static_call_update(pv_steal_clock, xen_steal_clock);=0A=
 =0A=
-	static_key_slow_inc(&paravirt_steal_enabled);=0A=
+	static_branch_inc(&paravirt_steal_enabled);=0A=
 	if (xen_runstate_remote)=0A=
-		static_key_slow_inc(&paravirt_steal_rq_enabled);=0A=
+		static_branch_inc(&paravirt_steal_rq_enabled);=0A=
 }=0A=
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h=
=0A=
index e90efaf6d26e..694126411dfe 100644=0A=
--- a/include/linux/sched/cputime.h=0A=
+++ b/include/linux/sched/cputime.h=0A=
@@ -182,9 +182,9 @@ extern unsigned long long=0A=
 task_sched_runtime(struct task_struct *task);=0A=
 =0A=
 #ifdef CONFIG_PARAVIRT=0A=
-struct static_key;=0A=
-extern struct static_key paravirt_steal_enabled;=0A=
-extern struct static_key paravirt_steal_rq_enabled;=0A=
+#include <linux/jump_label.h>=0A=
+DECLARE_STATIC_KEY_FALSE(paravirt_steal_enabled);=0A=
+DECLARE_STATIC_KEY_FALSE(paravirt_steal_rq_enabled);=0A=
 =0A=
 #ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN=0A=
 u64 dummy_steal_clock(int cpu);=0A=
diff --git a/kernel/sched/core.c b/kernel/sched/core.c=0A=
index 96226707c2f6..786975d4ca1e 100644=0A=
--- a/kernel/sched/core.c=0A=
+++ b/kernel/sched/core.c=0A=
@@ -795,7 +795,7 @@ struct rq *_task_rq_lock(struct task_struct *p, struct =
rq_flags *rf)=0A=
 =0A=
 /* Use CONFIG_PARAVIRT as this will avoid more #ifdef in arch code. */=0A=
 #ifdef CONFIG_PARAVIRT=0A=
-struct static_key paravirt_steal_rq_enabled;=0A=
+DEFINE_STATIC_KEY_FALSE(paravirt_steal_rq_enabled);=0A=
 #endif=0A=
 =0A=
 static void update_rq_clock_task(struct rq *rq, s64 delta)=0A=
@@ -834,7 +834,7 @@ static void update_rq_clock_task(struct rq *rq, s64 del=
ta)=0A=
 	}=0A=
 #endif=0A=
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING=0A=
-	if (static_key_false((&paravirt_steal_rq_enabled))) {=0A=
+	if (static_branch_unlikely(&paravirt_steal_rq_enabled)) {=0A=
 		u64 prev_steal;=0A=
 =0A=
 		steal =3D prev_steal =3D paravirt_steal_clock(cpu_of(rq));=0A=
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c=0A=
index 06bddaa738e5..f16970ca81d0 100644=0A=
--- a/kernel/sched/cputime.c=0A=
+++ b/kernel/sched/cputime.c=0A=
@@ -255,7 +255,7 @@ void __account_forceidle_time(struct task_struct *p, u6=
4 delta)=0A=
  * occasion account more time than the calling functions think elapsed.=0A=
  */=0A=
 #ifdef CONFIG_PARAVIRT=0A=
-struct static_key paravirt_steal_enabled;=0A=
+DEFINE_STATIC_KEY_FALSE(paravirt_steal_enabled);=0A=
 =0A=
 #ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN=0A=
 static u64 native_steal_clock(int cpu)=0A=
@@ -270,7 +270,7 @@ DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);=
=0A=
 static __always_inline u64 steal_account_process_time(u64 maxtime)=0A=
 {=0A=
 #ifdef CONFIG_PARAVIRT=0A=
-	if (static_key_false(&paravirt_steal_enabled)) {=0A=
+	if (static_branch_unlikely(&paravirt_steal_enabled)) {=0A=
 		u64 steal;=0A=
 =0A=
 		steal =3D paravirt_steal_clock(smp_processor_id());=0A=
-- =0A=
2.47.3=0A=
=0A=

