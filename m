Return-Path: <linuxppc-dev+bounces-27024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F47DC79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:06:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgbx543CVz2xRs;
	Thu, 10 Sep 2026 22:06:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789041961;
	cv=pass; b=gcrnS7zbUQrpXzgsW36sDGi6KgHaHOsk8c+7qQZsm8VXotzE8qo+PXo/tRxexTpXZfOmRtNmlWwgTFt6tRGqGKEltFAvCBbEG30pSRh0pXVfwwxLMFwI2TctCIykh7TpqeEl9o0w0KWZ+ged3b1BgQa3GCVuWJrcYMsTXzW8eXBZRS1OVR+1Oy6kdLKytiul+c0BnErLQXY/WW6HGJA1MnMbnS+1tO2lxVASHjbjVP6Ga22QbtpbFv1A1LsRFPQynrjD5lm4rvrXIPf3jNFJaaNfDsBaCd/dl4DxDmTDLzGtcd2iShiqv+RXw+FQaPfLCLaQWDnCqJ2NLBiBrM1vKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789041961; c=relaxed/relaxed;
	bh=IkPKM4xg1QtdLXmZIk6tQM9JV4h5uAtG7ZlJHdI0nd4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dB3wY5dMgynXAfnX15FL4Ej8nMQ3U9WaAMiwBskgzjgsBaaMYMEBAX0zc+PC+SZJFxbpY9EqEfzkLlII9Sn4JUDcF4DavJzu/kLkbpwoOLTFv7Y2Y28SkCDVlio2MsZc8K0NrAMnbOWNcMDK3O5KKamFcxLxaQbnVH9Lq5Ia5oX+vEcX/NUbj2QtK850yZaiTOjGkjrbix2NYn0WLvJ9J/f3IvDTFR0/3P+eyXJfDtOTWog6xbzp9YcI51YKjZ3IPNgXdjzK7el5qcMxqYZ6CIB0elSB1MRTrmPSRxXIyG4BY7mi5kMA4nZo3ei4aFwJacOrTYoC7rr8ZuNSSQ4Pcg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=s1DrRTVX; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::1; helo=lo3p265cu004.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=s1DrRTVX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::1; helo=lo3p265cu004.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgbx209VFz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:05:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKRljbv56uvPCJ0grRAC5grVHBrsRgaM8686LqAxN5gf7Wur2xDZxK/tPtdJewyuz6EbqMava6e1gA9aejfmH6h6dqjlP9CnQDVcY0XqItukKtb3u/SDKFK88YnGwtXXWH6y31b3X2AN7251e8BnznFQ3cu9l4g/8qKyQ07GN8MxtHIgjeHgijJJ54YbZcgDbCnv0R4qd/2GKgPzdCdfspWF93s7LZufnLsDyejOYVaoYHRdiewm28Xud/tvnlyBbjH2e198RsKTXkdHuTn6HVwmw94Np6kRvf70YeviZfzdQitHvnphL5sSNY/+gBTQNFvwx/YhQSfC8YemQT1w7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkPKM4xg1QtdLXmZIk6tQM9JV4h5uAtG7ZlJHdI0nd4=;
 b=NLGrRty2OfiD6fMBItctKdQtpMj9icaUDXBxjB1uY6yDeOPHr1vNI9waztq1a853D9DhLxNyw23WRfLUb7qgr9c/U55UEovcDLAg89DANRwu67ymaEHzEOQisqOvQ2OXWwwPHoImBb7KP7APj6T2Fk5MNEnq73TifEMtmNmBPqmxmaDZ8mCKzMxEtpe5dPSTQg6a87ep0IQyudObsSfJvix90scb/me3326qM0d2VKpoIQ5M6Oa3LlpIWCZCBqzE2cdOORmm012pNRuE5sZng2kdo5SMme8ERJpwKlzphyl1TOsXOHsp9idb6cjlC8uxK0tsqc0wfT33pwqaivYXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkPKM4xg1QtdLXmZIk6tQM9JV4h5uAtG7ZlJHdI0nd4=;
 b=s1DrRTVXaIRs96FaFvb4Fw/aqZkIZMhh+oDJegVmZd1a0nJJkLsyYfbB90w4ASIwsTbW4CGzOjBfeq7b2hZB3Epuv6zVE50K+qkb7xL1om+kfuGCNtX2o+iIeyLrlUGCGq8Y3M306J6NUY23kASWdOdnDhdhyAuta7GwvH8L0t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5650.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:159::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 12:05:30 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 12:05:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 13:05:27 +0100
Message-Id: <DLBMFNHCKSJ6.1I36FDVEACEUF@garyguo.net>
Cc: "FUJITA Tomonori" <tomo@flapping.org>
Subject: Re: [PATCH V3] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <daniel.almeida@collabora.com>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <linkmauve@linkmauve.fr>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260910100801.2159785-2-mkchauras@gmail.com>
In-Reply-To: <20260910100801.2159785-2-mkchauras@gmail.com>
X-ClientProxiedBy: VIYP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: ed89c7d2-6d84-44ee-bf83-08df0f33cf25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|921020|6133799003|22082099003|18002099003|5023799004|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	TNXQIsyg6nk7yq744E6lpWlGAsQQSfemgigqljBEF4vo7JcBpQtvRCYi6qMzUfiI2KVpjyRdcYUi1DS4nCh8RhUFjV1K/Y63vIKYhTiKdAxWnteEDMz9kCcYG57Q4TsSW6qeUrjxpt7m1wY54gaC2zpTAP69NdOWD5NlHHZqYl4B8uV+zF67whjgA+gnutBP2CbHVyF1WvtRvGwamJwZk3dwxayODJbHzsQR0GyDg1+OcU7WZLuFmzstfDgc46jdkAIx2ulv11/CnP/Akih9ryY1wtltJ3PubdicsILGqkCZPdbOOY+NUaHZHVhB2YGo3APugbtjSmn/GBjSIRTWwrXGLwuM8BDgi1EyP5e/aVflJrvNKiPSUxNvwbTfotMbZQLCtjuNhV/+e1sP2VOll7GfhCxAueybK0GHwQ1DbqeZbIxQxaALJRavxgscWTd2vuOETsKa+FqhslHN7DOwMg9Wn61VMrMjhm2+WgbFOET7viiaQsFH3uE51O4ZIfLCf8IeUKNw56efhlazpI6FIjuOWkRsu6XfMA2y2R9Bowt46Dne9Nz+xDhUwRVlzsLf1tdFYmB63U81lNIDJlq/gyzC/b7/Mt3840m60GK1Uq9DaxBbylgmnXuuZwmIr8IHIBkS80xdDeH1ykvDDk5DqPdMsxj2yH3+DfKxIAukjjfln2VY+4LKUSfVBRLLcezwUsW2T7RarHv7RBKsJ2PcaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0xYQ3ZiQnBHaTE2RWdvMFEyY3lTclRDUWZTZGtNbkFQNGFQQTU1SWxUMzcr?=
 =?utf-8?B?c0x4cUF2cEZvNXlXZHk1ck02ZW9QZi8xTzJ2ZU9vaTBCbTlHdTRPeXhaaTFE?=
 =?utf-8?B?TGRURjFpOWo4VUhmaHN3eTJSSlhxQ3MxNXBrWGxTaVgxd24wcXpaeTA5bTky?=
 =?utf-8?B?MDhNeDNicnYrMEg3VzBpTkhZUmprWlVETjRyQ1VjZGdjNzBJSmk1MFI5VGhE?=
 =?utf-8?B?MW5seUwwNGV3cUpJSlRydDhObGxKejJTZzRuUnVIM1BCUHc3QzdFRnRkbC9z?=
 =?utf-8?B?dlRXN0EwRXBjK0hQUEFSaGE1UUZCMjNjTTdzQUNyRkJqdlNhRjRzK2ZHNm5k?=
 =?utf-8?B?RUd4VXgvUWJ2dVBGZHhGYzg4UitNM3NPTnBMRjFNaFpnczE5NnBUcU56cXli?=
 =?utf-8?B?RkduTWtxTWFYRjhORFh3dWViU2s0UCszOXU5SmlYbEhTR0tBdjlzN3FsQVAw?=
 =?utf-8?B?NkR6UC9qOTIraUdEMHNNdnhaM1VxOU5KbzZMRlRLby9vS05RamlSbVNObTNr?=
 =?utf-8?B?bHNLTDJWWFVzYjZqcFpmaE5hbE9JbjR6Tk5OUi90TkFEaEpZeERMN3daTmlv?=
 =?utf-8?B?NnZOMEpXWHJNVFdqZHlqN0J1dVNkRHY3SFQwMnZpcTlpdy9rNzdZYkR6amFU?=
 =?utf-8?B?YkhGSVVoR3JZUGxrYUZ0cFk4RGRtbnVWNkJVSElOa2M1Y0RUUjlNOUlEc2d4?=
 =?utf-8?B?WjdlY2RxNlEzMXczUzA0L2wrNDZ4R1lZYTVMN3V3WU5OWFJrVUZTU2gvbUhN?=
 =?utf-8?B?ZU9rL091RlFOdlJXOGp5M1BUeDRGZlFyaGppdFR5ZlF2ZW1RUHMwbzhicEt0?=
 =?utf-8?B?cnl3OTZoNXlWKy9mWERWWHlFS3oxKzVnQXVuZlJjbUxBcm5SS3FCamNxV3pO?=
 =?utf-8?B?aTVLUFJhSnlFbGszTTVVaEJzV2NhNTNGWk5GY1ROdVdqYlpxNmVVdmI2S05R?=
 =?utf-8?B?T0JCQ3EvL1hVM0pvNW51YlgwQ0JvblVpQUl5N3dtK2NRbExTeXNCdDUraDFV?=
 =?utf-8?B?UkNpQUpjRHRIY05oTjl2V1p1K0JNYmcxTHoySEovNWpMd3RQR3htN0M2Vjgy?=
 =?utf-8?B?Ym85bkRudk5vdEM2a1FPdDkvT1dEdjdPU0RXelB3TVJIc3FqOFVMZWR1RE95?=
 =?utf-8?B?NlJ2SlV3YTBnb0pkNFlySkwwNEd6elhqTlNXWG9DcWRUMjlHdXNGNDFRcHlC?=
 =?utf-8?B?bk1heG1FakdlektSQks5aFAvT2JSUStjNUpLckh2ZklpWE9sTmNCRVdDM3BF?=
 =?utf-8?B?UGN2YWJpUmdVN0hkSUxUQ1FWNXhOTEE3eHp4NVE4WmhBS3c4TUNQUWNBMitR?=
 =?utf-8?B?QTRPb2ZzNkFLMG91SWQxTk5rOHBWREtxVGE3TXp2VXlrQzI5SHJsNWhMbVRi?=
 =?utf-8?B?NXZWbzFOYXBjK3oxaFhQcTBITjBNbFJHNk1ka2hDU3hKN2xJUk5sNE5PUnhq?=
 =?utf-8?B?MkZnWWlMK0kvTUF4c1IyaUpOcGIwMXdKbys5dGg4TDlFbzUwVGtyeGNYZmtQ?=
 =?utf-8?B?WVlOWFBLNlNlYnlHVWsyWFJ3UEtZRU9rNEo3M3hZU1BjUXIvYW9OZnpJYWps?=
 =?utf-8?B?akFzaUtOeXpZRkc4OEt5VmQ5YU91TzRPcUtIVmYyTndCTnJKcFNpUkp3c1VB?=
 =?utf-8?B?R0NrUUhVMnpjbE1CQmNYdTY4Rlc4ejY1UTNzUHM2MmswVHowUklkWGt3SDhz?=
 =?utf-8?B?WDBiUHl1dFRKN3QvWG1qVVpvOEdwT2d5QVhGZWlFVFhTbUpWT2hDV2FKSTMy?=
 =?utf-8?B?YXRxZ3BPVWZyMGNGbHB2em9CMGJMTjd5dUhoS1I0YkJKU0pDRDEvZzBhNStW?=
 =?utf-8?B?VnZ2R1NtRUgwWGswVEpLYThGV0t1d0xKZFdMNVhyc2JXNkwzYkJlcm1VYzFm?=
 =?utf-8?B?ekMxU2oxZFl0YTBsVE5GRjFZMVlHMVdxTDJieUVVN0V0WmkvTk1FSVRHRjZn?=
 =?utf-8?B?c0xnU2xCR1MrYXBzR2JnMkYyWUV5NHh6NEd6RDQ3KzUxemdiNnBwTnRSRzZL?=
 =?utf-8?B?YUp5Vk1IeG9hRWpjY01IU2VXOXRWZHJGd3lBQ1pJVzZYOCtXamExai85S3Rv?=
 =?utf-8?B?SDNYU1lzMXFwZXpPaFV4RjNVZy83S2gzREtnSnJid2JrYUNheXpWWEs4cHdw?=
 =?utf-8?B?ZGNZM0xwSitnN0JiV0E0STVaZlpjeDEvUVorZ3dwRXBlaXVrVXZ5ZEthdm04?=
 =?utf-8?B?K2owdEQ1eU0xNG8vOHRoMi84eVd3SXVQOG5rblQ5YjA5cktXakVnajFFL3I3?=
 =?utf-8?B?NjVXbFgwblhqRkpVaUE5U3FHK2ZnWTNXM2ttUnhjUzhoOFhzRFV1WWlYeFRx?=
 =?utf-8?B?NTJHMFZoYlVGU1hNOXRYL1FUd2MrNmV0UUJVK0oxb1ZFUURRdUdOQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ed89c7d2-6d84-44ee-bf83-08df0f33cf25
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:05:30.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wA6s0KxN79V7HFYJgFUE9zsMp6eqDQmLAv3QG6BUQbEDihjaDWF4c3bOqRZXvb0mkBwmPItaxKU0Kbg55D4lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5650

On Thu Sep 10, 2026 at 11:08 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> The Rust kernel infrastructure generates inline asm for WARN() via
> ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> arch-specific asm template string for use in Rust's core::arch macros.
>
> powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> Rust builds to fail on powerpc with
> ```
> error: no rules expected `ARCH_WARN_ASM`
>    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.=
rs:1:28
>     |
>   1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flag=
s}", "{size}"))

I think we probably want to catch this earlier by have something like

#ifndef ARCH_WARN_ASM
#error "ARCH_WARM_ASM is not defined"
#endif

in generated_arch_warn_asm.rs.S.

>     |                            ^^^^^^^^^^^^^ no rules expected this tok=
en in macro call
>     |
>    ::: ../rust/kernel/lib.rs:279:1
>     |
> 279 | macro_rules! concat_literals {
>     | ---------------------------- when calling this macro
>     |
>     =3D note: while trying to match sequence start
>
> error: no rules expected `ARCH_WARN_REACHABLE`
>    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable=
_asm.rs:1:28
>     |
>   1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
>     |                            ^^^^^^^^^^^^^^^^^^^ no rules expected th=
is token in macro call
>     |
>    ::: ../rust/kernel/lib.rs:279:1
>     |
> 279 | macro_rules! concat_literals {
>     | ---------------------------- when calling this macro
>     |
>     =3D note: while trying to match sequence start
>
> error: aborting due to 2 previous errors
> ```
>
> To add ARCH_WARN_ASM, _EMIT_BUG_ENTRY first needs to be refactored.
> The old definition was a bare macro with no parameters, relying on
> positional asm operand references (%0-%3), hardcoding the backward
> reference to local label 1b, and including .org/.previous directives
> inline. That made it impossible to compose as a plain string outside of
> an asm operand context, and left an invisible contract that callers must
> always emit their trap at label 1:.
>
> Refactor _EMIT_BUG_ENTRY to take explicit (label, file, line, flags)
> string arguments via string concatenation. This removes the dependency
> on asm operand numbering and makes the trap label an explicit argument,
> so the caller's intent is visible at the call site and a future caller
> using a different label cannot silently produce a wrong bug table entry.
>
> Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> each call site, so BUG_ENTRY() can still pass sizeof(struct bug_entry)
> as an asm operand while ARCH_WARN_ASM can supply its own size string
> independently.
>
> Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> convention, indicating that no additional reachability annotation is
> needed after a WARN on powerpc.
>
> This brings powerpc into line with x86, arm64, s390, and riscv, all of
> which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
>
> Reported-by: FUJITA Tomonori <tomo@flapping.org>
> Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
> Fixes: 73b741adb264 ("rust: Add PowerPC support")
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> Changelog:
> V2 -> V3:
>  - Add label argument in _EMIT_BUG_ENTRY
> V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.=
com
>
> V1 -> V2:
> - commit message now has error, fixes tag and closes tag
> V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.c=
om
>
>  arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bu=
g.h
> index 0db48977c70c..df2183c35945 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -32,34 +32,38 @@
>  #endif /* verbose */
> =20
>  #else /* !__ASSEMBLER__ */
> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> -   sizeof(struct bug_entry), respectively */
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define _EMIT_BUG_ENTRY				\
> -	".section __bug_table,\"aw\"\n"		\
> -	"2:	.4byte 1b - .\n"		\
> -	"	.4byte %0 - .\n"		\
> -	"	.short %1, %2\n"		\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> +	".section __bug_table,\"aw\"\n"			\
> +	"2:	.4byte " label "b - .\n"		\

"b" is part of the label. "1b" itself is a label and "1" is just an integer=
.

If the code uses

    _EMIT_BUG_ENTRY(..)
    "1: ..."

then the correct label would be "1f".

Best,
Gary


> +	"	.4byte " file " - .\n"			\
> +	"	.short " line ", " flags "\n"
>  #else
> -#define _EMIT_BUG_ENTRY				\
> -	".section __bug_table,\"aw\"\n"		\
> -	"2:	.4byte 1b - .\n"		\
> -	"	.short %2\n"			\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> +	".section __bug_table,\"aw\"\n"			\
> +	"2:	.4byte " label "b - .\n"		\
> +	"	.short " flags "\n"
>  #endif
> =20
>  #define BUG_ENTRY(cond_str, insn, flags, ...)		\
>  	__asm__ __volatile__(				\
>  		"1:	" insn "\n"			\
> -		_EMIT_BUG_ENTRY				\
> +		_EMIT_BUG_ENTRY("1", "%0", "%1", "%2")	\
> +		".org 2b+%3\n"				\
> +		".previous\n"				\
>  		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>  		  "i" (flags),				\
>  		  "i" (sizeof(struct bug_entry)),	\
>  		  ##__VA_ARGS__)
> =20
> +#define ARCH_WARN_ASM(file, line, flags, size)		\
> +		"1:	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY("1", file, line, flags)	\
> +		".org 2b+" size "\n"			\
> +		".previous\n"
> +
> +#define ARCH_WARN_REACHABLE
> +
>  /*
>   * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>   * optimisations. However depending on the complexity of the condition



