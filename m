Return-Path: <linuxppc-dev+bounces-28424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3B3CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 20:58:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4httvT5HzNz2yMK;
	Tue, 29 Sep 2026 06:58:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790629125;
	cv=pass; b=MHIk80fmD64Zs5y9LEV5V4hdcxAsDlk2MiMz84AQrCZrVZbJiEZo9IHBS4DnMqh/fFOu3/DLakfO6kwkrB4yLpnsohMMaWdikmZYTHq09I3M40NglY2ogakHFkYeVVMCVY5NDitx/5WiUVZ0YsdHTeIwNOm7GG0rZLqfVl80tvi5SbJXt/1UCnKrDgtbf8eoaQ90uhS84Ucqij6B4uIXHfq2xm0NBC7Bvqe8ZM9qYkqv7h95w4ST88bEnaPN2gkZU4o5ZnMs2UrfEME3+MUILaaPcwIOgqcIoYQmtRbl1VTnbSPDvILiBNd89Wke8KfWs8Vm07ptcPJmlz01GZfBYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790629125; c=relaxed/relaxed;
	bh=l9praY9pyAWJWianXSUaYMZfXVEJaEO/u+SUXyWVyhA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Se06P3iJGtB4kDJNeQe2HZgrVmVi97chqCTEOUfXp7janG5YR/kxmlr3GW9YIiQduhcFs4P+5KPMX9tlXi8HgKDvmxncDlTjr4gs2o9EtaAZHhMITIfXj+h/X63V4lKcm8bu7I0eLtQijCGknd+Pi6mxbOAKjy7Ui1nEySvdqALBGBkze7UJt5I7KrJX8sDg5Txfd26vwT/ayJpa0yGg3vmkius5z0vz9/2ECEKvXhK5Q43X0jdj69qiLKQm/BSmTMr67F9MknJSf17zmdS6TQdCvrDFMYNxKGAvCf7MI8oVfjfbXNmLT2g4Cl9iGQ2gnOt16QPRhbBGnUZdLLaZUQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b9kLiQRc; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b9kLiQRc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4httvR5SzTz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 06:58:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG+QdDNDJS7ZmYiyj90Ey4iajgDedQS94F8rnjROmjzinTRSmRuxG8FGE7cyQj/kqBdwRDm/1H/pNem8SvLJnQBFU3eMyzQrxlEKb2ZkYEHVbtarHQ22icp4eXt21gm4g5j/mKEB9QX2oHDAgdCCe4dAX+W8+7+8pHyPKwTWMTILAHuDKK9HnYBvQitw9ZCmBDyDTX6b6nVi9yOAfYZpDMuN9eRZ6/6umFwZZr4p16+G970kXmmPWJF7zcTOjF/lHrpV/K5HTqzbvC/rsqsgtnblEwUSe4pfRhFCouKuXdIceVic10VdG+hXa3VgZATf4n5NiGeq1pauH0qS5gDRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9praY9pyAWJWianXSUaYMZfXVEJaEO/u+SUXyWVyhA=;
 b=Gi9hCp56hlc7y1MXyEoXAUZgoZxSlammRPvmg2q+ak9gt87yy5WWo9rwuVVfsxjqyXnzI4ZuxXDpbyX5MSgUOmXf2p0cBNWm8N1Gbaz7tzKp55wGXgJVT/DOHHlJ1jkJ35qJlJ45GB3SrwIqcgY/oEoNdAbIj8WOh9vFXfmBMnwaLQ3mPLOUeDCkdjb54YdsZxxRyDWrfd219rJlgt1iog8+Tm6GmGUM4mjuotjQuqB9yGWLfDApAYToTKKbJ4ntzJJkRadryk7FTATwNrZxFOlLCZ5iGc12KJVyld5azDhUAuPQTvWlQCtfNKNIJc1q0J4Sbxy4f5nVeFBgWDLULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9praY9pyAWJWianXSUaYMZfXVEJaEO/u+SUXyWVyhA=;
 b=b9kLiQRc2Kics+w9Z19BAmPzx1a0Pqq2JLyZsxjS3iAsQGWvYNwrF54UjQcPWowpY4uOUF+/243Kkc2LcoHhhTLcUlz96NX4oxkV71pFMc2Altuwd11hwCCavYE62XApPpFMgbKOMhLsoQnbSffY4eWlx8fDM66tYiHpkTfqeSw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 20:58:19 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 20:58:19 +0000
Message-ID: <2604b3c2-4c6e-453c-b7be-d7ff6be1dbb0@amd.com>
Date: Mon, 28 Sep 2026 15:58:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>,
 linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::14) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS4PR12MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3e76e9-95c3-4b4c-7ed2-08df1da3397b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rWpuRkTO97gYrfx7+2DvF2rBI4h//Yp8At/0G/xconNzAGTAL6ikJBz9W5pY0PXhODNV3CCwa5IOkee1Mbo7FLXpAHCRoOj89FaCcUhIPuxMsJPbT9Yxb1RKwaWfcnKi6rJR/GonDIoTg/kxhxzJbuBeHo10edm4pBZjfCCLl1/h6z8xgRwxMbTiZ5tLx84NV+c4O1wXWVMnClwF9a1Z4pXsDNATSLr0LxPitO1lRlTQcdo9MKeXHaCXf/kel/M+Zp30Lj6ylEKjELuPv6Sj4HmRtOU81NRyKku+aomKyLwdV8ivo/Hxodzm7WI6pJZG/HmaFhBvJ+AJgzUb6hfmU0spIj+haGUxbkXDtItlUndn6BhYrBgp0S9REuGvCfr6gSGMouBJdBKi0lMKO3xch1duY0DiW1PdfdRDfMv0vjc7x2BMa2JhXmz9f5olcY0lr1vUj7n9wrhLqYT3KFvGCGoVd89uWTCV6FVY2GtFDLIsML9JtgiCsduUF9NdGrzd8e4EzDfylx3V50xtNxq8GkkW9ZWWGE1tULvzN3a7cAn6YFC5wN0chwgRhBwspRL5cACWXmfU9EO2vING+Uh0ShFLPrNhiIe13g6afNN2oenhYgh9RKjr/mBGs0+n0/Qh3eJZ6fqr0VhBFx09ypyIvg+hgwbTk1by4DRSSUW+BIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azZHa3RNanhYZkZvUWV2OHhzR1VSOEtBa2tyNTVXVVpuM1FrSGw2SzRjSE14?=
 =?utf-8?B?YmUyRkpvN3hQRXU1anB6Q2pweFpKQ292OU0rT25sL09kUkplMVlaaHgreWdU?=
 =?utf-8?B?TnJRT0hCcGdKZ1JUZjhXVHhFdlNmZnFDOEdGZnFVVUYzaWp3QVV1M3lvZEtM?=
 =?utf-8?B?cXlxZkUyS3Nta1FuL1IxTTROdGkvSzh0RXhGS2FDZTNDbktIMXM3VEpudGRO?=
 =?utf-8?B?MkxBd1FoeFBrQ2diVk9GTTBvT0F2aURkQ2ZoeW5BS3NQTER3cHdUaFVBV0d6?=
 =?utf-8?B?bFhlREozUnVuZFhWV3g0RGNoSHdjc3BZZnc4bkduR09XQ1BCb0ZWNm1WYjdL?=
 =?utf-8?B?K3E3RnVMTnBvMFVISC9Ba3kra3VTZThobmZqOGZOdVUvSC9majBtbEZMN3pH?=
 =?utf-8?B?OEFXWGl5Mlhqbm9xTDRiejMvb01BcDREdHkyeEZoeXU1UXFmRytkUkNjN3Vs?=
 =?utf-8?B?WnY0OE9DTW1UVzJSNEd4dnV3Z3hxaFJ2U3FLR1o1THBzYWJYMkxCM3NpM25z?=
 =?utf-8?B?N2NRTjY0TnlDTEhGQ2ZpUjE5anlpVWpaL0dxT1VVbTg5aCtQS3RSYTllSnVP?=
 =?utf-8?B?QUNaYnpGeWZ6UHFWdzJTcTlmNnVMV25uakpBUHRyVFBRSXdzWFFvREVKeFIr?=
 =?utf-8?B?cnArcVF0RDA1VUU3QVVvVzFHYmJJV2RRU0FSNzE0TkV1ZjV1MVp3dzRiZFYz?=
 =?utf-8?B?dWp1WXBBL2tpeWZOd3lVem81OHVSTGRFVE15Nm9STGtnZExhOWtSekpMcits?=
 =?utf-8?B?ZlNhbStyRDVVd2hWTERma1laSms4am9WeXFqc21CV0lIR2ZvcjEvUHFkanVu?=
 =?utf-8?B?ZzhrZ2JZeUxGUEtmRFRkbi9VL2VXOWhiRlhmNmdqNVNYc203N0gwUkhJd2tV?=
 =?utf-8?B?bnl6VVRWWXlubkxLSlJKMkNpaHd1WU16MEVHTlN2a2hkYjZpaVZHbEorNUNq?=
 =?utf-8?B?UGRkb3B6c3d0NUhvdmErUE9sajNHM0NLdEhvSnlSVXk5Uk9kd2owOWl0ZVFF?=
 =?utf-8?B?MnkyQjU2M2IrdDhNbEgzVlFkaWtiQ0hqQ3h2RW1Gc2lVYVZxWkViSDFUTGdw?=
 =?utf-8?B?eUIxdWVMZE5OQTdCNXJqVWcyZE1FUWJuOUdWQmxmL0FpaVErdW44b3FkTWhr?=
 =?utf-8?B?MCsvNGppMnA3MGw5OHlpVzZqazlPcE42dmpSSEZoRElqWjRtMTNaS2VFUlpv?=
 =?utf-8?B?dGdzOUF2WnU2NWY5bS9FajVjRkNSM2R0bUZYajBrNjlKdlVSOW1iRHVVQmVF?=
 =?utf-8?B?VFRKcDh3T09renZ1WXFWcEhTdDZ4UHFzQkhPdmhKb0p6YlhtSzVESTg0Q2dZ?=
 =?utf-8?B?aXdYRGFyMlM3TTZIYUxZZmR4ZVMvV0MyM0ptaEdOcTZZVWhzRjRQMUpCekEy?=
 =?utf-8?B?OHhOdGdDZnZ1QnJHcmI2WmZpcVRpUXUwYkRqQVV2RjJLQ3hwU1R0VkpxTWly?=
 =?utf-8?B?bUpIN2ZQaklMV1hrMjRtZzJjbW40NlBIZ3RVUzZvMk8wS04veXVHVnVsOTlB?=
 =?utf-8?B?eU9MeVVvVkVNVTBhcXp5VG5nN01QOGZuSUh3OXJWYi9IM0g5ai9QaEdGR2xS?=
 =?utf-8?B?dnpEcHRsZmVNclZpbDVxbythRGg0RzAwZkI0NGpBWGo2a3g1RTdxUDVlNFkz?=
 =?utf-8?B?cW0yT1d2T2hxeCtSQ0ZteW1FcVdnZ0JUMmQwVnVUbEs1UUpVT1hrZTlXSUhC?=
 =?utf-8?B?T3lwQmFjdEphWEw0Tk1hNDZrWElTVlVCd3NIaTlyMjRsL1p2MDJuOTNkUzZQ?=
 =?utf-8?B?OVVlaCtZLzdxR3o2YVpDMDZ4YkZqOUVvMkQ2SENLT2pHQndWa0t6NzhzOW50?=
 =?utf-8?B?VHlzYnlXMEpZdGNlRm1McE0xY1RWMGpUemRXZmpPU3VFK3FmT3ZkSFFHb053?=
 =?utf-8?B?MWFJZ0NjRUF6QUpzL1F4WVhma3I3bW1UUGNxc3ZuQUV2VnV3bzBJYlBhbzVu?=
 =?utf-8?B?Vkp5N3puV2MwLzF2a1dpUnBSWGV5L0ROaFRrakgycWRweWRWSUwzQXFaSkJK?=
 =?utf-8?B?QW14RkFFYlZZMjVqd0ErWTNvQjRadHdIQWpBeWpiNWVSaW1PUDZoTlFtQnd2?=
 =?utf-8?B?UVBLdjEwbEZ0VXdrWmpUTG1vdGJ5cTFneWRHVGZWUit0RzhjSVRhcW1uYmRE?=
 =?utf-8?B?bXk4MFZPT1VyMFliSkhxRi9LZk1vMU1ZZmluZVZLWW0vL2k2cFlRNkxXWVZl?=
 =?utf-8?B?L3d5TklQd25WNklsQ3VmNTdjUXlyUG1YcXRrc0FKQnRoalVFcXN3N095bGNy?=
 =?utf-8?B?cG56a3JqL1ZFL2VlVkRrS0NKWHgwVDhDc0xNelhIazZ4Y3Bjb3lWQWNtZTNZ?=
 =?utf-8?Q?7h4fhHWafyDLIfFWkf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3e76e9-95c3-4b4c-7ed2-08df1da3397b
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:58:19.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szswstDpwXcnR0pJGOD/AdE3Fixft+fTA/Z/R7r3g0dMuVCZk3tlfsYQF0wY1skgLjiy6Eqzm+YxAI1nH+MJTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633

On 9/27/2026 1:02 PM, Lukas Wunner wrote:
> Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().
> 
> The call is superfluous because the function is only called from:
> 
>   aer_probe()
>     cxl_rch_enable_rcec()
>       handles_cxl_errors()
> 
> ...and aer_probe() is only invoked if an AER port service was instantiated
> in get_port_device_capability(), which is conditional on:
> 
>   (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>   pci_aer_available() &&
>   dev->aer_cap && (pcie_ports_native || host->native_aer))
> 
> ...and the last line of those conditions is equivalent to
> pcie_aer_is_native().
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/aer_cxl_rch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c4..9cc2d5749b9d 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>  {
>  	bool handles_cxl = false;
>  
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;


Nice cleanup. The pcie_aer_is_native() check isn't necessary. You can add my RB.

Reviewed-by: Terry Bowman <terry.bowman@amd.com>

-Terry 


