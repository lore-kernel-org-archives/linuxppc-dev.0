Return-Path: <linuxppc-dev+bounces-26022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DE3C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 15:31:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQnTT0rxQz2xT6;
	Fri, 21 Aug 2026 01:31:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.135.77 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787237760;
	cv=pass; b=gbQo0w+/BUOjAXMCsGrhy8kOatZrISN2xCXgFMFOz2QfzHcWuZRQNdx2eadFAnDN4Y+Y7ZZiavGUFydSelqIvVy9OYDLEIM5ePMVipDIAh/DQcpCaqDqqPZ9oTrHGZlJe1DHcN/2Bg5eFyuJliox5DygtCoXBSGd43AwnNDAwcPAoE5+Zd0EI2oneBYY6HkzJB34itx26NgLzEqTMBDZcvtoo2Ldp0G2QgKgBP7jRI8+Fk4tMCJGdU9SsM9CfhAPsAmo1o0q+KI1SGgDEJSqyRrA0rIQsB9jHW0ieSk0HefhiJ+aEnsGYS5niAESLB4hJWFMENK6iP8m4WsQ3kRHpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787237760; c=relaxed/relaxed;
	bh=WftahfDEQcOKy5UzjzjFv/KA8L8XdNsDpbaiZC8+xqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O42Z8j8hAvwdXRajzW4Rd9R2dpQ/5JBTyoFH7TMl2Z+MKryV9HEc/36zoahu3xPB4F7leGt7YFRRFjYlxVvp7Nehpluma5BtuCwUqqS02n40oUbM3kFFRvDOwS0HZg/rDNM9n6vUwwxSZaQgk8PO6TMG7k6gkT78QD0mQYx6u5SU1thf5SJvbmCH/Z+kp39yVqjS0QUARSRVzELhwgnGSJERdeq3/f8SgwdOFWGaduJu8DWyINcf+loSM0JgDCMifMKMIVpTfgjQpOwhtYlXOReJISAWjHDUYxHevbPJgaQlaanWh37WuYIgMWBrqwSKePBakZRv57Q/63r+Nev+yA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=d/ueRkH3; dkim-atps=neutral; spf=pass (client-ip=148.163.135.77; helo=mx0a-00128a01.pphosted.com; envelope-from=alvin.sipraga@analog.com; receiver=lists.ozlabs.org) smtp.mailfrom=analog.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=d/ueRkH3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=analog.com (client-ip=148.163.135.77; helo=mx0a-00128a01.pphosted.com; envelope-from=alvin.sipraga@analog.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4071 seconds by postgrey-1.37 at boromir; Fri, 21 Aug 2026 00:55:58 AEST
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQmht6Jbdz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 00:55:58 +1000 (AEST)
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDM21b3166347;
	Thu, 20 Aug 2026 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Wftah
	fDEQcOKy5UzjzjFv/KA8L8XdNsDpbaiZC8+xqA=; b=d/ueRkH3ezp5JIC2mMBOW
	E0uk3bSdRFGT9rta0tD/UWBqYFW3HR5xzE09Hr++OSfopLbYoKvXxPlz9KmDwGPR
	c9JfbC2q6bIl/KFJJPFNAANBEmh7CjHZv/OJZbdrAPG3PH0UX6d/5qBdoevQqBhO
	A64y76XEFKb3ZVgo2UEOYr5GqRyq1FIkAeCcar7wsDCiRtIzGgWWkmVWo9e/liEh
	lgypfuOz33h64yglZB3F39blijrSyvg3KogzC/unF1bIX5kLkViHVL1LEMRC/MX1
	W0UHoyOVr6ASLgMWSbcYDmooYoiCp27A6dZnxpTSF6d4iA9t0soc5oxZ6SPieHTj
	w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4yfbjh7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 09:48:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWtXBwFRCZyOoQzNYt8O7XVqXUMFq/mod/Q9Jzt/oR84YJNryVyNJBvSkMcezH4NLTkOnemtp+sWQF5Dh7WfHnjqDInGYJarKauX5KJoA8Q2Gt42B8pqYcuNJm8k3vRpfvRHYwNFXuoPgTj6J7MdibUjutTgmji9UQ4UWHkmfOLTBlVy1ekwSChlfcpIC/UonOJ9SW/MUYboOQGWjYmRlROZiHJ3IhbMB8D3FAhd6H0lAerrCxNqQcRrwK77LEYbJJVuSSCZe+x5669KR5h6r334zJtN0T//F92Qm9M43m4jgbrFXQYj2uMarzjIisT2qTqn95OQ99/TjaQ/VOm5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WftahfDEQcOKy5UzjzjFv/KA8L8XdNsDpbaiZC8+xqA=;
 b=WcrEckn04+j7oQMcSGOUROZBZFvNtUJh05k156Q1FKEuvBYNIjNJsXRnTp6flKVGo46OmEv/kgwVF4PhqXlFPP01U/KCchvFQCvdMi0yda63itChD30kDyQBWeAj5Js9N3eJNMDaMHxj/2SmKSxJyQIsopsWOC3Ih62ni8bq6svQFz7xCcLzzbTh+5c+o2kiOLaCiT3fpa1kcVGcHfFhJSWzROJedwXd/DcwK9LJgnEQ+vU7awJyIz6IpmI4OnccN95VuYOM6HmlN7X7yaWT08H6uKbU76OKNZTW+utD1SvS0KvLdbW4X1jTvHmHLkaGXkxsLZsK0JPS5o08oYuqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by BN8PR03MB5058.namprd03.prod.outlook.com (2603:10b6:408:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 13:47:58 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 13:47:58 +0000
Date: Thu, 20 Aug 2026 15:47:55 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, Frank.Li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_mqs: Add DAPM output widgets for MQS_L/MQS_R
 pins
Message-ID: <aocFGXgB9X22W0XD@analog.com>
References: <20260820021454.2229094-1-chancel.liu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820021454.2229094-1-chancel.liu@oss.nxp.com>
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|BN8PR03MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5026dba9-19ac-4932-bd6c-08defec1a4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|10067099003|56012099006|3023799007|5023799004|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bk94lZ6PCszSzHKQwdNPv4R3QtyHhkEiN2KYZ3pohdDYW+oTZUZmBkHRjkYdMcz8X1iYywmPVL4DW6blaEPMpIbXabOnTZ2LslRqRHNi6E94nlr/W2viztf1Ws5EnatrG32w3i3U5dohMlynDrBE3Xhom/8bzPM+3QG9qeY8Um+/k+iWKaqjKsDgsbx2OPSgMIvG5EhgUYX3PzQ5yuwAm56pjefD9apVrU1u9i+GL+X1RMR5GKP+WyWLq8qDcb12G0SInWCI5/EiuCPyC2DmOVLIZzT9svhs5dNaiy5jlk60NrnPwfGPtQkoQwtKZqOFtkKmXvsJudEnknfKoPRcS3uMsUXDgxZYIGnSez8UHLrGexpzHsXH9/qBvkGFafD8yl3b3nnuQ2p8unraVyGjTAlzhd8C2RR7yWjG7RcniOBxzj3jomKMsp9HJRHuGySGAMQKL6PbxZXHKC7ugLMYB8lP8KppRKyAwqLGa/wQV4NGvK2qKXfW0IBRoCKs9eQcSLYyrldB26eW9oQv4NGpPr8DYxKjwB/4MDVkQMtlB6i8AdaYlMCcGPgz+qhDoiXU6L1ew6y+r2xXdITZroPslvbkwyC9ntnO+Ep/yJHDGDMSQ2+Mmx+GbYdaNH4oE1eTRAK2vZBiA4nstheS73YgTZ8+e2h7eSvbEdLGNUqc6FE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(10067099003)(56012099006)(3023799007)(5023799004)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVFUTzFYR3FFTHBuUVRseGUzY1JSa1VkLy84czhxUjdjQWVVM2hnNHAxY2U1?=
 =?utf-8?B?RUNvZDdsRGZGTDNXQi9SUGJVaHdobTRxWG1LWHV2clFKWmNhbGsyUFNFTUI1?=
 =?utf-8?B?bkpaM0NET2p4NTJwVXZGdko1Y1BiQkowd3d6K2dRNWxhbXluRHRhNy9LRTFm?=
 =?utf-8?B?YkFFUVhMNXRrT3hWbXAxQVljaXRQbzJRVzNFemozMXQvMm9oSi9QbVBjTUZK?=
 =?utf-8?B?RTVRRXAzNGgxcGVCaXl5Y1ZaNmlyK2RIOXBVQnNxWkROeDZnTndQekRBRjBL?=
 =?utf-8?B?SUxFZERiM2xRVHRkVWltRm8zdzg4b0NHR0tIWlo5cEU2R2VGZFJBZEdlVjhu?=
 =?utf-8?B?YkNOTEV4M3FuTFBhczFwNUYzWFhsOC9RTS9jOXVhRnAxWHhES1RQQ3FyZGJ2?=
 =?utf-8?B?b210bFRVUUw1YlFkL3pKUXhnbWpVbEZHQ0VEbmptbFJMRWRmRmhkek9RVkQv?=
 =?utf-8?B?MDc5SGswdWVtdldQUk5INk80VlRrMTIzMjNzU2cyN0VqZ3ZJUi9CbTNiU0dF?=
 =?utf-8?B?VWRWM3p1alhLS0Q1UFI1ZnhvcUxsM2tjcjZpNGhVRFREcTVTWmpmL0pZRVdO?=
 =?utf-8?B?cWZDRDlWOUJYZ05ROUNPcGZVdnQwZ0x0Ym5WRWxuaEtVa3dKeGJXT0xrNjZj?=
 =?utf-8?B?M3ZNMWtaT0ZTYlFlUHVGQmJId0xXZ0tJY24vaEhXVC9GRG96SmRDdFNGMG52?=
 =?utf-8?B?Y0ROMmpucm50VXZkN21ycjFlU2FpLzFNOEhjZXBUSThFV2xNOGk0YmsveTRm?=
 =?utf-8?B?Q1ZOVFJOdnZtcENhaWVnay9mcCthMWM0aVFpYkVHR3JNbDJwaW1RU1NHU1o0?=
 =?utf-8?B?TzE4MGo5V2dxd0FGUnpOOU1CTHNPeUhFZUVzbVhWOHBxZlp5eWdZT1FJdncy?=
 =?utf-8?B?U1pSTWw4Wk55U0tUdEFkdUQzZzdHTS9BeHI5aEUzSklRUUpIK2NxTGhHY21k?=
 =?utf-8?B?VUVmSkVtaDVvYk44ODU3Qkdha1NySWVPY1ozOWxPSlNsQzJxN3BPeENBTXU3?=
 =?utf-8?B?cjRma2o3ZVphdjJERWNOWjZLb0VaYVVDaGdvS2NlQWd4a3VNYUkzQ2tMaEtK?=
 =?utf-8?B?elpQZmZrRjNxcnk1Nm4zYXNjVlRqdXcxbjhpNjkzYTd5UGVpdi9FbFF4Zy91?=
 =?utf-8?B?NU91S0dWeWJiREc1N3NsQVpYOWhsc1U0bjBkWmdEZzZObTVHQTU0dkJ6Ymp2?=
 =?utf-8?B?Y1Y1VmprTVRPeFJxUWYrTGM5SC81L3NsN0Evc3Btd0RKaTVPWm8wYUNTZnh4?=
 =?utf-8?B?Qkl3alNodGNibXI2alVkeUxrMVVRTDJ5NHhqZVZhQStwNjFtT2QrSldiVlpH?=
 =?utf-8?B?NDR3R1VxSzVLUXBLUDhBZEdjejQ3QWMvcGpPSE94d1VPblZOV1hKbW1paCtP?=
 =?utf-8?B?UmNZZlhZZmZ4ZFp6L2pGQy80bmU5TStwYWNNaVB3MGh1RjMvTUZuMHJZeCt2?=
 =?utf-8?B?M2dDd0E5UnBGb3FVQ2IwSVJlTnpXa1lWcVd3Yi9wOGgxYmJGRWJNa20wSjY2?=
 =?utf-8?B?OWNkL3YveEVGTlVwc1R5eWRldWdna0NHU0hUVDkwQ3pZWWtwSVRVMHZVNVY1?=
 =?utf-8?B?ZXRlcEdET0VWZkVWd1I2Q2MrcEg3RXloZDhhSTV4Y3B0R0JDZ2tCY1NOZitQ?=
 =?utf-8?B?Zmd6REEway9LTzFQVVYxbnd3VnZWeTRlMmI3cGNoa1lsdkRDQW1jeDNXckRw?=
 =?utf-8?B?RlpMNXo5QlVBbHFHSnRRcnY0WmhjVlIrZHVSK0I2M0daczhqT2NiVVYvTUVC?=
 =?utf-8?B?bDVEZWJuUXZMN0NzVGhOMW4xbXJYSG5iUmF2aEtNalNDWm16ZjdCT2FOTUU1?=
 =?utf-8?B?SENrcEF2dDlLUnRsTjdST2hjQVlvTytBMEtMV1JtTW9wajBweU90RXlPR2JI?=
 =?utf-8?B?VE1Md1BpY0NnQmtzVGIwYjdvdThNU0Zmc1gyYklGS1ZtNVFERjhQUGJTQW5x?=
 =?utf-8?B?VUlCYXkxbFNibzBHTStHQmVQQ0ZJQXU1bEhFRHNDam10czgwZHRxNEpSa1BP?=
 =?utf-8?B?RS8rQ1Y0SFNDZ3ZVSEFNK2Z0bGhobjZ1L0RIbGxhVzJIZ3hEVjRENW1BMTI4?=
 =?utf-8?B?ZFJzeWZ1OUlxWWUwL0dXSkFKY0gzOEdzZzNGTVBPdUtDekljcVhxNHNreE5j?=
 =?utf-8?B?YzBFemg3TjNpbmxTNmNEZWc1Y1kxMnlGYmRVc1BMaWtDc1kyVVFXMjZwWkxM?=
 =?utf-8?B?WnpkVlJkOFVTZXppMDByeGlBQW1ua05Ld2ZLZjhJZ1R2UEUxY1NBMEtqMzk4?=
 =?utf-8?B?b1d5bkFFUVJ6NG0rZlhlelo0di9LaCsya3FUMEc2emtPdHNaVXlmSWt6bi9t?=
 =?utf-8?B?dWJRNVo2dzFRakVMZkJnNUQ5RHNCeHNBMUhQUVpDU0xhd3pXeXFnQT09?=
X-Exchange-RoutingPolicyChecked:
	kE6jtfKbyDkt5UGoAtjeU9SruSK6Z4zU8BAaN+hxt5U/e5FBYQ/P1u7WuHkXcQNREDX0U/3Qwq3soGeD25J36Ng6mL7zpmyXMGavHbavoRrM2OJjHs+ztZLABC56zm/c4SXiCR1e85fXP9kGYreWS5BveC6LdBV3Inr52orwRoqNsmVGLzXxb0TT4y6cSu2950uZV8Oxbe8Rc4MZhpd6J+6GW51OF5pOSOBgSr5Ch3EO3qg1d98UsiZWLMnLbuwrMEWN82qSG2LUnlE+R3FLp7X18LUUxzWdp9KiCdRFl6klEwfHeek/OzFmOESApR/ha6Cr5u2feveYDEHUwgjBCw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5026dba9-19ac-4932-bd6c-08defec1a4ef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 13:47:58.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9PT1qkRc8wr9gPHhOkHJ9HJqY/Zgb6dk0HgXRJJa4vYgSHDT3FNIxM4kJgIBqJJemmycaxOOW2f2eWez55yLaFnHpyonVqE1H9R4+vIWO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5058
X-Proofpoint-ORIG-GUID: KemQCkCF2INuv2cMACywHBSWRR070KSl
X-Authority-Analysis: v=2.4 cv=KbTidwYD c=1 sm=1 tr=0 ts=6a870591 cx=c_pps
 a=eQn4vQZDn50HuGbH8T6KOA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=rAjdTDPYhBUihyDjDmsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwMyBTYWx0ZWRfXwtyLRnoO13VU
 6zVRAfszVFyvDWOtRfBH/EBpYJY9IrkkCeDIhhqCd0VROMiMT5DX6ox8yPtUcMGk5/9xxmutV9V
 zwjVusS2DpHNR03hzzWdggNpb9fyx6aBj79LUlMjtoAe91Vk1CevBninjVQBJT3tlfo3hq9ADgG
 azd+BT6vSpFa+BnCRPVsPAAJfKjL7+9oTk8LqfGI+dgI2SCpGeY+U8RBmRG3mkO89BrQc+yGF7f
 egibg38gcVhyma3aR1FnZPPgOvltiD631Byf/n47vQXP+1aNZffmH5rPzPrB2WbpBDVoP23CLOd
 PZIC80TP3K5arAvbAWVLwNqBfcgSIlOxn3njOWvYO+vjnzs0WIs5rO56IyzB8OutWaodyniSiWh
 GoZiIb5Zlc7Nz1gWxTRmCtY4d3EYH+9Q45bfVz+thKOA3nPl5f8xMPvKgASzkR6+ckORRrLOLW8
 fQcZLXeXD9w3HzdmnLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwMyBTYWx0ZWRfX4FKCzivdAKNj
 E39/seF6I3BZ3WZN2SB9FgHD/SHnq6yG0Xf8iUtZiWfC7LVqQuXwSpFr0BOmORHiKa3S8h1l4lh
 iIPLt4wRiRC3IxWUkKEhyRNdmMr5lTTtx6DxniwrOWVp2Q9LhuJh
X-Proofpoint-GUID: KemQCkCF2INuv2cMACywHBSWRR070KSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200103

On Thu, Aug 20, 2026 at 11:14:53AM +0900, Chancel Liu wrote:
> From: Chancel Liu <chancel.liu@nxp.com>
> 
> Provide DAPM output widgets for the MQS_L/MQS_R pins and route them
> from the "Playback" stream. This allows external amplifiers connected
> to the MQS outputs to be properly linked into the DAPM graph, so their
> power state can follow the playback stream.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  sound/soc/fsl/fsl_mqs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> index 901f840df904..5b00488253bb 100644
> --- a/sound/soc/fsl/fsl_mqs.c
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -183,7 +183,21 @@ static void fsl_mqs_shutdown(struct snd_pcm_substream *substream,
>  			   mqs_priv->soc->en_mask, 0);
>  }
>  
> +static const struct snd_soc_dapm_widget fsl_mqs_dapm_widgets[] = {
> +	SND_SOC_DAPM_OUTPUT("MQS_L"),
> +	SND_SOC_DAPM_OUTPUT("MQS_R"),
> +};
> +
> +static const struct snd_soc_dapm_route fsl_mqs_dapm_routes[] = {
> +	{ "MQS_L", NULL, "Playback" },
> +	{ "MQS_R", NULL, "Playback" },
> +};
> +
>  static const struct snd_soc_component_driver soc_codec_fsl_mqs = {
> +	.dapm_widgets = fsl_mqs_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(fsl_mqs_dapm_widgets),
> +	.dapm_routes = fsl_mqs_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(fsl_mqs_dapm_routes),
>  	.idle_bias_on = 1,
>  };
>  
> -- 
> 2.50.1
> 

