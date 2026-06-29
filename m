Return-Path: <linuxppc-dev+bounces-23068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB9C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:42:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphCc5Cg7z2ydj;
	Mon, 29 Jun 2026 19:42:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726172;
	cv=none; b=KAkYEyA+eyHL7Uvq/tQLIbpu0WOLtMYRP2YwRlfLZeYXgL2kRguYmYsJSqRXiib45gGIaLjZRHQjW+DcQ1VcJLCeGxxlkJaUmB6g0AaNkaeCco5Gf6VPaLzsl4Grb0Za+qJWEoSS2i4avWBSUFO0o4gbMisv0C9V76lr+Fg355FapYCriDtkx1KVkJA+8aAjfe0qDD79/lUeHdDTNBNBJqN1qjPb7TCk8n2mmNdwFcsi1HWjCMyKla93ekjJuXF/XVtV0baXbR3heQVKKwf3Sd6XzpeqgNgAiGiV7kPM1VOlpT7f03wk99y/a6KmYPcYcJprL0TN18RWe3Mg+2peJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726172; c=relaxed/relaxed;
	bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gzks76YzHf797gNzXyk9YOCCL55UW7bc3BEcQRDmA5B+ED++8zm7KK9QOVjol9D84qRTVjcpAZZnA9JhmRldrRag2gu4f9ulu893AsGj7F/dr8FGGRr5WKe/w+ePGxvhMTwhpPbsPgchGtlTsuPtS3cZCmivIFX/fVo5cq4N5lYH8LrJJMwBjBBsYqvsoksAD8jny9Cdx4iTMd2KOVk9gUO9xVJz8P9jaUwAKy3zxC0WNk+PFQdKmhV1vF6Z1tn27Q7aa/U4w5mmWmkxmqCgqBs5fhg0MAjwAQhVpp1bUf2u683S64ylp0TXiA4eNdI+J1DboVmh+d53tSOmiR34ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TJV4dgAM; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a9iO113T; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TJV4dgAM;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a9iO113T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphCc0QL1z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:42:51 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8OYwe2349380
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=; b=TJV4dgAMWU/+8Fge
	LhekPmtkirGo2G1WGvWAssawORz+6M0mrlwHcIibOxpoZCVMq+2L7WT6vrJ9+1et
	EP8eV2W8OJx5qateDGni14/OqBOYH7A86vpDd5IN6J3SRx9H1H2Ka4oiJotKHAPq
	UHeT1r9ZDTLYFb8KRJjvJEQ3OOpHEJF4nQGXqoQ/kB6S4SqDPjL79pjN778T4gLz
	s2qvP9JtSlDZ/h4hSLUHXvMk1gOmOOrn5XCfm5kFQ5zhYJx8JhGoEVAAupN+uhcK
	xk6Zt9kFHNw+DCE5JAV4bCQIY3aH7alIM6f4eZ45FgXVRRBjfW08arsQJIKjxk5l
	5HftKA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s07f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9203d077d77so557616085a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724419; x=1783329219; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=a9iO113TxvGX/qYDbXTKjayRotSv8I/IVPaPXiykWnrdaoW4QrbaHuqTNNDPYbyUwE
         xsglk1E+8W0ZvWScwKQmgWJehlFuW8828B0GIqCtCI6Geh1pSjLRmnAj5ZM0nCevIofZ
         7KVMIInJOabkt9fdlE8m8xcBtsoPwj9tXk/9rDgNfM6+9LpUrUGmtaBp1b7PJ6V+9Ykj
         O1DK1HKQq9YxrjRIjX1nuFvyk5n63axWQWp4On610/Mput+8McO1boV7pw0Y+CcW4O/g
         VUvf07T1a0a0qH5RuegaRxcIQ2SI/58+FEV7q2qoSc39S5d/cEVTLx6v50mu9e+dIsc5
         qceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724419; x=1783329219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=ONNN1mEHwaToqNOSwyjSlY5d0xsl5VNa/Uc4n/YBMDZiKuSam6c/fC+jDPTdxQqLL5
         wBMN5QhcHx28jCPPsYP8EDoRvGBHl4Qx/I48INho1EYwJ1AtF0IdXQYIIr4zZpqLz5Rw
         gtSaUdcAprkK0BPUCfu3M3LXrOvlQW9ZgBJ7GJ5VJzsYIfdDLr0/hk+ndLNiDIODIOJh
         idhoINd9CrYc3ikM0GyjQZmD4+79oGweBMAFT6VJqcY/4yPmyexslKYDOtAzCoW4AFp9
         lVfSvic8uN5F+CF0fiq6mtjQkJNMXUjMahlEVyzuWzOIh09g56F0t9da8gWdEcMBi+dk
         FHBw==
X-Forwarded-Encrypted: i=1; AFNElJ9hp+CFJmjyKOl8PUOZHegK1A3Wbz/4SbslK+ApYtx2kgwtbrAgEDuZCMfNkjCUArSfVSm8ImYbIfX9F0I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwgRCoUkOGxnkGpAme1tZ1NodHBDppAM71i6U4UmLM7r9RZ1gGh
	poBWkv92SkkNGOX3voRFbbeXVhLHH/stV9zkIjv7VBL4uia0EUT6KuqHI9dPx3vy+sFMb47g2IU
	6vtL3/8/g2dnUVFdXVENRFqSRtvTSvmxUn4WOntZk7YUZiBAVG91COnmIvynIs1RJHLlu
X-Gm-Gg: AfdE7cnAF0FudkJmgNlF8wvxNIjq4SIbYlOwfiy4Q5nHvziTV0lTuf7p/sc8b0LRhuO
	3H1iblBUJNLrdnJtLQsUiUgw+uZ+4O0p+t2V805GCUuEup2FT47vR852LzKuCPwoy9KYpG5GZwi
	a1kxJRAydrjNpuCE7UWrAqJHCXXHdR2jENTLgalWVejgjksIPem+6Dn0bThQYIv4UPagxJlYHVh
	P7JOq1t0MgiANszj4Bsr8njIQgsp/2wfB6hc5ysr+PVyBZlcptndJpApx0NZ5x/FSh3HnUbVqKG
	hwXQYPSsBcJB3kg9THnmOTLtfGnvK5CRZBzfuOvz0Lzgdra6RaHzFnFkfnFwNPi6lidBl5huD2C
	RGuS7It/wMcG2jYIiJiFq5JGjcerPXMfM0hg1fj8y
X-Received: by 2002:a05:620a:880c:b0:92e:5444:9274 with SMTP id af79cd13be357-92e54449803mr246445685a.30.1782724419137;
        Mon, 29 Jun 2026 02:13:39 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:92e:5444:9274 with SMTP id af79cd13be357-92e54449803mr246436685a.30.1782724418509;
        Mon, 29 Jun 2026 02:13:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:36 +0200
Subject: [PATCH v2 13/19] net: mv643xx: use platform_device_set_of_node()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-13-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+Q36/R3+axSk26qNg0RKgcggtmrfBcF0QjetixEKu48=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcS4h2j1YriB7udV3KPdGB1WgZYJtyXF3EwY
 kWYyj6tBQOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EgAKCRAFnS7L/zaE
 w4OMEACpb+VV0xnCo9JBstslWcFSexsJONNn93JsC45mbPVtpAmKkjbrIEiewVFro99EPr3WYy1
 qgyQx0sGC5N8MjJ416HOMzRJxcjEIzd1oDsayga3Hm5jHr3aPET6ovOL2D8pPxKjEWcqcAVrZvK
 sxr4xUzdhk0cBmeaI05gXB2y/pbRlPvE8rcWRYyss8ohjJPNNnVQcjxZUSorQq16LSOFp5CGHPu
 EYwMXOaY7DoYklLTUUSFnqS46yyTgmmlNf7GYefxWF76TS2QcYDOcONjbhH+cs33Alsh6WdkAhI
 1K5Et3oS4k+uV8IeF/MJP+031ZUNWKaS0LSCqyXyYU8d9D6pA1XfEJMd+MrHJalMen+AoRuciDO
 JodmffqqSe8Ht3GT2UM1iwvhKz4qrca+6jtr7gVmieZA9R4w8XoFLLCHP8A1JagcJovYVca3af6
 hJWsCx4YQCUOk15HJeq1vMOPGj1iTQE7ynFI9+KPaPZiW54aTa7nl2ImLTSZGW4d3BWeU7MoWnH
 Qn0jHvQeWz9yhbmxxL7RbsInTMhP0hCO4CsGeuoX+JXUEshiZbxUWBo4YK/bz49AfsewLMLFERh
 N6DyGeSUtUzgNCVW6knWh/9+tzdIqic3hzgHEIXxCBODPiU/grBsnpnpOqfS4ToKqOS91Tkjrms
 2/CqPYQ9mTIKGDw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXxvkWCcBFMnKG
 vX9thv31lgoyAHI+vPqAm5LByHEAM2GMgJrxeUQYfZWn4VyQiKRxym3yXp3KKwvPY7/bo/vCKp0
 ED9GFa1pz5cj8yxOYnvE6b5+xE0dCFk=
X-Proofpoint-ORIG-GUID: w-vbw3nzmWRqnRuhHmRQVEcRCCve2GzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX6ccAiO+vcF3a
 Y7+b+bRzi5abs8F6Ey0a5CxD6OY5eszldVkLEKCM7n+cNOilorwpPbUVqmSaiqkfm+COrCyeHsz
 O+HHj5LXOx+BDO9ELO1fKdDxJ+zxPD3cBeTLGuEXLgWmsDyOaDmR9kDzg2acsiZXETtXWNmyRa2
 tNxsbl4vPiHHjlkwOZa0cvaPc4I+j5wtgJeNaXlPWlxMDjECryPn0J+oLbL+TSSpRRNPwtnp0oe
 8R/kyMINyYTJAufFHueticMqCakliFxtDmrDdF1JnODfB4uyHRdTgqQaz32JGlZngA/E6tkYMEe
 Y+vqge9EiOoE4akTTF5Hc1qDyujDQuztUKl8lq9pz8WSNyJ7LeIwprcEq0YAPlXo7RdVcdePXYF
 FTCXoOYopBgyIP4rNPCEud5Wncwx9Hg+sZhk+hsEmQUpUMj5AKH8vVVvihGZDw4VgBOOG5yAVDY
 u+wf7baRG4jHH0DRX2g==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423744 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=deS-VIKRvcGxR6069T0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: w-vbw3nzmWRqnRuhHmRQVEcRCCve2GzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1881583be5ce2e972fceb14c2b8348280c49ad1d..9caa1e47c174c9d7a161b7f2e2ee12a829b813d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = of_node_get(pnp);
+	platform_device_set_of_node(ppdev, pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


