Return-Path: <linuxppc-dev+bounces-21295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF72DCD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:38:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhcL1NxKz30FP;
	Thu, 21 May 2026 18:37:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352658;
	cv=none; b=Q4MFO1ky+4NljyVlBhSTPVmoo7+EgFTvUafczco0nYdibSW0RGxMUV8Xw95DkttQzuCi7apZrUHKSnXaLJ1G4oCthV80aNT6N0+z3pLrQ4U+l9mPQz06L4NGv4laAPuFZopDiSm7XohBo5TivpNuDL/PTO9r6YJC8yaOaf1Q/wnF4sG8jkaif2e9pWq8JDV+zJVO70fgnkL+T4NRk7rOMeYnQRgglXU/yroV4uHdtGdBa7U+kcpe/3fvJO1D3PNmfdgon4tz0yNWifrOt+9lTURs0/JjVaKEOmasCD0urAR5a2TlQcGMICwdMjYrEc4txFVBlR3ATeBFy7INYuPVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352658; c=relaxed/relaxed;
	bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jeq1Fs9vYoOdNnzUpPf6A9UQeyaB6blSBF6QAKSqVb8dOXUZ+zqrU4DyCCvhqxz4O9ZS0hEmpjJUqMquI1cl3wWusMHAswNLXdssD7gU0dh2L3+K7knfGg8c1IWSiZBWRmk+uN7Gsrdgox5vHIDp3raknLZ36FfjXfsfgkddyp1BylzbLWVl8vryZ49neN+AWYpplHcAGSioL8bWkKK39+3XgujXf2EwuniiSXjtu0ErHhyYAXc95auL2WGhtqsIepOS3Lvis7OB3MK4ZQ4t9AED96Vj57qHXNad6Yz9uYxfcV56v4Fp73GztwgbPv+2ne8Yvp6Xk+NxVdXoVZI14w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wx0mkrfh; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8bWQURs; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wx0mkrfh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8bWQURs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcK4YXcz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:37 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L75BOx3680286
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=; b=Wx0mkrfhTR25R2CR
	P19rj34FWn9V7nFvEfRskX2RWdvrWsW1njjrnxOrV/EhPy3AZr/lBeiimxCLDs+u
	IvefMDwBXsucLiZrWeC3atAcK7tXPEKVXMmJ4Nu/9snsAU+7uZdGmON+ofOmgpK0
	WO1RCTJ11flpN+fzXzevrwr/Z3XDSRoOkYyINb6plIMdZqx3juYxIFE/7fD6O4KK
	r+8sRezB6kVXkXTd2sh7wG3GEfPxaiqpsX2h9VwexfrfY1lrJ2CU6NL6wHOIZbRd
	3u8kPyV7Qyk2R2UHNkvKTnwsaZCdUtQLADvT9TPpntLC8xoYJj9rguVoTpLjy3Ff
	Aza/Ug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j40y2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e423a05c8so160879011cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352655; x=1779957455; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
        b=c8bWQURsPyf/3UKuUen0+odleN3NY14g6IRdFD/WZamFoOVL9RxmV6z92+MgQeexax
         9GLHv377kkPhRlbateEsYqka/+7YAw0G4Eq6ceKibUMa5zLLRFZVMb+YV35jQ++FfEqU
         0AsE/jXr/PDY49fd0fblrkgAngab+caIEZv7q9njC82nyOAoBHDJVBe8ofh4nsTcEvpg
         K8IINbQQvd1CLTLAgGMSXb6kyaKchCuduLpAdy/JifCDKNjwnCx9Y8RPxgSPDabiv/u6
         2xFmma9mSQYBSrY+KU/pZBxTDkc34/eIl9vsOuS5ejmuHIrQ+hF55t6rxaNybdcAgDmu
         lsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352655; x=1779957455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
        b=nELV36RcextoWh80qzHZhA9QSllQ6PuK98HGQsi+ikSk10YcAzgJJuR6EvQcg/D34j
         u3LsxDaw54QzPxWPZPxgJtN8qUa+gbqC4r8CT0dka8L0o+eo/CXgBIq3qLVZxCisHTqT
         LHGKXkW5ctAgfoCDf1fGF5irb6TLV6r87s36IT/18y2mmxXQIsD6kTuXD8DqfPDLHuXO
         mQ6D59RK+oLv93u/p8cHi9l80zGeeR6MQCIgK2mPvHWvKiIpifquVOCewnQfJeAqgzFj
         XmRJYAsVoC/NkL4s0p51TPlEwMr67CvNS/aO1eixM6ShfzXK9f1kd8f8d5ICOoPTZduB
         nxtA==
X-Forwarded-Encrypted: i=1; AFNElJ84jeegFa7okgE281fJR8/T8XxQh7I0Kpp0kC37CZW9d4xR1y8y3VThilmYaPStADPziuwxTIjkmoUKpu4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yww4DqC35PUIuaBFtAYC6y+Juq0cuAK9ZJ33rjVWRryU01OeqeI
	esjTcYdXGBvle0cqR9kjDKGqvi0QqqjN77Guu+7ez0hA0ydU5W4dbc26HImEwcqxNcEunANDKMR
	ia4WCGkciYWL42JAxwghp6wRFXlufGGL7eLDNXNCABWdFChZjpSDZhbMzH3CkNMxMRoZs
X-Gm-Gg: Acq92OHPK+Aonc9kQKNpGbNMwR3ZXAP+lniWSq3HYiOU+s+PRS1cS0shNS1CmR2BMgH
	aJAuXd2uPPlbOma1Pa1otEFSdjXGCVn8V8DFd52nF0eveqVBUHtSGS4lBY/dKSfEEEX9cY3PPDI
	tDT7Hy9gF+zozsEAOgrlpedlPzEFiJ+QxsYlANBF5V7YbjH6wZ2tJm2+UT831jWLI1mYtVFpQmb
	/0sMunZ0a9Mtd33LCxcCv0Uf05OyAKrffOe/gNKc/9VpIHhIDSEQPJ5UAzkDtG0VxJFe27bOUmv
	rwi3ct3TWW6g8XoXbJlnGxN35XvqzKRuVjQPTJnYUA//TZTJMyOxyTzNMPMLg524Te/9Nz1hrfj
	mxCCe/bryDy8xN3ELID3MDFDTBkRWwCoOCdAFpVle0vKgO598Px0=
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-516cd8dcb16mr1393341cf.39.1779352654887;
        Thu, 21 May 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-516cd8dcb16mr1392831cf.39.1779352654276;
        Thu, 21 May 2026 01:37:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:32 +0200
Subject: [PATCH 09/23] of: platform: use platform_device_set_of_node()
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
Message-Id: <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=62Oz1SbeAMwV4fv895oAqyFh69nhboZTNIz+xPLsUyA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQmchZFDFTztRU29nkcmIf2nW/nwlzDTpQz8
 +2keRMrA/6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJgAKCRAFnS7L/zaE
 wxw/EACn8eHQOwjd+Dgeolnl1EcseWe/xGk5I4KpBP1p2m+G11f9vLsOUXBOPZGZSyzUPO47NAC
 iyozeeVO+OH2RpEvb/3X3MbeIb+N7xCFhIXoBy9dHt8TFTc2eZb0zdOcQaQ7HwDPqPAsbDyDPAa
 tScifI1XmoBcqV9V1S5KHZLhhWr1TPVqyUBvQJBVFTDr9Dgc4IxSYyYTSp4oxZAseFDlwBM3oMv
 trGKhh+xWYBpqycF8F3nEAvyJKUpMT1WskDUb1hehpfJpEVsb7kEOzTj7zGh9PP3osTLQB1dDAu
 k93V0oRYboHvSnoLrZOA0OfqTfGPC94giWuIlDQxQBJ1QYipOf/9/bJ8EwDeKu9NiKwsunEwdwv
 ZDsejl4PufjMEpJ7PptHLqO1X/ktVBTcRplnmlTo53Vs9em3L/5kSW//1XptpJg5MHQKstiGNhT
 JwXkhQKxsEWHTU8bBlJ/KnCl5YeVz4bAiwE5K3LMZGTXxaPrKNPQE2a7OgCcqKI7GJZN+MbaSR5
 iRRE4GsITdqUI+V0a9GmZFcR/ACxIhFigTivLDROyYp52uEEBqs41OjLaek/Tn/8+GAbu/+LBlq
 9u9KFLbmZmj68Q+6ZlZNIN+DZ4GjJ1qCQlnSFJk++NQiAZCIzxiS7FBUV7Sc4R1rjga7Eoru04k
 30fJtzl/FkuS5GA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0ec44f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: KbBSk_IFBaLNkxwaxIFRlO3g3khEa2Fg
X-Proofpoint-ORIG-GUID: KbBSk_IFBaLNkxwaxIFRlO3g3khEa2Fg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXw8CjHADtQ8Jd
 eObHSkLXJlH+APx5iCrpmkZQaWc6pVBvLOQ7TaDOcPvcMf44xVgCsmPfxtJ/bxRX5jFKDoJ5URE
 4e7h8jtXmJFt8I1e0UsT62vpJ1k0A+UICETmMcaLZgnv9uFfMpPpRM1hBc6SqmKDLNwq2I7mALw
 ZnIP0HobjasnvynZPBP6ztSBoJ361R/O5YObhvxe0ga1XQto/mA/iEDrJeN3wL3ZoVlmZdhVTMj
 ksTypePBqbKhBrN3A/rjGooXYNoO0EXTMSu/koz9kKhahVbJPVk9hL7M1MO9bhI5dBIVP+6b1FL
 veRu0IgwA0yz9ap52Zl9Uf2KSRPiiSN12DiM/OULoJwIeEIOhFpr0e92EEET1T2ppBjz25iPBNQ
 bYEzwlL54bL3ohPJ9oQXRSXU0L4d7gmXeErVFxg/qTdXIs7a7nt6+TcAVTGau5k6aY1Rl9XeD3R
 kyTXBhfwvZUwHkw9VQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a42224f9d1a888a6e6cad7534cd2c5f110e995da..db45d1e99bf9b027548aac3a15bf754b3c023161 100644
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


