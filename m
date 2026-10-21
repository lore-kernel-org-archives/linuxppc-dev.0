Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8D606A31F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=westermo.com header.i=@westermo.com header.a=rsa-sha256 header.s=270620241 header.b=h3p5KT87;
	dkim=pass (1024-bit key, unprotected) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=lodHQqBN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8ryv0sgVz2xjv;
	Thu, 22 Oct 2026 01:20:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.31.45 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792564803;
	cv=pass; b=G3igTqbweKTqomU5ZoLMXFGv9UK2XhwoEX6/7ydurjo4hvh0ajFUYAltGRMkRzRAPAyHybY95nVfsM/vk7MJmUHxiFe3/3c5V0VnrsoD0iCLKfNuGY+LnlqKCyArYX3C+hoLPrTvGOm6qdffDp7ClcH3nLBIncDGHkPMEkbxVEq3I5AszD8hA9GPzq+w9KgkWCI0TFrL2b+BRe2fivL+IeH3mMlCuMsdXnR+h7yYdqU9shBXp4cK+rfOSejGzYBYxlAjCLkCHSIA1CH2aKDoL0szp1d9ijlF6gMJKGj4tZRUbAlr8Fx4vd0zyn1ve8UWtmhL9tnjjPaxbc655ChCng==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792564803; c=relaxed/relaxed;
	bh=L48V3TUV+O/gFhL+FNi2Z9qvJIP4hqhbcjRyT9SbP2k=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=JBwDh2BcTbbyZNLNAp4Ubzi5DJtf1W1J8wPSMn1W3sZWa8LcRpVSnbVgdoZ4fsjHYrqO3DlDYbuYW2KUGr/jRDQF7PeqewgSOw/4tbMKj+/FKzVDT7NYoWAmR7eFnfDG+fVYeZVZb2XM+fg5BNowPICanzFpkTD3O/aaG5j1qXaJ2h+WnHm0Hu9I0RZ/KyXd6KWWD1QUEyNoxtEZHdj7mReXCdY3TIO/mLOCDIcWUR/EDzWiJFL+nJRixJZeVslIN2VY9sUCYOGMFIReH2YJ3ip6CJg0mJP6hCBP+oTl9/hgJ3e7dtLy7a6RaD2jJGObqVDIsQFkG8YKOcfjuhnknQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; dkim=pass (2048-bit key; secure) header.d=westermo.com header.i=@westermo.com header.a=rsa-sha256 header.s=270620241 header.b=h3p5KT87; dkim=pass (1024-bit key; unprotected) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=lodHQqBN; dkim-atps=neutral; spf=pass (client-ip=185.183.31.45; helo=mx08-0057a101.pphosted.com; envelope-from=alexander.wilhelm@westermo.com; receiver=lists.ozlabs.org) smtp.mailfrom=westermo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=westermo.com header.i=@westermo.com header.a=rsa-sha256 header.s=270620241 header.b=h3p5KT87;
	dkim=pass (1024-bit key; unprotected) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=lodHQqBN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=westermo.com (client-ip=185.183.31.45; helo=mx08-0057a101.pphosted.com; envelope-from=alexander.wilhelm@westermo.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1187 seconds by postgrey-1.37 at boromir; Wed, 21 Oct 2026 17:40:00 AEDT
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8fm043nYz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 17:39:59 +1100 (AEDT)
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5lp2P692724;
	Wed, 21 Oct 2026 08:19:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=L48V3TUV+O/gFhL+FNi2Z9
	qvJIP4hqhbcjRyT9SbP2k=; b=h3p5KT87b92+k8srKEkXjYDORU8k1PP36kGqBv
	QViU0Zj5uI+dEeDghUusBR8Gja/1hPLj1Mat4WH+ZIBAfxI4oSXyixNew0ha3W4x
	DDnhyk7qAPUuC8ZfYJmqrLMIcrvuxfHirLl+INxaStzHV33sYClz7/seU5m95IW+
	4/VeFWo9Ka9u1AGF+QMYvehG3NZu/MrBj4P0N+htI8xW1RI+pEHX9aDTld7WzZn6
	PxaY9ayf6PDJd2IF7vwP8dQ1N5i3c+fw89ig+aqazKtQ3FcS/ACOmBi8NDwH22IM
	j3GGq5sJVNilYmRLptyVkPVA5XaljN1MkYBwpJUGQIeevDjA==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020142.outbound.protection.outlook.com [52.101.84.142])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4hdvm5sgw5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 08:19:37 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/ysch/NfKf6rdTg6PbHd2OTzk/L26RawzEEqE/I/oNMXWv0Jg6pedToWOd/hj8nwQDydhOdtrQTlNgYchAiv9JNt8276MgJCghFISksZl6NcAKwy6XXxIqIwy3aa9LvzYJlYGcjAvLMTDDNlxEHHjMIlRWsKzwlZCa6HbmPlhqE9NnBSQP7RjlFY0IxyZE3m3fTjqnKv3H1sdc0jk6A610jNksl15aIRUGjSlwJn8GtyANTFlusioJpV4DKy/EnBhKz1tTepdktN8MOfNgrcVA8hqgR0Hb682hs/eUrDiJKQWAWZy2IrdMmO1GI9nQUYLJGfN/XaIFzZk66Xn+yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L48V3TUV+O/gFhL+FNi2Z9qvJIP4hqhbcjRyT9SbP2k=;
 b=s9URQ3vltvWvA/vX+MaGlh5sX55hGoLqnDukU1smwEkiUCeZlqHwWJMNu+ESod7ozjmkdMiXYhfWvQf8Y1EFTCWFvPJCM4FksS6kYqbcyr9YK6+TgGF/m43RQEj8XBSqb0Z82Goriqv85H47xuhSvObKXINbvM3+twdEiQXE4Tkcw00XGyYg2T5LsFP7iyewUhEQEjosvaC5CqFXvnzOL+8KXjruai59j1CBdR26JVpHG5aixVOJSFpIJkE39TbQBOVj6cI2OsfFmJMJsxzGCMA0At7fQGEpmvQyncozgYseaAhdErdDhphidGzNDUwS0nIYTWS7hJ8fWiQe2Notag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L48V3TUV+O/gFhL+FNi2Z9qvJIP4hqhbcjRyT9SbP2k=;
 b=lodHQqBNmLivHrf1FvJhf6ayGGJ5PKmpB872X9BIx2b08ANVcZsyrAcl3jS9lwQAQmm2gn5Sp4wdKm5lNvc3iDS5k7weeoulumelsr6DU2QMF3syZZFANv/364wmHlW4gXRoxuJh+ROobtM24IfVDGA9Fpcvv3IwGQ09sgPDh7A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=westermo.com;
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AS2P192MB2167.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:643::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:19:36 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 06:19:36 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Wed, 21 Oct 2026 08:19:33 +0200
Subject: [PATCH] powerpc/85xx: corenet: add fsl,ifc to device ids
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-powerpc-corenet-fsl-ifc-v1-1-81c3984db460@westermo.com>
X-B4-Tracking: v=1; b=H4sIAHRZ2GoC/x3MQQqDMBBG4avIrDtgpuiiVyld2OkfHZAkTEori
 Hc3uPwW7+1U4YZKj24nx8+q5dQQbh3pMqUZbJ9mkl7G0Evgkv/woqzZkfDlWFe2qCxh0LtA3oB
 Qq4sj2nadn6/jOAENTx6haQAAAA==
To: Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Frank Li <Frank.Li@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3PEPF0001DBFC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::317) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
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
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AS2P192MB2167:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1c11ad-4114-48a2-acfd-08df2f3b4787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UaUz9+Ghi2AYJ1shUWUkhCZgnVkhp9ZQypET+wKNWfrHdPxaQAlWj4+lO5h8v+9KTXe6UxYpZ3gH+O1ilSPA5WZLzI3L0SBvQEJp6LBwDlPli8Epd0tZZEprAhQHom6/H2+FqwELiBVZJrI5OgqUik/6qcwb/n36RPzBOO/CqzPUUZa7pKX5hPauajwlUVMJSIBNUHQ/yD7IPKm2i2+SXhJUkTdbDvlSPIrju9RQjavQOHT0rfgfUQWLcVnG7M06Qf2ziIdt5pSgaqVniwOkeniTXeL6e8VpwItQi2RhlooPheWh/0qwVbyz/aCwnyeVjC0GW/mnORWrcga3eEjluV+Ybk3BdScC75+nxSUt4Bf/FfBtYhdkjbGMR5hLG5fsxE0xNQ2N8VuCoTLgXe4uoFotAvf9aP8wsmScuaghMdemFIYg7AUuMRYF7tXAAGVDBJxSApR8/tfQCbd7zCzDNX/76LY/1S6LLvGkY0/AC2NS6+TWEXvWpMusVEMicMKp4lRD3MPBDbHZrHY9gfTlDNvkaI2GP+8tpQty/NPkXO5tINLUjLLEpaLIsNYhZEJOpZWFvnEBsFCqrWuDhsYa9SVXnHedeJaagfuSkLCwh7BAHLCAWUEogkCi5/vTm7LS/QkuRBqJ7SjMWBj25hE3zvfg7vXFVbhcj11E5dJcp8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1dSMWpFTUJxUmVGSnlrcW12bWhMemIvanNvcWFiRWpwbWU2cURQM1N1aU5Y?=
 =?utf-8?B?SFcyUEIrcWNvcForaklTVHVPdDdGcGpOYjNwSzFaUElNVUZCZ29WcUpuZGNs?=
 =?utf-8?B?Z3RVTm54VjJ5R2hLaWJRNGRvR21rN3VyY1pnT2hMY3RTS21MWFVURzJ5aGdF?=
 =?utf-8?B?dEdhM3hNeEJ5akEzK3ZHUUpvMXA3Q2JrUHB5WTViOXJnMTB2Tlc4ZC8xRVhR?=
 =?utf-8?B?OFQ1NDlMUXJHOGptZS91ZG1hWkQ2SGYvYTVYMFhtWHB6bnRYMXJJRDl5UnY3?=
 =?utf-8?B?S1ZDSnkwbkNMT2FsazF0eUxrai9qRXNjNFdBVVUvdXZwalBxZEcxQS8xQ3Rw?=
 =?utf-8?B?cHlnVER4R2NFZFY4Y0s1dFo1c3E2emVuNkc2RXNERGNVSzF1NzRVUFFjanRP?=
 =?utf-8?B?L1FUV0xFc2VhT25CM1BZZzdDdXY3Sy9NcE9WVTQ2MkF5T2hZeExiUnZUdlN3?=
 =?utf-8?B?eHNyamQ0ODRaVWR6ekNDd1NrVGppTmcvRzRaWFprT0ZkTjllRGo0Q2ZvbEkw?=
 =?utf-8?B?Q1UyVC9PVkUzWHE0ekFkMm5kWVJCem5qblJydnc0dk9LVEpid2JsK1FZNEc3?=
 =?utf-8?B?c2x6S0d3bXBZNVJweGMyZ0FVREpIRmwvbWNhUkVVY0dBNXh2em04cC9mYi9M?=
 =?utf-8?B?ZlIxbXpPSW1ud091dVpIaWlIUkEwS0lLMlV2UitKVGVlejdhbmtTSG1qUjQ4?=
 =?utf-8?B?eHIrSmZQS0hsZEo5R1NtTERxbm1Kc1Rub0szclBXaWpYZVlxaUh3VkIzSTJO?=
 =?utf-8?B?OXpMVFN6eFQvam1YV3RaMExaSGtPdm9ybnIxREptR0s1dThaNE1lRzBvMnht?=
 =?utf-8?B?Qk1WZ3VLcXFuSmhJSVNLTnAwK2pQY0xBcU1OWXpnN3dsYXVCd2t1VHoybTRD?=
 =?utf-8?B?d0RCV1U2OFFPbkRoZHpTK2krdUlDcjJseC9McThGekFKckxYWkNFeG5YR005?=
 =?utf-8?B?QTllTURlWlBOQzE5YlVkeWQvdno3Mi9QdnZGVGl6aEVOVm1jUFFScEtjMG1H?=
 =?utf-8?B?SUVhamdmakRCekVBTkZNUkhmTVV6YlcrLzYxOWt0TkZMVFUzQWlzazNuR1Bh?=
 =?utf-8?B?VCtidUxnZTVzcW5QVzdiS1Y0Z1kyTVJoOCt0ak5qNlJTcmhxN2xsbkM5bEl3?=
 =?utf-8?B?dWJ2aHU5NEZsMWwwM0Qzbm42T1FwQlJEYnEvTUpockZ0NERFRjJyRDdaN1J0?=
 =?utf-8?B?L01JM1lxZkM4QUhCM1dJZHB2c1R4T3ZyWHlqd2lyUnFOVlN5VEQwaFZqRkRV?=
 =?utf-8?B?cFlBMEgrcnFNSzBVVmFyalRVWEIwVzk3cWQ0YSt2K1NKUGU5ZWFwS2d0bG1O?=
 =?utf-8?B?Z21OVk5nNjZtVWh1WW5PT3U2c0c0SEpOdlpxNTV6Y2phV0tLM2Iya3FLemdo?=
 =?utf-8?B?enplK2VWbnN0Y3ltRzZ5ejJYTlJoVzJuak5IWGlCNkkyeEluK3hadURGQ0Rx?=
 =?utf-8?B?WFVwb0hOcEdkRUZJQzdaN0E3T0dOK3A0SHNFOTdZeGlOdnZRRW94TU1iWVNw?=
 =?utf-8?B?cDUzbUFNTHdoa1Uxd3J4UjIyenZNNktJOW1MRGtlV1NuREdpZS96T2RXOFov?=
 =?utf-8?B?SlpJZEIweldzZVR3UlVXcGdCOUt4MjFjaDVURDh5R2g4WllDcko0Zk1wVWEv?=
 =?utf-8?B?VnhVQWE0VEJIMFFpSXloVGtrRnlEM0NHT1A3eElIMXpKUU9ON0hkNmZTM25n?=
 =?utf-8?B?dHFFOW1oRmxtaHp0T3h4NUVtUGtlRGVIamlPR2FTUW9uVUhwNFNjeitqVDEz?=
 =?utf-8?B?bXRjZ25teUtybUJJODdidTJNUThyeERaQVQwSjRpV2RidzMyRFRvTTByVXZu?=
 =?utf-8?B?aDUwZHRud21GODUvMURLWnNEbHFyRmNvVkd2MFM0cTZ5UGhPRUN0ZUxxc3NT?=
 =?utf-8?B?OWxyUUtBSDZKY1ZqdlRMQWxpOG9tWDlhK2lYVXIvK0M4N2NUVU1FNW1IL1Jz?=
 =?utf-8?B?L0dUZ3hCZWNRZWsxZ0svVEViQXg0UG5qdVJ5ZnpzR2s3Vy9PN1FwbDc1c0tl?=
 =?utf-8?B?MlE2Nng3RFc2eHRXM3cvTFhQNldJRlR0WHdkUGlsYk0wbG9TT1hLMEM0MllU?=
 =?utf-8?B?a1NhVXk2Nm13eXNxbE9IR2w4OGZ2YXF3bWNBUUdsR3JScDE3TDdkdWE2b25W?=
 =?utf-8?B?THlQSzNtRHFHMjZscUZOUHNtZVluMmV2MlJzTThUYkY3bXAyMWJCNElvOTlp?=
 =?utf-8?B?ckZxMVNXMFZmL1JwZ1hQaG1wM0VzK1p5c1pvbTNJOWRWd2VSaXBsdXAxQW9q?=
 =?utf-8?B?V04zeEl2THoySVdWTnRwcFBZRHBMdWxQSXZUSm84aGZLc2prNkp2eWprNXpN?=
 =?utf-8?B?dHpnN3c1ZWRmZVlFVE53RWxPM2t3V2VmMFhYT25oL3NrVE1JdzFsdz09?=
X-Exchange-RoutingPolicyChecked:
	MYQmJOl+hjnKuTqJPRGd7iSX+8IfhXUl7EKqQtx8tbCowJEG1GpK9mlUE1i7aDxSjAsnr/VZQTYCi+YRZM7Z/UtDj9EtppPkDKNGekWhpAK4Ap9Gp5reV/DcOTpcrr/BhrNQicJaTVGiHax0GZvPlKJobDqSTuuFVWFacE1V+pMXzvxRj7yoFHt15tLIq1rMoUQwzzCL23T/q6aF5O5CCJLNg/UGS3hlbOtWSL4S0CWEW0/Q+bHDa1QYJMcZn9z7QaFagD+P8uW/HMfD29pWVgdySpvPRpsP988uyVMWDdD1+jfX/zPBhEBD/KRGgfrGRP6H6tYJljx2EgyUluIa/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9v9YnGf7yiuCXJemcfwWnJpNzdMHKtxdAy91SC+uTbg0c3+K3X0UsAH83BIDlu0lipttBZ6cIfN7cvg151ylNiK9fBP+zd9cApAzvxw2hGuMWw6mOfr4OnwzGTZGCUEJsX7XKRJY646YhsrvHPWSAtEiX5iRggRKuyY8BEYKMRb5yXulBa7TtvRkUbNYwOWVoHTs6iJGpsC+Rlh7cgupqzjEc2vweksXufhsjTayFtQDWJX33Z2oeGpvhkCsVDn+r5JUBXF0HQA02ArL2XI8Z4p7jG+TVbt7yqACIkFeEuE2G0mgKvOfvBLk9OY3gj+JLHkiVlFfSqsysCaFBpuJIvSa/KziXHGhi9eqRoI/z089ZWEXXJ5l7FR9N7/BiK/w56+IaewdaBcmVpgVS66N030mP+/xny8Zwg9AiQaCoJ0rut9kFKpcwcIVqsPIc0kRh/Svc2TNReo/QjexI9E98R8NHOpaQDn4TAOCCB3H4EZuQ7kzIavcwIG4cM4790dW198JQvem0pk/qVHVHvrcGz8VQAY4RDMKh6k0nZoeym+efrtCHOk3XWh9LrfNVTpo4D2l+fRBwmZHz7z7RKzgl7mxObaflV6HshMrlgCx9UO45Zp7AfBp8R7ds3NBj+gS
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1c11ad-4114-48a2-acfd-08df2f3b4787
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:19:36.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwWw4ra7jRe3suo1awOSaA97XtXSWZ8CuOF6jRNToRPrlFpTLoqzVVtb2JQpdcWVJEBsnF+yZG27esbhgQjHLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2167
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AS2P192MB2167.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: rSXNVS65JhlCXybrcvqgxG2y9P8VOdm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNCBTYWx0ZWRfX2lSjNwxMHl5U
 tBS6q83aW8H3C83jGGZ1lz0pesTUy5zgpLu/rZoloXMqJiz6TUgcmtSBNNO2HToruLMvyiJAjv9
 93mmX+6n76cFd85UYTAytbHlmmjyP2T+A8mUChlsj+TZCTbFQIj74Uq2V4CZ8sL255Be2PQjk7j
 gkH8DavduUJ6s32/oKte/1EuvZrvTBM/4IV+V18Lodq/diBoHxafN6OSqCPcbsfecwENYiEuYul
 SO5SOjPqtRGrZRT3SHAVZqQ8j88uLO7DBIgHkYaX4tIlAcpl09xeYCtMUIYavbGQmIlFtUPi9Co
 8CivuhD5qc0XzWvTOdiCoHKc4Gs/EV8rpUaRuwxzhYHVdBCZtp3LP5hjsRFlwf36QwnWMSVdo3u
 Me7GcP9g9p4PM+kSv2EJd+dMNcaUlklmZLpuKT1pcgd1DDC8PFuDIRzpLSsWJH1xo+QYtNKOwWs
 goqC5yvA7qZNxRqr/yw==
X-Authority-Analysis: v=2.4 cv=E5lYNqdl c=1 sm=1 tr=0 ts=6ad85979 cx=c_pps
 a=vA9PrX/BfemLN70XEOC+sw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=N9GNhs4bAAAA:8 a=xZvYxlTpHXetQya4VmIA:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: rSXNVS65JhlCXybrcvqgxG2y9P8VOdm0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNCBTYWx0ZWRfXzRC5g9gyqKa1
 ZfJbhVCeFx9n71FhdPOe27j5ZnhqAl9hEU554JApaql8I5h7gHVO+BNJbhmYldVqChUweADlQSa
 igLRX4gfBZblAaHrVgg5LM7Yd55wymE=
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove simple-bus compatible
from ifc node") removed "simple-bus" from the IFC nodes. Commit
25957f7c3dac ("powerpc/85xx: Add fsl,ifc to common device ids") restored
the probing only for boards using mpc85xx_common_ids.

CoreNet platforms (T1023, T1040/T1042, T2081, ...) use their own
of_device_ids table in corenet_generic.c. The IFC node is a direct child of
the root there, so without a matching entry no platform device is created
for it and its NOR/NAND children are never probed. As a result /proc/mtd
stays empty.

Add "fsl,ifc" to the CoreNet device ids so that of_platform_bus_probe
populates the IFC node and its children again.

Fixes: 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove simple-bus compatible from ifc node")
Assisted-by: claude-opus-5.5
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index c44400e95f55..881fd25cad10 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -91,6 +91,9 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,qe",
 	},
+	{
+		.compatible	= "fsl,ifc",
+	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",

---
base-commit: 2c455ddca7827ad8fa3a64fdbf5a60efb928b46a
change-id: 20261021-powerpc-corenet-fsl-ifc-215c32e2bee2

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


