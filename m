Return-Path: <linuxppc-dev+bounces-22433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8FECD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 23:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbMRp52CPz2ysW;
	Thu, 11 Jun 2026 09:29:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781115268;
	cv=pass; b=JOcph8txloeXEgHQYqE2aiatxijowZA2nHArDw++bHVxYGhMk24smyvafRS6jC/v0qNkIeCckUISuoe1RNkScuSL1nOB3ec8/GSMpHYQSpz2eFJMwGrzb4YRwUsG4NKTdh1ZzvRgFALyMmzJ8g+g6UHphiVBWUTkibu8RcOgTY1iVkZg1oqv9BPVxlbG8I3alwgRwiQXRhg4g+qSh3tL76a0D2uIY8Lk3myBv27kSKGKb8rdFaSx/1Ed36Vg534xxeUvrOaSySNnAtS23d18WsJJTvuj7aJ+8xRAVirpeq6EJcmWVue+NGpn+mc5/HNZOJNWbxdy926HglQQzvlVAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781115268; c=relaxed/relaxed;
	bh=DkS1FTd+qbaNr9HqaYWVqCBsm78oGqOVbxJkY8Ve68Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fzRfcsMJj0ccSMeMIlV1whFjnZGk7MBKIVlZuHAyrcZ1HP3yalB+ceinfbU5rL2V0v0D9OAKHMlCMHYKjc/oRUVGNFOJA/U0eNRRX7XRc3UP66Z3FzX6b2D39PEc7ucN10aVXFwMoyF272g06hjkkW992HEoGEpt2FgPt9IWgrd0shQZeeMq5poV2e3Neb8utVcPjdm420eH9i3KuDlz0NTbJdaoSB1cUI5r/Lxe+6uYxi5smPXgT3LQqTvET/nUsdllmj8ftmTXaB5lUgyjal2FLDtfJ+lh7JNabvJ8gsq54U7r7eTLFlzJ8qWGfNLYGKngMCgZVw++Vq/K4CWifA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VLO5u0Yp; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=huibo.wang@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VLO5u0Yp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=huibo.wang@amd.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbDSf615gz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 04:14:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT369nfkbHNw7KmVRlTSq4RQKqCOE/jKD30QFDpVPC+vYzmnMjTGIAthqlMRsEaanv4sxiukPjKnxasiOkP1w0JohwnRAhNzlzR13FJ9qj+IBjpxsKMt/F2zCb7WKCL1fHd8AGEmjhUURvqnp02wOPhLtkje4MdpSaRhgdwUaG9WAFnciZwrryDO4YMkAkS0RgojT2Jyb3i2uwaGj6PO7AKAExAeml5HC6udC54oMU1mEz5AEU0AwusCvitvQetmy7AadFIx22uCiBlmHZNByWOo+VxZvwNeH54YveSHjcDXT/bZXnX7LJHvfJZbLj3LVfbWt2UnU6btaEmunz9Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkS1FTd+qbaNr9HqaYWVqCBsm78oGqOVbxJkY8Ve68Y=;
 b=g25dqjAmevSWxqBgZXiGBB7ZjMC624tFM/A4u7fLTSLvsaG/PanBUU7YUhcix/j7wmgp8wymgAnSt749I6JBb1lrFMXWKO3YnD7yCLgWyxprsESZuPITj1fwBIT1zGF4mcDdoNyLzJPewnWGDcCEnD9Vv+0J8zMO8tV29txpDOpsJeO+yqClHxh9j/E/41HThe1HimZ1bfaKzTexnAZDKVs6qCWR3rGW2Snq4Jt0PsBzy2bZvlP+j+uMn1f+O0vGVMe2+Qf/fkvmY6jpY2nxTqnDlGS4RXWcA6zooVsKXhTKbQf8TgGcXbAiynz8NZCwKUSywDsF5qxOW90PR8dp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkS1FTd+qbaNr9HqaYWVqCBsm78oGqOVbxJkY8Ve68Y=;
 b=VLO5u0YpzdY5MiuzFIRaEu6JSGGiiRpjua7AecQFkFBVMOVip0aPhuJq9lH4VVC9XWnzHYnq6Gz6W0D3Ksn0csYNdWx7LSGmCutAyv2+YHrcntfG/30bFDir52IIsLlYMoaIscPG2KFhS5/2fHHJBlLYSsyiH+OiSRPOlBwHVnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 18:14:00 +0000
Received: from CH1PR12MB9575.namprd12.prod.outlook.com
 ([fe80::2aab:a788:44ed:f4da]) by CH1PR12MB9575.namprd12.prod.outlook.com
 ([fe80::2aab:a788:44ed:f4da%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 18:14:00 +0000
Message-ID: <3c4c6c24-ec76-4085-b6da-cadfc8a229aa@amd.com>
Date: Wed, 10 Jun 2026 11:13:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/60] KVM Planes + SEV-SNP Support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com,
 michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de,
 James.Bottomley@HansenPartnership.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 x86@kernel.org, coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
References: <20260608144252.351443-1-joro@8bytes.org>
Content-Language: en-US
From: Melody Wang <huibo.wang@amd.com>
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To CH1PR12MB9575.namprd12.prod.outlook.com
 (2603:10b6:610:2ad::12)
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
X-MS-TrafficTypeDiagnostic: CH1PR12MB9575:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b4ca4c-1c34-4f54-d74d-08dec71c0b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	85rVobyKmzAiMmj0x9bsU7nkxs2Ql9SZvtnsjHoHirXMbPzb7KoTTAbXcInHr+dDsC0rWdRdA1MPfbMB1ZYC9yjdt1OM9u4tM+Y0HNvJmjeFxeRqxtmu/byzJPJMWDkO07lopvy5zRxgFWAHixBUvaTG5IjxBxEJwa9+Biex/XMkB7ktzh6JnoNa67BUbSZ/Oa5nTvDJ2zpRjOIfjqDzaii+bjGz06ndPhpsrmWpbYYhHdkRkBEjSa9SP0QutITV1PnaJp0o7E5UFBICbi8fd6Dib0b51H/BHuoScV7lKiuWU1QgGaf9PBoA6/xGQdD4pR0opRiONWOZIj5QWCGuNlqNJ24M2oViLZ/yy6XITXhZ7FD+9uz2u2rm36xzhjpmanMI6gQmPxFEQ/d3ut1vSQq28QgxyP386sM/ljUl6MTRxMGJJIafHmhmarRuu7BKrplcMRibayOgdtLJ/uJa9tDjYv/VmLQmhoVjgQ3Twjz8q35HMx+GLg/csoWWir1OPu0Oy/OphO52+6Ap7OLhkiOdnrYZzbO2xkCZwc7TtbGTo5nmOYFWkB7mwfBTmyXH517lNvTU/PIzeWyaD9bqCwWo0vpAQG4vLyiPpfZRLyzkHDqnqwOcw+2sAcJhoaHwoKZdKi7+FUXeQolCRkpHJ5ieXCm7I+gDkdPPu38XknKKOTBWloB3KmQ5LngJ4sxI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9575.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUJwYndwY3ZQOE1aeHkxbS94cGp5NmRvd0k2QVppNmZhMGdGUEppUEpkTlMv?=
 =?utf-8?B?aUFWdGZoZHU4bk9yUWp2RmpsczJycFpKcmorR212TFZNVGo4QXQ3ME12Mjg5?=
 =?utf-8?B?aXZMdEpjNURVWFN2enhSM1lvZEhLazE3QndQN2p4VFg1aVE3c1RnVUVQRGl0?=
 =?utf-8?B?aDZUSkJXQjhtVldHOENGdVhUbVphdzRsRjdPMVYvRG9hTWR4SStKL1VFN1Fy?=
 =?utf-8?B?OFJ3TGttU1MxK1ZHVlorRWh0UXE1VzRmU2JNTWUxdUFWb1ZNWEcvZjd6OVgw?=
 =?utf-8?B?d3F1TFN3QmR5ZlJodXVsd1B4bFhZVHpySE9zbFliMklubEt0K2UyeWl3eWhh?=
 =?utf-8?B?OTZGQi9BOCtTQVVacm5vYm55ajk3M0tLVTFIc0JFeCtYNkF3aVRYcS9IcWMz?=
 =?utf-8?B?eHNPakswelpFYXo0YVhXNmxZOGNNK2dEaUJEZmdXTzJtNDJzWGFrd0N4Ty9y?=
 =?utf-8?B?ZVdrUFV2ekNtOTB0ZnFBd2RTU2hTVXFDcHhjNWs1a09TQ3IzbzZnQUJnckpS?=
 =?utf-8?B?SWRhUkJOMzV2Nis5WGVIUTBneEtSZkkvY0RyVWI0R3EyYVJjTWV3VnorNDgy?=
 =?utf-8?B?YWNXNy9QSHliaHJRUFFDcUxYVTdBNHJTWUErSHRDeGdhVUFNUTl3LzFGMGdW?=
 =?utf-8?B?aHNWczh6YTRaeE1JY1RKUzVNU2U4Rmd4OWxuUHVpdjZFL0hKcVArV1BUcDI2?=
 =?utf-8?B?eW01b2NDTFVQckxFV1p4REs2M2pOcnVPcC9TdGxjR0Y0M3dSamhSa1ZFVjFL?=
 =?utf-8?B?TzRWaklxNWN6MGJ5Zy9WYmJYdkZ3VDVOdytQK1VBL05zOFRxcVcxQTdLbTlK?=
 =?utf-8?B?clIweGthdU1BdDV5ZlBTRWxJa2crWkdJZVIxMUZWQTd3NXBTS3Vrbk5SakFD?=
 =?utf-8?B?aHIrZTM1STE0UUNmMGlOcE96ZVV1SzlCaFUwbjZSeFJXZ2hVL3c5Z3JseElm?=
 =?utf-8?B?cy84T1R0OTc1ZzAwVWppVXZTdjNqTW54dnlHZjY3Rk1aS3JHYTdBR1BjSDZB?=
 =?utf-8?B?L1VTcHY4b3NYUGU2RUh1RnQveCtadHhPeHhGZFNTV2NEWVZxRUZHRVF6ZHpx?=
 =?utf-8?B?MTYvNDNRdy9vck1zWVEydS8yOU1JZnlKeUYwT0VJbGdzU0hnaDQ4VldVcjRJ?=
 =?utf-8?B?UXR2bU9KYThnZ3BIbTBka3c0V0M4dFRUZVVEbDdYTUdxRFdiN1BFaWFwWDBI?=
 =?utf-8?B?UHpXeFBIbndNd0k4OWZlZXZJQWxqZmZhRC82dG1WRzFKOFhxQmN6M1ZKcmpp?=
 =?utf-8?B?OEV0dzFFcEdEVWNJZWZoYnlWa2kyKzZnc2djbHdBK3RJdncrd1ZpRDdKZTFG?=
 =?utf-8?B?WU1KUlZTZllOckM2T210b3IvVDB5K1hNblZIT3BGQUxWY3M5aUFhaWNOc3hP?=
 =?utf-8?B?Q3NNYmpFVHRvN3RyMVN0dHVxNWdnSUN6TmxTbUg1TzN5dENPMnhwZy81REs3?=
 =?utf-8?B?NHZvbDFXQ2ppb0JocStzU2pPNHMrdjE2dVR1UlFxUFZMTHJMdXNka09zdG45?=
 =?utf-8?B?d09aVDdiSzY5SlliVHpUbG1BYVlmWXZ6NDBoUExDRTc4UTFzY2FpdTdCaS9x?=
 =?utf-8?B?TXZoR1l6Y2w4VHoxSmwvbXlpVmY0MGZ6eGx3ajZUQnBhaTNURWVmN1ZLZHh5?=
 =?utf-8?B?dU5LT3VvSXpmVk9EVkVDT1RpTDZrU3NNOGYwbWRHRm93RjZBM2FaVXpxdzEz?=
 =?utf-8?B?Ty91SHd2d0NaWGN2WDdWMmN1VlRFT2RSQ0V1aEFtQkVwakI0bkZIZGVNSWgy?=
 =?utf-8?B?MEp3cC9YaVRyMCthYUpNQjNOK0F5QWF2VlNtRU1Cdnk3OFB2V0lucTJZK293?=
 =?utf-8?B?b1JpTFpxY0w4YTJWWmQ3Smc3MHdMYmRlTkYxdURPaDJ4K3VORjllWDZjZ3dF?=
 =?utf-8?B?MGZkRHNFOVdMOGpWaXRkeklmbGVRWUpnODU0MTVrZzlzNFR3WkJxSmF4S0pz?=
 =?utf-8?B?VS9yTmpnZnlOZFV6VGFtVEpDM0lVTDkvSURxSm9ib1JiQnQ2S0Y0Rmdvbkhk?=
 =?utf-8?B?QzhwODRoOWxCT2dncXdhMWJRb1F1VGxETFpMdDJwU1Z6N2doZExCc2R4cTJY?=
 =?utf-8?B?ZndhMVg3dVpFOWVJT2pYV1pRWlM3L1R0VE5rRnowenlZd3J5Qi90TzFqUE9Q?=
 =?utf-8?B?UDdvNGZnOHRHVHRMdVI2bWNLSDBwYmZnYnVIN3RXbVBLVFFCSVUxWmFyb25H?=
 =?utf-8?B?TEg3ZEtpLzFpNlZ3Sy9zY1lqM2VNbkczVlJjNVB6cmF5dU5ZcTJQQXc2R2Vq?=
 =?utf-8?B?VnpVUXZMMkNJTzk0bnJVL3h2akJUNFprQThPM2QzQ2hzTWp5Z2dkVnZhVHdO?=
 =?utf-8?B?eHh1V3NGekowNUx1aU9jRCtZSUNrQkJLZkVGSlJ1WGNRbHNTWXpZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b4ca4c-1c34-4f54-d74d-08dec71c0b89
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:14:00.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+Rg3KGvROGFm1p95CNRxo1p8Fw3mpQCssxc/9Xmhd4JJxA6pqRX6qTQQvbV0FtEYTz03B48tas2e9pYtD/xLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

Hi,

On 6/8/26 7:41 AM, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
 > ...
> This changes depend on Melodys patches for supporting restricted
> injection. As they are required to run COCONUT-SVSM, they are included
> here for completeness.

Btw, I am fixing up the restricted injection patches based on AI 
reviews, will send the new version out upstream soon. So you dont need 
to review the current version.

-- 
Thanks,
Melody


