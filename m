Return-Path: <linuxppc-dev+bounces-18981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308DFF3D601
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 18:29:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkNFH60zdz2ySS;
	Mon, 30 Mar 2026 05:29:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774808947;
	cv=pass; b=KVuai/r3MM22JQ/VyRPDxEblnhtd5P20v1ENEuC3k6SNfE3RTt3wiOxyHmxQEhDsSBsl8496oGZLG58AasolIrZNOVPBg1+HvuF17b7LHOmJW7WEBZqwqZBqPjvW3nLWoREp4HiqL4JG7SoD7NVu6o2LKcAy1ELGo5f6Z2alvHPjlPrOiEdcClr1XW7zxx9xQViXsRL/asiTBYDO5Z3PIqRaoQVSMRKdqu/6fiRXUZOWlT2DxFIVqDhecfIiNdrmNAS+DfRzbtMv7d30C1EjiVjhi8S4scrawpRlVMlB8K7Ei4ecsBd+1PWg6BVFTj8zg3zwoOGv8ZHfioBjeMATfA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774808947; c=relaxed/relaxed;
	bh=sM+iDUglU77V80PvGxntWZhoy/RvWeEHg2/oQubsnjc=;
	h=Content-Type:Date:Message-Id:To:Subject:From:References:
	 In-Reply-To:MIME-Version; b=d52GbIqKWagqToFhxVU9TtuXucf2gCLItXZHWGizSSVzQaRVwixpYi3Kg4AYpW2ocKu/PNo+xIFWBUkD4EZGLvWMcd8ckrPkONdayx3+lpR403nCP52oby0bvIT11xURcR/eZiKIi5kcyvHZK1qv+MdD+6HNosmn/tC+Cew/36bid0N3McfTkKTTgHabfFOoxWcC0vNGE1/r6vQofgi7uKJX6RAEqwtlGvWl2dZOiJ3gainutGD8s648TEQenqBGUPqitnt4aSADZGFkVDDa/6LTPA2QtJ0rsgpF+9mr3TAvL2L9MW70rcX5rxX51KAOBB8qd/s6WGdVpN8frrKjqQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=tRVVyeDn; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=tRVVyeDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkNFG71Wkz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 05:29:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRX13uZaHmloIZbYcN1rRoNmy/raiOxjPJ+d+pFgWRvB9EkgwqYik/YXra43Ysc+c6lJYUlas0+NxTmntgODVeb6toh7xV6TGvyicvE/CKtV5lPxcbMk9Au0HxNqGZP21/3k/yIZ0Hdta8gtijwDilrgF6pH3EjroCXfa6MqpkMq3NkXWQhrHil1gvdBF5/b27Lpy0fI1F34kUxEmjU6tmCWF/vTlqM5PJTo6xbbv15yqp0rWA322m9+p/Q/IR/tUJn7DLdiI3CMWd4dJsihGiAtkURwQgthCG0C6fCrLF+zmMA6AUcf+y4nPm6bq8G/h6K4p+gvqn1BLfhRVmweZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM+iDUglU77V80PvGxntWZhoy/RvWeEHg2/oQubsnjc=;
 b=lelxk3enLKu8c4yI0rDetrntv/arf50Fd2ZngbOytmQegASZP98gslXCSRf7IQKJISIEaJNj3CNUrJ7rEerswEvxZTiSrwHwhd4Ho5Uyr9vQBLVD8YVYRXYotIGt1ZffNyAMRSUdbBT2am7lGVS+LWVZu9lkJXG9KnfRJEDAAyETIar7Xy7cO2y4wfOs9zxIR6hDPEozQWKVV6nG3n6RP+aUJT36Qs4Mkf0Cswoe6mTVxXlMA9kzPdmYCyo46K6BKzowjYcQbxjjUDM+x9vELFVEYsCJctdtpqWOJlRTvs4hjbkUUEKeHrhN1WD5ENCRFo+43HUWV4spJgJDydKA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM+iDUglU77V80PvGxntWZhoy/RvWeEHg2/oQubsnjc=;
 b=tRVVyeDnzR8AGfCQB+8rj0lhlSbnGS7EIhIBii5TGKhEPC3Muhl46u0TE0A8m4Wnje81D0N3BFZr868KGurzL1TGgc5EIRKjeSCBL2tAJCpL+HzA+B2E8KkLAPmTYjCtSTLIuBmiKIkdk5Aq635YWDjQLxxJ0Cg9/K5z9Hk0nvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:46c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 18:28:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9745.027; Sun, 29 Mar 2026
 18:28:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 29 Mar 2026 19:28:43 +0100
Message-Id: <DHFH97P32UX9.3N2AR59ZFXV4P@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH V7 2/4] powerpc/jump_label: adjust inline asm to be
 consistent
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <20260329160254.2592207-3-mkchauras@gmail.com>
In-Reply-To: <20260329160254.2592207-3-mkchauras@gmail.com>
X-ClientProxiedBy: LO2P265CA0473.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::29) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d65aa2-1433-449e-9cee-08de8dc10279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	zy4DUjfUHbvgXW7fzz4aWuX8AYWLJIAe7zgBB2yp7nKMYcGYHmkkzcBTEHxvzzJpSm3jpkST7nin9PYRL4k2Dy5UOqnbRTB5rWdgY9A9VlHQYIIorw2WOf9gr00tSUpwSNqBcGN3mKxj07ZJ0rbfwBJ9qQ7Eoa3Y6VRQJjnBo8Iw7JLQydUZYEOFjhuaqDm4nlmqCfzCK9AESTlKoFQPZWaAkJbiT9wKKiKbitRODycnwjw/ADBw9dK6KYj1j7K4KZGwLx0TirjTj6uV1RRpprhXgLR8IXq8ydiJkN7On0TQW0dbDjFyFopMjePy6AkSOqrud97a3eI5b7u4odr28ZqP3JuFFVPpsgwL+hhfkui7h1wlAibJrW41ceoPjtzjX8/KnB0vBg7guu13J9wrBrB4iYSQCYey7YraRprqADl/VF3dCirgfymeNXc7F4jXI7hVboKNAE1iSlDnYJHNInb4I4JKBx88dEv4kRnUtO6AKFhwFDoef/sPBslhA5Hw0N8/wNZDwMJuqL/RfJJLhON9jsKQJSNabR1XNPPArNQMnWTaTh67WZ0F7qiqxFIEHVn2trNG7BL4Cus5Yv0xMRnaQzmypMFP8WTc4Mf9AQQmoJLaUmWPdVOWaBTwNgxFp0B4HzDyWUyytkaZYaP8FwLfyqJO/Kr8JUJuGWr7xydj+6nCW0Kfhm2OKm3AScHAB6CnQWi4wiB/Dqn7p5q6mjBlJx4nI6fSeKrxO6rmkDiPklAvrXfpa2GXKFHIV+SIvt6ilvXfQmPHjhIxHFSGVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak05UFQ3T1AvRVR2WWVjNzhDTk90amZrWnBoejcwQzhGV21PMUE2U0xZbis4?=
 =?utf-8?B?aUNTdWVuSlFoS3FHQk1paFg1SEJrb0VWN3JsdTE5OHhLWDVXN1VTVjVDM005?=
 =?utf-8?B?OGdCMFhCY1pTWlp6cmVmNzB0d2pwcHAwSnBEc2tFYzJ3akZLcnkrS0tRakZw?=
 =?utf-8?B?NDhkakFPTHJNa3Nmd084ZGZZeUlYT3o2NkJQN2VXK09XS0xDaVZMQXlxUXJY?=
 =?utf-8?B?dWZJRkg4eWNJRHlDMVg0aG9FQmJodDFnQ0F1R1kzdWNwUzFjU3l1cG1vdWN2?=
 =?utf-8?B?aWo4UDIvaWFWSUxkK3hibi9VeHpYTC9CUVVIcXBSZEUwT3hyTk5YajdUQzJz?=
 =?utf-8?B?dUVDakFFV1FhMkh3VS9QNGhJWnJjR3U0K3J4bWxUMitEM0RaOXYrNVpLMlNz?=
 =?utf-8?B?S3ZFQmtTamdCQXVBaVRWSGJQSXhkRjRNaytKcXZ6cVVJc2Yvd01nN3VPTks5?=
 =?utf-8?B?ekg3UDZUWGNKWCt0NTZzT2F3eGVYVWN2a3FBNXB0eGhXallVbm9Fd1k0TlhN?=
 =?utf-8?B?Vjhmb0owSFRmaURKMjErdkxhdXdRN3M3R3Nxem5VbitkLzdXcWpNZ3hKVkxo?=
 =?utf-8?B?QWx6N3ZIQ25uY05LT0xGdEVRYzZGQ2RqTXhXMHhpSnJadFNRelBjeUtSMVJy?=
 =?utf-8?B?MHdnQ3VSZVM4YThySFo1WkE4WjYvek5IRUNqbEdtSmFLTUQweHhtZHVUK1o2?=
 =?utf-8?B?SDRydEdlMGwxRXdmM0tPcnJtVmM2T3dlTWtKRGVVS1V3cjJTSUpBYmRjUFBm?=
 =?utf-8?B?TWVBUXk4RkdZNWNiVlEzeE82OG5rZ05QdlJ2dXB1ZWJBYzdDSUU4aEg2YmhB?=
 =?utf-8?B?aDAvME1pWmwxRlVrbTFqR1NPa2I0bS9SUDhUS0dLL1NtbEVyZUdzTExtTStq?=
 =?utf-8?B?dHJxVm9kS0p2YWxrSXdBNVQvU0Y5QzQ1WlM1NUNzcTN6dTNkdjdzdmp3aVdl?=
 =?utf-8?B?SEIzeExaNGtzeURUY0l6YWUzQms0UWFPTFRDVHpYNXFVcmFrbkx2QzRzMGd1?=
 =?utf-8?B?THlra0hiZFFVbmtRb0YyUFhjaWF1R3k3QkdlR0Z0VmdGemRrSEk1ZnNwUnVC?=
 =?utf-8?B?QTkyN3I2R01UZC9nZExkSXd1eHFjN01NNnNSam5ha2xCc0FQY3c5ZDNLQVBm?=
 =?utf-8?B?RHVicHZqLzUwRFFwR3k3NjZvKzBkSnVvZ0ViejZaRkNmZ1oxR0JlWGY4QlNu?=
 =?utf-8?B?cTJpUkU2czdHbkJoT2o0cVZHR3pDVk92YTlZSzNCOEdLeHlMZEJuTmF4MXFR?=
 =?utf-8?B?dnhWR2pTT2xZVzZkbnI2bHl5Ty9adFU1dVhmUGpUOUtKNE9rNU9SSlNheEJn?=
 =?utf-8?B?U1ppNXQ3N3o5UGIrWTJXYzZPKyt4VUhLb2VLbmZxcHpneEw4bmExdFpWejVN?=
 =?utf-8?B?WE1TYktzUjFoNGdLaW1PVldQS3BwVFRMVHoreDJaYmRrTmt5Q3k1d3hBVU9q?=
 =?utf-8?B?eGtid08wTlZIQWsrN2xJQms2NVZyMmhGcHVFYll0TWpEbGVNN1FEQmVZTnhT?=
 =?utf-8?B?bFBEYU1QUEMrMWxENWdNOVVXMy9ZQ0dDUTZCd3NoeWpEb2FWM1JlNlA2K1ho?=
 =?utf-8?B?KzFhaW83NzRNOFJjcmRJQXl5Q3hnTW9McDB3L05vanVUNG1WWVJHTWgzaGdP?=
 =?utf-8?B?L0J6dUc0LzZsallpUkZJeU9YMDQzRmNIVjdsS2oxbmg2RDdHM2Z0My9CT2FU?=
 =?utf-8?B?TU9CZjNBc2Y2ek5uN2lobkxpaDRxMFFjYTd0WFUwSGxjZVRtbHBWNnlBbXV3?=
 =?utf-8?B?b01wVzU3bHZQbFZJdERBVHhmWENMQjVNL1RBSDI5UHhETmQrblZINy9XK0hi?=
 =?utf-8?B?MitSL1E4NS9CejBqRWxYUUNEKzJHZWVCdmgzT0Q0K0xYMkVlY0xiZHZyMXpX?=
 =?utf-8?B?NjZWOS9icGZPc3gwVXFGT28yQnprR2hHQnpyclRnVGI3QndEY3BROU11ak4z?=
 =?utf-8?B?bkZCWSsvMVlGTkhyRXZETEJwUTgwbFpYYzlmaEltcTJQVjlCVHczV29TTE1Q?=
 =?utf-8?B?a203K1JKbHFuRTh1OEsxWVNUbFRlWDQ0b1d4N2dwMnc4Wno3bnZFaFNsNUgy?=
 =?utf-8?B?dWdPRi9CT3A1bW4ycDcxbkh5ZEM0ZWFLdXRlMmNwMHNoWHVFb1lGOTFIVTlz?=
 =?utf-8?B?TmwwSEpycE5uMXJPZGNyUmdkSCtDN0NMUUl1UjR6TnF2aFc4YWVkRGlHNHBk?=
 =?utf-8?B?VlVteUFhU082Sk5lb0ZzVzBMZkdPY2wwSEM5RSt4ZC9jRDhja2FmOW1FVXN0?=
 =?utf-8?B?UDVBYW8zRUhqVnNDcGN1dlZ5MnYzYm9FeHFBdE83V1p4V3piWUV2Mzdsd3Z5?=
 =?utf-8?B?Z1hIZUdBc0dNYms1cG0vVURYeG1ieDBzZC9lWW8wR3RJZTdibkRkdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d65aa2-1433-449e-9cee-08de8dc10279
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 18:28:44.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1H1giRElmsR2AKGM4cdoxN7vlciHt6wYuewt77TqqGaCqYCDMLpB3VmbQyylBpkRf1GxbGU1iifS36153264g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8493

On Sun Mar 29, 2026 at 5:02 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> Added support for a new macro ARCH_STATIC_BRANCH_ASM in powerpc
> to avoid duplication of inline asm between C and Rust. This is
> inline with commit aecaf181651c '("jump_label: adjust inline asm to be co=
nsistent")'
>=20
> Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)


