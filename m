Return-Path: <linuxppc-dev+bounces-17557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F04E67A6C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 05:53:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ4jD66qjz2yFY;
	Tue, 03 Mar 2026 16:53:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772517200;
	cv=pass; b=k7S8rDm7nIGD4y9HyoHC2Ftk1TdfD2ZNO0wj343GYGemHcgkX5zxjRghhYkk/WbkAGDlZFFY4ka52hfNXebJ1DybYmcRbu7kmrmXGRrnwstLLvjvpbjDXaM4DLjEcNyRo0vS9hd52lYlM53Q9MgBY6y0TZ6ePSOqLplq8LqO25aTYeNWYEX+waugS+MEt+RKO8qekVgoatzPemQebOh3xc6NBIJ+xCOtyjlUDb9Np8pSbKW23F/3P1AnGk1qW59WUc5QRFf16QJi5VYfjg8DczB/lAEHsmrKXelatlOnU7xDVZA2bFpSSV9iqTUZQ1oSQnl9BWLx53RiYRRkrONXQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772517200; c=relaxed/relaxed;
	bh=IlPR2Y3LYT3gIVwOXi1Mmn2FE4cpLAI87aqBElzWKNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clKOEPpSTknjoTTZr8Vj5/ET890K9GMrf/1O7OY78gFavHJ+r1TsM5VOtWNo7dR65ZdlXfpfwRQD8A34HOeH7vEeqO72vX+hTc3OakuFUdVp4MSAuxhZ0NOpbUVqWAmkCIuNUKUPch4SqEJxpnfsDQSQh6kNwMZMsOBslA9c1S5zwOoEfro2lbTD17eLxmCyilqR0iIr7mAeeHdaJX3iU6q0Qp/xxrKGbnYQVrG8th7Ovyrj8zYp5RwuuaTaeGSjmklmtW1/82LePvisrc09qVyTManWC/jltTEBC0XkLNtdhezktF62ci499pbssyaqptEYzvUW4TcwF3eNZS+erQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FFGoXnAY; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jniethe@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FFGoXnAY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jniethe@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ4jC3QFpz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 16:53:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGTPGdS+Jk9fHWvr4ri3J6qkmW6iLzLyX/Fb+uwnnCHc04fs2oowuFKBdgyZXnX+p3r0WbLfhzXPzwInYNowQvNRQxNMIww24495ojcHaeXV4QyQgbn6ZqeN1q/BImTdjAO2R+G1ohZGRXBzruGHxasD2TAxLPKdIrwE8HfIHsVvx9qKdc6BU7MbCCz0M+umChMwNNHZMbDLXKX6p0KtDWeeIPB4Q1ytn+viAxy4YBBjCOAJdmEb+wm0OtP5LDB+SVVt1fxMlcjSpfEXmjZZitK9qe80bEHMZtH2DMnXS1SNZWHfhbuWb3triFLfwfXFHFqdoR2P0815HFMG5mQqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlPR2Y3LYT3gIVwOXi1Mmn2FE4cpLAI87aqBElzWKNo=;
 b=cqJbnsNQrCeKjoV9RVGRpe5WGiI+Nk28hnEQPaEpndNs47QudZDUA461dPZSUSVvUkoYXqWkIM17W/dBPbve1OfuuNkD3AXzmDiEQTGKAgz6yChFUpLw4BbBct+RTYTtQCDlZG4nQ//Cxjkxbxooo3iLorMTu+prYalQxfuDAZTINCEqfa2WOlWOJWGsc/cKbkf/+H7hmoiSlcATvxknV8HCPnP89NtWIk4x0h3IOJr83CahPOB7RXCPiAULcmDQCtuWeDfLmQUHt7CwEq5TDgvICiI90bGf0cACdAZYPHythdz0muvgijutNINqA5eZJxrx/vOigRHVTndNpr5WCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPR2Y3LYT3gIVwOXi1Mmn2FE4cpLAI87aqBElzWKNo=;
 b=FFGoXnAY5qD0aH7hBcvxxqP6Z/IZ5myGQlI0rqvI6X0rSQAzDS/8B7x0j1Qo5AwGHq4QrH1g1w1kJW7Ub2wh6C/Oz80VwDwILd86N9HGk4gE+60Ut7Q7UgFLrE3f0BIyFahT06kObfsBwJyZaHT6cjjP4CtbogjFeB4Ex6sNP1IJYnGRAIayvo2y2tougSPgadu//otuUd6DqBmN73F7DS9ZFjP/md/OeYEXhO7QrU3h2UrGFRZu9m0xj7l9cWdpJqMAXQed33bwCMyzHw/i6mW0eTKvwoHq4naFkydY0Pi83tDetw3d/0aZgzutlFYRS2BFdLCtDL5M5HWgZ9/EKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) by
 SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Tue, 3 Mar 2026 05:52:54 +0000
Received: from DM4PR12MB9072.namprd12.prod.outlook.com
 ([fe80::32dc:be07:3859:b4e3]) by DM4PR12MB9072.namprd12.prod.outlook.com
 ([fe80::32dc:be07:3859:b4e3%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 05:52:54 +0000
Message-ID: <faaa84fd-095e-440b-9922-b4037a67416d@nvidia.com>
Date: Tue, 3 Mar 2026 16:52:44 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] mm/migrate_device: Introduce
 migrate_pfn_from_page() helper
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org
Cc: balbirs@nvidia.com, matthew.brost@intel.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ziy@nvidia.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com,
 lyude@redhat.com, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 rcampbell@nvidia.com, mpenttil@redhat.com, jgg@nvidia.com,
 willy@infradead.org, linuxppc-dev@lists.ozlabs.org,
 intel-xe@lists.freedesktop.org, jgg@ziepe.ca, Felix.Kuehling@amd.com,
 jhubbard@nvidia.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 ying.huang@linux.alibaba.com
References: <20260202113642.59295-1-jniethe@nvidia.com>
 <20260202113642.59295-2-jniethe@nvidia.com>
 <9ee22635-a219-47bb-a397-bc4e141b408d@kernel.org>
 <cf547dbb-af45-49d0-87a0-5267dedf0470@nvidia.com>
 <5182bb7d-f7cf-4b8e-8320-996c52fe24d8@kernel.org>
Content-Language: en-US
From: Jordan Niethe <jniethe@nvidia.com>
In-Reply-To: <5182bb7d-f7cf-4b8e-8320-996c52fe24d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To DM4PR12MB9072.namprd12.prod.outlook.com
 (2603:10b6:8:be::6)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB9072:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d540d63-c5ce-4957-6498-08de78e91ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	DMi8qZC6/X5uS+1pRH/Zkse+zGMbtE4k1fHRiZrz/rBbAZWoCzV6Gc4AlY2xI0wpaqFFJgE/hJOjKVSAQ4UrO9OS23Q7bxrj6xzrx1NaJqnCcscMbitSgJyU4IChMo5RLMZ2oHSNldmmlGnDlQo7eXEUWL5O2ms7O2w7KhqITJl+WqHov/m+yhRiSfZF9VNpSHkwGJX1HfPEVIIaGA2UkgS7Wm9fNeWJnXJoqk7DNzUFE3TiyxZR3QX1FDFfGXhnH+cnXfwu280bKYsc8zY/6qRkOBC4n2R53pa9nleWRl41j+HoQ48UMh6Ybm9L9GfHpalBPmD94vyVV/5y+mg40CHwOmkUUaEEm1czqobX6WzG5k2kTil7znQxe3decocjq8NlEeAh4vuPL6cVpC6/KHuASlVHFWZ0aCPhOfORmtlPI8PF90QWuVjyn4yDg3qFSJ9X96aGtNohqRKS4lr+q2QGoy/xonWHPriUzc57AAVx+AaCOUWW1g33/Xpub5FQ1DJFyokWQmyxSN1Ue1PCEYWYJ8O6+DmUJcd9ZBc5Ub8YbMcBCd3EcJOOvruLjqnh7HWYZLDNRKYNrI8monvyjJzD/LLs3Dwbb1EQXquEuAmShENnKP34Ua3z/nVq/0NB3XeaNJr0tHNXg6fzBxB3W6fW2+qgkebETR+8w6TfhpPUAXsxWabvrU439/Y3s1NI6HRjC4c5JdWsSvqekF/8aRYLhpHiypopmugAXAqrO/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9072.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXh2T3J6OER5dHNwcUU1V1p6WFNxQjBzUnQranc2UmY3dnVXMi9Ga2lqdzQy?=
 =?utf-8?B?aDNVSnYyV0Q2WEZ1U3crUmQwRklDVmZDWGN3Qnd5cXlOaXFPMXAxdmxpTWlY?=
 =?utf-8?B?VTJ6bGpxcnNXQW93aWl3YlczZDVtM0k5UktLSWtoN2pzb0pTQzQ3Nm5sRUNG?=
 =?utf-8?B?MEhmWnJRRTd0Y0liR0Z6UXdmZTU2c3hUdnlLV05SR0g2dWhkVUNyVEJsTTRH?=
 =?utf-8?B?ZTh1UGpVN0NMTW53L2t1YjNaaXhmUTNyVzF6L3lPRVBzYlYvd1N6dDJTK2p5?=
 =?utf-8?B?aTFlQmgyUHkyR3Eyb0NFRllzUTRUb0VQOWtaeUNsblNoMWNYL3hvMks2UG1O?=
 =?utf-8?B?MDdSSVdpRFBScW1oOTJkY2JDYnFuL3JlakxyYTVzZEJYdjNlM0JXaDJhTVBG?=
 =?utf-8?B?NVVFNWI5WVY5SnBSYzNUTzFheUlLOXJrMFhEalhUVHpwMkJlWVM3R1ZKL05G?=
 =?utf-8?B?MVlqeUxMTHIzR1pMVG5aZ0NPRDhKTjNQL1Y4Tm41WVdka2NmaE9IOEFGUW8v?=
 =?utf-8?B?UXJyajJpaklZalFWanZvMjhHU0lmZWxlUWdaTFVKT2xySkJTOUVIMFJBTVBv?=
 =?utf-8?B?Uy9MMjZ1ci9oa0JnYjR0bjVLK2pteUJLNXErQkpCMFhQY2tyWllIdk9Zb21l?=
 =?utf-8?B?amR4NHZCRFVUVUhNTUJ3RkFDSTJ2V3pmZnFMdUtPTTdlVVh3N1RNTytLVzFk?=
 =?utf-8?B?bXI3K3dSNEplNzdXZGFFS09LL3UzMHV5OFBBbG9sejJHNXdNbkt1Z1oxZW96?=
 =?utf-8?B?Y3Zrd0RoMW5pbVlGKzBvYXFjaUZ5S0JNRitjOUdSQzlVbUM1WnNJaExENmM1?=
 =?utf-8?B?RjZ0WFprd0FjRGkzWWRwZU9JZU90ZTVrMitKdUljU2xWTWtOaXdLV3YvSHVw?=
 =?utf-8?B?VGF1RzJKcUFkbEVRNzdkbzVZTWxnUXJmblZFWVdTYi95azRBRVpIbk5jV1hG?=
 =?utf-8?B?b2VJcFdHMDQxUnRSb0srRnE1Yk54MnRHOEh5aDFiNml6UXNQTEExWUdzU0dH?=
 =?utf-8?B?cVVyKzNuejRUOTJkelN4QWJCSkRtZzZSZmdySzJYSHhDZ2hkc1lLZXNsTkVu?=
 =?utf-8?B?NWN3TUQxY0VlM2k5TEJ4WGxzdHF0NTVaa0hqSzN3MCszZC9UTHlWdFpPTDh5?=
 =?utf-8?B?Q1B5dmxwOTg3djBvTFNGS3UyeCswQnBJNXMyYzlYTHFHMDVPdTduRTRkNUlr?=
 =?utf-8?B?VzBqWWlsWnpyOEVHVDdxbDNHcUZrdFNqdkQwZGF0ZGpoaHp5bVZYYkxUSVF2?=
 =?utf-8?B?ZXJJUmduNzRYeXJlZWhuTmpkYzRBWTcxVkZEOXdqR3VIeERwbXViekJmMGdD?=
 =?utf-8?B?cFFzc2tJYUM3bnhqakt2UkplWlBLMXBDa0ZGbUZQcklhQnl2NkgxblZKbE55?=
 =?utf-8?B?bnBuWFpoOUc4cDgxbDdZem8yTUNEdmZzeFlkRVRNcTVFRkVLUG9HVUZsVXEx?=
 =?utf-8?B?cVNtNnRVVmFEY05mRnpxVGZKTU5aMmJXSVlqWi9Md09HMlRIWmhsbFRnVEpi?=
 =?utf-8?B?ZGpzZ2U3enJWREhCK1V6dWt1QzJ5ckhudFRKS0w0Q05heGJZRGlmQ3FDdmp3?=
 =?utf-8?B?VjUrSEE1RzRXR0M3amJibGh3ZXNOS0FiOW05b25weWxhMEhoVkh1T21aenFr?=
 =?utf-8?B?a3huc1NVMVZkdFErTWdHbGJld2pRZmtna05vVm5hVEhXOGN5K25pVE9mL0Nn?=
 =?utf-8?B?L0lOLzdaTTh2aDNPZUtGYVozd1dEWGpORW9BcHBGdWlUcURYU0lNc0VEekNx?=
 =?utf-8?B?N3J2WisydDdaWS9xOVNJWUZMNUF0anlKWFFzNU8yWnNGR2FxcHBTRTF5WVdu?=
 =?utf-8?B?VndnY3lHZitibm1VVEpNOVpBalVOb2V5ZmFqNU51aWhzUjd6VmZZaXRHajVs?=
 =?utf-8?B?V2c1L3NtdlhFNFMwOHA5cXZFNzAwTzYvNVpiUEhvdWtEKzd2TVNjZ0oxVFlD?=
 =?utf-8?B?MXlCWUtOZ1pES2FFQnFxS1lmaXE5cG5ZWkJaWHpzbGNnMWlDN2pqYit2MmZR?=
 =?utf-8?B?UDhoS0VpWkpxR04zdmNva1pKLzNoa0JhOEZBRzJzc1pWMGJqUVQ3V3RROWRO?=
 =?utf-8?B?Y2IwaXo2dXBlWDlyS0NLcjVrd1FFODVHY3o0OFpiRzhBeUFpTjlxY2N6ekZS?=
 =?utf-8?B?clRnQlRrR2RLMktGNWx1U1dxZUJ5anpRSmJWYm90UlVoTVAvWEd6YkRoZWN0?=
 =?utf-8?B?d1BJZkkvVTRSSUp2RncrNmZZcmFOTzdteEtYWGx6bzkzRXV4WnpSMzZuNE81?=
 =?utf-8?B?R1pVbGptLzIvQ3pydXcyd3JZNDcwSUQ4bDBGdlBBWG8vcEJWZitucWdoOHFI?=
 =?utf-8?B?ZE5YREpiT3ViaWpWZHlpaEVyUy9TRWdFNHVCalN1VC9QN3BMZ0N3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d540d63-c5ce-4957-6498-08de78e91ccd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 05:52:54.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+qw/itqKyayInlKbDzIvFSr3qJADsJVPBZEcJEmWO4MoMaBgQMr+fJaNKQigNN4wHYZusq62nfjvre66GMWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

Hi

On 2/3/26 20:22, David Hildenbrand (Arm) wrote:
> On 3/2/26 00:38, Jordan Niethe wrote:
>> Hi,
>>
>> On 28/2/26 08:11, David Hildenbrand (Arm) wrote:
>>> On 2/2/26 12:36, Jordan Niethe wrote:
>>>> To create a migrate entry from a given struct page, that page is first
>>>> converted to its pfn, before passing the pfn to migrate_pfn().
>>>>
>>>> A future change will remove device private pages from the physical
>>>> address space. This will mean that device private pages no longer have a
>>>> pfn and must be handled separately.
>>>>
>>>> Prepare for this with a new helper:
>>>>
>>>>       - migrate_pfn_from_page()
>>>>
>>>> This helper takes a struct page as parameter instead of a pfn. This will
>>>> allow more flexibility for handling the mpfn differently for device
>>>> private pages.
>>>>
>>>> Reviewed-by: Balbir Singh <balbirs@nvidia.com>
>>>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>>>> Signed-off-by: Jordan Niethe <jniethe@nvidia.com>
>>>> ---
>>>
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> I'll go through he remainder of the patchset this week.

Much appreciated.

> 
> While skimming over patch #2, I was wondering whether
> "page_to_migration_pfn()" would better fit "migration_pfn_to_page".

I guess you were thinking about migration_pfn_/from/_page() rather than
"migration_pfn_to_page()"? Renaming it to page_to_migration_pfn() would be fine.

> 
> ... and I was wondering why that code deals with pages instead of folios.

> 
> E.g.,
> 
> 	page = folio_page(folio, 0);
> 	mpfn[i] = migrate_pfn_from_page(page);
> 
> Should just be
> 
> 	mpfn[i] = folio_to_migration_pfn(folio);
> 
> Right?

This patch is quite limited, essentially just converts usages of
migrate_pfn(page_to_pfn()) to migration_pfn_from_page().  However, I
agree, there could be scope for moving some of those usages to folios.

Was that example from drm_pagemap_migrate_populate_ram_pfn()?  There
'page' goes on to be used elsewhere in the function so we'd need some
further refactoring to fully benefit.

I see migrate_vma_collect_huge_pmd() as a candidate for a
folio_to_migration_pfn() function too.

Thanks,
Jordan.
> 


