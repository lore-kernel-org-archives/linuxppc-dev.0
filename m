Return-Path: <linuxppc-dev+bounces-23578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118A6C44501
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdCP21dpz2yrw;
	Mon, 06 Jul 2026 05:41:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280481;
	cv=none; b=iPXusNCDiL2euCD8Zov3Fu4iJFZ5IZFG5RzHg7GxM9KFinHzxnS9ti4GwYKpskPpzD5DVtQpKSSoam70jvRM9fjiPEQg/vrJZRc4K4rPfQ0ojMJLEqT3ljkKmL+/DqKNN7BsrI0RH6NSAZWi4Nbu/kJ7fRLALnDKtABrWzuuqBVsZ1oCIfSp1q8FBUDOsLfhBm/L+nbA3sAzc/e6Fii6BIiLtjOogOntSVqKKVy+pD8t3DwFUBpj8xCio7hzxM/CcxY2uvu4B7SXpWtF3nBqcknk2/F3SWWtK6/WBFRkBTsBspcZBfMPzmM8/A2jP1XN6MwxdSENFar+1B4o82hXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280481; c=relaxed/relaxed;
	bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNOfbUBXIYwJM/49jw/VoO0NgKBYKIxA7PAXEsz4j1bg6krsS4s7iJVuAYGfBcV6K9gZFyA8gf5VXyWl1vAdxzW3e9sbq9ihQvj4n5fLzz71yZwvZUEW4hhMxn+VPlBE8RHNTFPoujsylLhEOAOb0pExw3kD4UNi31JsOgxByrbpiA63/U7m01n3swfP+gC7Ec0vMWW7/Ubvyldtt72wLRbuoVj76+bxFecL2KI5/LgcbjOH3GHJ5j0kJvifwh4dDOnMmNGaKvpUJaBPXt01b+n0/0nWimalIHqITMb5VU8pNNQiFgLPJ8bLXJeY6C1seQy/YY2FUViZjORfL8WlpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVhvB4ar; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KSckZslR; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVhvB4ar;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KSckZslR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdCN3vrfz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:20 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665IW2gS2287822
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VVldA6NTRnp
	wPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=; b=PVhvB4arTRaJVhF2SofLv+u1aVD
	jK8zIqELdsOTMECr0irbXF13Py7AAvUWwCcgloBqNe5sydVgobN3ykdNbR62SDhl
	xSdi8gXykZAYDggG/l29V+pDv8vxNl/8bfs3RsFDtihqoBwh9TvV8ccwG6jurLqz
	hXyA3tzVzG/9j/LFOunKeib03MEp2rrcHiuWykXLV2BW7biJwWZULRxuE/380H/W
	jxvEJrmSgF/oSVLpQz6WOjtRFsfVbrSe0a7iY0325hYiJ5tqlT9bhtEQhpDaeG/2
	q5Zdnz1hGEN80AyPY0gPhol8PR+yZE2CguSboTpYR821bg4icMzfKXPz3+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf8359h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2caf4173b1cso41674625ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280478; x=1783885278; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
        b=KSckZslRm6q7yjX3w3e0u5FUbpqQ9UaWsVLeC+zgwjVyLKkGqb5y8E7MsnzSlFsDyP
         4ZjkuFc0oy1S+a3V2xwLCjPVSwkY//AIBMdnJcVF9sYqqLtFIYqzwP6PCRmTWtnwbbLI
         vHEAtA8woI+G09Z3sJcMvgO4H/gTvNHJi8GpDrbyo39D5fP2j2hXjECq7/yufd0JCPG1
         uJ1WqQdwfvbSRrLojOFv8OZ9WvOeekhhBD4ZZvgQVRJtwM2wEGXTWcp7EzMmhOq8KTAk
         I8vo2kq/gaTZqHHfzQlHCv7euZ9cuaR+TLEj33MJu+j5FNDTQPSywjGata4YpgvEClaE
         3AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280478; x=1783885278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVldA6NTRnpwPp0U9xX7eE/7+mcCmlhnYAOTkmKf4Os=;
        b=oyjYbopfn/lrwhnZ5l+xAwxyu4Eaiik9M6a5zVqg/CLka1bJb1E5vn2nZyK61CcNm3
         brr2P4At6YXvynhYQDzwoGu9DI3fTFd+BLHvr96xeZWlXuKp1ycckB8k2o8rSPFgvfDP
         VkxsVsjFT085kP4LHKK9e8S83cD7zz4hDCHEgK1CY90hceKiUNxj/u5SH6optFYM++uN
         MDzV8M5ZthN9PORpTSJQFZz1k5uSe6h9vYFVp0QXR1zz6TzXZqIZaYlvA2W1cWT7pON5
         9iDBNVbVLt8UvZMvajMn4zMq8MNOHUvHKsL6yHGB2t02e7SG53gx6EHukQys9lZ3oyrs
         0Lww==
X-Forwarded-Encrypted: i=1; AHgh+RqT+KeEStxNh5Bzc9xvRexqMCwq5nTs/m8Kz2vjzQWTQwSW0P9j1Wj7qGfXzQECgsGXFH+kGQINjy8Czb0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFRQeCUsr4FhlF90zZ5XTuwppDm5v+L5mz0AOGn9j9cUQQ6LP1
	9wekFzbA4XJiFKZdnUm4g37YKj+0RC/WggYHxz9ZWQkNXEuFDs2Lcfht7fSCBY348Ql0c6wncVY
	zTwpfExMZtd0diJrnLx+B/iXT+OGDrNZMOQ2AR3+a7g9uAbgGks3lOFk4U+mnCtDkckxG
X-Gm-Gg: AfdE7cn85vYFEehmZxPs1JRG9QcuMRBW4GeznZlD+qEG1KIcJ9OkN3XZEM7QA0iFVUO
	OAx4URU5qZZ6pLH/EwotpBmKgZND7Z8TXoMDzmtnagX7Ok75iqxZmuqdYow5qJDtwlqjwokwUur
	ruO2rYYNhtFk4Ann1w/zc4s7wWmqcBvLbmP4d275uhqoCy+3Ui4llf04vLQEknU7euzKbQd0DUO
	sbtvlOjaeT48B/8eIqv9O8uu2/m9WmWRjrJqVnkdP84lj/F4qeCFPGkhc9nMVUihI9IKcUWOhZp
	Z3MjqFrypsfRcdhFiP/aWRuyB2zMiyM8teaHu/Q6v22bOZyUWy+qA7OOjr1RjYCJ1GtAIwk3dZB
	pB/yt0mTXC8w0waZGIjoVNeQW5sRG4647ORGlJQ==
X-Received: by 2002:a17:902:ce12:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cbb9eba53bmr79826035ad.34.1783280478033;
        Sun, 05 Jul 2026 12:41:18 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cbb9eba53bmr79825855ad.34.1783280477546;
        Sun, 05 Jul 2026 12:41:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:17 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 40/42] misc: fastrpc: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:16 +0530
Message-ID: <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pnOZ8RVnZIJBAve4IZwkdM2PRyyG_fZ0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX3E8M9809bvmT
 BVCRX3MSQhd93gEitWgecHfu1wn23uSJa/wJt8vAyBMAcFjQu3xbjY06BytpN5VrCxGlGR0U4QD
 XPSMhK4jYnIhn2vW6BJxmRiiJd6UeKM=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4ab35e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2vM2yDDFhuSsTauGYd8A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: pnOZ8RVnZIJBAve4IZwkdM2PRyyG_fZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXygkw6wXz6lBC
 9u5xVSCrPZTCgq2K8hitwfUzgEAFvQPbqOFYXKxUE2BVej7y7C88MGKyWSA9eTJ3VMGollbY8oH
 +nG+mRFRk239xqbnr4RCZzPkO90hSCKVr4PzYdphrnHXy9ZIbmPJC8EToWCkeUvi9pTvSVOquh9
 aVcssYEEMcUafM1uvxivCKwWFFmjvGYhqWERETug0d9lAqYZ7PfT10Gte60HQwO5UcG50rPTlon
 g+ylgQQWVKLBv+pT/GYNCzJN2Mc0zOZdezXV+v27VCL1DXBTJj/EPqBjSZfNr8hvjXSGTiXxwYI
 ofM4+rCUibl4n7ELziydBQRZqYjjgcwZIqUzT7SQqlTPQbiDl9pipJ+gmz1JjaBBvcFT6wghW2X
 mIAkllaENg0zB6vT+HJWvpZckeDVMmbdLyFYfKrdIAVjuwF3nOvehbGLjdcknMjWQxIA06x19wy
 WG0RAtIGl0BVXKnOuhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..c4e05b0db527 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2396,7 +2396,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
-	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
+	if (devm_of_reserved_mem_device_init(rdev))
 		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
 
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
-- 
2.53.0


