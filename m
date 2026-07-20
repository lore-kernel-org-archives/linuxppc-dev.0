Return-Path: <linuxppc-dev+bounces-24456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A7BC4451B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:26:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ZrK17Stz2yYf;
	Mon, 20 Jul 2026 19:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539553;
	cv=none; b=RpBNVYibGdmiu8UJeAkjBp1D8DSmG86V8zA1jQR3HdTBe1kj//LkeOZEvAVc+G7v35fNSEDaV2XOnuyfmb0hSrYOssHvg8hgWUpGI4x+/V5SjEt50qPXsyhbyxvjHBxKmyU8HhPYmafSsgHxksEOynXV8lrXjbXfsKEWil/3a3jENMqJBE6AJRS4ZzKR84WE34/8E4yTAazg5X33tqXL8U0kS5StdiUu6T7zJ+2bJv1MGFK0yCgEdj7VcgdKNU22qIGFw3FR8ibPWdsErPke++GHiFP5Ogfz4iSXcSrpMemN2TLfHfdGEeimACERx32VH5Z6fDjLIs+m4wbBDN+k4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539553; c=relaxed/relaxed;
	bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xa2Voy8q8eAizb92rDucVeK3lQa/eYhvHMf9i+mdzUhdltpbfziV2bulDKnB5yLlKGP534mCsCqjsf3ldDcukEzok/sVMxHLCuuOJnjItooAHOCYeMrjm2WljQ1F4oEgqocQdnvjvQj+H9EgZCjbLlrVErsRg97K4e15ckNZwjkJXeLD6C5sgPXFj8tLKT1G40mO3hjEjhhD1sq9cnOKfziKvSuD7lAVDnYjmsPGfbxnshSKka7dIWB50Uucer564MPU7YJnBCc5464RQlBYvVYa5yvRdz+bfsI8m6CxFDEh6M2Xq9drTWynmx3Gq9l6KwEsu3RJVeL2tNsoWY87jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KlqIfYj2; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BWhXzLEg; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KlqIfYj2;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BWhXzLEg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ZrJ386Mz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:52 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RVGd1420185
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=; b=KlqIfYj24yaFf79w
	7Rebwfq6wOB8LJIJfcOSwVzj8iaykOD+BlPcDZSb0cBdWQ/OJ8g/3RUKCH8I84dF
	bTklcwnNbIC8LgFDvh2Zd41sQa4Z4qY1zfhH5zztNgAHUzbG2j33ECwyTCj4sYeg
	2LdXdFfBk8SiLKdVSnwAmEnDPSHtSk4ZVYbojPcQcNWXIcZypczqSyWi9G+LaMkX
	aZkg1tjB1QO21JwFUq0BmbAHIvd8q/a4xCzpwESVMJTdxYAw7vYZo0Rqn+oMRnt6
	2a0leS5KgupFo3792wHUl9yNhKjib47ri1ajCPMMrb4qrUNfn4M+W+Y9eJkYXbyl
	lfcfHQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7wjsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso144483811cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539550; x=1785144350; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
        b=BWhXzLEglNI9EYxHZ3TnX0d5Bf3jm2ueI1tAdgEj3CWUBrw1G3uUdnnkVGLAL/Aexv
         HlBawuQJZNM+1jMY6ALX0eHaNVP/PetvJHfXvBr0SGoNVoHmH4Cdie5JU3LOJn1wEtEh
         vdh3wfq4tUxtAAs9lwio1OYyszs1KTm8NTO6iSStXr9cJ6uQ6Ueqdl+sU1t3PENfGX/Y
         iLty80VLAs/DT173O6RiBsRFwINryUVSq6LuR6zpzl645rWiRUjFW2u9FWISi2O1ysqE
         ZF9x+VhR7PO8M2uyoS1K7GGPIFu2alaHNLmtOlg+5ibAddZ39P1HJTky29Y4CQDvD/Qm
         w+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539550; x=1785144350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
        b=rhu5tLkzdGNKnfSwNR3OSkvOc7ZdzRRVOZGjXozq7O1ai7BRBNYsM3MSGV5H+a3mre
         BJE0/YkHUqKFK1ENt9VswoXPFL9kcbSBQMbTI9sIgO5EwPbuCspLA8a2txHJdi8n13A6
         SvlUo7mxVRu6yHxLZMC7+tqaytUOvKrmKTuWaLgSOVwH9sO9l+6J6wiWbBI7XtNMMSR9
         HGR184+PVeVs5FH4ldbw8gCmGZJVLmPVqKWW9TR9VihtvI14K3A2gpZBqqqEBNOCIIGE
         XkwLAxlHawDWsO/C9rYSdlyHc8PduPsr0lu1vAQqBucc8gb86d84L8Pm/P9MKYMzV2o4
         hV5A==
X-Forwarded-Encrypted: i=1; AHgh+RoKckZ16aPYEg2TLY4USsAPCSOUOOViNsEVhAMpOC2SZ+aEBuuSg9VTg8HM18BwuvGktvLPfFONYuXgzgM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMVkdnGsuTExJNZK9P44xBRememHgbgY4md9GS1ynWX9iaFtQ2
	iBd+5Vz1f1xehalroIyS7AD746VT7FqI9oCFeceBe6+Dj2CYb9QaKhShuntPKLL4MxzfzjoK5Qr
	7vMtn6geiWGprwewG5R6DrW04xFgoV8CO8N/9bZXegHlsuDei4KkKi5WcwYgTNU9/yTsv
X-Gm-Gg: AfdE7cnV3i2JrHW+SinQS+zvq3rSGSRydMYlmLMeMV+J+hJSjBZcUCWmQz2xBapc7Pw
	eCg9mm56qByPUJ7k4Lkc52L+CoY2HD77hM5zgrxH+fqLuXW7iC9mHGScfFAyEzjowWYscMVnTtz
	VwOouEXp5b8Q/VMsnZgAbsEAehCgAI5Y5jmcV3S0yThVFvW1sICFYJQ+8ridADDsYQ0/30TmgAz
	5H5EBU0qMXR+CLKdfymGFz1IzBUln3L2TAEZAXlsN3l963wMrPsYz77co6aU4H3C0xxBKc3WAE5
	JwqSbO3xMiNiclF1r+qt9IqjUNssbvCYHGVr4VEf6C3UKXgzufv4qgnFXPxx0jcqo6PNeJyK81Z
	jl4ua/PSsMVHsy/9Sqt+yqlpaAZuIvw==
X-Received: by 2002:ac8:7fd5:0:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-5213e886569mr118276631cf.59.1784539549613;
        Mon, 20 Jul 2026 02:25:49 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-5213e886569mr118276431cf.59.1784539549156;
        Mon, 20 Jul 2026 02:25:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:54 +0200
Subject: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xqsPX1hXJ5p8S4DkE8vtCmD8bNryEUzUedAtz3x4vb8=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGpd6X+h/ifYFhQyBjNRAMZp3sKfs2dOQQAGWOSJWeEWTFT5/
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqXel/AAoJEAWdLsv/NoTDaPwP/RCK
 7Pwxf8vZOh5uaFiaUylNW9sFBv0DTkc12XbVDBYvSH/UfZrhZNMpdObQiVZ0SMsBjpcFYp/1AZB
 bv/F5eIASG2zBoN057E5VLLCsx82l6r/JbeVQgw5sCPYBDfaFMn5uPaQXGHdfCtVzj107jr0atg
 MpQOTuIilyBFr3uTKuOU7pU31UrvyYd/WaJ9iIF6yscrWH/v4Qs1NgyuD5SXNzXQy3CdXMuZWPw
 OfBtGBf6WPhpJYK8SJ8cxHXNTC3mp02VZHt8QJoXG+UcIywc7z9x2aIXBI2wqX000BykBPNlSWC
 mY3n3CcQ2YJPZstI6l/D5a5Ag1tvZyjFn23kZX27b2b+0vfEWAo3XxJs4LD96b8ru1CihZM4DNr
 J7ePsCpJxshz8tCUh/g8vlubXLhRCQuMOCve6JfkiVWeFuCbbrtw/uB+qI4BX6ItSyElc3Pkd9A
 zqucZ40Ol3KJyC0Hpqxv0yAHDnt73BHlxnotHkeJUkco+UU572qEZp2P/tHBng23kf7VdgJKzfM
 0Vmj+kL6FAYBqwOZUqDULhVWTcaepaa6iM5W9ZkRvjLWWBLCdYGzVZKBmU+3X/B1u1vnRuKOPdc
 vNkkEAD4/hll03aBOJFx5J4KIfwjuuLHfYesAeoCPVMULek6L0iDo1ICKKxFU2N/ZGUpG50fB24
 46Qsg
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX4xr/EFPe7rG0
 svIErx71P+Lhibb9wL2yR96GS7JEu8E25X2Xv6V4ycPtPk9yxfnzBcaGIAA/neHrhbXAeAxqyUh
 qm1hVx9mVNVTjH10B41L/uft8z5dlNCxo5yIeGaWVIbuGxOztOYp70Y4YGwpTxhxivFE9Buoi2T
 laZY2vcMsiQptVCTBbDBKQorpl6v+zv43dv8QCrEOGGceBqWctIt+B+yGrjqgUB8r6Y9R5+ybAE
 WEHkCosc0qCmCcg3W8BGwsRVAmqov/JoaQOMJMw3SF4ZNQtOQroLJJZ/7dWkLDiIuu/fhjKw0iy
 b8fDA37F8nbL70Ckjcw9/aPe3uo/0NIPmhHs10ZK0P8g22DLDYKRADvwQCEkAgKzTDS7H3gcZAA
 E/tIbbvy7zZL10Hf0eYpCuAReNj8n9+xSWfmH/ZjqxcVVIz6mMbUdxz39VFvgI7OFM8Pq0L8jFr
 hlphXhQT1SrTANK942w==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5de99e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Ue-CkOehRSWfgkZZKZIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: YxZ4xIZ7VTIrIzONzdGvSYr6vj6dex4C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXzeRJUMZnhFdl
 QUFVlwPWckd5X7jX0MoNXuqs2RPisJ43xN6+9/rt9uOTUCU246pyEhnipnJQ0uFE+WkLHgUxQAM
 b/FksZo54b58vJKFRM2FGTV/dpAObu8=
X-Proofpoint-GUID: YxZ4xIZ7VTIrIzONzdGvSYr6vj6dex4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	platform_device_set_of_node(ppdev, pnp);
+	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


