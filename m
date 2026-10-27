Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B260A260D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Gt/46kow
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDmZr08V9z2ynZ;
	Wed, 28 Oct 2026 10:16:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793142979;
	cv=pass; b=JpQ/3FlmZ2ZnE3ZCCO0UblZRyHZyOng+SNqqPyj+QU22ZiONeh9zTxGFoCOs825ElEppk0d1jsFQtUKiMks+FPXHTNUvUS6KBlAhiLqV0jeIQ/QPnQ91hX9MEKby/GQBN3s0pkkQjXWKtUAocLoEzOkaVxIo3NTj+tA5Srd2AQnRkIJOwCwLBnBqhUV2nMgiRjg221DJ07vd1M6KyW7Hc5Riln3FnVCIXmte3m/GGRjovVO5hUzwCbhdJ1Fj+ePJlQOxfRH/G62uF2wcaUbwz1o6HaLP/66drTo56I64dOC4oONz00yCPEkUrRL9SKdlpMhgHGQmdd4jM4hfxdYOgw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793142979; c=relaxed/relaxed;
	bh=7ISyHKlVAcM0/DZJiGCw/9XLIFyiBD/SzVNJUBpkA0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMMozpTmeT1Mx3g+axO8AkMCUfpifHQiEsTqUHLpDMthgCVaEXENWKhpRVNZ+jqZrXvkEHbzy7y4oLGO1UgASelUTXT2JEqTW59hP/RP6IsTyPff3++X6mWflebWK+fuj+oTmD5QGzNv+RMvfK7mnZcBdL/4uijH7dh0dtngk68Fuo/dmyE2A1Ov3JE+GGheYGI4s9/aE4jqES1P6gOxsnJqPZJrtJaEaKOOLMKftHL3QysY1CpJk7dcct7frGy9rmGI9sfhgfLzgpcdqfuvYPHbC0KfhBOdGMT/J8bb8zGQCf3BVBUVyh3grwdksWW+7nEinqYFtF37+663/546WA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Gt/46kow; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=felix.kuehling@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Gt/46kow;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=felix.kuehling@amd.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDmZp3CSyz2ylj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 10:16:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQ0rtxs2yHtePTZKSKD03j2Lp/EMu3QXDUf/w94nK9S+l9CYSX+7Cr9paPIDE4/M19m4Ca8X79C0uz89dK22pQ72n+cDOzmWDU3wG0TK0yKs4K0jp/3oIuLOfP+nbdP0y8i3vmhQd6gwRl02mrcu4ByiN+RZ8GhgbCqALGUlndhuhHv5OsXsAxiLkHufzubfHg7vmeVMkxluO80yGDKOOnS0fKbHULE0sAh1LIqaFZh7Oc+5k5hucReBYuB1hA4t0UzQYIJe2FEpnsVIbRa9NCcLN7pveLT71fbGYNPKuH2nmC/bxE/gcjOhOCp6OTi2iVqnf3pdkgdpQpEn7LUOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ISyHKlVAcM0/DZJiGCw/9XLIFyiBD/SzVNJUBpkA0g=;
 b=b0JQW2AEqPk0iP8a9Zub+egPaFvQ3Dhf84zHirwe+SMZ7cbPs0/46tOcyBL2VHwrITCNhqMvFDlSoVfjuzHpvUShZ2rRyprTXr+2xJHEoJtCrTCq/qSxBvu1X+whIr0SBZqudOvFV+Hk0pqnT9+l0aBVaqR9sTE4zuLh7oD9DA/M4D0Ueo2m9Y8cv2Gf98xBykKP/uu4UIBVJHmiEFpJmW4xFNhe6B0hlBOktB/K8r+61T/36+0AhC60Iv3KqqvTCz8hoMyjiY36xf8h5RBGR+GrDYg27t4fE/Kc+iK6EFaxySSCcUo3nJ6cU/d5ZkkJsU5IyxzbTYJgerhci1O+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ISyHKlVAcM0/DZJiGCw/9XLIFyiBD/SzVNJUBpkA0g=;
 b=Gt/46kowYNiZfGLkAVE6OaDkSSnYpqckrOor/qJPeSdsHwKMTjjCglaYc28asPRHN0TIJ5YbjWWz+FYDCNfl7LBI4K+P4kmPsVpQwcgoeixgHICmsdDLcX6F6xw3v88rW98z6lgDsR4c0TCgFyOXraesRF/6osIb1OZDO9j2J/Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:15:52 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 23:15:52 +0000
Message-ID: <34272fe1-e5cb-490e-9053-a2fa72f29a10@amd.com>
Date: Tue, 27 Oct 2026 19:15:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] drm/amdkfd: Free queue in procfs_queue_type
 kobject release callback
To: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amber Lin <Amber.Lin@amd.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-9-irogers@google.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027223847.652884-9-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a9363e-e46d-4dba-1360-08df34803e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	DSmAC/LXxQNwDa5i5URmYnYa+8b0/OwMVhNeh3ZW0NuqAJafHKuOnQaOV0lIwiLh4xwlaBNevUZsjqmNUxBpst2EwayM/QPsvWOCH0nAQ7Ouwlh2Xxrx5NbkBIBXKIT1DqRqeULra7VgJq+BY7jk8uBLBM6q/X4zWFfSe30Dw2M/22y2CzhhaNFeBZwxvLStpgYWP5LPHl1fSHxHXphIwW6FLRkZPM1oiOpWa5Wj5GAr1qWDL/VJ6Yng12EqO5soAG290Xaytsxguy25IQ9zDRdFrF/+qqV9RT8gSDSTnNOwV7ERKIKIi1G8Z/ivMVfMoFHiCrIRR1Y9VYfRwMRW/wCp68FhBilOa8m3tW1zyUagPjSy31NY1yS9ChLCORD1FtVrn3A0xQ85Nr4kZcDm9WQU9kYFKhzppGECZlJ9g7Mx8fmoN/Yqfclcu37pAXmQFyVLWlMAEXHqFTLhtC7gh35ILFxRPgDh2HcGtsCQYl9Jx4qErnS7ttXoPClfclYDED+WsPGOSE7/5NzeoleF2c47cTgMdb/WC+R/4X/WTPFkvm7W18xysyPN656LB5laecoHSmWC61nJF0Rj9CpKopp67Fn+6SIj542SLGThROjCygcddKDvn4sWrWAafoxmVK8LL3yRIU6av/Rat8GCaOFUQAtOq09LPlAM5nOv2Fk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?empiQldXdGliaGFsc1JwOFdmQWViK0VFMlV5Vi80MnI1WW9tc1ZiSmNVN0VZ?=
 =?utf-8?B?VVlhOHVzVFliZ0NScEx0OUxNVm13eUppMm9OU25NRGNUcWRrWFYwaVl4dDg2?=
 =?utf-8?B?RUU3S2dPSk1taGxzbU1LV3lRQUhDK0FOcFZrdTBtQ29YeW43cnB2RnQyV0F2?=
 =?utf-8?B?SlVET3F3d0V6aU42S3dwSXIzaGdLOFo2THJwTEx4YXRDVHdWR1pzcjN5TUtF?=
 =?utf-8?B?Y1pEKytxd3QyaUJQQmtkRWVNWG91eFcycWlvKzBldjhGZk82em0xQ09sV0VC?=
 =?utf-8?B?R0VFZW90dUpLeDF4TVI1U2tLN0kycXlpRnplRlR3SzFPRDlqcjdoS3hKbks4?=
 =?utf-8?B?RXBIK1d1cDIrbjJjUWc0RVdKZGltKzdPNFBlVUx5MTRTSmZER2g3NTlLNUFn?=
 =?utf-8?B?WU5DOU84OG82cE8zc2ZBUVJYT3dxQ0JtemUxODk2QXpUb2xESG1RUzdid1B5?=
 =?utf-8?B?ZnZneE03VHk1S1BhRzhtNE1XQmxQOVRPb05IOUhaeUhqblVtVExxR2ovOUdC?=
 =?utf-8?B?NjNIbE91c2JwcXJtYktKN2ZDaDAzeVZ1YkErT2Q2RVJDc3Q4bDc0aHFhZVNX?=
 =?utf-8?B?V1hMUWZKU0t2R01HVEhaTEVKamFqMUZXd1luS2NaM0ozKzV1dldwUDlaMkRk?=
 =?utf-8?B?YTljQlN1SXVJQlM0UjNrSWdieVpMWFdESEI1STNQVHJUK3k5eW1rYWRLbXA0?=
 =?utf-8?B?V0g0bmYwSlBLcksrNUZ5NlJyUGM3bWw3TDlCR2Izc2U5STNpRGxKUEthN2cv?=
 =?utf-8?B?TjhyYStvUDhVTjFIYVNDenJJVHFSZ2JpTmVHK0VEYVZKSlByVC9QS0pFcVJ0?=
 =?utf-8?B?emI2ekJBVFpXNXozYnVLRXdTUURLb2VDeldlOFE3MERLVlZYWnVzSGhkVDlt?=
 =?utf-8?B?YW94OTFabFhWem5pdEhQWlRDMFZNMldkUmJ3dXdjdnE2R0FudUdXZzdLM2lG?=
 =?utf-8?B?Q1JkWXh5NVpGRFFOdGtNS2oxUnZ2M1JwbjBtV0s2Y1BIT1NuZ0JWTCs0Q01J?=
 =?utf-8?B?ZUJINmtIY1ZlRjdUVmNESENuSUNQV25pdTBaaXNHVEs3K1FYSU4xYlcvN09m?=
 =?utf-8?B?SllmR0NqRkxFcUh4ZEJYekJpOGpHdDAxRGFJNUJUQ3RjODQzZUN2aVlVOWNw?=
 =?utf-8?B?TEM0SFZrcE0yR1A0bFNoK1lHK2VOZXE2dENJcXZQanBRckJKUTh5elVKOU9O?=
 =?utf-8?B?RVFmTjhrTkZnTHN0RzFDTEkxR2hMUW9zYTBJNnBTbnRhMWVEUmphanFmT1E4?=
 =?utf-8?B?YVBKeE9FdUNNZEtZUm5lZGp6NGVRUnRudGhSWGROd2E5OEE3blArVVFvTmI5?=
 =?utf-8?B?cHpEZm1TUGpYZVNjSzZFeHBTeGNFYm1FUTIwbmVGazh3NmM3MHZtSkREZjBh?=
 =?utf-8?B?d1pndkJnUEJaR0ZMUUJyb2greDJ3OHJRRE8xTy93SVpuamNaakVtNVhOc0pL?=
 =?utf-8?B?WG5KZDdhcGRzZG9zTCtpOGJqZFY2dmswVjBmMjR6aDYyc2JjK2s3MDJ5M1R0?=
 =?utf-8?B?bHNNSk9mN0FPUjhCcWRKUW5mQnBqUStZU1pobllGSGdUa0h6WjBld203OE8w?=
 =?utf-8?B?TytZc1ZpekF3cTJxakZvQU94dUdLT2hHTVIxKzRaMldRQk9HTTVRcS9hNm45?=
 =?utf-8?B?WDJIK0h4TUJyUVNqSkk1RTJRTGYwY3dvSWdrNW45MnErY3FlS3BFc280SFE0?=
 =?utf-8?B?MXNNM203SnA4VGMzMnMycVpSdjdlWENnSEQ4dlNzSHF1ckV0RzBiZ0xLKzcw?=
 =?utf-8?B?anJZS01PZUpOTVJIa2h3VXFRTzd0YlBySVIwN2NqQ3UyNnM1d09Bc0YrVEVj?=
 =?utf-8?B?VTk2d0ZINllJWWh0bmtXdmw3dlhyTVEyL1B2a2gwSFY1dEM5c3NYWUFLTmp5?=
 =?utf-8?B?cVUvM3ZWRkwxTnQyQ3UyeUUwWS96QVgvamo0c21UVTYzOFlaZWRmVWxQTU92?=
 =?utf-8?B?ZzhEZmtYVkVkTm9ldER3RDMrS3ZqMDBZZEp1Y1ZxVnhDS2lFOTRoR1F3OWVi?=
 =?utf-8?B?NmFocUZqT2pIakJlT2FnY2ZGdFZNL0Q5aDhGOWNxT3dmbk1tOHpxZGk4TzZO?=
 =?utf-8?B?c3pucmhJT2ZqZFpvSDRTN0dqYW5ITzFtQVBBQlhKUi8zcEtsdlJKOUFEd2k3?=
 =?utf-8?B?KzVzS3ZWZ1FDODJnYlQ3YzBGL0ZDaVJNOUJQdGJEVHhCdjZoWGZ5SEs0T1JT?=
 =?utf-8?B?UXJBeWZBVWRpaEJKU2ViQldVbEN3T3pKb1AxdlNTdkZOTGVUU1d0VmdjYWNj?=
 =?utf-8?B?T0Y0a3FYcFRwTzdqLzFhNjRGd0Z0VTZaR0dhaWFBNmhqVDdWd3gvdDFJbGpR?=
 =?utf-8?B?dm0weUVFNDI4VVNXWVZIbVp0L1g4ODlKOWREaE00SjRFSjJ0M0liZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a9363e-e46d-4dba-1360-08df34803e8c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:15:52.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ob+TKLRgRvAPv0Q9NjDGMWPP+1+Q+RZGLPVUAzRJKfxvNbAWmbA/GcQ++WN0aIUSZde9N19st+by1XpDYPKkRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 18:38, Ian Rogers wrote:
> struct queue embeds a struct kobject (q->kobj) for procfs entries, but
> procfs_queue_type had no .release callback and uninit_queue() freed q
> immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
> With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.
>
> Add kfd_procfs_queue_release() to free struct queue from the kobject
> release callback, change kfd_procfs_del_queue() to only remove the
> kobject from sysfs via kobject_del(), and drop the final reference in
> uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
> calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
> sysfs creation previously failed.
>
> Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
>   2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 226f52626e84..8e6136d52a50 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
>   	.show = kfd_procfs_queue_show,
>   };
>   
> +static void kfd_procfs_queue_release(struct kobject *kobj)
> +{
> +	struct queue *q = container_of(kobj, struct queue, kobj);
> +
> +	kfree(q);
> +}
> +
>   static const struct kobj_type procfs_queue_type = {
> +	.release = kfd_procfs_queue_release,
>   	.sysfs_ops = &procfs_queue_ops,
>   	.default_groups = procfs_queue_groups,
>   };
> @@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
>   	if (ret < 0) {
>   		pr_warn("Creating proc/<pid>/queues/%u failed",
>   			q->properties.queue_id);
> -		kobject_put(&q->kobj);
>   		return ret;
>   	}
>   
> @@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   
>   void kfd_procfs_del_queue(struct queue *q)
>   {
> -	if (!q || !q->process->kobj)
> +	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
>   		return;
>   
>   	kobject_del(&q->kobj);
> -	kobject_put(&q->kobj);
>   }
>   
>   int kfd_process_create_wq(void)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index ae3e7c54014a..4666110aebe0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
>   
>   void uninit_queue(struct queue *q)
>   {
> -	kfree(q);
> +	if (q && q->kobj.state_initialized)
> +		kobject_put(&q->kobj);
> +	else
> +		kfree(q);
>   }
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD_SVM)

