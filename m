Return-Path: <linuxppc-dev+bounces-23061-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E646C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:29:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgvt5S9pz2yT0;
	Mon, 29 Jun 2026 19:29:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782725354;
	cv=none; b=ObOBjc7UwlFMIcyHq84GoHVQAbjFP5cjMRLHkCNWdx3TSHZhbh32Fp5oPQ14CcINkTTRAtH7sNwuLGJQt1UgxKmHD8bdNyOntTePcAkxme0aQ8Q5cCRlitgFqQZrxfDbUr1b0acYDVHAD6uTHntalgyosbLtCMqZ0fdjb1ct9fJDs1Dj9iYQnqkbcpbO1Ak4nUHgDfUYRg3Qd8ByUdL+3+s2FwOXMYDB5igkrvIENvUvV1DfvLuBVsgZAWBRxFNoKjeLfSsNacSt4gePIqfeu6AFBg5z5Ig9cIlGFBAZ3bD1u80l4t5jEKj2dKU1K2aadfueIUO1UGKtYcF+maRC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782725354; c=relaxed/relaxed;
	bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TK/naYQ9Et+c9Cyoy2VQGTVqVUqVm5UBnQM8j5401/MQx7iThjSRTOP/8ZJw6vmK8RkPVQ93Y4faQzj3xV+cNiR9aIVkq2YhjEvyY9Qk9jm8//HklBd2r3NQ0vO4IGsOMC2+0rXSNuuSmGa9PQxE6C2NeO8YcwSxUUi0V4N9rz7Q7dljJHuoKJbPzqVnPRfgz3DwCUK85gaQ9QM87ivCIjKVbSC23VmmLUzXdbq/cY6YcEOnrHT61/Qx477I+rtZG98BUOs5NdKtHYaps6uWLsrUL5yJhOifljVoBLZZdqO3XGAcvfNud43x+Q0fF1sObJgCQk8DjtDheG/sUKWoXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nNOiOP5A; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4SlEVhA; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nNOiOP5A;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4SlEVhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgvt0XXRz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:29:13 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T9043Q2433806
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=; b=nNOiOP5Atvc+atun
	45mZNhDx7q6EkdNaRDhn5LjMh6TLUjFzUhycSyCa3Z0uv5nBqXMOPxV+uSAke4Ku
	T7lMTA/09AOUgNWuRqRQ+d/zJTddMeOluwU0/40N70wtzyAnneMDXch6BBr7w998
	tDB8wNA5lT2pZlrzedKaDM5b64ztVvjDf0Gbs/SGiB48jRd7ISE1fLOXWLc5zYf9
	Xd4Qzg/SINHf5XYSXSgrtlAjVF/y2vohT5Kc9Yr7j3UtRtPUff6ADT0Wcj9A2m/t
	dgOrs/9D7nyS3eyWoxlNwgPKeCQ+C9ENwgsQy65LkO4wRNDRrDi8kxXeT5Vapuqa
	11H4bg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper24n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b4b575561so537294285a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724413; x=1783329213; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
        b=i4SlEVhA1uTlWpwMbmjdwt0ksujkZlGRjQka86S3JQQuoUZvTTNu9shPdQkK7IWvDg
         Mqkshhb2P+05rVcjBm9fEELmdOQ4aZK9b2C18cSvB4ad7hyLZgV88XJ/sH6g9JSjZB7o
         iM3f+r8LgPfJ+Ee0MlLtSbDYvgy5ryiYBoUUowZo8TLuVA7l7V9wArZ6GPNhAwvb75C9
         QNSZSsdR5CwIdx2nwGDng7eD3/ABd0e/sTQaqw3U5f8BqjbGzPbqYc1NrlfBu4IZInOY
         4qpo5FuAB8EAfbaPnqrp8MPq/o+FHFt6PwX2Ni4G3eDSNHF1n7BKkuKlphguOtosRxfa
         hzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724413; x=1783329213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
        b=iAhgfLUb+m3dBE+2UbR21V+R7Dxv6yOWibKHwogFX5PgYNJXaLZUzsx8W+3AzhvsdG
         9PhtodAhGjOFpyKqUQWa5pW6yqGpqSpu1723LUXjMT0kAbzGFoVgKjVoVzbKlrMSaYpB
         T9pDUZgoGQMqno6o5Q3Qb2EPwgajes4UwbkRipAdxeY1M1R46ivqDJp5hUzQC7+yR8np
         gdJdR/tczQqFKlr5Vm5VPdtrKSexBGLi/toxo+5K43pilsExWK9I9BcTGmZgH1UBwxkn
         dnaR3gmeuVGrH/ySLzxMx9X8Wp7Bm3rLr/4XrdiGW6BVN5xN+4QH11ykb6dvzkyp5pI2
         jWlw==
X-Forwarded-Encrypted: i=1; AFNElJ/+JYFlrK2jQbhuOZ/mMz8rYxEQF4KtFIcnd487CY2obkkvfAd2G+lJWsOHnZv+6JWxXEY3e/ydmUG5F0w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLPIXFiTsvAa7141MeeaAQd518FzR0mTHOVDpptbA5G/eQE8HF
	aLL9HgwLY6qp6gx08HXrS/cPvH98T3/TbEVoimLyxJ4W4UQ96E4LP0rtCBaMfeFKSVDJffGCPMZ
	ncmT2uX6XpbeYe7p1Nk2R27Pac2fBHGGVq5DRzH+RODB1SmgAPD3GMMHx+zWdPY454akM
X-Gm-Gg: AfdE7clrdGO4hhxl7FPv+J7rhGMc/KO7ji5OEEDXILe9/oBfXXNXjdBH8Ff64F9lcRn
	rnb6BhZl9SFYFMGCfu/Ep5MaeL2TXZZt+dwaOEJTlf2+KYWXliRLgRCE48Gj/BsY+5zhwc2WgT9
	+hq7xU8mKEAmGgzQS8SxBuYjmhsv5DbEzmRBpHob9HFMKhw5cfvJharqcC6YWjY1YveeBfTDc5y
	pAMvgr5itoJXthJePtUAFuyJFaEjQi202QGarOdBNSaLhVHC+DrK5253D8If+R0hv3jzIj9UWbH
	ksCtRTlghkSkKamMIyNjWvQqyheGWgvp/On+xkS57n9Iqo+VA45uKzkOGVz/25NiCU1Wg8Pl7vj
	Gp3MibpPltdKmzLoUX7QYch4bnHXYsUAS/gyPmrNA
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr3581738385a.39.1782724412970;
        Mon, 29 Jun 2026 02:13:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr3581733185a.39.1782724412420;
        Mon, 29 Jun 2026 02:13:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:34 +0200
Subject: [PATCH v2 11/19] mfd: tps6586: use platform_device_set_of_node()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-11-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YiZHp0QI3Ng/8lAx//2O4lFffX7ntR6tJ9zCtpgXyiE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcRLZEV4wuAyM1XFVhA7zrIOgiuiY2Lgzwoy
 WvXthoR70uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EQAKCRAFnS7L/zaE
 w1cGD/9752d9n7/+/8T9TqF9iQ7G9zlOuyfPubcVf3N8oYfxQ+0pZy96O9R+C0vx5H1PXXRmjn6
 1MaB3Vt39w1WVmSUyqDJ4n8WB24AjpfYGTwAbI0o1lZERogpod5E3M9QPnnVwD9wPPhllmUPty7
 xj30SvOca8pUgImOxyER+gR75EsHqUPeWQasNVopAFx4mS1lo2/u1kqscnDBeqg6Y87buduJX0V
 uOUtSHuQ7w2vlhQ7NqgZHurmNliUGIpxzWfiGSSX3BK9D3AkZSWvLW8zctTGAHCPG+qBFzRVpQ6
 0FqFad0z86W86hiNnldftd2a9NL8dP7GfTyhmmggP/mzqh8x5/bDltnbVjzYzBrVM31qSvqxNUS
 YPD8Ey0CB/ZX/lcEsaoLCOsAHRQsJE+Pt7xReohmz/oBquTOGfSFv1jtm5jIY03sh44Qnqc35QD
 CAnMCCHblZZB9eCTh3y+FCKJXfxLvwMdtbMKOLf4azEE/0LB+S0PZrFvyocZSoMtKLtoR4aExim
 DnBupTzpN+mh2vq64tVXBcwg38pkExWqxEX1LAQUM/UmS1ByltvukbJRxqlHs8WD1UJ+3oTsxSJ
 w/mPtguXJ2fFOtqgczI61HeMKF4E2nHfhBqpM+JhFX/aZ3O/llYHjqsfXoVg6qzpOOoGiwcLxSI
 BcmB/XQ48OIAacQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX8SFpUWD/MXmZ
 PoM46lvQeD8ChDOJQ1tsWgYoSeL6uHmu1/RZTXDGUvhIIXbG8CWq6rfYcAmtyV+EtX1/W+QljAO
 edF9/NSyCd6OtKa5rQpYe+NQEITHnm+xnk9cvJCyQOLQVD3q/3u08aAQhYMWM4SzHkNGWCbvynm
 1miD/ievJWmNAiUplX3ugetMx9LcH6pLmazdn6zNvO9ScZxiORmVG//wM60yQigz1mtSrECUrpI
 eVw3b4f5BXMCnOtTSVwiiwWMAb/ZpUZrTdbCG1KwV9gSScRHY7sGxoHXYsMHyyIlWH6u+zimvYe
 77/yIAjvoYdBhM3jY4Kps2qE00wrdkKIPOrvcllXqr207uDPZeLs3WI1hrCgmis2sVGV16zK/m+
 hf/37nJx7kHKsZRbCBcQ3qTND/7uvhLIHhkzhZwzJCAVJpa53GwtRKACvopQa3Q+VAhyitG1XqL
 Pdk7MRgjIAZrCNvSAjQ==
X-Proofpoint-ORIG-GUID: 8b1GicXZuVuASTRNygcQQwg13_8r7vdm
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42373e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ESSmVKC5p6WdXJfq0SwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX8ViOnX92YIsg
 YxiV1XG1G6qun4s1QgbaQD4ftwdegQX/rfL7yIBiWZm2FV0MP/ZYSBmkUB1g7mhZ3VO6gM1EL44
 1/1ZJIyAvVJ208VBpPjDx2GYMdeNYOU=
X-Proofpoint-GUID: 8b1GicXZuVuASTRNygcQQwg13_8r7vdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index f5f805446603315ba76ce1fc501c908f1cec0d16..3cfd2f02b62f3cc370e0d970ec2643b638fd0fec 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = of_node_get(subdev->of_node);
+		platform_device_set_of_node(pdev, subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3


