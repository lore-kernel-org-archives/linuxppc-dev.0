Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF0606A320
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OQVSB9Gh;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QDWlZPPv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPM1S6wqQz2y2h;
	Wed, 11 Nov 2026 09:35:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.135.77 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794329448;
	cv=pass; b=Yf0rymx6aUB8I+Dm1Y+j1fZ31v3HRZ1cz0SrFbz6P7HfrEaQjZZXM1Q29uBxd2wzMTPfowao7BzenA9dERDBucNZ0Weei+hzVj7Bo9v5w7CTDdp+daAUapSPu8u9ZxMeP16CkUnCn33fuBSI1F/jnmj+D2O/mmYteIQVcHnPsAs1gRPiY3D3LD2Y8C4hyPetBqc4o8q7OLj/hlZ04yatLBXiwft20yjB9K+MLm5siPdslgD/w94CaJ7K4MIe+/afI3628hjhUbYRWPTjwaxX0S6kiNuL/pmjbmgu7FaY/Sj91t+Ni78xr9YONwBUkd0ckH2H0em+TNU4kduMoyuVIw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794329448; c=relaxed/relaxed;
	bh=NKYT9g5PeHo9rz1Xs7oNrSVftCpyKqKw0cqdvwF/aHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ktANBax1BeH/ZFZcVVO29sklzLxN9CP0qj7OOFFYrbk1IQQa+Jt5cGU74O21yGPnlBzdVUkRXQkk0+nWzHkTT1cRyghI8Tom+kTTHbMpQO9AHNypf13M0k3m9YcnHrLmNbm8wc3FRgixepj7IWU+FQ5ZVszFpnh1zk94HHkEAB572Ah1piM4HS6xntRUy7co3XVtFR4VpcmV7UGxmdRpr+6n/ZMe+QEtIfBt5RnsU8HnMwWim6pkj+C/GyyzJ5w6cb4InbgsWW21NPJfzFoTEQbqV9iZEdV3T2pcH897NBmvXXPQk8/ssRTauW5aJHlFzYZGv+UD7UQR7GWZksjnWA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; dkim=pass (2048-bit key; unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OQVSB9Gh; dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QDWlZPPv; dkim-atps=neutral; spf=pass (client-ip=148.163.135.77; helo=mx0a-00128a01.pphosted.com; envelope-from=nuno.sa@analog.com; receiver=lists.ozlabs.org) smtp.mailfrom=analog.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OQVSB9Gh;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QDWlZPPv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=analog.com (client-ip=148.163.135.77; helo=mx0a-00128a01.pphosted.com; envelope-from=nuno.sa@analog.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4339 seconds by postgrey-1.37 at boromir; Wed, 11 Nov 2026 03:50:46 AEDT
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPCMV1wsQz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 03:50:45 +1100 (AEDT)
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFBALJ4188857;
	Tue, 10 Nov 2026 10:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=NKYT9g5PeHo9rz1Xs7oNrSVftCpyKqKw0cqdvwF/aHM=; b=OQVSB9G
	hW55mimjtsBJnYSwTyX0+38NthMKQBRTo3jyz/NZ41Zk4bFBPrzV0bApMQQLBE1l
	Vb6BzMB1WUuWsQM3cRxOVpln2fyTkyeRdoyntaV39cv+xVtZuyM0OwtWaukTJU9c
	iRI1QpoeqFiOKjtoTpqhLB3sOf6BrLCL1cagh5IAaywUAqqm09JCsz/+TNXXmO6+
	fv07AT+gtI/QjdIZrqbVzw+Ablqa35nXM0LELKWnTC6To0pRIlNTjIC1hrCp42BJ
	Y6J3PyZHFWaztWkpd05rmypyPfzKGbI7qgrV9zLcQEV3oq/BJAPbc9npL6WVYIyp
	jnhs9bEUcjNWV0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NKYT9
	g5PeHo9rz1Xs7oNrSVftCpyKqKw0cqdvwF/aHM=; b=QDWlZPPvfcOTa1AqqdFS9
	02kPpHJoRdmoOhlgqjTY92woEQVfyoeMXCJm1te4gN9Kum1NUB+Qp9c1bM5b3otc
	13iWVqiYaw9pklZDDpUVBuI0kn7atPZ+nfUgLZ3H0rZ+L+gyuYkwMu+b0mSeckwA
	GSQOMgRl5tkSKiMso5zMxmPy7EdqT2Yv5x4QC3XwqMygeu6/o9A+VCcuAZ/NRS+5
	KiXTiQdydXCqkZzNkz19DFQoBcI1WWDwIBLzKOHizLXSZcvQiQQdJkvnblA7/sWh
	qwT/mfH82aGxaRL1f9A5F+Jz/Zrz/rKCW7rP0INpNeExoQplcq9GpjRieeQwOygJ
	w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hv5pdr6rk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 10:38:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NonMVmbxe8RNspZkfxL0t+i63k5Q4iPNq0X7QmsKoezGKIzq72QPFS8gI2ChFhWZ8njvGblPP7hTexO/g8zxw+AOL+4jwhKv1p6I+q1UKK3VqpBAfpyQ09COJYe5RDKDaXQAPuqd7XAVubXz4HtA1lTGsh26g2QdsbngCJIrGe75Gkj4KlRGkYSfP1ZMICY/tNmnUmyhgJP71zHwKzTn1FmYbWoRV6rDWMXzKSdHMcexJ6o0XD2HS3g9B1dYC1NcoJGqecBJ87q+4Slm+J62MMNOIxSVN/xskHgUubdqRezEAkBOw4H5oUfe5bjcB7G82YsOeq6s29bPAohVO5McKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKYT9g5PeHo9rz1Xs7oNrSVftCpyKqKw0cqdvwF/aHM=;
 b=rjcDdK6vng8EdPq89KIXo0gmbqwnLRaX4UnH3HRgZSlGft8u/xY3Bmh4jww6B9gw3xrKqp9B6QyqnuuFHys+nSuv3XZgy6dsz02VUfaHcF9sdM9gZuLsY7BZweOUkTF+nbfOKdCRA/BkChYVWjS/x6s+kDItr58efZkdW5FiAY43xgoiNOe3YjkXI8rzdMFlJ2Z/BfPxcl8q2oFnVz+Fa2WPoPsZRc56Qu5VKatcR5JpPkTwYthnW+gU1ZiopM9k1qi1nTImGhf1N6nknGrjWVJY1kq8LKOaRRkQ7L1R3krxnM8l5eGgqNB8Kjsg92ZZ3Ty5aiCCsa4FdiSvXW/uEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH5PR03MB7862.namprd03.prod.outlook.com (2603:10b6:610:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:37:54 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:37:53 +0000
Date: Tue, 10 Nov 2026 15:39:12 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Thompson <danielt@kernel.org>, Helge Deller <deller@gmx.de>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, Mauro Carvalho Chehab <mchehab@kernel.org>,
        mfd@lists.linux.dev, Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Message-ID: <avM5EnC9yujUZcCO@nsa>
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <20260912232047.19c4cb10@jic23-hlaptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260912232047.19c4cb10@jic23-hlaptop>
X-ClientProxiedBy: MA3P292CA0069.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH5PR03MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c1e083-4b3b-45a2-3c13-08df3f409584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|10067099003|11063799006|261021135927099003|261028144727099003|261026121527099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003|56012099006|261009221227099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	r4iYqk8EHHH+i/qgK9yrK95M6PAOmp2cwmEY2M8D/7Tkj3vz75/Y+CUeY2I0RNhZNltTDfbsPLz3HvFd02ePt8rInHyMSvjQZ/KQ1Ored1Za4tGaJSCPCgAy52OC9JfRAhp3k7J9bRd8YWpXetCpGvBqofsp04YkOB7cDMtvD269OZYKA75g3kGuo2unSg27ZqKHwzqSKLZmsEnTShOux+3o/J8cnlzVN0gnkKS8nmKWYwKuequdVi+4d5g6foMugkmocOayYO0Ax3bqTeiPPfy8Z7+oi1UCZK+buvIp7am5Q40BxdK9rLDXnawlaUd5mFGn2OhISsPKiU3rveCVWpmAlvofcKUKd11L1BUx/dSKI/ir7vV3tal3MKADfg4sJeFMT1iKH7h+qIdoztNnRWYII9ZGec9eAzHliRZV7NKCmcv4IVpQ3pvDzN5n0Lt2Ole71quqeAnpJ9nn7nsrS7W1NjEGWDkEIX++ZwRruHLpdRts2yCrl5qYQJLqtKrtZogkL3oM7Ab8OyzNR/0Dm2F+ukXoO3eHcH5E/IHrODaFQ10ydnVni3tewcSL/4yvIuwiyIOs12S71RuwlPw7T1Z5H7hnH0KHZ8xzCzLF3UfO0td9rs4fPxgeXpSJ34Ek
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(10067099003)(11063799006)(261021135927099003)(261028144727099003)(261026121527099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003)(56012099006)(261009221227099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkJuTGZWZDhzdnoyb3BSeUd6Q2xTbnBGeTBUQ1l6THdoNjVWTXpwblVMK1h6?=
 =?utf-8?B?eWJXbkh2WHZvSENJRjNZRWFjVzRzTTh5OWJZNGthM0lydFVSenFuT0UrNUlx?=
 =?utf-8?B?Y1ZqQ1JjNWJIWFIrT3BQMHgzc1lHNkRKRnRKVHpxVkxQNk5zZDhqVW5lS0JZ?=
 =?utf-8?B?TXRFbmowSlA4emlpZG9PMjVSRkxHM1l1SWFhaFRRa0Z3MHMwRUFNZWZrQ1JZ?=
 =?utf-8?B?YzNNWFlTeW5wNE9BUzhnNWpOY2lWWERzeEZEMEFjbFNINEpyZkhGbE9HZ3g5?=
 =?utf-8?B?YXhlaThBTkd0TzFHdDFKMk9GOGs1YXczNUdZRFQvc0Vwb1JBTDZwd0U1TDVG?=
 =?utf-8?B?ckZmcjV3dlc2WDFMWCtoMlhQZGNtalZWZlpqcFlNTEtHb09MNGVPelA2dzEy?=
 =?utf-8?B?K1c1TFNPem53aThEaUJRZEVYZTNId2prRW9GOHFLb1dpcXgwcWVCZWF3TG4v?=
 =?utf-8?B?L1BUTTFZUk5rZUNFMS81eUt5ZnJ1Qjdpa0lIT0ZnSUNialI1NVgrZW9pTW1i?=
 =?utf-8?B?eGRENEEyM2F5dFMwQU12VEZIRHJ5SHdOcFBGMzhuS245OW5YUUR0VFNLL3o3?=
 =?utf-8?B?T25JRTRSeXlLRmx1aXErVzRZY29QRy8vNXJ1bFdNYU4zS25DYXlIV1daenRK?=
 =?utf-8?B?Q1dYUHFFeUtVRUlwUmR5bTJRdHcrYTBZcTFmaGJXc1Y5M3BWTTgrdUJyUERt?=
 =?utf-8?B?OVdmYjI3T0xOREdOQUtXcmZPazdOd3lEVmhwU20rTlNtMFNtOE92VHhvdUJV?=
 =?utf-8?B?dk1Dc1NRSzcrdDZTYWYyQSs5VDFldVRWTG56VXVEY0NoSG9Bb0ZMcGlLelp2?=
 =?utf-8?B?N0pzYkRGWXQ5NGZJNFZlSGI4Y0xGRjNqT01Cc0FqSDl5N0tBb2Q0RjY0WnBX?=
 =?utf-8?B?SDlwODNNY1NjRHJSVDJ0cGNodUtvWndiNzQ1cm5aSFh6eTk4RHVPQi9KR3Fz?=
 =?utf-8?B?YmNGVkRkRWlpUDU5TEYxdERNdTc1V2ZQV2xZdUxvSXBIK21SNGkwSnphOHVE?=
 =?utf-8?B?WE1wV1NTcU5NOWZkR1VNUGdLOFFYWXlQdkxxTHlhekFUbW5wSTc2bDVYZk5N?=
 =?utf-8?B?dE1MR3FyUDFWYjBxZkJXbXAwZXRheHFnM1Q2RXU4VHg1ZGZpWHdpaGtIaTAr?=
 =?utf-8?B?TmZQZ1hoajhhbnNBN0ZpTWlEY3dMNWQ1ZjVuMWw5NEQwVHZTZ01YN1JjYmNF?=
 =?utf-8?B?SU1yZmwra3UybWw0TXRCMXM4cDhmMUlZWHBLSWVzM1ZMU0xLWTk4SWxsSWxm?=
 =?utf-8?B?MUZXZkRFcytXTS9vR1QxTjRsQTcwN0thMFJIYmFibjA2clVPOWQyOW1mZ0s4?=
 =?utf-8?B?NDR4M2ZSczFWZWttaEVqcnMwTUVWZFFtRWNUZnlsM3cwSFc3dzJqNFNUR0xS?=
 =?utf-8?B?VDZVM01sQk5ZS1lZcTZCUjdlVkxZRFc3VDB2ZjlFRDIrZW9YcWhpOE1SY2tw?=
 =?utf-8?B?b2kxWUhiZ2paZjdsTXhoSkFNYkl1Wm42MmgycHp1d0JGNVI3VHk4SGVxSHJF?=
 =?utf-8?B?Y0dQdXIvZkVzb0t3MENRbmVzZldMd3p2UDViTGtKdkpDeE4yWUFoTDRoZUF2?=
 =?utf-8?B?ZTZsK296N0xaSVdWb0VWbkNyL3pHL2lBdFNhaWNoS2IydnFxRW0vQ01DcEI5?=
 =?utf-8?B?YXpIYjVtWDNDZmZraWR0RlJ1cmFNekIxQVRDM3RXWDEwMjRWOUN3VzYwU2tq?=
 =?utf-8?B?OVByeEpOcmJ3cTlpVlVXQXZWZnhKaU1yejhUWHh0YzY3c0wxSmdISjVEQ1cy?=
 =?utf-8?B?c1dDY3F6QnluQVJvbndWeDNyemhSZWsvQ2greFBpZFIxNkUvRWg4RHVHMldI?=
 =?utf-8?B?K0NkUWMzRy9zMGNtYU1CeElKcXUzZllNSWdiQ3ZjQldPM1FhdWdPSFBwOXo3?=
 =?utf-8?B?ZGRDMENzTTc0ZlBtL0N4bEJJS2FWem1ldFpTKzZtNnRWV1N5ZnpXRk0reUx1?=
 =?utf-8?B?cjJlTnpJRVgzZHZZRk43ZC9CTjdONnlLL09CVzBuQjduUjg5WjllazJOMW9t?=
 =?utf-8?B?cVlEVnBmSFZDQmlXa0lteWFOUGRtZ2ZrRmljTXZLZkhDVDV5VGJZQzU1S21T?=
 =?utf-8?B?cjNyMWNmOW1SeWV4cGt1THZRUU1yQkFoUUl1VGtMRUYzYWFLd29lQjJHVDF5?=
 =?utf-8?B?dkU1MjgzQ1dCTjMwL1BoWDRpTHM3YmRyQXNwZTV0ZEptTVdneTNUNWZ3akNz?=
 =?utf-8?B?dkJyeFdqaHVwR1BhUWE2VUlHRFlMVE96Q2JnK2ZxQVVDN21IQ0U2dHdMTFdJ?=
 =?utf-8?B?SlJacFV2NHNZNU4rNEM3a3g4Qko3NmRGNTNZejhtcFJnVkk4d0x0S0RIT1U1?=
 =?utf-8?B?ZlhLSlVlWExhT1dtMTkrVkVNRld6a3N5UTUwdXZTUG9FY1EwYzl2dz09?=
X-Exchange-RoutingPolicyChecked:
	Fg+4odflvOVg/qC3P0jcHuVvFP05frllrULlxzqWiA0rjJRtOCB7laUbrOKmNBlsobPk6qqFYc5dNMGNPTIMv3D9n/qaajEBGPKmXvJhW5QXfY1uVHj1qtBfl3RiZdF4/mKbbi3VPSkVjvVM23s8jn8TDewGkCV/2ocCz+x35DA4TP4SxxKHQkU/MvWGyy4cRDgd0NV01hdpyaZIqcd9cC2YEM0w7X1HD2CTlrLzahoEM9lGAhYtTbhjq94SILROlt98EzbW0Y7es9uujk7YF8jjl8RdFFsJrKbN7yKiJDjoNlnYOa0ZAEHbMrRNNio/Kvsn+rmDPPeKCUoAbq8cvw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c1e083-4b3b-45a2-3c13-08df3f409584
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:37:53.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40YI0i0n9DrLFb8UnBhArvkQDq0TmY2CwSLUQ8JKLyyb0aZ0I5O5Jh5q9aRWmNPNDh68oDSdthtG2UlYbXpZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7862
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MiBTYWx0ZWRfX8Buy1TM7wQUd
 xaUZRKo88Fv4gDL1P/kcE4ud+LRnchUcG1Zf3RHHLpTdUrWKTqqierVfwn3Iz2HoN8EbmHptBAY
 QnDzbghGPHXTXD01aZp5SO7vqUGC28ic+Cl7MUd8le7PQqzk09xw
X-Authority-Analysis: v=2.4 cv=W/qtxhWk c=1 sm=1 tr=0 ts=6af33a59 cx=c_pps
 a=hwAR686YzpmZ7aH69gEPcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=bolBC-KKTCpxfz2DwocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MiBTYWx0ZWRfXw6vgjpF5SlYK
 hHALji/BXTTq3OrYRC7QNQpd0MF3ibX/2RoazbDeK1k4NOtrAkvyDwr6CRK/yDegrLSMMCNKnps
 kkb4VfGCuCn6k9PkFcgkMVLhW6B2babWEodJYRdUQ61t0f/3VXdqQKuhPeLwzcHIl+vry61AZCt
 DjZLqDn187P8b6rAKCrNHWtvjl8Ycl+hewFd4soUdJfIkvRzU5GRu125hmGKTDnUlZQcbsZKhl7
 FC2JOEx8JiIA6KikLDXaSHb5vjle9Hys4GkGUWcQrlt6E+MViszgVcG3YWO4CvU0Jn6+QfhKEAu
 p4cUh/b0F4i+YCK9dwSFSiFXPnYJB0a+mob2xIeHQW9zIB73ZdZRBiD96RKCzqy+7iNAe/4rmAd
 s6XsK0X9NU/+pxAhluumGHJ4kfPiGTGcPWeSQSw5HorW/quUKOXVwjC5YjVDTKVeh5LH/+d51iV
 i6bZBurNd/goH3iiS2g==
X-Proofpoint-GUID: xguw2edFALpIk2drdCtE7HoauRhX0SQQ
X-Proofpoint-ORIG-GUID: xguw2edFALpIk2drdCtE7HoauRhX0SQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100062
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 12, 2026 at 11:20:47PM +0100, Jonathan Cameron wrote:
> On Thu, 10 Sep 2026 20:14:15 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> > On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
> > > __ 
> > > Hello Arnd! May you please spare AAT2870 from being removed? I have a 
> > > device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed 
> > > yet, but in process as well) and atm I am working on converting this 
> > > driver to use OF. Thank you!  
> > 
> > Sure, I have removed this patch from my series now.
> > 
> > > P. S. If you are planning to remove more old drivers, please CC me in 
> > > since I may be interested in some additional driver upgrades for 
> > > devices I own.  
> > 
> > Please have a look at
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
> > 
> > I tried to be careful about figuring out exactly which drivers are
> > unused, but I'm sure there are still a few false positive and false
> > negative ones in there. I've added the current list of driver files below,
> > let me know if you see something that shouldn't be there.
> Hi Arnd
> 

...

> 
> > drivers/iio/adc/ad7793.c
> Maybe. Analog devices ack needed.
> 
> Production part but this one indeed fails to probe.  Analog
> folk, do you want to fix this one up?

Given it's production we should fix. Looking at platdata seems to nicely
fir in DT. Issue is that I don't have HW with me to test. So I'll maybe
just remove platdata and assume some defaults.

> 
> > drivers/iio/adc/ad7887.c
> No to dropping this.
> 
> Production part - should work fine with defaults in driver.
> Could like the others drop the platform data handling.
> 
> > drivers/iio/adc/lp8788_adc.c
> Probably
> 
> Sub driver of an MFD.  I'm fine with that going if we know
> the mfd is no longer in use.
> 
> > drivers/iio/adc/lpc18xx_adc.c
> > drivers/iio/dac/lpc18xx_dac.c
> Probably
> 
> Likewise these two.
> 
> > drivers/iio/frequency/ad9523.c
> Maybe. Analog Devices ack needed.
> 

Hmm we definitely use this one and we have OF support out of tree with
likely some DT abuse of what can be in DT or not. Not sure if I have
some HW around but we'll need to fix it.

In general for ADI parts, I think we can drop the ones that are not
recommended for new designs. All the others I tempted to say we should
keep. Naturally we need to fix all the drivers that do not compile
without platdata. And for the ones with defaults we can also just remove
platdata and use the plain defaults.

- Nuno Sá


