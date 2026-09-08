Return-Path: <linuxppc-dev+bounces-26781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF80FC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:28:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfJWt2Nmcz2y8G;
	Tue, 08 Sep 2026 19:28:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788859690;
	cv=none; b=jqRC/HPOLgVjHxV5f/XBnwiID+jZ6p3WCt03shIZ6MkfjIYPTcpYEgnvKb8yIgZ3bgJX6cQ5kSAVmHS/qrEaJuRCMcTiKfGuPA5DmPDfrzJ8XPIs3fNan4rOGfSv+cL29H02DJ61Sgq7IjOR3O1aQ3KK75Q8WUgCHsH1YLBgErDFXnWLf4Dtbg89VTLxqm6PCCsgEIgZyC8ai+6C5kkD04lw348f2eVFEx03vIyVKdhP0337E77ZQfbLyP4Oej3UPk+8n3IBVXOiMO3rIigMHRXLEFkT1ABjhh9YRFQzLcwhW5X1Goq0VbEZXgJTLf8sY7K/wS9wgSnTVsRxUXSmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788859690; c=relaxed/relaxed;
	bh=xQ5AnXapuDmwQthGbSeXpdB6HyiT025OD5a5rgt3h+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xm9K7+gRD66/EtpojCXfRhsTyxZB9h//bNxFq+sVsN4zq8X+/xMU1C2s8hS4YInLVj2kWDiH3GMBw66xpjyxsmr5tFvO27oVWBqHuIBBcpnx8kCv+xf0Kw6+dws/njeROzqcjjmUZFm0ObkxtI8Aq0SprDpPSzESkAQMWtk6tqOvqjDU34qd75HDmUhWBQpbfdLCZqL3qG1LhOxF08cLcVz31UUlnRXBlinqkjd38gx5+G93pDUkR22Emsa6PVBxVPD5vHXqmt6thn5mBDJgc2C8swNOUXwSV6n7ufGvgbUeESaG8FuYZQ0xJ1fXlorOrORiWIUpIQKkwlLSY0H4bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IDuIpTTD; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gWbXIyFK; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IDuIpTTD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gWbXIyFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfJWr4dxDz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:28:07 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Lc9k3299064
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2026 09:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xQ5AnXapuDmwQthGbSeXpd
	B6HyiT025OD5a5rgt3h+I=; b=IDuIpTTDT2iBrJo3NF3irTMMKpCHE7YD8YHlr5
	6VUacu/rh+6fudiycQJzvjxhR7mjrCAcHYxPBsv0NlinrNFcB/j9W2Dbhbe3wHuv
	AYpPRmRI53IGMkMe1So+1y4u1/B0nq8kX1ZWBfhijsU4WqeTKyQA5v3g86yfmg4G
	1NVH4DSX6ybRnsg0WPTID3ijy7cTqLNLZBTPsfahWvsyrUb8PsTpyarRObrrA7WT
	sU3hQ2g9sury0eAUYSsluQQa1jpAw0L1z9m6jWpFHBDHuUGniXsHKl2NY6JmrISH
	5TovdCVEjbmRElSYF8DryQi8QRHAKUw+mQVTOxVjLysj4i2Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p96xd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 09:28:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9104c2ce026so75954776d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788859684; x=1789464484; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xQ5AnXapuDmwQthGbSeXpdB6HyiT025OD5a5rgt3h+I=;
        b=gWbXIyFKkEewLrb4Vqz+XvdDfDX64nchR9s51jkMn7AZnRE7NZwDdClhLy8m9wQSuZ
         Pgx+bD/VA63ltMS7Mmdl1LunB+poaXZ6WP/qodDr+NLgFBFOVXc5f/Qo8Ug72YIVn8kV
         CD7skppptvmrFsMnEF4SUWbl4eJFIgDW+pQUEuxZ3MuZo75VBhYJm2zycQm4ptEdGwr/
         xpEfgTmSWZwGR+RbgVX7w5WlX7roCLDYAZ6N5xcHGopEIusQA3D8tRb7r8hstdfL/jqn
         JOcLGF/B8e7tuADMofyUGl22Dvoe0DAFABNsTlVnPAqnHZpqLoEiQB2tftSMwYSEWP67
         tQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859684; x=1789464484;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xQ5AnXapuDmwQthGbSeXpdB6HyiT025OD5a5rgt3h+I=;
        b=LeIXPFZeC8YumV7Qr6RW1rfeTO3zRM+RMpOJMPCO02tdYa8LvBIxJP7ssY/fyfxGeR
         olu0+tyys7N7QsKfy8SttlmuSiiUjYLCQZcXdQAZggqKM3UV5NRbI7SB6Uvf06fIPntQ
         8r1BYrT+BJrykXGl2rRBLffnZ1jBl2EyWlK0UKrS5Pwb0eNbKMmd8R0FbnfLkTJ0PY68
         WiJQJ/SbalrXX/fOdMtihgDRkP5Ndi3DKPsTqh81uasswINNJTtqnYPE2T228JxmCIgo
         E8bb0iN6wqTjdl1vNlt7X7ZRFH4GA+mlhikQcKkolY72qQqkso0k/X930nXaIf0hkHAH
         Pmbg==
X-Gm-Message-State: AFuF++m9jK3H6Bgvug5yg+mo4dtzUXlxxBFInhWDSky7/Mba/oORd5oa
	yr9aWnjsk9kKY+U0WrFhP6Dh2spIlLsJdyRAhZJruQAxGKG7kzqbWTFvXGID8+5aQFnsn4Innvo
	AAquncrzKCkBU4AQusoHs0EKuXqvPa0DQDLp8uLVcHhljKCdwPuVrfH8JJi4/WKZOnwzy
X-Gm-Gg: AYBFou26TGTvOBUR+xL/OMeRcuS5tsm+ghO2T/t324TFHNg1ZD+5X56na4PaJiwWxpk
	boJHvxrxfT9npJjZuhlRBSt4H8ezd0Ot3rh2pZ95sN0abNL7SrPxjiy52oEQs/pJEiGUhACfNxS
	jUwaXgk8HDSqd5DCbEHs5mb9d1mlV3Ny9L6p+dMu1LaFraVF09sGSGfIBPg8lN6FHKGjoJlAL9n
	+GOqtm7fttKG1mR+Ho2L02DSjxG9KZ3dKJddgNe1n0RnS0Cf4vdhnfKi8tXT+/bv5KKqZoCFr2r
	YyA3/tn0EXM+/1FF6IO1ruxZv7+WQSKkOkrArur1h/dbyREP5YTh8VfbdreY+2leVumSZaDYrCk
	YTrU27UdRVLRTNRJJIus77yZaXMC/
X-Received: by 2002:a05:620a:4875:b0:936:8840:427f with SMTP id af79cd13be357-93980328a11mr2689596185a.4.1788859683649;
        Tue, 08 Sep 2026 02:28:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4875:b0:936:8840:427f with SMTP id af79cd13be357-93980328a11mr2689592385a.4.1788859683082;
        Tue, 08 Sep 2026 02:28:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a2:f118:df09:fe51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm349714825e9.11.2026.09.08.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:28:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 11:27:46 +0200
Subject: [PATCH] soc: fsl: qe: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
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
Message-Id: <20260908-usb-fhci-drop-gpio-nonexclusive-v1-1-8e405dc67874@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABHVn2oC/x3NwQqDMAyA4VeRnBeIbs66VxEPLkYNSFsaKoL47
 is7fpf/v8AkqRh8qguSHGoafEH9qIC3ya+COhdDQ82beuow2xeXjRXnFCKuUQP64OXkPZsegq1
 7ccuO3PQkKJWYZNHzfxjG+/4B8MoRJHEAAAA=
X-Change-ID: 20260907-usb-fhci-drop-gpio-nonexclusive-584c5c808a30
To: Qiang Zhao <qiang.zhao@nxp.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5039;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=e978EXWIA4sXTr97huLawpOgX8082ymb9e+2dGNjw5M=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqn9UYmHVJfDtsLbAHMyEmW5VQCD+WP9drTn2DY
 AcGBHo39UOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCap/VGAAKCRAFnS7L/zaE
 w9tfD/9kbyaVWzykBOKPu+CBlGh1AiRvifpabM2JsEGENIXivb7FefAWZOoT8QEnHrIIZObwq/5
 fpsbf7Dl0zV754tbqWvoUKs9j76lidy1OGe3AG2WuIt8BLKXwFOaqrBqi9Qtlwa6AKBm6FoIbQM
 H9rEBskiyvJkNu++hVDq3kwTGyDH2BlGnwyIMAew6esPJoS1KzhrzlSnTNvfJfdRzdWJjNsWhnp
 7pljZKS/GU0mATdh4pXPZlv1eCcFFj9xypUVwRyd6FyhyGtf13ZM+qGjwYZVWCaU2GQiYkQcSdC
 arBhhDHyFJWexzeZXvE8ndOYT7q6Z7wwUXvDcebEN1aMmcsilnlD4jGM2etJ45XbskWjFwtAxlD
 gvfTNnbmg9udfGHeWstwt2kt4oh2CDJznp4xuMn+p+kQNlyrn7VdLM1nKaT724m0Rj2Wa/lTZyc
 DzeaRRCCmOq1nuRhJp3s/SWWvGYDNdKSUZyuCBKd1DrxYptp9xMrdHG7vNBw3IEnTTTtoGKCxdh
 sklyMapEBIVXc2rdJJtRIF7fXgRp5VqzW8MaQm3D2ocB370fZKXncEYzc7/V69mDPZErQbn5kPi
 6sTDiZ/jY/ONBjNPql+1Hm517jQrhl7H3EZdNMmxWIwnAqdVZ5iEUjSaTuq6XQmRHIAxzpJiINP
 7H96kj5/CoBUaMA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: ZMEy__xfKkdG3uJme_30Ts4RVFztwii3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5OSBTYWx0ZWRfX+BgdE9t9OY/6
 cz9nKQ0UvEP7Fla4P8Y4k86p0ObDO7Jfqy9JbrkwGq+Vbsy9ec85jL6lTOcxByCA4JGmuOnFlAd
 pejHBaRF4XX/GHxhLm98kITBeGagA4E=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9fd524 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=buOPlMvk26ltgJ9tiNoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: ZMEy__xfKkdG3uJme_30Ts4RVFztwii3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5OSBTYWx0ZWRfX7d5PxFuZtG0a
 pkOOXQHDLQEwnxdG7SKjZx0BZ22NkJGB3DpUUo/Hi9/6oEqmhbORkeZwwZlYm9mu0cBsm2MI3dA
 PlZR6U35TYJbrrJ7NZcc3EeE2XDetbt0HLYJ8YjAGx4wmRUCRsNQA1yHng9e7B6nMWZvk1wk/sa
 9DfnxPDPRbfqHURq6I6wdl3ys04CGLcB8yDMPaMbpScI+Maod6HnzMEpBavqKZwnFqq8g7r2j6O
 sRhJa5mB9bmCvXlghzmWMIHOVItPnmHSEFqqf/C5PrYhdGzbHW6KCT2AJ1iyi38aqZiuqna5P9B
 ye+7v5fzcXAdMoBROng6jKq5edp1qew+z0vcfCD1EfXez6MWmgXvLVRkSJRFY5x5EUsv+QhIcns
 bL8OhP2inyPm3hOSd7jQlho7Kb7LXGGn+M2vRMLPoVKQiMCg04+Q+qE0xPVXr7Kzrk+FlHjRgMo
 KVFy5aENzVcKRe/GxQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080099

The GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for gpiod_get() is deprecated. For
actually shared GPIOs, it should be replaced by using the functionality
provided by gpio-shared-proxy. The Freescale QUICC Engine GPIO driver
uses it as a workaround to access the GPIO descriptor already requested
by the caller of qe_pin_request() in order to access the private GPIO
chip data.

As the existing comment itself states, the user already requested this
GPIO and the only user in tree is the FHCI USB driver which does in fact
request it, we can safely modify the function to take the *exclusive*
GPIO descriptor as argument and stop using the deprecated flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/soc/fsl/qe/gpio.c   | 29 +++++++----------------------
 drivers/usb/host/fhci-hcd.c |  2 +-
 include/soc/fsl/qe/qe.h     |  6 ++++--
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 5cd59cfbf22fa68d39ad00b8f73ad389ac8860a3..5a3a1d5df669b1e0a084a0ebfd2aef91e15f126e 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -196,18 +196,17 @@ struct qe_pin {
 /**
  * qe_pin_request - Request a QE pin
  * @dev:	device to get the pin from
- * @index:	index of the pin in the device tree
+ * @gpiod:	GPIO descriptor associated with this pin
  * Context:	non-atomic
  *
  * This function return qe_pin so that you could use it with the rest of
  * the QE Pin Multiplexing API.
  */
-struct qe_pin *qe_pin_request(struct device *dev, int index)
+struct qe_pin *qe_pin_request(struct device *dev, struct gpio_desc *gpiod)
 {
+	struct gpio_device *gdev;
 	struct qe_pin *qe_pin;
 	struct gpio_chip *gc;
-	struct gpio_desc *gpiod;
-	int gpio_num;
 	int err;
 
 	qe_pin = kzalloc_obj(*qe_pin);
@@ -216,34 +215,20 @@ struct qe_pin *qe_pin_request(struct device *dev, int index)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/*
-	 * Request gpio as nonexclusive as it was likely reserved by the
-	 * caller, and we are not planning on controlling it, we only need
-	 * the descriptor to the to the gpio chip structure.
-	 */
-	gpiod = gpiod_get_index(dev, NULL, index,
-			        GPIOD_ASIS | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-	err = PTR_ERR_OR_ZERO(gpiod);
-	if (err)
-		goto err0;
-
-	gc = gpiod_to_chip(gpiod);
-	gpio_num = desc_to_gpio(gpiod);
-	/* We no longer need this descriptor */
-	gpiod_put(gpiod);
-
-	if (WARN_ON(!gc)) {
+	gdev = gpiod_to_gpio_device(gpiod);
+	if (WARN_ON(!gdev)) {
 		err = -ENODEV;
 		goto err0;
 	}
 
+	gc = gpio_device_get_chip(gdev);
 	qe_pin->controller = gpiochip_get_data(gc);
 	/*
 	 * FIXME: this gets the local offset on the gpio_chip so that the driver
 	 * can manipulate pin control settings through its custom API. The real
 	 * solution is to create a real pin control driver for this.
 	 */
-	qe_pin->num = gpio_num - gc->base;
+	qe_pin->num = desc_to_gpio(gpiod) - gc->base;
 
 	if (!fwnode_device_is_compatible(gc->fwnode, "fsl,mpc8323-qe-pario-bank")) {
 		dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 71e785f445a30e116a9cb421d417deaf24389174..d572f0c1dffaf3a40b2fe4326ba8ab021fefb986 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -643,7 +643,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
 	}
 
 	for (j = 0; j < NUM_PINS; j++) {
-		fhci->pins[j] = qe_pin_request(dev, j);
+		fhci->pins[j] = qe_pin_request(dev, fhci->gpiods[j]);
 		if (IS_ERR(fhci->pins[j])) {
 			ret = PTR_ERR(fhci->pins[j]);
 			dev_err(dev, "can't get pin %d: %d\n", j, ret);
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 8f967d15e479792219333264c2a463d26e5edae9..7f0e4165c3b0cafdf401be20862aa1bf28047102 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 
 struct device;
+struct gpio_desc;
 
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
 #define QE_NUM_OF_BRGS	16
@@ -193,12 +194,13 @@ static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
  */
 struct qe_pin;
 #ifdef CONFIG_QE_GPIO
-extern struct qe_pin *qe_pin_request(struct device *dev, int index);
+extern struct qe_pin *qe_pin_request(struct device *dev, struct gpio_desc *gpiod);
 extern void qe_pin_free(struct qe_pin *qe_pin);
 extern void qe_pin_set_gpio(struct qe_pin *qe_pin);
 extern void qe_pin_set_dedicated(struct qe_pin *pin);
 #else
-static inline struct qe_pin *qe_pin_request(struct device *dev, int index)
+static inline struct qe_pin *
+qe_pin_request(struct device *dev, struct gpio_desc *gpiod)
 {
 	return ERR_PTR(-ENOSYS);
 }

---
base-commit: af5f12805e5cefa4fe68d6127c7e1fb78cd5535c
change-id: 20260907-usb-fhci-drop-gpio-nonexclusive-584c5c808a30

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


