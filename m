Return-Path: <linuxppc-dev+bounces-23085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC1FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:55:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphVG1CwLz2yT0;
	Mon, 29 Jun 2026 19:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726934;
	cv=none; b=CbQJ4Yi5g450g/RtdSMNbDnWOWMIBwXTmtq35jxuyhD/+6nqHnvLDiMmQc8J2psnD9Jdf6R8QXj7038/NNZmdfAU1/6v6n+efpbmsglQ/uadx90UjvVWGzv188SZqyRtWWDp8Y3O1TSZCupyNnhdVY6HyZLiRIfHQzl40sYzvpep9Oy/GrYhIZ2zJbf94OlkIzlKH7Azf3HV4Iat7LAoWFHSKsUTSMUWvdhwhtRIsnJqmWiym5DKFHujaD+v/Qj05KLUufcKRxnkHTKGLh4Ks6hv8GKc4sLOkuzZ7i55rWw0rx9dDcDi5nUB9PllUk3HFkwjgnonODmGfHfihlaC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726934; c=relaxed/relaxed;
	bh=NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtKoHN7VhJI7eJyAKWMuQAvvB5bBea7flB/WA97Uw/ksUdSOdAHNPMdUAVrjgcJ86twkL0zq+IVu34D5mzX74/zU+h7Ynd8NiPWHla8NNdF6hvOrmbamOLYNKy5BZmlOsfeoC32UASH4oLDuwfh0mHyeQ9Y1Ynmz2kXBsqgBlrMiz9YyRsHdfnNCkx/Y3FKqSCSZ3KvJjyTxQoLdgcHjass6vMML5ni9O4Ko7+/DHj1SHzDJVXn+gACo3rKywKWxZqo7r+YN28evs7C1sG5Y40DzmAWUoAqUOX9C9GzoLeggw6MmAzSc/OjO62TvAnSBASrez4wFnwiA3Ga67uAfOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gYI/y+G9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cHRKPa9W; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gYI/y+G9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cHRKPa9W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphVF1d4Pz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:55:32 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6r8PZ2076539
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=; b=gYI/y+G95VumA8SD
	/R59cVJHGOIt5pSimIFypsAqavIeXQaZcfb3WjkwbUJYNFoo8aH/QBp7uGVD3eas
	Lr0atSwt6c7aq+ikROGmESkAzTzl0B1g4uTb77HhpcqieTQm0wPBXwPKilg4xTkY
	jKJbM3mLi+mkc48JWb30vOO10hxR9PhSkbP+KDz4UwMdvnwcUOEjVvKfwoAQYkgl
	gPMxOE/72VwvH8eXJKtTUPAapgu/txpGKnhD2UhCN+tCgnfm44W6g9Vf1hZWU5DW
	GhGs2PAeNFj88H/XEA9LXtyNYAR7ScpzMO05COuPAUZcc0NULXwA7b1clvWReCcn
	LCXaKQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gkh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4f946461so142655885a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724387; x=1783329187; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=;
        b=cHRKPa9WkRA8HsR8opZTkwsZ+M6ewC566xKr5Is68vVuFtp7wbAYDmBvbxq03giRZI
         4iF88C6SoH9ZyWN0ttG59KiT/bEeiRloYs6BEi9gLLjfwplwJjoy8wPCZlpeNEsoOpjv
         VYvCA87qfTbfIx2ndp4wEfkyKV80084ZwUrLInPNsiegaQYGN/h/MlnLX3aJnI3aJSZD
         DdLIQRgLY+3DyGyD2jjl69pxabOwsFGhHNgk0ERYae5RRPi6nifuE5+LniL6HkIEhHch
         3ld4/ljpy8U31U7aQYwn4su0yzyQ41EKbdd9/qkwmmfb36NGqHoW1GTMIRKvdHb1LyXL
         Jc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724387; x=1783329187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=;
        b=KLKqikvsKexELdGIaSXw+o0aAlW8HTf7cJqgHO6g7ik9+CI5aHOA55/uf0kgaLgTp2
         U7W9rmavbFkI/6FRYIAgxu61LKJdOHZ8UfUHly6Xs/VIRfOZOAo/Oc/xuhR1N2bx7C98
         my49gmH666H9N0oKgfVn0BXJG02OOg+PtYlvxtpn20swJPn4PHY+X4TxNi3LWxppBM3c
         GVhojxfpv3RP718NOdfefFGubQjqm59wM0Wqq5cV3NdoSBk8r3hUVgTkKaTMnf7Tk0kW
         aV5NIkDU5m5kROA43q7ZNOdsZQgA3R+X6Sp3AMTt8uTWHvYgtIUxPWa+LxzjdeRV3of1
         lXyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fVx1EvnGSmeM9gKZEAiSwAyUBwg4jjusnHzTAcjer8QEkN8uPfaugu8E1lno1k/wTwwze3CYgVizq+vo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxEYitu2LqCoF4A/QHLgyokkR2z8xj/EzYkK8/1MPpvNxdeJ8I
	zajkF7J8w16ysc0ruIyXn/dby2yuDaaHCxrZfsBY2kJ+dcR5IKTyePgId1RB4ttOYHMEvOXoSYI
	ZjgcE/38mFV+zsNps9sn8+ID0EKlbNsqqYVIRMiosfeOjwa7222H9oj4LPaLK00bm9QLW
X-Gm-Gg: AfdE7cnIvr1YSuew9Qbsdu7pW8BwdXNCGptz4ylVt67cgrQHAG25JKJcE/Bk6cF505j
	Fp4dfECoxF1PDFFlnlvqbaZysTODO4BVcBW7Ck6Nr/uvXjI4YjV7BR8smWp+fmTOyFno/tD4v2C
	A3hrmn7suPfrq6jdFQqwAP45WLEbNMZAVHOQa65q73/XLCiNOXgoy46oWzlug/slG3RZG1L9sEF
	T8wwSvSIucJGjOrpqARGoCotmAnMD5yEdQcSRCRBBGW3DdLTbr+rHMsSWCX4Lzua+rqSoWvOysr
	STinXve58gbdNTP1DnI1hWLU77t3aWh64CZfY9MmVaeUbx94TsPIKNunXDcBZUuMqmHrITb5jgN
	m24qPpHfJNiDyMNmpi+HTxYc+qHFvRFeaggBqcYU3
X-Received: by 2002:a05:620a:17a0:b0:921:9d7a:ea38 with SMTP id af79cd13be357-92b3e46fe04mr1387186085a.45.1782724387496;
        Mon, 29 Jun 2026 02:13:07 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:921:9d7a:ea38 with SMTP id af79cd13be357-92b3e46fe04mr1387179685a.45.1782724386772;
        Mon, 29 Jun 2026 02:13:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:26 +0200
Subject: [PATCH v2 03/19] driver core: platform: provide
 platform_device_set_fwnode()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-3-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rUG0oEwArOQI4stC68CYhz65UwovfxaACRw43q5Ey5U=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcJjPh5mDVUknauSD999iEJoQhOldHh2+5sY
 Ww2SlGyFmmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3CQAKCRAFnS7L/zaE
 w+y1D/9MES2KbtS+PRc7JBKv67xJ1ZbKe/n9QDkmQW3Fo3GeBTca3T3dkyrF9AKSM24U+GvjZou
 /krTxMLjjLMEIK62SRmS1xLxWyc/DISbLyTE4c8AUYfVuqTPy48X8A8meGPg7hfWc/Ytl7U/+ZF
 4Bmcnc+qhSS0WdcwRcXJ5r+5q2BohvzW2Hg4yNk44DxQSqgd6xy7d4TlVAG3fUIp+2zCbPXx8ed
 G++O4czOLSbEsEPM2pI/bGPJJkM9C+gjbqN1NdLtds8PfL+Ltr3Mo5cyRY5wmITnuQKrzc2SB6Y
 eXCHjkdukHWRc47AD5Jtd4Bo5YH0p/lHVPY+Y4L6wu7fGGpE9s7k6g02v0N/ZSjgRV2Dwy/YFwv
 8ptXzAdQR1sRag8biXf8XwCe2qpjEt32eLjWBFS/NhEBaIexc2Vlko8t+s/nKh//af4WWWzIK6f
 hBhFvGPMc2xX6Hfhm8xtpnkklUakjwvXa/hHr2ZS2XT9JKTn/uggmbE5kAKCV737iom/G6SvIQ+
 mHSlz08g8XpkXmumGsmvIS5r1YW/yZ7Nr3Jjnz1TpKl/Xw9ZtYTjk8gnDfkRCTryOZiSqWELkGs
 h31XwoK+zijgOwVnaDmYXxrSzbtnAJQxBHMA+AwMll8KTyhe4jcz9NiWNumn+m6m1nP4HPGAhgo
 7evHEDzQbm0hLcg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX+zaGyWc1w9TZ
 CdUkRhHNIVVs1itsFoDD2JHm51Kp5C9CAHbVcSy68XdANhc9psj0MK94zv7jCpNU/v3hZlEkixq
 6YzQcOKCGO/NJTVnZsoFF3FJGnQt3SA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX7vQEWxXWCi9T
 MCX7GJeZoiaVCuBlM/0Flj32DCZLrOpHZzK7df9skrycDRBL1ojZEjVUrrwz2c29V9d7l62BopL
 FsjNEoOgqGKS9zZ/klvc+HVxrJVDNnEzqNYSa5ki0V91jNAy8z/WbFq5c2OHSSX6ruTdl4FjAv/
 R7UL09nH0BeM2N/zvn1JnIcjHEcMOt/r+5JTWH+PMZk6Phg1vFBuJV7ckJGazfFajbwKXojYxHz
 Ft/xAPQHj6pDNFSRwSZa8w/289ZURi78IJqyyID4pJQku5ZoYM59gAiGjkcuZ5TDWW3HbaHtumb
 o6LME7np9Bc5so9f4Z3i8bSfr0iGf/BsQ3nc2vBQQo4wvAt8ZuVVr//K7V9dPMTkF0+Xn7Bcbso
 94forTMGrFmvTb2ctfar9ibTbh7bY0RT3M+yXAXWR7egRqwXHDgsczUlYzrcaYEKUOWflrMTvwT
 fkd/XjiZUO3HdnhkveA==
X-Proofpoint-ORIG-GUID: EScjSzOGFYfqA-dSo6BEsW5AFtDlj0oi
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423724 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=7s1i5lxVbzGmBzMXG7QA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: EScjSzOGFYfqA-dSo6BEsW5AFtDlj0oi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Provide a helper function encapsulating the logic of assigning firmware
nodes to platform devices created with platform_device_alloc(). Make the
kerneldoc state that this is the proper interface for assigning firmware
nodes to dynamically allocated platform devices. This will allow us to
switch to counting the references of the device's firmware nodes in the
future, not only the OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 19 +++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3188d5aba5f90622f821c695049cacda030204fb..6520b70cf3052d683a2ecb1a0dd7227575546ba0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -711,6 +711,25 @@ void platform_device_set_of_node(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
+/**
+ * platform_device_set_fwnode - assign a firmware node to device
+ * @pdev: platform device to set the node for
+ * @fwnode: new firmware node
+ *
+ * Assign a firmware node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		platform_device_set_of_node(pdev, to_of_node(fwnode));
+	else
+		pdev->dev.fwnode = fwnode;
+}
+EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 870d168aeff8558749eae71723e657ab150ce0be..c463d46b7b9ab6b891df1ca9f0c98608d2bb140f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -20,6 +20,7 @@ struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
 struct device_node;
+struct fwnode_handle;
 
 struct platform_device {
 	const char	*name;
@@ -265,6 +266,8 @@ extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


