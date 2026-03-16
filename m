Return-Path: <linuxppc-dev+bounces-18282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C9FFB5E8B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 00:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZXYY6Tl6z2ygl;
	Tue, 17 Mar 2026 11:16:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.177.32 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773705076;
	cv=pass; b=CqBUo0/aNGmgBqcJXiiOQwX5P2aF+uMcIRehmStd7jeMh1ORvK1nTqaZuDWy6rnZyK8NFLwS+gGFFqgkRBeLyqNJ1jnppbud9D6/+yRpq2iAXScRg/1+cKWERJnQuHTihvLiOfLT3GoP/xhzXP2lrUqBjSc9XZwGEfK63tZ9FiIIbwDgpP8M8lbYMsmZ73bEB28KzkT+EwQCc5KPeQcKqMJgxvLzZKOGxxuCMLUFHpyyqoxZgqZM9jXNhXXVrcz9pui4OtKckvf8Scu3uyHrDh++qCu6r95K/OtP93pMG3MJ+YKbODvLo8gdGzhMofGEHg0AHEqX7Q3dHthGN7GQtg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773705076; c=relaxed/relaxed;
	bh=EMRNxLcN2gFygz9ydBQrMXqMRR2351B5lIi5ba/KMMY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YspqPl6cJ6Y60GgqvSMiyX2TbWXHFGDJdIrriN9t0UsRvSyltGxqB0jqy0R7/4QTLkw3GDcvotmcVN9vuyrlOxHViGjts6pENgMBcrmLMjbDmw2cfJVd0pfV918yDJYBa9BT/cvY68/MDH5n0ekDFZ5DeEZymiY3qikd54TfW2eZxavCXY+5onpYVKEJjxG2r04wtKt6lWXCW7wkJQeN5xqqrD3PaCTz+pZfEb1Eot4+VKb+x85YWMiz9HT/ufTTf+Z1vpLmwiur8Pq+orBqGteZO9zz0xk42mD2WV/InG0LyTBlBrHKdBp1GiOrCfIfciPzjQ+EZU3jN4U1uR5DYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=geuxP93P; dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=pKH4DAyC; dkim-atps=neutral; spf=pass (client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=joseph.salisbury@oracle.com; receiver=lists.ozlabs.org) smtp.mailfrom=oracle.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=geuxP93P;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=pKH4DAyC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=joseph.salisbury@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZX0y0wDPz2ygH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 10:51:10 +1100 (AEDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GE2lp81339865;
	Mon, 16 Mar 2026 23:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EMRNxLcN2gFygz9ydBQrMXqMRR2351B5lIi5ba/KMMY=; b=
	geuxP93P1/ZHrqqMD+FSTrazNkTE17oZ1WrOyC93JmJAi40In1NRo1jg90AX4x2X
	7Ha3cHz7GdSEA6k9zd+4M8JdYMv02VrPFJDRwJ+3CdiAIG6WipOaV+jaNl1GHoeM
	QQ0coZQBVtWCzR8RRbmQ4f/Yrn6kkwdZ+svlbNWM0Q5uVoiQFCSWXHL4lMeFGz+7
	tDwW33vlB5MWgmZkCAjkAbEQ+hVfayBsOQQeGwdyoDPF0N/5mmCel/jWvvmjK3a8
	OJWTIh/bCoVABp/hpAJ8ssu4ozxAopeV5wZXlZjO38XJERszQslsF488TkmI4JJs
	wkIeCAmt+mfACeK4jgudRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b37wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:51:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GLv3ir017788;
	Mon, 16 Mar 2026 23:51:03 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4kttc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+cCHPLjoETLcij3iPd3FvwNXyGKkRrWM6ipDm6I9zyETkPnHapzzfl/bGvmXgC54eLHK/wBP2NLatalh+LEtYhdHzgpYmvXxy90nW5gnkaeEWx0Ft0ixLD2fdJzFX0PSMe9/Hnx72GA08iPxplGSO4LIZ0LiDdtwZItcXBtORsvTcWgVUKFvDOQC1fgGJ2WJTHW1oyUfOfkw8C+ECIGex08W5/wFAJlwUGMAceuib6jWDpM7ApV4Rew1+5jodVRDUmmHtYZxrAaVyyJUe4+PrGBXAc3ndqHrS3i0n0FeyHZED3G2QJWu6y4MI95w8r0PoYtr1Hv2Lam9j9vL7sUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMRNxLcN2gFygz9ydBQrMXqMRR2351B5lIi5ba/KMMY=;
 b=OkMv7rA4rmLrg7ihIwUbyYd3ozQNGqFCTD9bczLQiLlbbuql5/GyT5dMlYJeRTT06XWl6nSdFFpvA7vkpyl3ygyPpCNovskXy6qXulUjooh/Cwv7ql0C4Ia4kIem3S/Q5Mn9Jf/YmGHCEn+yfGVpKatwbVm6yXVKn615RuuzDsXGXey7qBmVSw9DQ8NLMVuTuKVlcZ2/6c2hRtgCieDPCRBZJU+nJkMbTvNDE62oMp/1Vx/paL6mZlCXl0jAbcgo9DszSRat6YMVynv7T6IqjiAPTwHnoxmgMLDSN9El55t7oS9DRQefoARu2AkLb5pIInrLWqf/oJ6Zdhw5Kh5LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMRNxLcN2gFygz9ydBQrMXqMRR2351B5lIi5ba/KMMY=;
 b=pKH4DAyCWWUagxq6yUpVu2WWtRBF4mzUOPGgeGd3sRrFVR1L4qe3+9s08BK08q7V4eEzZsI0ZWM1dQQbLFMx/u8K8OZVLiDAVldLAkJy/U7Y8yyMRv9GcGUOCjBZosBmdEoPbFv17+5u61iYE5SHNryOm/mqUbNUv/N5KBl64ok=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 23:51:00 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9700.025; Mon, 16 Mar 2026
 23:51:00 +0000
Message-ID: <a61b8ef0-32c1-4d1a-9ab4-ceb6d5f004bd@oracle.com>
Date: Mon, 16 Mar 2026 19:50:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] ASoC: fsl_easrc: fix comment typo
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <festevam@gmail.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260316180545.144032-1-joseph.salisbury@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <20260316180545.144032-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:930:13::10) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
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
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: df79a52e-9204-4119-a765-08de83b6e05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/7XfjIL9HtYahkw9AjqUC1UNdSWQW1e8mPeVfUtYcd/DVeYECorDeKDcapZ2l9MHNZrDGLp4RG0D51rieOhNzpkdWuRkobwLH9U9A6eaJIqwOjXikPZZz+USn23pGkLQBy4L7LZxXTZb5v6Ga78sjyqNE1NMfrs38HMx+mSSrzC8Y1cfMBqMyiPmzXMScJTyqicucfcluCOX0lS0rN/gcdxGCHgWOacdt0Dg3sgsjy9mbI+f/XG/BASUIM6n3sysLI4Pcj31OgsXyZLEYMJeWEb4UTm10xhRaNef6PK3L/FMYAFa+xIL6ovgmwP1ZsFJWlyWFuc9n7tthtU/OdPr2MrFFbz3wsK6RdGHTsL1iIFHW321Sc+4tKwsQgoHV9o+IIV4/Bv1Jr5Ee+b4D4SyoCjeHok5tn8SpKnSLwOVVfGpRxlHyDBOvtQ/wUkYJQOXIXmqNMDTOELO5klXxMbcK5sUk0JbGYlIUKqFQcTFSLbTqoyShQH0Z+LJTfMv8aDIrLQgR6n7LlbWcgjohB1v1dEUga0WzsC+zwcC7Kez6D//DS14Uc9TcpwPNyV/LBjqg86oWrP6I5zBZ3HleR1GSwGgQ5O5/EkJiIlM3yRHLYgCdH1LzHOCwfnV+hxkrGfCM66d8nj9Ae4Ud9fCY/oEfxYKtQRJNRqEn8v/On8iBAC10eSElsCi+brmYUC/7Aexd2sI8CeQ2qsCwMjEATXM5+9ZKpJ2ri1Z4Kdv6a7VEaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHN4N1RnSFBUMWRlbUx4YUh1RVJ1VklwRmxjZzBQVjhnN3hGWTJ2aGEwaFQw?=
 =?utf-8?B?Wi8yeWhaTHU5cXpDU2FncldzWngzVXlRYTV6bTFGQnF0Sm5aSVdDWUpuaU1N?=
 =?utf-8?B?V0NNWDVqamwzeFZYVVRKaTNDM0VaVFNseE9NV09XbUhueFBRbzlmdFhCaU9w?=
 =?utf-8?B?UjU4NVQ0RVpNQ0hEQVo4RzlWMW1ncSsvRURmRGxUR3pPK1FlQVFyQ09MZjVr?=
 =?utf-8?B?ajhqcFdHTEc3ODNDUzl2emRuR1YwSU1HNVdra0lsRzBSMmFzY3JoVkp0ZmNt?=
 =?utf-8?B?Y2VWUUxZdXk4TzhTMk9LUXJ6UmJYckFtZTRJZ3BENmRKMDNZRU8yUTAvNkRp?=
 =?utf-8?B?b2t5a09IY3oxczlZcVJ6MUluTi9HQkcrdkZVT01vdGZvekNPMEJsUXA0bFA3?=
 =?utf-8?B?dEF3M04rZVFCcHVlTUtMbU9vSHQwVnFJVWZEY1FqZTFPRmRFN1lyTzhNWTlW?=
 =?utf-8?B?NjBkaUhIclBUUlRYVldZanBST0FUam9qcFg1dkNnazIxdERUNHl6S1F1RFJ1?=
 =?utf-8?B?QjkwOU9LeHRXa2VUNXVYKzZVclhhOFBNL3FxZ0dveEdYNUhnbG1pbTRvd00z?=
 =?utf-8?B?SmZLVTQ0N3Mwa2krdjFReitRMlVuR3V0bUZSTGtwd2RzS3VSc3JKMVpmeVRT?=
 =?utf-8?B?SktwLzdmWkxiRTIrb2ViYXJ5b1hWcnRKSzQ3aStmMWIrUEhndTdzamRjb0JG?=
 =?utf-8?B?cldlT0tNdlVZNUMyY1FZN0ROeXJuLzIrRGxDTGhEUDU1a0o4UDBOOXVQNHJ0?=
 =?utf-8?B?UVkvdVN0dnQyVkpwVGhtR0IvVk1EVG5rNFJPMCswL3UraGt2R2llNjVFTFZX?=
 =?utf-8?B?VEVrN281OHVuL2RmYmtNcWVuZHdBZW5JRTdXTWNsaHE4bG1vT0svRUZpYnl0?=
 =?utf-8?B?V2NFSnE3cjBwZkJsUVdsSzFoN0Z6UnJXbXJrTnRmaHBZaTVGOHJ2ZTZ4Qzd6?=
 =?utf-8?B?NE5qbFJXTVQ1VEFmKzJ6NFBJTFB4S09tNkhZSXRpQUNybGlLRkRjcFRjdW5T?=
 =?utf-8?B?ZEpKeDI4Wkg0bHk0eVZ4R1dtS2FLa0tUeTFUY3I5eGMzUmw1N0pPalJxYUF4?=
 =?utf-8?B?c0xTRGdUWndUZEJCTUdQaWdMeFJPeGtuZk5EeFNYKzVKM3V3cUhZay9XK1pF?=
 =?utf-8?B?R2V4TXU5ZFJMSDIxeEFlQXFTQ094bFZkZjlHd1p5SG1RZE9oQVFCSTFHbDkw?=
 =?utf-8?B?QkN0K3N2Smpja2kwam5WenJnK2lKUngrQnphZExkMlYyMkxEeE5LOXJrK0V5?=
 =?utf-8?B?SHh1by9udVloNEYyQ1RsR3dQemcrN1Y2N0FTNVhFZ21DODVaMkUyaU5yQld2?=
 =?utf-8?B?NmxabmFUYi83UU5Gb0xFdlE1cnpHRVdLOGVrTjFsRjNmWkJRZDduTVNFQlZD?=
 =?utf-8?B?SEZiNUhycC9md2ZBREJGaWx0NU1WbE1yTHFLRDRmMWtCaDJsYS9tTXhwc00z?=
 =?utf-8?B?MVVsUmw5dFpjSUNmeWFwSTNST0J6d01VcEFjRnhmZUVSbUFKZEl4QWNTTDJr?=
 =?utf-8?B?YW1BYkFnbzB6b2xqSG9LbXlPZWZQR0REV3FRUXczNnRiSllkdFNHZFY3TnVW?=
 =?utf-8?B?VVUybUNkVk8xU0xSV1ovRWU1Lzg3VXRpVWtPanNRcEowK0cxZnZOaWVRUDFC?=
 =?utf-8?B?aXhGNEZTSDlIUmJKVm5CeWZhUVNMSXE5bUtMbU1DYU1INDgzKzVzUUhwT1ly?=
 =?utf-8?B?UHQ2R3gzQ043eGRBaUMweUNhanRXUDhyNVRWbE1ybE0vY2d1VkR5QmVwRENp?=
 =?utf-8?B?TlIxVUNyRjA5SVdIL3FWNnc5ZzdEVzRQZDZabXFuWjRBL1RrdTA4VVgrWjRu?=
 =?utf-8?B?czRkNnVrWG9TenAvbTJmTjM4UzdFb3hlSFdPbmN5QTZaRm45N1U4c0UvTzhy?=
 =?utf-8?B?NTBBYzlDQUlqVkhreTdMU3VUY0VXQ1Z0bXBKSUxhU21ZdE51a0ZIcUk0UzQ1?=
 =?utf-8?B?bUh1MkJMZnQyNGlSeWEwOFM0ODdaMjB4WnFneWp1amNIWnJSZHVYNkN4ZU04?=
 =?utf-8?B?Q3M5QVQ0MzJ6TTVFdDZJNUdYV0JycjR0TXV4eENPY0M4SmZFNVlDYUNmVFY2?=
 =?utf-8?B?akZMQnpHMWFNWTdaQ0JsbFhLNXpZaUhyZ2dOUk1takIwNy9scWN4OHE0ZE5U?=
 =?utf-8?B?RzhJb1gva2tsTGI2Yi9RTGJJZVhOUVpJUHdWbG9jZnFkcXlac1NhbzFCYkZ3?=
 =?utf-8?B?dU05LzNsZDY0bkhRRzlXanN6d0s2NERuOURwYTRNaVMwQUhPN2JOYjFkKzRO?=
 =?utf-8?B?ZjB4UFBFU0JYejRsSWxXd2t3cFU2RWxmeWU2YVQrOXNPWU5Za1JUWWpQMXRx?=
 =?utf-8?B?bjRlbUFPRHBrQkJRWG11dFB2bmUrYUJWNmxqY3U3TnZ0THE4RXhkY0hHcnZY?=
 =?utf-8?Q?Nn26D3EhzrIkUcc8=3D?=
X-Exchange-RoutingPolicyChecked:
	rrjLD6xZHYMGQanGsJSkaOhJsMrvTu2Zy8Y+8zXUmOY1AVxmYUq1SfRX3Jp9meEgqxwMjz3uWXH7sC3dfn4LyWxk47rMaXnCmMQZYx0zxG/x9PdJAL+d1d8QGCcJnpRalklvzngs2F9AAxYS3ofzeTXunetFVeotjIGmVs5Z+c9bspWqk9BSADG04/90v9pDI1x/J7jtqcV0N22fwhpacybPYSekIOjKkhJijEaIVH7y37ar4aJoa/5PrCRyS5PMZ9T39hzAeStS7Mdqy7kSmr36CdMH4P8NBLsSSpasLJfyu5yN9avQhPlcMbHs3GZUnt52Kj7KAFDaoTwXoFTEog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HvOPbaGknvLO2/HUy1jXCjLeLQ2yoFKs04XtebkQMVboGLARdAbhjVqWxKn2GaSZXIdtkSnz0GvoUzj/kgfw1Fna9Z3X/gi/Su2aT7KZJFmHvmc8Scz/RC18JsJKhEqXJPAu2SnOMN9nk5kb9VuWrq8YYUJZSMThMigQrSlIekZAtsJVFOJRyywLvJwj51PucPePLRmB9jA/oa+hgOS2NKSbUevFA1wO55ixDp0ke7ne/wVybqjpJMf+n38Fw284fSWqOBihR6Nnub9KVOkdLwyEmFnbk1fYhl+f0Ex0TSq/dzhKJa3Q14F1VX/c41IAO2moIFmZSjz+RxwFxNmq1JANmZCEtaVSzG6dVXmdNNeSAvIrcpwwXKox5MP6hPFDpIDZwqvjjPzK4kJ+ZpyU4veWHWy6//D+hCWcB2ItkILTf70MySOeaDPb2Y9QbgVlEf9qxqlLxX14ute8tMg5fqy1xhtTpvCM6NKssuvKfCzgXuR8xSsf8Q3ZJdNSrdgCC6oixYWalCFoEI6DJGZWA8WV7rR7BaI93k18Ecl6bglpsf1JogWhR5sx7O0509HlFjoadfqOdKeDxDZSEzgZ66Q+SgFBNt7TD1MpIg5X6KA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df79a52e-9204-4119-a765-08de83b6e05d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:51:00.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpDd3CuFEIz0sljuW1gZ7ZabGz2eTrCjOgEgFgSuCxfpHmRzdoZR4/G2xhPbL1zPOqmvOl4GVh9oQ+OADE23B0uB+wignu29ncyLoTz+I9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160197
X-Proofpoint-GUID: icqSpUoWbuUSqRPw3Fr2u28IHLf4fbWo
X-Proofpoint-ORIG-GUID: icqSpUoWbuUSqRPw3Fr2u28IHLf4fbWo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5NyBTYWx0ZWRfX0Z2zzS+q12NH
 HBVmYAPZq+ALVATRvVeneWoCg6p+psHhqebvgd/jdGpQygw/9Neo4qFxsk3T2orA4cP8QTaR3hf
 74LbNoPDjald9CmfdtUCcsvmSSVoXPdpQRL4v1Sxc7XgV9oomR5ZYO+LLm8emNUX4HmRUtbEotu
 sB3ay/meCkNZwBxcY5d+4tg1+1C/aN8GENxRolbotuQyIEhUi+yThzrM19/qqLZgZnFGiSEMU8K
 69vtDr9DaH+CUPc3mQTWPGfQnsyrJxxWVZ1OxlcNhw798Ob23Gr5QyBbD+xw0zB2sLa0+/h8txp
 UtOdtnnORjdMrxgeJABPmRAAObzFFm5ib5HCcbs9++hVqU417ggfl7oPkl9HG+d06QMNq08trkP
 3NaYHOkMk2ezdky1kDb3tsOFeUe7sT4zq+zNWEB2l3OamE31yZuwwStcD5aNh+07DNWjQbcQK1V
 vC/W4QVraMqyWK58WWEvXy/MpOrY22aQP+jIbktk=
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b89768 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=hujm7iy5ZJgXrMFZW9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12273



On 3/16/26 2:05 PM, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (funciton).
>
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
>
> Replace 'funciton' with 'function' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
>
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>   sound/soc/fsl/fsl_easrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 6c56134c60cc..599e439b359a 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1286,7 +1286,7 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
>   /*
>    * Release the context
>    *
> - * This funciton is mainly doing the revert thing in request context
> + * This function is mainly doing the revert thing in request context
>    */
>   static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
>   {
I inadvertently added Fixes: and Cc: stable tags.  If possible, please 
remove them as they are not appropriate for fixes to misspellings in 
code comments.  If it's not possible to remove them, I can send a v2.

