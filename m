Return-Path: <linuxppc-dev+bounces-18171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA2105F797
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 10:44:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXLhj66dBz3cJk;
	Fri, 13 Mar 2026 21:44:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773398677;
	cv=pass; b=nuZ5XapFzsd8MjCCoIM6im7stmB18RQdKgaXIi2o777Z5MrO9nSmOVR9q+kKDIoyv1QzUa0IDtlfDONiqC8GtfSZ6bUee0hKbGjw/nQWqgoGofncJCg8NCKybrefZ/refZXD5Qa2fOmJMNbCcwdb9C37AfvGM/hFkXhdMexlMD8CFwkFeBh1yU3Wkdrs5DOUvIdod/4+vvMfMtzxiOeLPBTB00cdpgyuKSJhASL+7FjRNntNgUFNBai9pVlJ75VhpdzL6b73aeEeZ9RA6F1Gr6DAQyKUWiLwYieUeZvDV+FRChKtUTHfsHoGqm/t8IpHnId2L/zZwrspsmlx8cfeDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773398677; c=relaxed/relaxed;
	bh=jlkCAird6sp2vbBjC8j0enw65qF8za2p7ncRhVr2gj4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zqh7IvFZvNNbjWOuwzjr1RDhTlNBkNY2Jz9qw4lBdfX1PTPDicFj0ag72VV4ZN4b8+1Wgjfe3OA2Li0w+Kf97tb6DF+4TW61BWRaFea8aCAGg9PkcUVxCxQMoKanRzzutGRPnlxBdnuS/q14XbL6gLWlv51XlrFp5gVoCto27Ca96hKJejYxAR3218dbwKsX+4262Qq60YV2FuM9Y5c5j261kzd5ERNTgTBe9xp41hV2Apm2kgYc0945IPCwS/qTzbY37AG6Y/2ldT5wtwOJ+Rqhz3bZJZRXFP8UYIaE5ZNB0VnZ3zsF2ZIbhAsdVwWHExyFifhiR/hHAdMUhyZngg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; dkim=pass (1024-bit key; unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=NyJLFKor; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=andrew.cooper@citrix.com; receiver=lists.ozlabs.org) smtp.mailfrom=citrix.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=NyJLFKor;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=citrix.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=andrew.cooper@citrix.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXLhg6bftz3cGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 21:44:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcq9Z38JlzuZ5qw7AEMK018kujswaJL4eFK86JEV+lY3mdVFxGN/26kvjvWO7ajtit7WbMDRJWVTGFyXxU/1NJ5eWChJsHKbSpcG/gaffLlfPttG6JbFHpIPMPunF+fULcQIHn9oO3Z+XLvnU37NirFA39t/VY50//0f7JsgdJclCEhu2sDpfnzsRYW5S63kxIwIah3uTN+8hxP/WHjviWL1Vwi28BQvym90jSmYzOsuYxEB7ejXsjpLclZbxb4lDkfj/Q4mn9wbf3mx9RxjZbxx4RWuZTr5n30DpuObPGpBhDZSyHSC+77GdMweejoxrOz5SvpViWWnMTCERP5iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlkCAird6sp2vbBjC8j0enw65qF8za2p7ncRhVr2gj4=;
 b=IgB53z+E86d4YQRb/BRnECf9/Wt/F7ujEsG33eXHQfq83j0JD/bgzJR/CrFV/BTrbEjPQ4GoHpzQWwbAe90LHqRcviAJ7nXJv/RaUjtGqOEKmj6BlvseJ2qm64q6pgB3EoHwIs12yKVScs0g0itT7gBBAtHHsMlnPvprEJk2mE0MbaLZbu3N4oOJ5ajLsnRBA9SX/AKIsl/ViTqxJxvqBCQ+CKveHI8EmGGu2COSyhl/WA5wLXAp8tZy2I1AbrOHUnCP0uCdjkqEhE5BBipPqNXcIrFulu1SPLcHQeKW7Y+u0Ax7QKNjSKFmV5YLjbWLPbd1ea9/X3kTW+XFSan9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlkCAird6sp2vbBjC8j0enw65qF8za2p7ncRhVr2gj4=;
 b=NyJLFKorSFJoDdUJmSCvlCESdKokmIOxg2R8KtZaxT2zyMCoS44gBr3pLbirsy5EEnsxXZculXqgNo3EjpQIWpKfcy/S69V/5bJenVd71s2QXU3YSnIjsAeiSbyg2wdvTI5GneWEDo+D6RcgnYFYUvQrvujC4OFleEfMgrsarOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by DM6PR03MB5372.namprd03.prod.outlook.com (2603:10b6:5:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 10:44:01 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 10:44:08 +0000
Message-ID: <ff1cce61-abb4-463d-adce-0e5fc0a326df@citrix.com>
Date: Fri, 13 Mar 2026 10:44:06 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH] hvc/xen: Check console connection flag
To: Jiri Slaby <jirislaby@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20260312173845.47235-1-jason.andryuk@amd.com>
 <8e5974b1-da6d-4718-9140-1f943cdd2404@kernel.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <8e5974b1-da6d-4718-9140-1f943cdd2404@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::19) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
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
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|DM6PR03MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e8a078-9104-4d73-47f4-08de80ed7498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8fGUf62pqmXp9I5+1WUu5UR6dct6IXlXHRoUQvqq9oFdxT/XBnwFIN2iuvFniJ3vSl6DVdH1tSFoPh45AyY7kq4EJcHxotQgeYnll19lrMDugcLuQBZ01jbgcyMaS/2oIx7RJW3icLUuGRdkE5IswGXCaDct85rgylnOrBZrhW2nJ6exfs9A1tZ0q1YPZDERtYZI2JNvOU4SuTb3kO/y4waZDLCUINDadARAjVhuPNIFpT2SYqcHQq9Y40sjmmH6dSJeCtLX4V/FVnYILhufihYGzPtlqnltzSUMKpJDwOwfG80AyyQClExOtCbZngWKqfCrVTXoQg/cmIxgK3jaG4LIZjgZSeM/g//v7cUABd9o/i4iB8luFfaUlOE6nRA8XDUaTx/BfnxzAEa8r2ne/PIJI1jLjDNHdXuRvUGg36XsP8Qhrr5gFILLz1X7ygeSQvk88S8HSrMnJ7YzKxjt+dyjc8p2mLWRHpwbVPUBpN0I+XY+4wLkdPcdPX0+UwhCO9G8uZX519nVrOeni7i5MfIxZeo0svtdAMdJ1Ps35tactqLo900qyC7shVgSQ9xNIHn2o6FgDH1wjipPZc5ZeB6qaj4oqP4NQWMNLfMIzRKtToZjxpgoJt0+1kNPJAfLZGABVL0f59MKbed40xqFJq4gUBDXuYGS6gm+2ZkiJmPDwIM79Z2nbCb7o76nSeW3vAzccDPbgvQsRZST1P/zkVfECMEjcf8zzgems9xalx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FGZDFLUWU1V2Z1aWJ4cWlGYmUxQmlDc2h2Ritkcm03NnowMWh5V2t0VWlm?=
 =?utf-8?B?VUtUR05Nc3U4QUd4eUFlekVLTE9NM0dSbGF5L01DRXYyMlh0MlpVdVJ0aTFH?=
 =?utf-8?B?dTJ6YzdyOGNFYjBBQzlwYzRYM2tOUEtqaVYvR3lwWklIUEk0K2doNndzcnpC?=
 =?utf-8?B?UVRQUmFZUTRSMlY4djZrOGJOU3RDaFJObnFmeHVkdlZIaDJTWVRySlFCZzFh?=
 =?utf-8?B?L3RVSlpveVFwaWtkTWwvUVkwbEJPNU1XOTJzck1WbmlRSHhnaFBBVFhNQ3Vz?=
 =?utf-8?B?YnV5MVo0QlpWZnRyWXVOQW1nWTNCN3JxWXE4YWpGTE5RdnBDbjBEZ25USUtH?=
 =?utf-8?B?a3ZPM0xhTE9vK0Y0QW1NSUhZVWQ2Q3FyenlsZVEwdFZ2OERBQUNBQytXTVpW?=
 =?utf-8?B?V0QrZkd1RXJNcmRQT1JVK0l2U0dJWmQ2MlFHSWdFT3c2NExmTDNPWE9iVXZY?=
 =?utf-8?B?c1BUOUFMMGVrb29pd1M2L1VIZmFNVHgzMkU0UXJyQnB6YVNmS2plRmZsd2ZT?=
 =?utf-8?B?bDB1NHBxcTNlYmxQN085WjU5RHVYMlZoRHlpWjVkMTE0eEdENy9lRVVWejB4?=
 =?utf-8?B?MjFnamkrSFQ0MnJ6MEZ5bG82RkNiQW5Lak9JS2JZd0duSk51dXArQmJJamQr?=
 =?utf-8?B?RFdGVnUwS012K0l6QWMzSEFBQUFUVXQ4MUI2aEcyMWZOejQ3WWJPdE4wZXIv?=
 =?utf-8?B?TDViendKb21mRHNJeUZ0d0F0RlgyQ0FHd2xOSWNDUU1PcXlmSVpiejVrQjZj?=
 =?utf-8?B?aWN6NXZ3TzcwQTFydlk4NXZkSmhMa3NpNGhVVGlrT0JQU2FYZlM4Wko3T3BY?=
 =?utf-8?B?SnZoZUZrSE4yZDVPSnU4a3pxazd6bzdINTZMakFPdm9uMEFQQi9xZWRMMXJx?=
 =?utf-8?B?MXhiWERUcEZKUUR2QldYd0ZPa013bnpsRDNtWEh0YWorbzhDMi9wQ000T2NY?=
 =?utf-8?B?MzJlTXVscE1GVXNhbWFnVGo2UkJYZkt3Vzc3MmFzanNFR3pXbzhWcTZhOGtw?=
 =?utf-8?B?aG8xRXp6THFtQ3E4b1lHckNrVHY5eGZXL2hmRGQ4UU5MNDlFelJDQjIycGRM?=
 =?utf-8?B?T2xZVDhnZmpsODVsdDFzNVdsWDgzbVlXWXBKcVVzZG9US1dMMnJJUEhONjZK?=
 =?utf-8?B?dlpOVlJnOGhKaVlxNEdFV0d4Tm9pQ3RkK2tGRXA5dXpNQVZnaXdUTkxPVXlv?=
 =?utf-8?B?TVcwR3NkeTNBN2VaRGxqeXRLZjhkWjZMZCtTUFloU1A4K3UrUmhwOUZjWlRh?=
 =?utf-8?B?dTR5TkNWWStuRFBsSUJyQ3E5SS9hZmRFQkxDRzNlVGR0aDYvL08rYll0endw?=
 =?utf-8?B?YXR3dXd0MjhoVVpyOWZPeHZnbmUvQXZ6MzJHQjA2S3Z5ZWt4OFR0ais3NldN?=
 =?utf-8?B?NXFlR1FPK0tEcml4QTlNbGFMazBzekt4YU8vaU5JalNQNGgxY2FrUEE4VHRP?=
 =?utf-8?B?dzhleUFmUDNwRmptRjFBamxVWjd0eUwvUlgwMW4vcHpIakVBU0dtMEJsS3RK?=
 =?utf-8?B?cVFpZ1N1dHdCSlRwOGh4ZGFqQ1JNMmFTdHBlTVJ1cVdqV0RyalhGODhhcVU4?=
 =?utf-8?B?aGIrOXVMVVBDa3BWV0ZMN1FRZnN4cnZDUWFLN1cyNHFxWFNYUU5qRXNmT0xV?=
 =?utf-8?B?Q3JLeGdqY21xMzUxZU8wbGhUd1JHVHZrYklwZW03TXEvN2cyTzQwV2kyT0Y3?=
 =?utf-8?B?UkpGbjM0eXNjTGgzb3hDN0hSUC9OT2xlTitPbXVuZGVXRTY0bi9rclBiOUli?=
 =?utf-8?B?Snd1Q0k5SzhlVXBGNjlKUTZGL1dndldJcmJJOVB5N3lKbEVrd0FhSkxITVhR?=
 =?utf-8?B?bHhCckt3K05kVGpNZWh3anFOaTNZUTZnQ1FrTFdZQWZRQno1U2pTK1VHbytQ?=
 =?utf-8?B?ejBuaE9nWjlHV2xJaitETEdQa0hBT0o5ZGlURDRabVN2WVdMbW5yV2tsMFUy?=
 =?utf-8?B?Y3BvbU5yQmNXMnpDbHUxYnA4QllteTVQOG03dW8wcXR0WVlMVTE1N1dkN3Vr?=
 =?utf-8?B?cWlYcUZQcGh0UHNGczF0RVcybWg1Tis3Y1I5K2RRa3I4ck5kUXJZVnpjUktS?=
 =?utf-8?B?K3ZMTTBvdnh4WVlSTlBKRm1UbDhOMy9qRkFFa1hiUFZndm1wK3JOKzJCbStU?=
 =?utf-8?B?T29qWVhtbFpkdzYrQkNiQ3NwanFuUjhkVmdHL1BjalUrZlVXSk9RbnF4YVVE?=
 =?utf-8?B?dk1jalZwbmorRUE4ZGxnSWZadjlsMlpicC82VHRRQ0Jab3FZelNTNG9mdjVa?=
 =?utf-8?B?QkIrdlM5OFljQmd3ME1TK2cwenpxYUU4SHloNW1vUDc1dFdqeHdLVkZrVkpi?=
 =?utf-8?B?ZER0M2RHSlU3QzJyTW1qaUVpdTJ5SjlGcmJLME11Y2NJdkVTVXZ0Zz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e8a078-9104-4d73-47f4-08de80ed7498
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:44:08.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfAo5RM1mmInd401JM8NLq05nx2pqDENBmY4jakZ6kf6ciSKz+RV9yKsFxpSugAII3JyyhJdTaZAiUQrs74vbDJLgeLQn1KBsG86+8NZdfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5372

On 13/03/2026 8:33 am, Jiri Slaby wrote:
> On 12. 03. 26, 18:38, Jason Andryuk wrote:
>> --- a/include/xen/interface/io/console.h
>> +++ b/include/xen/interface/io/console.h
>> @@ -19,6 +19,19 @@ struct xencons_interface {
>>       char out[2048];
>>       XENCONS_RING_IDX in_cons, in_prod;
>>       XENCONS_RING_IDX out_cons, out_prod;
>> +/*
>> + * Flag values signaling from backend to frontend whether the
>> console is
>> + * connected.  i.e. Whether it will be serviced and emptied.
>> + *
>> + * The flag starts as disconnected.
>> + */
>> +#define XENCONSOLE_DISCONNECTED 1
>> +/*
>> + * The flag is set to connected when the backend connects and the
>> console
>> + * will be serviced.
>> + */
>> +#define XENCONSOLE_CONNECTED    0
>
> This all should be an enum. And you can document it using kernel-doc
> properly then.
>
>> +    uint8_t connection;
>
> And type check as well.

This is a non-Linux header file being re-sync'd with it's original source.

It describes an ABI between VMs, where things like enum are forbidden.

~Andrew

