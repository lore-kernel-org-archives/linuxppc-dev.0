Return-Path: <linuxppc-dev+bounces-24804-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E7CC531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 17:33:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6FTM4RQwz2xnQ;
	Sat, 25 Jul 2026 03:33:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.150.75 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784914423;
	cv=pass; b=d7KzZ7bHDVPxC8QrbNDDsSAtfucX0CuD52h0N69boXkhw/j6Bb9GuNeRVPHKNYDUcGJL2Vp0EoyMnJJYKMvnGypWGTSDU2sx2FIM2ZV860GTNaDCShgu6VrzWCLBfy3i+Q39iy58vfzZwKM81ORT8GU9WHIHSe1nmTqFFAhBbc1g63t/qHHe61Xv14m6G9ucAPCyW2aPeMbGruRFtzyMOelzRz84/GlpIN8+BVUMJR5S353EBUv8zjLwDYcxnkZkoZMuDMuJYcaIEvBvhgWUia/aRpQcYVMrpnocHONZimMzZViV5lbGLVSwsl2p36E0/2j+8mYJ5+CVXgvKdszGAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784914423; c=relaxed/relaxed;
	bh=tO+l0boHt/uy2bye3LGM78GjpCC91Ksm16Gp2zUd7j4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9UT6U+wNCvmwoJ7hSO5CjiiIp203ZYegZrLZaOjP4AXK5fmiY1lXrMRmW/PUm5mMxcb0VoK2bmR3oGRBVghbTd9NinKTAMK1/44sADdCUHpO+HNNstCow5A+JWu6FcSvmcpiBKiLJXyj1Wkow90ZOProKNP26Gu6fburyEGDEo1nHxDmFApjHO/ECqITvMVvzHDIOWVOIX6SicVe6PZ3y4WHvVDWJj6g9mqcLOWcUietsgcWYvs/fsAhB9/AcUxvDA1RQBA95u3Kz770EhiqhiT78jT6zGytwMXAJ28en3bj9mclHvBK43kzYXgYSgdoEf2CUvRLz0swckqnWe1iw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Eh5WLgtX; dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=kWaJBiHX; dkim-atps=neutral; spf=pass (client-ip=148.163.150.75; helo=mx0a-0002e601.pphosted.com; envelope-from=nm@ti.com; receiver=lists.ozlabs.org) smtp.mailfrom=ti.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Eh5WLgtX;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=kWaJBiHX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ti.com (client-ip=148.163.150.75; helo=mx0a-0002e601.pphosted.com; envelope-from=nm@ti.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3266 seconds by postgrey-1.37 at boromir; Sat, 25 Jul 2026 03:33:40 AEST
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6FTJ0tMdz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 03:33:38 +1000 (AEST)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66ODdth83234199;
	Fri, 24 Jul 2026 11:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=tO+l0boHt/uy2bye3LGM78GjpCC91Ksm16Gp2zUd7
	j4=; b=Eh5WLgtXYEwEZv4FW/SrPtO8T2QGly9tzw+vsxKS4uzeaMyyRsjhXW0DF
	F8CZJnCrSr+OV8pZH29ec6k6BqwV8RyO4cmIImJvqJFMFmtGmaJvac/E2ZkTv/tZ
	tzRDt+tSzA3Ni0VhBBqbDccyg41S0JShJyMkZUs81X1m+U4b2/1nkckNihtcyxrz
	xL72jZ0LqPj9EEG8p1o50VfMgCkDDSJBQZMdPUdnrEl3OXjgidZuNPar64Rcx5pF
	Sl4h1dooGxUnPKaNzF9nQJFCjV7J/yAkGfXX1yXI6jMVuDS89TDh4fZ8e+oUhTjU
	Dy+bWV6g5+kn8nq2ulfM4+zBdaORQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fm8k7h5ww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:38:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPq/OWwEyyFz8TVFOSQvUGCVirixhFg6VGQGbHueGJXhlx0jXLBjBcT9H3LJb21o47WqMO5nTtOUPuNA7VmtLrGAwRXGZs6IUCpIDpPhSpSl5LRr7ou4VlxBJaPiV00sQzxDvcD94P9aapr8w46qVHq2WNZFt8E4FloavU/jLC4DBeldQucyOVP2tsBLWhRvZyUWU5Gzsjtj1PMiZ4Elzha/+4PMnFEpf/fbLxYxgJFpcGynvAT1deN/n9VYrFZXUi6ntXzmYxT71hvSTla6hMzdAP8Iy7dA7OKYxbZdZXXZvRhpnEsTHFHbMMn4kljid32h9LVzXkWyr4yX2yiTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO+l0boHt/uy2bye3LGM78GjpCC91Ksm16Gp2zUd7j4=;
 b=BZ5Lwl5kg3rIjM0vbrShqPH0/3XWnjWiwUZRYpKA+Yq+apExXFYBO0hsquKi53dZSLb8exXTWagAIrD3YTbeK48voHssAWyDrxYb2X54+8s4q/rtldTJGx9gAgkZ6gt+Yqj/oO7PBtYvafbwtlBSSHHT3u1Wm9610ye8Dh5xZXypbAyHc3YOD4igMHI5Fci5qbIQ97eguOVArXuyjUAYP1QEmMUa6tGrY+a4VJ8FHwfT5Awk7TdFinfdyFE89zqR0lZuOi/5Zgp6uZf7O7kGzkMgJiuk1Cre/vYWni33h+AlZabpavHFOfkYhXn5II0mEH1twWyXCdZ/MBeOuV/SNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vivo.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO+l0boHt/uy2bye3LGM78GjpCC91Ksm16Gp2zUd7j4=;
 b=kWaJBiHXqOcuUPe5+GkbT6EFu2UlOszRGkz1wTe0dbLnH10a2yJhOoHhiQRp+sJqIFw12hXG56/iGAvK5PPFI5evqDYO7tYR4tzc/p12kANttD7LSkSTY89pJT2VOmD2Y97bSlLT/e6hz1ksoGtfXmHIhhwYuythJugrtCLe9qI=
Received: from BLAPR03CA0180.namprd03.prod.outlook.com (2603:10b6:208:32f::10)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 16:38:41 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::54) by BLAPR03CA0180.outlook.office365.com
 (2603:10b6:208:32f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 16:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 16:38:39 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Jul
 2026 11:38:37 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Jul
 2026 11:38:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 24 Jul 2026 11:38:37 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66OGcbiI4192341;
	Fri, 24 Jul 2026 11:38:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Roy Pledge <Roy.Pledge@nxp.com>,
        "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Imre Kaloz
	<kaloz@openwrt.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter
	<jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michal Simek
	<michal.simek@amd.com>,
        Shashank Balaji <shashank.mahadasyam@sony.com>,
        "Gary
 Guo" <gary@garyguo.net>, Sumit Gupta <sumitg@nvidia.com>,
        Rahul Bukte
	<rahul.bukte@sony.com>,
        =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?=
	<brunofrancadevsec@gmail.com>,
        Prasanna Kumar T S M
	<ptsm@linux.microsoft.com>,
        Marco Crivellari <marco.crivellari@suse.com>,
        "Jay Buddhabhatti" <jay.buddhabhatti@amd.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Pan Chuang
	<panchuang@vivo.com>
CC: Nishanth Menon <nm@ti.com>
Subject: Re: (subset) [PATCH 0/7] soc: Remove redundant error messages on IRQ request failure
Date: Fri, 24 Jul 2026 11:38:35 -0500
Message-ID: <178491109420.3162889.2128805019731933130.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260720095920.542801-1-panchuang@vivo.com>
References: <20260720095920.542801-1-panchuang@vivo.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CO1PR10MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f30d8d6-f2d6-47e5-f63b-08dee9a20451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|921020|13003099007|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	TDwszLl3y7tWzNBqfgRpGATOcHpiEXqsTa69ksX7vUZTQ2af/+qNIrQcKb8P2tacQsbfswbHZ5LAJIIJ5eO22KGlfF9niWxlOViWAJD0awmXcgfDOIb1usQ0naUcyt1IncW/rfPxZd4psHp/d5XIVwFJ3/DUbZ/tTO0pUJJosw4LQ1rral3iOBKEl5tFt4CSrcO5jetQkGOvlp/dDSJgEmwvFDDB8uJoxT4n/Zn60ga1L0AD/HAU+oJCarHLilEN4TvQJ3STb4bcA0qBiOEfjqUTprMPMD3SM0IZyur87hL/GQ28UoYYZWr2uTYVtcbqm7JHD/wEZhQ98jKSpXhzWgG4tWmseo5y0b5hujwEDWlgsF3WwqsRBE4bbtM8bzuGM5B8Xp/GMsrxYgob7Pz3orjrdvJaAXO6KXepckDJ5HrH+3aeaz6AFY/dqAEuuSe5vjESbZAHulkIBTMLoNNtXKx9i01zacriM2hTT/eqZtcu6QimIq2sZLGVMBOk01CiZvBS2Ksj0q+2EJiLawfpA7bZT47pLYWPanAzEHW0xm9QobB4zsZp+q+XXLUBqEldl/AZJpHzrm4pNUhgyBZFgQf7DE9EQSGQCnliwttlb8pMUCxYxEL6mfV8/A9SgspF+Cidpwd1VIh66VmAechIDMbIYgeEvmgILbm+2sKj7doXb1jiUYQ7AeTCGYM40/n7xSlqNMGb9GbfQZGhs0iFIA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(921020)(13003099007)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nM248eSHrxXj+tluVJ+j3XxPrXntEZJH06Zue2e21ClLss2Wxz9mHXaNlyICR2SFxMtswtKasXOMuityb6PZdJeBK8kqonTzYbSfNVt0/OEyG7n5B2JrNOVep8w5J9ueSsPYHSyHkUS1804JNE3reX69mW/VNF1nU+VqXGuCkMkWFp1b5oZZrb0vaHcVhQW7CQZ068hFY6Q3vc0VSh2XilTbfrc/OaYihQ2ij4q8OE/ACRKupRo5oP0KXYGIBpU2VpE2e9pKeCJsym9yE6R6VVUl4U+5cqhYaAeFkpFHi5DeVCBIB8dKcnuojnuNf77nM3t25QJQvdtH6OyGYwaB9Vy05QuW8ZuiwieKBKqlPkFU29IPSQkYHjYnbIR+M6s/JSrCjMiNYbsNEH9koejsgj9xRi9+qQBfXqJWzXrFhlp2LtT3xvaxs6gtTKyCsc9/
X-Exchange-RoutingPolicyChecked:
	JwCakoNjZ7STVquPuScKOJ/bz2rn+cnQRhUCxtqtrjno5BszilL4KCptshHDy7/z7zogeSWKKsbCR4qdli1YujNkQ86MciwfCk2xMtvYXo7AQJqglND/GtYvOaxTJY5BvhFLD1K7ltRXzvB+KKmlcUTaat6jbrXWtW+hCR3J01tvzDfW+KVfWP5Iy/q/stl2Omkdd6DHdon9SCKeS1hazhH683QVoVhWa22GdW/KKgalLhtzd96strRqxIkDdeEMygX6aczxznmXolqXw4SROvXeNHvDkCPZX2reYzBMPHGp161Ix/FP5y2sa/2slF6r4lnPypS9OS/CTuPkUYqF3w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:38:39.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f30d8d6-f2d6-47e5-f63b-08dee9a20451
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-GUID: wDuUOP0t_DSjIRNpHtBk-5r78zqdJKGm
X-Authority-Analysis: v=2.4 cv=bJYm5v+Z c=1 sm=1 tr=0 ts=6a63951c cx=c_pps
 a=hqw49duEbq/Dm1LMQehLaw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=o1kACPpZKAZCWsj7fAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wDuUOP0t_DSjIRNpHtBk-5r78zqdJKGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0OCBTYWx0ZWRfX9zhXGnGEQ632
 bNGH5elVG3gE4L/9koXYECqkR1jUQQRxjiRJZFEX4J36WF4q2rdOSH2FeqFAv5jf9MNcBuXV2uE
 PXFj39AS0UeMpvh/s9i8a+vBDryohod/iV2LONMLdkfKCtE1VQErjVhKiDytbqrdGYfi35vatt7
 mnKCZh5BzgyS6AxntHdDbn8jick5CLtZ6C/QUyFlbPemhWC4EpNfqLHvpKPp6fwrdBifr2UcD42
 jofjd3VWzdnus0IQghsA0x4qJsZi4h2Gk2SG44XNu23wMGnGYeqY2DULZuioWphMhkjZDvbMfKD
 Tg/FAV8toU/axwo/c1bmY5YNqqKScntH1y06ASyDykV9D9YCXN0gcCVV3IZxLSoSuyqH6AwMYbh
 FFB2DEMvDFoaFt+DzLueCegcsSxUhuOnU+LPox7D2g4RTk3YdAzRkzp8YgqNGuAmZVBp7uCJm/J
 9yFgavqPFL04ib5dOeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0OCBTYWx0ZWRfX9B3kT8gEVCvq
 GKWRNaSsvbUkRjHg/7RUI9f7p8p3AHwTvsruEy+3C8OhT1ShWkQVgzTOESt9rTmRq1bl/wka0Di
 5xvic694ALacOsFMqGneEZCZ9OPbsMk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240148

Hi Pan Chuang,

On Mon, 20 Jul 2026 17:59:06 +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[6/7] soc: ti: wkup_m3_ipc: Remove redundant dev_err()
      commit: dce7afe3efe485a99200a59dc78738539cbd133f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


