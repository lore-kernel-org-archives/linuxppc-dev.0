Return-Path: <linuxppc-dev+bounces-20054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746C9FE51E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:45:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g263n06VJz2xZK;
	Fri, 24 Apr 2026 18:45:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777020324;
	cv=pass; b=QHIMVZOzHVxZKP0vyzk2bzVzrhmb3qfS68+ld4XxzPqTt4Nu4+D7Qgy87yLD2pT4W7pDWDrLPZFsHbPuUXr4dEGO74g51/CQFsMFJz61vu05f2FpyeD1UdTUUvpKeV9kgoRGW3SrP8PeBStT/5n+aTJ6XPkMNg2a6x636R40z2lV5teLoWUhH87ckUvwwh+BQBIxX4P+OuSJMAmPj1cWmmh1x1EK2ZpMuDU6vqK120e72EEZNp01WtuW3mjmEkEF+ZYI4zrTRO9F1cbQ535OATnLGpVenLnpADRbYIeo+8IwCk9BuUaxxtSCTn3Kkiws0JpU1Ml0QpJMbhAK5ISzdg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777020324; c=relaxed/relaxed;
	bh=SChoTryJsEZYV02j3nArEHyA5zsLVzHXB83wg3XYmR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f7URdgdHPzNrxLC3DER6wa+U/n8xzWFrF3scOJ++v0DaCWlcp4Xzcn7QTTAc6IBlQ7gOApg/PutB9QkhsZ0qnpiHCBaeLB4hC+TTMY0e/UVYi6NK4ormo7vs8omIR1y4Th3l4BQ7Pimck72OcfF2rI90qF6baQINDeA6oGjdjMcUVJPS0GM0P5dpcFjgBfbTmT1KblZef1WfmSq9trMi9sYi+a8dOpWADu9ED+GbMNGcVL+OslZsfp9v4a7u5AhJJMAlIMIkaouGx7JgscAYSlGDhmj4gTxkmsLJmG1+sLquMawQpoKYbS5+n9k6UQjJtmVSD5OUJdRIQzMgq+XjnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HOKyeAJ3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=christian.koenig@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HOKyeAJ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=christian.koenig@amd.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g263l5BY1z2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:45:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td85LtW7QHoyx90Csh1TqGttoB0IYdDP1a5Gfj8BwKYBJx9X3E9Ck4hRQkJdIJpSwVFCn9N1N0Su1kOdZqlU3uaVacnsMdqwDlfpFNcBrxYuiTXoFPWmUaNDGzkFzA7kI5EoTfZh3sePo7fvBqVi2KOk/YW1AdQjbIri9QP5/vDBXfwWgf9lBvWckkPwPBoWJLYVQp+0thYOKxKp6SLLImsW+yeWBk4oW4HrlW/hlYxO2Xvid9Ptt0nZIz1ycQfWifj7sZhoGHDkdfE87F8lz3xbPnMD3gPo3xDd/hCrhMO/eBD9IhVT836/1gBEHSpyiOyt2PFwhHvN61m6ZGj4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SChoTryJsEZYV02j3nArEHyA5zsLVzHXB83wg3XYmR8=;
 b=mCN2Y79piPyUa5SufD8bs2hJJAxigMBEt2MlWWkMMe4E/J3VTYVOj29w/MAt0oc08d+c3TDcXZswRy+mFPKECNA4Ab6S6ccItQeOa2zLadRgV8c+fpJzpTgxPaYf8pwASlyXOBjJnvfrWQVEtKaAhwrakIEHJ88AJbHiUURj3YEgf3hPz7L9hSQG9agVSJ7qN6a+DUwgHdgCePNHgbxUsE9DehhN1y/Bkpl4CbNQSwm/U1Tkx8Vx3lXMdxspG+1acg63YKZ/YYrWhVcia/BU+CU4uFuDbTEocl7+RvT8T6tu+gGtkjWjMgUSB/o+vwb/YLPQYWDZLqHVD5hgDIYUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SChoTryJsEZYV02j3nArEHyA5zsLVzHXB83wg3XYmR8=;
 b=HOKyeAJ3WdyrOjNtxUZ4r5L5Zd/KtSz6kHPBFvnj3UOXOkXEuPn6LRwT6Mqlbyj2e9JsKTPraG7KSQDMH+H03LZhTEVuAOgHCs8MQepXBev+rm6MMH40Be3Ej17KBSJdsjKbjHE3Ojl8axXmyhaWcwbJBg9LPdS5X765jxxl03U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 08:44:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:44:58 +0000
Message-ID: <60a6eabc-af5f-48ea-ac95-f9a5d780ba56@amd.com>
Date: Fri, 24 Apr 2026 10:44:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, tamird@kernel.org, arnd@arndb.de,
 nsc@kernel.org, simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-3-mkchauras@gmail.com>
 <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
 <aeskOeb9uBiPptEJ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <a2241936-579f-4fa6-a9ec-49325d44413f@amd.com>
 <aesqe2NKWhkT4kc2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aesqe2NKWhkT4kc2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0483.namprd03.prod.outlook.com
 (2603:10b6:408:130::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e8cf23-fc53-4730-6d02-08dea1ddc404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Byt7Bnw3mX5dl8uowRA3/EpMvSLTC5Tar7VRB4bVw35Pb5j1i9J9sVvVPvmVFitiW2YVfPta6qXFlMpkLFhtbcVMlQyzR7FPyL4c3LVLl1TRn3wwok8s/oHAT0rZwGOvv1pglSsVwYWInWMiya6P7gzwJ2T8WZNGj17yOX0isw/1nLWWR2F8mCF7Vi3gmKqtYHB3+H+416MM3YNsU8EOu1S+UoaTSYuJBnxTq/ygpUzL3KIcDJLdJjQ3Pil1RZbawY8o2p7qUqt5CodIwUP51S/+CHU8FaSzcxqyRk6JAbufTu7Q1wnaPOuf0oQ4N1uvzULDz1IcL2YJMm5Cru3gEZkEiOjWy2x3vZc6Ued5zzl1DT96mdvGgMyKPXPLufscbnSVblMlvhUauztwIWEHS636sICgHFxBGs5OW36Pr15QwZnPJ8gfNxfFIS6HfPPGMGx3CiDwhtT0W1hsQOHt14Qiv4N//bcU/LpiE+gvYj4zWLV7fBfHgmAF6yL+yOyksH8Wnxb1abrWGZy3mgGrkTH2fKA0CZDgP54g7J4SrtPtRIQMOQq1JiUQrlzEMEfxoMZ7oNZPARtXJBL6r7qqK+iVu/ZYEGY6CeWeQyBz/VfYejHzLWl0iC6zrb9XxsJJXw6fyob27l+8xYZRMKawIpTO4iA9iWBh3oO+wWI4kHHHN3AX9M0w8OelfqXHb1+6d4u9HWC0D6eMTn+SEI9HaHT2EObi3IjgiubghqGMJAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHRtdkVQSUpsT3VRcEttZjFhS1JYTUhxOC9aMHd3bHM4Yzh3VHpjYzVJb2U0?=
 =?utf-8?B?RFRnVSt2aG5vNWs1NncrOVZ6d013SjcwSVV4cG1OVFAzUUhMbmp2eVlvdUVH?=
 =?utf-8?B?TThyUURUTExKTHJ3cmMxUmxHdm9kMzgvUnZQeWdtbXRjMVdmdk9GWmVPUDhM?=
 =?utf-8?B?cmJmS2FxeDlpdGxXcFduNkNPV1NxZm9tNzlpMnFJTEhBeVRtUlF2ZFAyZmRT?=
 =?utf-8?B?dHZnMWFENHlld1RHN0d3aUhHSXhIWjFWWndjMUxQdVcrTGtkSmxFSWxESzBV?=
 =?utf-8?B?bmNSSlNlMSs0N0ZFODJYZnJsUUQ4cHRjY25TRUFiTlJueFkydWNieDhkZDJ5?=
 =?utf-8?B?NmtHaHVZaVhaRTVBMzRGSlFISXZMTTlqME92aUlHVi9yQzZWSjMwNVB5K2Mr?=
 =?utf-8?B?YnlMYlZVZklzYmhxeFNWdkpZbFhVKzBjVkhKZFpjcHBjYkVNY1JPSDZzeDlt?=
 =?utf-8?B?cXliN2hSNm81c01GczkrY25LZ3g2djlvZThmRW9ESDNDRGJmemNveVJrVDQw?=
 =?utf-8?B?NGxvNFdxTDhoTWcwSlMxRkFtYndDQjRYemJuZFFTMXhVODU4VFVESkdUNytl?=
 =?utf-8?B?Y0xyTjdsbHJvZDdzQzl1UlprWThLRHY0QlBUbVJtcTR6akgrZHUxVHMwcGV3?=
 =?utf-8?B?UzIyYmFlZU5kamZtMlBKZXNJeTFObDlrODA1cS8waTI0SWNLcUtiRkErUFgz?=
 =?utf-8?B?Ym1XMUIwTnlGbWJHUE80U0JBYmFNYXFNM0szaWdlNytESml3aGlYRVNaNWVZ?=
 =?utf-8?B?YTB4RzNjb25kNTZqT1V0dmZ4cG1DeGRLUzdRQXFLSGRiOXlIME4zZXlvVDdZ?=
 =?utf-8?B?ZnFMWHNTL2I4QVZUMy9VOGt5MXhGVUpucWxQZHV0Q1hrYzJUYTBUcWIrRTVy?=
 =?utf-8?B?eWJhT3QyWjZuU1hOV1dVT2FXL0JGUkkzdGRjWVBibCt5cERlTGlKSXFoWWtT?=
 =?utf-8?B?V3RhYVVSNWlMUE1uRk5RS3I2eW1yWE05cHhJc1VIKzI2Zkx0a3JrVTk2OG9F?=
 =?utf-8?B?eXcyL2puL1I0QWQwemd4SWg5NVBDYWt6ZVBJVSs3ZWE3ZzdUeldlRFl1WXVF?=
 =?utf-8?B?NEpZOEVxZ25nUi9sRkh6cG1xVE5IR2JFMVBSRmNSL2Rsb1k0VExENExzRkhu?=
 =?utf-8?B?MXMrRCtoLzgzbG9qcTA3UFFOZXZSUGM3dXVHQytQdmE4NjU2QWJQdi9qUjdW?=
 =?utf-8?B?M294cVNxaVJMeGkwd1lVUGpFVE5FdllhcXlCMHBkVWc1UktNUDQ1UVNDME1M?=
 =?utf-8?B?amxsZHVhaElHQ1E0a0NEbTU2bGQxTGkvNDZwMzJNR20xMytjUmtnVUs2Mjl1?=
 =?utf-8?B?cFZYT1RheUpSOUdCRWRQK0NHU1ZkSHhnRVJTN0lRQ3MwbVRBb3owQk5qR1ZP?=
 =?utf-8?B?TGIybnZQR01sUDBUV2U5TU8rVjRQOWxDS2dlYy9DSGVpcUlOZTFzZ0RoS3BK?=
 =?utf-8?B?VEZ5dUhNSTJiaGd2SXZtTXB2UDdocFhleXR1Q2dyTUhYLzNqTFNuNHB1cXZn?=
 =?utf-8?B?OWxOTTZmZmlEQjJSOTNOK3REV0preXdQZEZZZzZHVHpLVjh6Z2d2QkZySDhF?=
 =?utf-8?B?VGNjL1pteGtXQmRUTi9qNmtrV2djTVI2RVp1SFkzdThTMnNEaEc5eldoRW5F?=
 =?utf-8?B?aG9rdWpBMmNvelBORTNWYXdlR2l5T2xqVHo2V2s0NlFrME9kZmxFRDBFRDhE?=
 =?utf-8?B?ZGE4T1I2MHoyb2ZrVFNSVVRyY2tvU2wxRVc1Snk0Qm5zUjZjak1idTRZQ3NQ?=
 =?utf-8?B?SjBWS0duN0V6S3Y5b3lpSVFXWnFPbHdkdXJOeVdpYWd4dHYwalkzdTQvVjgx?=
 =?utf-8?B?eko2Qm4vU2pWbHQrcWVQRnhpdDJBZ1ZETVlrb3oxMGJ1MjdFajc2SWJWSk5j?=
 =?utf-8?B?T09jWTl3Z0JKNjlZa3I4Smw0SGhjcXd3eUE3cFZzbjhXc3A0bzFDOXpqSnlR?=
 =?utf-8?B?OE5odHRZeU1GbVhBTUZqWW9NT2h0MHduLzU3VVpYdkpDTWt3SHRlcE5NcUNk?=
 =?utf-8?B?TVpLK1NyK21OLzlSYmdtdHpFWEFhSFBUTmpYYVp1Ynk4Z2lUQThZdm4rMlhq?=
 =?utf-8?B?VFBNMm9PVUsrN20zRlVtZVdmNnFNLzY1VlFSSkJhTElEdFdROWlTYTFqV21I?=
 =?utf-8?B?Zml6UzZHSnpnRmd0VGhCdEdUZVhOb0RDVmJNeVlmOWU2cEpVVWdBdVZmYkFr?=
 =?utf-8?B?Umw3dW9aZnlaTmtTZkJ3djE1em96S2VmelNmR0dlVGJWK1YybStjZEZ0RGl4?=
 =?utf-8?B?bU13d0RCMTdEWFZoNlp2RWcyd0pyaXA1bnBUejlnKzhjRmx6UmpCZExBdVVX?=
 =?utf-8?Q?5FG9yX2thGLWYqq/Pq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e8cf23-fc53-4730-6d02-08dea1ddc404
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:44:58.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crgfvRK31+auzuvLpHW3zEfjL7fRrqCaMgLFibwOM0k1T4gdbwa6GhDixoTYeA+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644

On 4/24/26 10:34, Mukesh Kumar Chaurasiya wrote:
> On Fri, Apr 24, 2026 at 10:25:25AM +0200, Christian König wrote:
>> On 4/24/26 10:06, Mukesh Kumar Chaurasiya wrote:
>>> [Sie erhalten nicht häufig E-Mails von mkchauras@gmail.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Fri, Apr 24, 2026 at 09:56:16AM +0200, Christian König wrote:
>>>> On 4/24/26 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
>>>>> When building with LLVM=1 for architectures like powerpc where
>>>>> CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
>>>>>
>>>>>   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
>>>>>   >>> referenced by helpers.c
>>>>>   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
>>>>>
>>>>> The issue occurs because:
>>>>> 1. CONFIG_DEBUG_MUTEXES=y is enabled
>>>>> 2. CONFIG_DMA_SHARED_BUFFER is not enabled
>>>>> 3. dma_resv_reset_max_fences() is declared in the header when
>>>>>    CONFIG_DEBUG_MUTEXES is set
>>>>> 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
>>>>>    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
>>>>> 5. Rust helpers call dma_resv_unlock() which calls
>>>>>    dma_resv_reset_max_fences(), causing an undefined symbol
>>>>>
>>>>> Fix this by making the function declaration conditional on both
>>>>> CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
>>>>> disabled, use a static inline stub instead.
>>>>
>>>> Well we are clearly missing something here, but of hand that doesn't looks like the right fix.
>>>>
>>>> When CONFIG_DMA_SHARED_BUFFER isn't enabled then the whole dma-resv.h header can't be used at all.
>>>>
>>>> So you also can't call dma_resv_unlock() from the Rust helpers. Which means that we need to make the Rust helpers somehow depend on CONFIG_DMA_SHARED_BUFFER.
>>>>
>>>> Alternative would be to provide dummies for the functions in dma-resv.h when CONFIG_DMA_SHARED_BUFFER isn't set, but that looks a bit like it just hides the issue.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> What about something like this:
>>>
>>> diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
>>> index 71914d8241e2..53c119f1b144 100644
>>> --- a/rust/helpers/dma-resv.c
>>> +++ b/rust/helpers/dma-resv.c
>>> @@ -2,6 +2,7 @@
>>>
>>>  #include <linux/dma-resv.h>
>>>
>>> +#ifdef CONFIG_DMA_SHARED_BUFFER
>>>  __rust_helper
>>>  int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
>>>  {
>>> @@ -12,3 +13,4 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
>>>  {
>>>         dma_resv_unlock(obj);
>>>  }
>>> +#endif
>>>
>>> This seems to fix the issue and makes sense, whoever wants to use the
>>> dma shared buffer will anyway enable the config
>>
>> Yeah that directions makes sense.
>>
>> I would maybe go a step further and don't even compile rust/helpers/dma-resv.c when CONFIG_DMA_SHARED_BUFFER isn't set.
>>
> This makes sense.
>> But if that is not possible for some reason then this solution is perfectly fine with me as well.
>>
>> The general goal is to make the error messages when you haven't set CONFIG_DMA_SHARED_BUFFER and still try to use the DMA-buf functions easy to understand and not something cryptic.
>>
>> Thanks,
>> Christian.
>>
> 
> What about this one?
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 625921e27dfb..09ee5cac600d 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -57,7 +57,9 @@
>  #include "cred.c"
>  #include "device.c"
>  #include "dma.c"
> +#ifdef CONFIG_DMA_SHARED_BUFFER
>  #include "dma-resv.c"
> +#endif
>  #include "drm.c"
>  #include "err.c"
>  #include "irq.c"

Looks good, feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>

But somebody more familiar with the Rust helpers should take another look on it.

Regards,
Christian.

> 
> Regards,
> Mukesh
> 
>>>
>>> Regards,
>>> Mukesh
>>>>>
>>>>> Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
>>>>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>>>>> ---
>>>>>  include/linux/dma-resv.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
>>>>> index c5ab6fd9ebe8..23c8db0b5214 100644
>>>>> --- a/include/linux/dma-resv.h
>>>>> +++ b/include/linux/dma-resv.h
>>>>> @@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
>>>>>  #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
>>>>>  #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
>>>>>
>>>>> -#ifdef CONFIG_DEBUG_MUTEXES
>>>>> +#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
>>>>>  void dma_resv_reset_max_fences(struct dma_resv *obj);
>>>>>  #else
>>>>>  static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
>>>>> --
>>>>> 2.53.0
>>>>>
>>>>
>>


