Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A68606A324
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ST3uKl4t;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hEm8u6O5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPgv85Qnqz2y2h;
	Wed, 11 Nov 2026 22:16:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.139.77 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794395780;
	cv=pass; b=SU8S5EmgmU1wNQJBlfGEZDTZ5TruRs1IkXQ84stDhSykw7a3198823eHI7BR/ohv8kK373AB1L4jWRFI/btJhodV2aj8W8CSrQg09KNVCW5yp9kZKqmu8+5+M6lkvhouigkO0oRv5cqd/2GiPxw/aC/OCHbrX1kub173d6eTW22+8pB/cqyMr7nOXdQOOLqUFp19vLdSxUX1srSbDmMU3HMEjtjFFBj20yDhSthg/WyypbTaD0QpLTs4Rmazgc5eeCnxPFvTOzVfGwWfObcqLv0cxzuk7rq5jF2DjAhq0d6e+D73lTQ7Ix23Z+ZM1/b+rqEG5UgrtSnSTNF90uQY3g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794395780; c=relaxed/relaxed;
	bh=ihQMTmjkyvTUyMrpW0BOFCJ1LHuEdZbM2Yi2/Xc5PxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFIhWKW8BKSnkytmsqxePZrXqZ+IQBxiXfG9+jBjxBHsLfigWfApYplvppC1hN8QSVmJ8mHHrddVbAQ8IpdGRTHqAIQ+ncZsm9Lyx3+cMhcX3mrefkxXqZEmpAk7MbMHy2ZbOFvTDz4vPmuJx1i8UPXPqnP4iMxbvsI/bv+WFmjpLlnVUF3McfxCloseD+Zlsw/ZqZWo+xjn2l2s9cGY7Yzz6EMy+9Me5K5pEzzJ5TwIVXUNuPHvPtTmVrch2TXbC9oXXagnW35TE35EngoyZRIUDLRe73LULE92Gs3KiBxQ9bzJLsl2t+4HuGfz0fNBizk2xyMQ6aoZjRQgHIaAZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; dkim=pass (2048-bit key; unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ST3uKl4t; dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hEm8u6O5; dkim-atps=neutral; spf=pass (client-ip=148.163.139.77; helo=mx0b-00128a01.pphosted.com; envelope-from=nuno.sa@analog.com; receiver=lists.ozlabs.org) smtp.mailfrom=analog.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ST3uKl4t;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hEm8u6O5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=analog.com (client-ip=148.163.139.77; helo=mx0b-00128a01.pphosted.com; envelope-from=nuno.sa@analog.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2393 seconds by postgrey-1.37 at boromir; Wed, 11 Nov 2026 22:16:17 AEDT
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPgv54c6Xz2xqr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 22:16:16 +1100 (AEDT)
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB94cca3040587;
	Wed, 11 Nov 2026 05:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ihQMTmjkyvTUyMrpW0BOFCJ1LHuEdZbM2Yi2/Xc5PxU=; b=ST3uKl4
	tPzrTD2g5BaK2U7Uw5mkllTPQ5cjLX9PGYK2/G9fKkk7fVF5yRDAKm/YBm8BtWXR
	JpZCJ9WrfV5zymCSnEwwXo1JSJniJ/C5kV00wyAChs5d9bZMQ3fkO1Mey1ZIP4cQ
	0KlA/DE0gQPr2el7kWBs++OgHBSaYThWSTpB0AzSOI0OkZMWP1Y1rHSbnw4Y+RvN
	p4WojSDKNJtsqHtyH/usYvtGRQ9w4V82Ayjw5n0/qhBEk2klrn4LVMBa07KZIsjk
	dEhuaarSWHjQZW6sjZY7/dnNCF0Zhk7MuxP6sz14kuiZi3AkXMuKSdAbmJqAaZzp
	9XMuDrSauWCkQPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ihQMT
	mjkyvTUyMrpW0BOFCJ1LHuEdZbM2Yi2/Xc5PxU=; b=hEm8u6O5V5I2rKyUM8AAh
	Y9p4FH4dXHdgXtyRbOliIBvPMX1hcdxpd0zQsOhSI0S/h6ftc6JPn8TpRSYI20xy
	wUifPSqBp65ME9dLJ5oZhDiyBfbfR6neYGoE0aXifQfa8t/oTvTeoIDYutFMXOmI
	yjG4ZrehNpVdQOsgWdvTSQihjO9+C5m8Nbk18Q5LhQi8wvJBDHUNV8wf+IUA+7YA
	wqJtv7GJMbhU9keQ2K1KzvppfMO3Btk32NOjUJfwn8XCrWRDOXAF2//YhhknJq7K
	fdpVU5knuareBLhdSNQ7dw8yX0ACABGPlthKT9yzmzJlO0/qB5sgNly/3BKK9RLF
	Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvg58j2c9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 05:35:49 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvNJ+xWOC9ynfMVF+huvznmyxMzOpicIKMNtx7I6diGKZS1Ajs30nwB8qm9PzegnMPGF7Bv4Z0ueuSTy+/Uk9RfjH8pz2Fjj3IcfDZiL2taDbUv29MvoIb6axDpDRAFx5BY6HMSnLxUDD1Th07Ca7uCYyLmGyMaUV5XVwbjNkCU7waUK0NIXZRatYWlUIzDofBWh26H0SSvvPxKDJrEVkMW22rQjVLOxqKXB77E1JjsAy9rylLmDFUunfNbqA3wnIcIEnt9tuAhqQ//X227abSpALNTs+DRVNf2oYxCRxOBPH8hXgLiKqmjWrW5zVuLB6P/JI7/g3n/uzpKKiWkGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihQMTmjkyvTUyMrpW0BOFCJ1LHuEdZbM2Yi2/Xc5PxU=;
 b=RSP3u2M9V3Aflm3g4J8TUWZW3OKcn9nmBWO4/8E+dp6e09GFpnMOtfoJxBj6WeqOqLfYHqxzUny/3XDEpvNXvAU1GR5lLH8BTji+nxJl8MYkFqu4TQaq3f0u60ITH0N98hYmEOVWpqFIEPH6LnQ3J4TagJjXaz8yPwhhGvz8r+kqEaZaXunOdwdVfn307cl0wBERU7556h4rfsarxjloV/SVBJ8o7sCjUM+fSjgU0ir0ZFeksTOisAikg8x4rfbfKyzCLRMRA0hfcAEIvyEfRDAeMucH6Xdj26JonP+8N/KnthcU4dk5thnpkTd+uZpBrEinPY58XbMVesEfX2x9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA1PR03MB6339.namprd03.prod.outlook.com (2603:10b6:806:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:35:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 10:35:46 +0000
Date: Wed, 11 Nov 2026 10:37:12 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
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
Message-ID: <avRCbtfKg4WkSP1u@nsa>
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <20260912232047.19c4cb10@jic23-hlaptop>
 <avM5EnC9yujUZcCO@nsa>
 <991009b6-e62b-46bd-9a0b-43c3b7a6d10a@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <991009b6-e62b-46bd-9a0b-43c3b7a6d10a@app.fastmail.com>
X-ClientProxiedBy: MR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::25) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA1PR03MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: ff02e511-b8fc-49ec-6f59-08df3fdf8b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261028144727099003|261026140227099003|261026121527099003|261021135927099003|261022105027099003|261022075727099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Ni986ctO6xiSDH3Tse7H/tfhVmcpySoYJQ3H79C2XabCPTdWQnt85qbb/EPtTU5I9mlKHg8Xjeqh76av3uUdOMGWIC7OrEdMHSYWQmCGvDZsuHwf66vb3bi9Q1e8bTxVy2pdnfyCjSadFsvoZgJkXJ6mNiz38Azwc1PmsxG2v0acEr50FAeNmbfnSAPSPvr0QM3GpHYBJVOCIXtpm++Xh/i3+KnUAZm6zPCVXDxdlczdc6o/LRaGq52oh9DDFp16C4YWNpjTaqdf2+Mir40DxaCI2RqOl/4gOdtl1tRHnWWFZKzBVUVcxQ+KwZ9bwWOpTHilZEwx1hhu0fwlClOvAavjIHh5PTDRXwxSecCXm4WEZQW4W261NHR1TEGbLG+172xf8MxK0SsTkZFtOAofN2xhckM4Lz02XzEuYoET6rCCk8ROfiqIgoqfEpfvdB+GPMFEiOKqe5JtJekOj51n/X5+ruY1Y8lzmxXd2qxAMLqOeI7yDbfGsC9By0FG3Fs0yp3VhbFqltYAoXyODBuw/7pzqkCH50ZNRuxDsWwyUeph5wiz+uyaiCla6B6Xg0EKZLuUh1Q2MN7au0z9MpyeZ3SHax91OJ1fuQ4s1ZjspsXckpZ85etRBUyQ7Zacv9qr7v8cwHH8Z2Itu2JNxiRHjqCQ4FpIbW4QvLughHszwnY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1ViWFYyUm10SndZL2tmMk9qYUdBR3BiTUNMc2l4SzJyZzY1L2NhbHFxYkZp?=
 =?utf-8?B?cTlyZHFpdGNid2dDdHNUdm5oVllxWlNBNEl5S3cyTXZJclZoRlhGUEJqWTRl?=
 =?utf-8?B?a1lsQU05anNVVnNaOERJWVQzWXo0K2wxcXUzRE5QVVF1M2hLd21pWXdQMm9N?=
 =?utf-8?B?Q2NLbWlqWEpMYjU0MnRCNCttdjJoQkx6L1dMeitFR2wyUjlkV2tuQkRmLzZx?=
 =?utf-8?B?cmlicFVsZDV6bkFhMHRwNnN2VjZLNVplRkRiNWpxbXBDOG5JSUc1eExHV2Ju?=
 =?utf-8?B?aytIby83VDl1VUVwYWxNd2IzME9OSGJhb3RpR1J5WFIzSGRGZ3BjOE9yWWRJ?=
 =?utf-8?B?M1kzZUJmOW5RQU9SYi9xdVJ6a2IwWHVha1JqVlNBbHRJK3V1NHMyZFh4aHJE?=
 =?utf-8?B?R1N1UktHeWF0M253elJlR3Z6RjJPYndhUXJ6a1EwYS9CbllFS2JNL0hPV3dx?=
 =?utf-8?B?OS85MGJpVmFVN3h5VURQUC93d3pMZzRtN0R4NlE4dHNvRlBMUk5mZ3lSbTZ5?=
 =?utf-8?B?cmFRT3BrdFUyNTJLLzFVdi9DVzVSUGN2SmZxODI5RmlYMWwwVE1CVmRvSy9y?=
 =?utf-8?B?OVo0clhYMnBJL01rMytlOGFiY0VNbzBQcGZtbnc3d2cyVmF6bEY1M2duK3pj?=
 =?utf-8?B?REYwNENheHVIaFFUVFFWYUpJQUtJOEllNXViU3lGTVBhWEpFWDRyS0htNWgy?=
 =?utf-8?B?VjR0ajRKVmNOYTM1QzZjZW1aVTZoZEsyUzVGZmt4dTRDeFF6UVlBaHlreTR3?=
 =?utf-8?B?cFRxY1RFK3dRZ1d3TWE2cWVwTHE1bUQrNUxHeGFtcENXb0o2b1dsck5ZRUpV?=
 =?utf-8?B?Z0pwWGtNbUJZN1J0dHpTZlJBV09HWVVJNndyVjZUWFUzSzlER3FXMGsrNTJC?=
 =?utf-8?B?b2pETWxRdXl1S2NSZHFQS00vbHZpd3Q4U0t3UWszREUrU1RFM2Q5SGxaZFNM?=
 =?utf-8?B?MW5HQWRsYVRyeUVGREZxZHB1UktiTFdocWs3SXpmcVo1MmFzaWdIRTBmVHE0?=
 =?utf-8?B?cmwrY1plZUVuVFVZbmFCano5WkN5aG93SzZIMDB0QThOM1hJY2RIb2dMVkl2?=
 =?utf-8?B?bTlwMDgwTEVZeERpakRiTFUzZHNSZXN3SFVyWDNtZm1aWFd5VTg5KzBvanVF?=
 =?utf-8?B?cnNFUFh1S3dGYXAxUWFxblpZTm1VM01WZmQ1VlIyTllFOGFjYWVPblNHMHlV?=
 =?utf-8?B?VG5SZmVObk10aE5SUCt1ckJweHdFZzA3YldqYTlwUDJQVTM3L0V2N0NBeDhJ?=
 =?utf-8?B?UE5DbWRZUk10cTlMUXUyMjZhdmhLL2RKV3RHMzRLQTJ5amdhdmN3WE5BZ0Vs?=
 =?utf-8?B?K24vZjFDVHZRZmt5anErVTBIRWpsdHZ1WEtjU0YxTENHM0o4RmxOUzZYWTYv?=
 =?utf-8?B?R0JCZ3liUDNFRzdzVzVFRkdTdDJjazFjM2ZHN0ZxN3R1VHZBdytaYWJIRExr?=
 =?utf-8?B?aDNxNmFuSkR4ZVFkaGE4aExybVdUTWxya3hHYVFRZXc1T1Z5RW5hbWQ2dWFq?=
 =?utf-8?B?ODVPZC9tT1A3ZW5aVFpTTWZzWk1WcjcyMTY4R055czgxdVMrVFZpZWdhSGtD?=
 =?utf-8?B?UXhobjJVbU1RYVFreGtuZkF0SWNmcmV0QTIxTWE5TUpEaUV2TjdYYjFvb2du?=
 =?utf-8?B?ak1CWlBJV3Bqc09qZUhiV2FKQTdLU3R3Ym51RmZEeEN6NVdNQ0NZeVdJQk90?=
 =?utf-8?B?MWZ1NVAzQ1gxeVRrRFZZTkQ2VjF6K2pWMDBqWXk1a0dCNFp1bkJsT2UrUUxr?=
 =?utf-8?B?bDZlcWQveW9HLzQ1Q0FjWGNyUUxVcGFxN1NNTXgyYXZkRU1mbE03SitvTGdj?=
 =?utf-8?B?SVBXa0poZjVTY2Z2dVQyS0RHckZxcTdONGIwdFBjczU3NTBwTUh4aXFQYVpq?=
 =?utf-8?B?Qkd3Q1FNTnhmVGtFQUxtTU5qQ0g3VEJyMVRMdkhUV0lrY0krRURFOG5CZTQ3?=
 =?utf-8?B?UlIxaEdoZUt1Mk1IQWJjQWU0R0oyYWNMSTlBck12dFRnVm02R2F6NkdYU0kz?=
 =?utf-8?B?b2lZS0RiYkxYdFJHaDRxbnM4REtHUStmN3MySDNHdy9McUNkSEZUMlhRRkpi?=
 =?utf-8?B?VnZNdlFtZDNoZ0QxcTZ5N3RYTlBENk1kVTc5SDNPN3BkZTlNbjZaOU54Z08z?=
 =?utf-8?B?ZzFRdTBKUVpKRFk4QkVSVlBVbm1vK2xHbGl0QThua1Y1SGtVSm12cVF1WFZQ?=
 =?utf-8?B?em14S2FleXd1ZVF3U3FPbUx5QW1FOEN0WFVFSy9QZEdCaGtDTlh3Zk1KZDVS?=
 =?utf-8?B?TjFNNWkvQ3I1UHljcTc4ZUNSb0dsM0JEVVM1ZGNEV1I4S0hmMXZNOWFYTDVr?=
 =?utf-8?B?WXNkRVdJdVFNSE5uVXZlL0NvSzRJcGtwOHpUVkozeEg1UnM0blExZz09?=
X-Exchange-RoutingPolicyChecked:
	W+IllVXtlti+SuvFyHZSOC4dpe9oFwDwjqKLpDHixfMNwIH59ZyADSlF3Ar48BRayEfYXyUbcIqsnPSZuj+rR8S0JaOKhnL5ZXLLjYLXAu4uwCghUKa6IoWwvwqk2jRX1cxDowaMsdCDFw3UCILR29htCT9kumWy/rg69w5fZplWHR3H7S4aAUPkYq9Ybdo2aF2My1gPQ/NAYYk/tK4q88NQqLpykOiiP/h0IrzIlZKaKfP3x1JlFuHSQPPKnVvLFco0+s+Oxf/1fkPfuwOql48AhwXZG2DxTkMyb1LulQYUArv8DGnxlDp5UUH8k5/uRdz79aQ/xKT+Qj4JcFG+WQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff02e511-b8fc-49ec-6f59-08df3fdf8b69
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:35:46.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkZZ4GHOLwT0NDovxtJImfi5rremL5EZodQabi+HMvKcU7afzC37SoRQSaIlw9DWKN4MeSnnNGsjpEDsvDYUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6339
X-Proofpoint-ORIG-GUID: DdqhZe60zaGeSLLR4y0zqnA7uRg5oi5T
X-Proofpoint-GUID: DdqhZe60zaGeSLLR4y0zqnA7uRg5oi5T
X-Authority-Analysis: v=2.4 cv=Cooq4X4D c=1 sm=1 tr=0 ts=6af44505 cx=c_pps
 a=H6CWIJr9C+/oc5/J52O/6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=AIbcN7bpn11A85WRVH0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MSBTYWx0ZWRfXyKcWHrlxz6Ni
 CY5EY4ARhXPOXEflqD35Tiw2cQnVzCq2Q99DcK1Ahrof9UB/OpT5ERtN+NIGnX4+VFHtRXSegMv
 IRIaFfyu1jTbyk8hahBerknpsSLvfPH6xxMfnrWEjl57NZxFhFYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MSBTYWx0ZWRfX/rJlk7y9I93V
 O3iHuWnAl+rHD47/S/8OD3di5C22mbviWl01UzNEy4BO+V2rYJ9zHXqYORrK/2R0iBtoJHhs8sY
 kHJsYmy+ddVOvczABdFBC7cdg4jHJCRnC0eD2aHV6J1yIP7aC2uZYHFdJpx7+39gtcWUI+B+k96
 WDAeHQPNbRjOktS8l9TLhjzAsnuNs16bhgZTQ2QQ8LJ+0SOYzJlp2oReTf8AMeVqzThcT+Ka/Sc
 exdQbfz8pZNZDeKiVxVz83acIc4eROivgsgY7Te29s4SbC/H+vzlVci1TG/3xW438WcKWOmLgb9
 jTqO65a5QiDtosZ6HGfjz2C8hHENnc31hSqN1Mw7Jv9L1XWbPvfuRLSGnysT9hNdyseklfVbjnP
 mzjI6mAo5zCiuLu4NRIkMBMNOROiZzVDydbPC2ivRDAnRvd/F9/xnbgnADxbhlyMoLVxU6KnRrf
 X93BXPB+ODwcyToplaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110041
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 05:12:28PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 10, 2026, at 16:39, Nuno Sá wrote:
> > On Sat, Sep 12, 2026 at 11:20:47PM +0100, Jonathan Cameron wrote:
> >> On Thu, 10 Sep 2026 20:14:15 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> >> > drivers/iio/adc/ad7793.c
> >> Maybe. Analog devices ack needed.
> >> 
> >> Production part but this one indeed fails to probe.  Analog
> >> folk, do you want to fix this one up?
> >
> > Given it's production we should fix. Looking at platdata seems to nicely
> > fir in DT. Issue is that I don't have HW with me to test. So I'll maybe
> > just remove platdata and assume some defaults.
> 
> Sounds good. I already dropped my removal patch for this one.
> 
> >> > drivers/iio/frequency/ad9523.c
> >> Maybe. Analog Devices ack needed.
> >> 
> >
> > Hmm we definitely use this one and we have OF support out of tree with
> > likely some DT abuse of what can be in DT or not. Not sure if I have
> > some HW around but we'll need to fix it.
> >
> > In general for ADI parts, I think we can drop the ones that are not
> > recommended for new designs. All the others I tempted to say we should
> > keep. Naturally we need to fix all the drivers that do not compile
> > without platdata. And for the ones with defaults we can also just remove
> > platdata and use the plain defaults.
> 
> Ok, I'll leave it alone as well now.
> 
> I currently still have patches to remove adp8860/8870 (backlight), ad7877
> (touchscreen), ad714x (touch) and adxl34x (input, not the iio one), which
> are currently unusable with DT but are all listed as in production.
> 
> I assume you want to fix all of these and keep them in the kernel,
> but possibly still remove the adxl34x and only keep the IIO driver for
> that part?

Yes. And yes, seems to me the input driver has not reason to be in tree.
The IIO should be the one to use.

> 
> I also have patches to remove platform_data probing from ad5761, adf4350,
> ad5791, ad5421 and ad5504, these all have DT support.
> 
> See 
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=board-remove-7.4
> for the updated series. I hope to slowly get through that. Let
> me know if you want me to skip any more of those patches.

Thanks for taking care of this. Let me know if you need any help with
ADI related parts.

- Nuno Sá

> 
> Thanks,
> 
>     Arnd

