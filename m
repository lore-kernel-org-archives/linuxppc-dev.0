Return-Path: <linuxppc-dev+bounces-21961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3812CD6E64
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVgll1J0xz2ybQ;
	Wed, 03 Jun 2026 18:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780475203;
	cv=none; b=Viw3gjy8AOxzvIgf6stEI709gqAmLyYcLIqE1oE3LDXojhGpnp/LwQp8xCLuqbQlCjGmySPjAPusf+XrBQBGpjsDpp1O9shL3Zjpn8lfLVKnKJ28xIVxWIm70wwNb2MlZ8AyOEXdQ5kj4a3q+U7dN6S/+Nmkw2bmHM8GEbqsGtwOnp0nc2iDI0jt67Xrj4L9Np2nYwlwvRBySsvi3AMk3SYaBlQug1F6TzuUM+guzt2lQFqQNgf372pnjT7YSKjdHJfr7MYOzc0aGo7hXcNY2XQ271V5BWqqFo6osBwQcn5zm8BQ1j5UTD+nzzOwWcFUqfJsniaPeK7Bvamdac2lEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780475203; c=relaxed/relaxed;
	bh=e7muuFyxXzcqXgmNJOoai7dMFzqfIvKUobcfRRnVGpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gYsQd9s7wviGigOdKCsVuJx0fMFsrEj09+939FlA4h4phUWqJg717xv2/uieN85hImLnLs48rHZr0wdMXVAAa9/c7mWl6kU/7CzkxoLtsh5I+X026bWWWLnqU+vQGofL/ESNk1lPPEzkAp+iTbgKN2o3OUxmweMq3Eev/QhpPzK4Tgqp2nM/sP6jGcKQ6lcfDWgH35ryIv0s8ZxTneb3Owv76kbuaXzNKkJG2HMMSM175R9pPHlYej4gdvTng2UFQl99jKjBq1DNgYmQ289ihybCjeUXtcmCjaB6Xb/ABpyjW+ztR9Ag6IkG+M/PMnNA1KVaqixVfj2hhRe8es3pTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QvFGzEIj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TGJoBhxw; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QvFGzEIj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TGJoBhxw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVglj5FFXz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 18:26:40 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RHgK2076090
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2026 08:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e7muuFyxXzcqXgmNJOoai7
	dMFzqfIvKUobcfRRnVGpI=; b=QvFGzEIjGuPGW6Bw5JOj4FXhVQLeJRWUVfzasG
	soo45BgOozeAPPusy3EdwWNSJG0AVFbbXR797Rb0x1qHMX5RZlxl3Z4lmHMP7vQK
	zLE9q+UsE1HZr3ha5I50tYVQWIwNbFwoGocHhIC59kJ5WG82bmselvDrCdeg/tg0
	vXOvc5gNV8mi4UtKpKI+OXwmC+3O8VExV/cPuUutR3WYMYo9pq2cKtP5TsWOMo4P
	2CnkqWQwErS5c24Hf/RMZ9+O76G1FO1FJ6PJNRLaPulfGfgoWSkDPyPKqLebx5R3
	+Mu9ogUsAQjppsUX27q0wMK6yxd2oaJlUv+IBWg/14z5mHGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev18hhw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 08:26:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5175a1e32e3so10111631cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780475196; x=1781079996; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7muuFyxXzcqXgmNJOoai7dMFzqfIvKUobcfRRnVGpI=;
        b=TGJoBhxwkTLPNKazi70ArJFqTJcjWC4apWceIOSZ/5/AhmPxTZBHQn3LaE+kV+jade
         DkvNN8NIt0hIgReybvx3sbNdKD66kcgw9ErjNBw9ZMExmw/FceIgYuE1xJG8MGIggSS/
         jB0fPAj/Pbtg/8nxIWlukCFN/IIssNQbZgYkvVAh4JUtU3wGpHrX8eiF7S999wpabiXS
         1vrKEsIZtjyKschsEUk3H9Zd7kNsLp92mDQblDeIa69YoqinoW6rfQzBLZBP22vo9HmU
         iYW0uk5DHNfohLufVudaLxCeWEovtawwojUjEIaHunsNrt40pzJhcg+fE+3chv1rquZe
         uQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780475196; x=1781079996;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7muuFyxXzcqXgmNJOoai7dMFzqfIvKUobcfRRnVGpI=;
        b=O89bdAdPUbuheM3+7jL7CTm3jXE7JXF/SUmLKzY62sjVb34mn4guzP+3vbk0FKlYgs
         LOzoBxBxvWDRaBwpqjasW7jwhnQt/n8wogmvnvQ1oazb/dJtzsTw7SZSIuD0gc6YjWOi
         bnpbbdCHCj4AlXRn549rlzNArWba48uLIeMjGV/IKG9oaXt431s6jGqLKpk+Guzdo8D1
         G3J27tloSNJJ+rHD0RXXY6Eam4pGmPT0+vYTWG+3J8rQUtBT4dAB8++VsNo/9Z4UbwPJ
         Qx0Omwq0551HWmgSm1HlWJpKh8J2rsqxV9twmUk412DfMcRnV0AE+FJBMqynWOcNe0Ce
         +YWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YpGDAU2kzG0p4ZGyoaIOG09Kh4KHvU6+s0UurDUGlXZ8a4WB06tA5d2OJzeJc+qfPaF5Od1mbUhdnLEE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7Pq6h3IttXsoC5/5uZ0C2Hmgh++ZS/auLFjflLAxYaTWXahG+
	plRjWcNJsEUxj1WLSCerxhhlGMzdmGlxoz9RSoZ5jz6/kDcNvyxVPWOmkOVbe/0pfRYUYylAjjG
	qXVasVXyg+VbbCIjohDHb+dWgh0QGd9RiltZMiNWjUaUL3/T5YTl7+4gSpkXIK2bWWUGn
X-Gm-Gg: Acq92OH+szWbTuP5F+cL/qhqJ6kqbgTs4hvPNi7t9oJUaib2MOvgC+Y4uKGNbTndCqM
	127tHl7pN3qnMhRkEZDWUTzS8fO4QJpgAW+jOIbMrOHODpiummfu9J9Mv2ESg94LH6EVgF4ywmJ
	e8rfcMRM0ghkA0GPh6YeDw816ma90Mf13tqi8zOb/sMSciNoukXO4lKe1/YrpfrRrtgMKjRVp2K
	Ttpr85BfeBVi/gz2gIGp8nWfZyGYZ+Wfp1DtbpZFghoA7ausH20RcyxASsHY9xdVCEKlljZ8yeP
	5903oaRccPXCN97ls9uiPlWgPrE/YkRdPVvwI4ZxSIBbEytcwXp1mjOeCkKsMa6OpcY1XKTbzF3
	OO8rjy698DqVPcyfvhwV0C6vlbKjKFcCEArM3GxCFaoQanfWNI/65JLdgSiw4gIYDhvh2nEtb2c
	CyJjE0mqfBG8E=
X-Received: by 2002:ac8:5511:0:b0:517:7188:c47a with SMTP id d75a77b69052e-51778606842mr26226501cf.2.1780475196237;
        Wed, 03 Jun 2026 01:26:36 -0700 (PDT)
X-Received: by 2002:ac8:5511:0:b0:517:7188:c47a with SMTP id d75a77b69052e-51778606842mr26226301cf.2.1780475195867;
        Wed, 03 Jun 2026 01:26:35 -0700 (PDT)
Received: from brgl-qcom.local (206.107.204.77.rev.sfr.net. [77.204.107.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20bacsm117036575e9.6.2026.06.03.01.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:26:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 10:26:26 +0200
Subject: [PATCH RFT] powerpc/8xx: implement get_direction() in cpm1
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
Message-Id: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADHlH2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNj3YL88tSigmRdi4oK3eSCXEPd9NQS3ZTMIl0zS4vk1LRUSyMzE3M
 loPaCotS0zAqw0dFKQW4hSrG1tQD1+bzfbwAAAA==
X-Change-ID: 20260603-powerpc-8xx-cpm1-get-dir-698cefe92647
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: brgl@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=eTMsESb02191VBWAM3gdYrq7DArj7WqJXG0UaTF3UHk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqH+U0cpm99RL77fqJl2Zh2p2iYRyx1qLUn9F/a
 uBbBTVY4QGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCah/lNAAKCRAFnS7L/zaE
 wzEmD/901JUDy822gDnXxa3+xDHSz3iK5cA2S+i8lULkT81mGB3JDvrpH0EJOp+0Yrm+2RGMomt
 g6z5jVjzpAjuEEzzHHdaVrHw3sLlEyzrEl3v2DL3kGIbb3pL1HiIqURTjYymsgqIXk8Y1a3NBck
 EVx2cyXnxLp9YYIP0dLn93e3kvpbyFfUiiZMM1ZuzJ1pm+paANFTrUKFysHHHHigTNB83AjrV42
 LPDm+g+5dHqDAQ3mSKo4D9MbFRH7yzRWk2rM1ca3HSWrjkcEEzey2ObShUvbAcRhoMfXOMK4MyQ
 mhoB1AOv79/5U6g3GzB3ymZkJ3fsi/hA1682MUoAwf70R+1SAY5zr66qqySdq6nVClnZqw4LiX2
 ib7fxfPgnqhsBhcy9njBDyv3A0n63qr8db9ZOhpHtD3uzzTQNCJsXz7q5l5vGNZroXC2i0WdjqL
 VNVCdYlYTNB3pv9i3Fe7HBdcUYxTIy5vkOVTjVNRGaF4Pd8LeUq41+TqkPChJEqO2q4xfR1dazk
 hjTj5dVZj1yXKvkmPnhdlWBDln+8oMb80vM97h1sUA1xEOGmqJdcq5LWyFnGrKDomR5Kd+FyHJw
 4pIcDNNvV4BkEfDbKSvTNfkJP9uLwFWQ4v4+LtzVb5wdAYCFi17kBhX9UPW4Of6PbC55fnVRaS+
 +OV1J0lYmYDbFvw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 5xv8lEb4gvXmUgjVOyFgq5MCWwF4lE3e
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a1fe53c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=KBhjw7w+/BNUhOyiMSe1Cw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IQRRjYDBaVz1tQnfht8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 5xv8lEb4gvXmUgjVOyFgq5MCWwF4lE3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA4MCBTYWx0ZWRfXzszaE5V3EldU
 d+Y0ld11C1qMhKF5akXPj6mxQgCKSHeC/OykqVkTGS+VQX8xF5KU5eE4b8XSnmYBfPOpHy2xc7c
 FtHAmQI7CuMPW7+yNdD/pd10aLdq36XPcOYFgPIZ1oo+DCnXBits4nay0yGLr5G4X3LlI/fbYwT
 3EeQuK9nw6XMKpizQSbE/VX6L/RVQ4txrt6E/HN6RAnlz0g+yPu4/6VgqiA7s39HBnP4ifBL9Eo
 TspVQ5u+N21y2qwpvi2c5XAQ7a+hgGq7Uq5Hr/pbKzOiThzzEgSPSBOXy/h6cclwsVluexOqf5c
 9GQ6MZZ+Og+CB1xkeaKGUxiEUQTXUWYrSvPOKLA3HAQL/AELS2GJAxkMdNeYsR/4u6/RNq74F/n
 5q1CoSBSZiUdu4KRDQBc6GYzZiJkGKD0nEbgjWfM0gnTTd26DpBZz1qDxgmsAygu+lh6vaI1Zsn
 Q+3htQRBlor++q5iDEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030080

The lack of get_direction() callbacks in this driver causes GPIOLIB to
emit a warning. Implement them for 16- and 32-bit variants.

Reported-by: Christophe Leroy <chleroy@kernel.org>
Closes: https://lore.kernel.org/all/63487206f6e5a93eaf9f41784317fe99d394312f.1780399750.git.chleroy@kernel.org/
Fixes: ec2cceadfae7 ("gpiolib: normalize the return value of gc->get() on behalf of buggy drivers")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Hi Christophe, please test if this works for you to silence the warning
from GPIO core.
---
 arch/powerpc/platforms/8xx/cpm1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index f00734f0590cf7c7382f808dce27373d9ff3d8bc..b31376bf6778802a7f6b6b499066846b6b1f61e9 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -472,6 +472,18 @@ static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	return 0;
 }
 
+static int cpm1_gpio16_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
+	u16 pin_mask = 1 << (15 - gpio);
+
+	if (in_be16(&iop->dir) & pin_mask)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
 int cpm1_gpiochip_add16(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
@@ -498,6 +510,7 @@ int cpm1_gpiochip_add16(struct device *dev)
 	gc->ngpio = 16;
 	gc->direction_input = cpm1_gpio16_dir_in;
 	gc->direction_output = cpm1_gpio16_dir_out;
+	gc->get_direction = cpm1_gpio16_get_direction;
 	gc->get = cpm1_gpio16_get;
 	gc->set = cpm1_gpio16_set;
 	gc->to_irq = cpm1_gpio16_to_irq;
@@ -604,6 +617,18 @@ static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	return 0;
 }
 
+static int cpm1_gpio32_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
+	u32 pin_mask = 1 << (31 - gpio);
+
+	if (in_be32(&iop->dir) & pin_mask)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
 int cpm1_gpiochip_add32(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
@@ -621,6 +646,7 @@ int cpm1_gpiochip_add32(struct device *dev)
 	gc->ngpio = 32;
 	gc->direction_input = cpm1_gpio32_dir_in;
 	gc->direction_output = cpm1_gpio32_dir_out;
+	gc->get_direction = cpm1_gpio32_get_direction;
 	gc->get = cpm1_gpio32_get;
 	gc->set = cpm1_gpio32_set;
 	gc->parent = dev;

---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-powerpc-8xx-cpm1-get-dir-698cefe92647

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


