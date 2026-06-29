Return-Path: <linuxppc-dev+bounces-23058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9308EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:22:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgmf1yLxz2yT0;
	Mon, 29 Jun 2026 19:22:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782724978;
	cv=none; b=VbFSqq2vqDsXX97DcyP5QIZiG2vlZcWicCe9Tx2D6fXOkL3Kepe5/AiTl0i3mLExmK0FFCq4aiQ8pJk2CHYzLmLMAlo11ltUJCfR1iZk9t3g6H9lMozxHNXu1KaC55mJMfVdU8xk7NDUqG9DMKPI7BM4Qikag1RSIp6PI4nSHRNuTSBVWmOPNrMeNA0sresY7nn5fdbb8HTOnHaXMdwMPjjxdoKpseDRPrUSGPvRT+GQ5cEQ8WuNbia/JvX+D8Lleh5CkBFeBiFpdlq3KMi6FkUcGAaryB+8iWEzFMsD4SW6WVncpTN20J0vry2Laj8giIKoXDy9YF+85gJGtCsW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782724978; c=relaxed/relaxed;
	bh=PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvXqe+qLLdwuZVRgbW64rq041GU7v3tmOVuUaMox5R3nrn5W/8bs96/ywx6+YPxW0IZEdSBh4gb1QKUo+ERhC81USdOSwLdcfxeIZ0FAFJ5f6JVPsrCJUg4gQRRY5DgKwEzEb9GQc+apfs+fVdx7sGYtwiOcn+T8GlSg7WI39ZL954fj7Z0ZteuoiHSgW1otn7A8rRYmQwq6R4EZMW1FYjGoTGWz2KD9Mf1w/dZbUw8Pzh8CGhxl2L7I0p+GqMnADbCgSudMvAaKJsUzWR42zzoevWswZAI4GAOGiXsd87C+Fb/pN52IHdJ0SMfG6w4hxx07U9KexeKEkJ8Gzf3Akw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q7A1WH+H; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bSZ2NyQi; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q7A1WH+H;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bSZ2NyQi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgmd3XJ1z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:22:56 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7DxuC2188882
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=; b=Q7A1WH+H+84NUDVy
	kDlSuaTfa/vDNHD5W+jKXjedHKuT7ZADHpKjsgJObzl6LiN29woI2/c/EVIdiHaU
	ouvLXuPvm3hTZAu8/3JklErXI9fUWdY2naoBi1dOsLbotNAexxbD2MV3NVu77Rnw
	21Wh4Jn+7IES2oRaZoPE4PJz5LXB6ILiYL4Fey3A5DQpRenp+HGt/ConT4BsdQWB
	llBJ9IhMym+GtD1Nw11ufljxY8VJnPyUYPDIONZKGAY1apG6hCEzgWm3W+bTqUEg
	RENXcrOuCvXQer3CV2t2j0K/EmdrtXA4lvG6UReSzTVy+hgcBEp+vs4Q3QujJTs7
	PDaHFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trg2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915c364ae3bso483119185a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724395; x=1783329195; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=;
        b=bSZ2NyQiQwfT4zMML9HLOHetl/1HieVNy+hrzdnYZAsgaRSNiAkklL+KlUQc5GPbsq
         aSzqD7yhnlcPLA5SyXI/EvxX2axM6KmpQKZxopxRtjmUlKUHvcmKHwMrkin4VqchNEW+
         SsFN+7U3BjGvdZWyCDXv5MTwzSHwDvqOLDXDqixIyiZbmpAgmu43PqUqg1BhdRfTecHn
         7OsDor1ny2LgdIBxggz27rzE70vq2knXEvne7/eMl9kbshyhKULGYaKVsa6+cUXrSXNN
         /H3shP7lNPiM8jbh4k3vCW+p+CFA31oV1SUUP1FnE891HKaTWtwxTImrCMoqIo9Ia3Fo
         bQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724395; x=1783329195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=;
        b=pNJuHcF6BVSsjovvVrU8BtwYgxlzIpiaq8LjxyFDVUm1U8SVlHgWcprqY6RvHba/IY
         044gmAtTj7axIRkmAj5LeZ5q37I6/U3rnNz+JoZA8pABqa5dovzVIzGoaYK5yPt8WEPx
         /6IIOrw6WcOM9QXFXBDQNnHXCK8xiPjnqAPHwMNy3HXQJMsUPzHjgUmuo11JLsRH3RHp
         /mCLkA/pCxWOK84Rs7s39P3Rr0Gnl4tRwTp90dxqBdyfA0/Po7V8vT0LJ7ZzdHbqUNre
         Qi7zGnZF4NnxMfKwqZz2sNhuHsmk+bj1g7HtWa1Ipd2h566OVr/6rukcstNdfB2e5R/F
         XQxw==
X-Forwarded-Encrypted: i=1; AFNElJ8i7+pH9dG8NuBd9OY9wJG5rDfGfb7IDnDqxNDcGmBDs1FNjkPzhvBpvOMFvqlEFMBAzXILvixphJDoS84=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwrkTuaJxqMhHtMNRcwK/p4qva03uT5PAYHJwTsj1chD7zpgDUN
	MYX3F6GAUVMnFqiIMyf1lutK7uuHbestQWK151NLzG4f5f12uFcpTwQlXex06mryI4afjEgY0n0
	5Y2CSS9UwkKObGyHOr89Onr3bBjfB6uCcEX3SFad41pyKhz60h2hBCSMJ+JcxkTtgYPM9
X-Gm-Gg: AfdE7cmVmB8T6eE33A8wRXcRrer1PlUO/txbh+gIv6xpxvXCOKvxwwswVyFXTXzHLMc
	Djij6+JJ0SELhrPyBPfZJvOZ49yyeO1G6NEMgHrw2vZOSBhtFu17qdRVUuCPzaZ65X4ZjhtSDOP
	kBaunuebmLf0M8YeBk0eee3AKRKpUaDK5LgblXnekLSryEZiL7XSohEKwZ59bD5C42+3aYVPVd7
	rpb1PTl+Y/7RWYYM0jP1SaYFOvtnS3WhTMoJTwAYBbxAyB7AKkIGTQWvcpk++r/MgmeEb4CJS/b
	AVWkMO7QjUebXmLxvd+Ngf+wBhaKJQMf3CSIGWPhNDQZqDrR5tCd5VMCGGD2HOYvm2PiVeluS+8
	eVmCPpt5xzLu5fmnRGxWWFrL8op7cI08ta9K67tKB
X-Received: by 2002:a05:620a:2591:b0:927:59bf:46ca with SMTP id af79cd13be357-9293cdca63cmr2440345985a.40.1782724394389;
        Mon, 29 Jun 2026 02:13:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2591:b0:927:59bf:46ca with SMTP id af79cd13be357-9293cdca63cmr2440337085a.40.1782724393838;
        Mon, 29 Jun 2026 02:13:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:28 +0200
Subject: [PATCH v2 05/19] of: platform: use platform_device_set_of_node()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-5-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rrDc1Uz6I2aUdO8G3QZmOKFJZ+6purM4q0mZXEAYeWA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcLD++JnQrIX2VzO+dYdToOeDwQeKJ2LBgA2
 f41r81v332JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3CwAKCRAFnS7L/zaE
 w2WfD/wPpjTQ5122QbfNMJ1ncEqmky0pkCQKc8KgH16BI/YYrf6YCDYbVXp4OOhlfZ+AA0amozc
 YlbIHZr8yW/8Ww61zaZ/f24+kXP5qnHaraGtL08YSswqy+bgiy6DYHDY5qUo73sVcHKO5sUkyJd
 VNvTzMspkd/CSHW9IobLoZY+2kWm8E31AIOO/hfDyyS3EQifk8vhfUoNuOK4JQ+Udl2MocgNcXK
 gyJcW5wP7/teYAL5yUwNwHOW2goa4bkxNwYhDjV1m2ha5HM7wBmjMo4nxKPRhHknE26NmoUY/3V
 MVt/rrRKu9cMEw0bVUAg5LpMWATwm6DGIvMMdyUGdCYJ3FOdpR2oNyAPt7c1w6VQ9hw+yemoMsB
 GM0rf3wL6NxEZ2U3n2TMFLsq04TUPNcmqkCPxGoNBe4WDfEoJQOjWTqr6QhpKRhjanbvLUCLhnG
 C24dqO1si0SdYnqmqfdJAtp2HtSOy3jb3n0S4scELZMX/cUKTCUyKAyESPlXE12RQk4Y4kjHrQF
 klKXae+vS4MilI8Hxo1/p0tl31WhBiLnQx0NO9E8f895BW3R7CYmGU7OAlRsZlXZaJb6J2MAl/p
 N3t1e8+eIs5bngjp6talt1GoO0x1cZpCIGKELGViK+k99s1krS/BpZ+cZiesq+H5lGbn7cCw0vr
 wkNrdcAeGiShgow==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX6DUv+a/lLwl8
 /v6yfQbxpEz7cMwW3/2neN/LiqRWLZd+6CHPJAZuWXXTB5IMCENB9Xc7rVdhXfoL6pBKBXVwayO
 KuhnrOxb8VOehjWLitMGewlE64FjXmwUWVofBn6Jjffq/30runKnkGS+KPj49e6hcsGsaf48PtN
 xfGSspPXvn6agKV6mNOD2z9CH+NvJkQLQsehkTjSXTZdEY3kzQ6OR+8SWY4qp8Oatm6iQOtDCiK
 mZDikqZhoY31yaqrXUlGARNZXXgA/zWekTHSbPsaYncAzd5eNB3DdMn3vnut6DWCDHLEts9uIpE
 2tmwpXREcxhvWiqz9CCkZSY0DgVuI3ZkKqQE8YHOEx1r3dnX9+6RByiYLMsYGrrj+U0sdWbNBUR
 1K+7pAzpdTVD+nUyLNxDHOF+471UFhE1eIcqQyEYR44sNNvDj8/Z86c5wjzRCPLSonZgxpwPyC9
 IQwYBgAHgvqI38h/ehw==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a42372b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX1oItCZpo0ahy
 efYbgri1sYqYbcTqSNTVVzgtrQYzIlxb3uxaeRROoj2mUqzUUoZhEPBPAANv+AXoZ92B8KS2rjz
 evB+gUnkIogWhEVkcvsNnNvv/BUK1yw=
X-Proofpoint-ORIG-GUID: jSY985XrulcPRIsoFr_kdHpSvbln7kaR
X-Proofpoint-GUID: jSY985XrulcPRIsoFr_kdHpSvbln7kaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 53bca8c6f7810ce2235b4d084a361626b1d2da33..8b1e7640778253492c080085b4015e1423389d83 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -126,7 +126,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
+	platform_device_set_of_node(dev, np);
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)

-- 
2.47.3


