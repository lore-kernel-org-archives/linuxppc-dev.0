Return-Path: <linuxppc-dev+bounces-18319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB27EFD8763
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:33:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZtFt5nXyz2yqF;
	Wed, 18 Mar 2026 00:33:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773754418;
	cv=none; b=hrAUgwbcYKKQ2uiPdaj35hQWKswcBxnkBod2aBNBaQ156QgnTjiVyp/P9YdvW2cNygx3n4Zw5zbld843nlayHBi8kMWoTpuMLNv/hBJq7huI+Y2CggNrbSG+rZ149spCs2cRFq0WwOjB5jVf/XPjZf4oW3vEo2I7E00CnNsif++4SSKq2iixGiYInroVHz3bABR+mcLAQbqzl+Wk8VjmK/dFh769bhzsrM4+3aznK2cv3HG+H3/LRFjMppWPvp664O5aJOVM0JZBHAv9I9mm3vM8mSWA/vKweD7Dfe/WZwl0uXR83XEHTd2nW/6Mgw8LY/e1uwzadEiHcaHvG9vdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773754418; c=relaxed/relaxed;
	bh=88mM0UwfW559Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbIr75+DbgXAlPy1PgXr2QQcjO4FEEBdxhk6QwnCN66h4s2GQbwMv0jA6XeYF9DxoVc75/GC0Fw51YnvhV1TC7pFKefbVDXHr5A8wfyOSuvrJhiwUdjVKex+HvJ9xQVnukNyGy+ACBvu7B9lnHdp//iHrEoCDuWdTdiuDHp2lyVmBp7ieibgUU7fn/xysMxKgemMt/rRFgARsZP9yWpHdsIlnwLdGj3xCJAF8Imbckc2Bl08Z8UVC+h4uj39wgqXJ3GZFdR83Xjp+GjhV5dciyTZG7N+HkXblUAtJ/oWP/JOZQF3n/HCP3I5x0BhM/AbJBOix14Ix05oI31qM9caEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWIHho7D; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QgRVaM1O; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWIHho7D;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QgRVaM1O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZtFs6fjxz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:33:37 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7JPYE3124394
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=88mM0UwfW55
	9Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=; b=lWIHho7DytD+zQIa3BaWdOoOeKU
	ZVC60QGQrjqvpRt82HkwH3Z2k+DnTKuabw9v3vog7BL2AVmZ4CMfUXMlEUKLw7Sm
	0yRshPkXidtbOuJmZVe1Se30cQvIuNrsJk4tIsx8YbRPXoWzyXAKp1bwwbjAsTJg
	1hAtH2qYebTCI67LeOgVUPjOleZHAp6nr9cYZrOv1lclF7tFF8Gz07c/Dag0UUYq
	azLlmX6jdDX5pZU3OO7flD+WkIIHt25OJk1OpKBN+BOZ3M12hW+csxY5nvsxbEcy
	w2K5XtcEd3YXUmT4wsg+f1bKJ+MfsrH0SJbSAO5Va/jC9STJ1jVzU80joEA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy2fbsaxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5ffbf6d209aso46189725137.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754415; x=1774359215; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88mM0UwfW559Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=;
        b=QgRVaM1OQjjP9EQvRtnMhLNL+N/cRLURAY9syJbC1cu3DPICk8Bwly1HXoD9UDhu63
         sFRtyQB5dcoWqiCcz39LUARvKIhK+8SdOGSxVBEyiKaMAzZ0ST8fNnWP/P3vFa9qssDM
         4x68GQ0hSjgta/3sngAac+jEQ0+xIyaH7HYLxh8+DXIdPf4xj00MhXo5iCQuUAJVUJJj
         OgezCXRcAbeZ43/dssjGKGXab2t/iRETxZhQTZCAvN+NNwxKM7GBa8rSLhh/e10bjdMQ
         ZRkOP/j1JBTvflFCbLLE1eO0qm8RnHoJcHw9WVDy+9Icsq4P0erdraraWu+/WPVO/XCS
         IOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754415; x=1774359215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88mM0UwfW559Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=;
        b=JajOFi0zuIocoFye7/fLbwzwN4RIsaBdm2poIoh8pJLbFKWdXceekB9heFyea0uKll
         Col76g26RCQ3+hrhSmSbODpnEbtHtN564EWorAJC/34jsOMH26x6idVZ+94kCHyOF2+B
         ujoeQ5i1MYsHrGMwhXK1XSC5Imkcikc0nXn5/OSLskAS2lDrIje93DmSnXhxVuOeskTZ
         KXt3ckUuFlpG4RgbpIv2WFOuzR+X07ikzi43ghBAiw7w9Qij0XpuqWt5VdPEx1gj1Ta1
         9/u8Hjs3KXP/2qLBScZpVs7CV32rLpCzufJJhrHLJ/0Yc+UtQ9NUNJIIcb43ClBSDgnn
         JQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWvrfvyFVWXWNv5LkFkmApyEmfbebfY0YyVODcrTauA79JcreXyvJVqiTldzNUoBYB2gYgUA2XN1t9PHrI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyM65fH0/AQGxNU8dOiQtoOEnFMKcKZ6v48rIsvnKuIt3s8JrvM
	0SaS2YLw0WFGowkihEUus3rvNYWm5KUnG3tz0gh5DGh9xWdkeVFunNSHDyIV4LAk4O3XeNY6h7x
	mNoJu/fNvsOhb1LoUiKlaP4zwxpF4W5wuIMQrNq65hI6D42aBydmmOU1JFm9yL+N4O+w1
X-Gm-Gg: ATEYQzz6u7XCJ9TkxBVUadrorAcgqBNa82sQNRbqeOTBX216aNVr4wmnuEPW27HmTnt
	j+nmosG/4ic46M2jOteHixt/59vLyOyQgcU1wjyS7cA9da+863qQVs3nxRQEVI6chCnb/IdrIKV
	wDzYTLW+QHUgHnET7TGNs/HJnSULP4KnEI1enpF9ZQielqIh2eRvxl12y7wzk/M1g9cQ2Z2vOPZ
	fg0rQzLUJx6tK/dPFLSEe28YGhS1bmx5u5VSqWUkTRg8PdMxD36uW4nv0I/Wzx0FjWRuPuR0Wuw
	xwJeVBDdFElakHMf22MA2lQYCwy737kLaogZndReRTbRPtnEPr7vKlAoPmEPrxJ4sXp8UOx4/zb
	SulbnYnPVQNo8mQqjT/yjrPzZYgB017YulBaj
X-Received: by 2002:a05:6102:5489:b0:5ff:ca6e:c897 with SMTP id ada2fe7eead31-6020e8b0a82mr7765956137.25.1773754414595;
        Tue, 17 Mar 2026 06:33:34 -0700 (PDT)
X-Received: by 2002:a05:6102:5489:b0:5ff:ca6e:c897 with SMTP id ada2fe7eead31-6020e8b0a82mr7765939137.25.1773754414189;
        Tue, 17 Mar 2026 06:33:34 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 3/4] PCI: pnv_php: Simplify with scoped for each OF child loop
Date: Tue, 17 Mar 2026 14:33:25 +0100
Message-ID: <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=eFMulhlJa2czqc6PcJ/mERCRbh2LOh0022dwe4uJYpY=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGm5WCSgUBvQt0JDHdii3jWXC/hFw2j0Bpx4Q0CacjgyAikrz
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpuVgkAAoJEME3ZuaGi4PXiJoP/1M+
 O2IBPigfQbnSPLXMO9PGtKAtkLFrr7UH0xdJmfKyTWqwr4f3bd+NnDFEcCQTTDOhi5q1/DfvHPz
 oSBfYhhtTib8d11CyFDvJhXi2uNWole466n4geS1ah+G7H+6A1/ePH2BhShkYKmK9ozKw4cKtkM
 mMke2eJG46E7FGMuYTlpg3b8yukEIogxlAfO04ei4vC99ESxVP5y9v5QSaCI9+D0PItGjnF+yF/
 kxbvMfDh1o5QoMrzLmqFxFoA6N9C6k84W8YzmXMQnU4YmPGIvyaoCGqbwG35nx704jx/Xgc0E0t
 8lzHD2+FupqcBNTmXnxErH8qjjmQJOsB29727VBE18vBGad132yrTnqBnHYeZe2vx8cjpms7UVe
 7dp3+ZkvMliHKiMYahouDtGP56kJ6qm20WyA45cbNVH7sr4y6aWhWgN0zeuwwGkW28jkQLdMwhf
 PE9wOYSgDBeyNHdIvJNPex0m6JeyE6C92+lPFxTukWnhD5bozbd9tscptfBxfKV6WXUHhCRKJxA
 wva1nWjijOc2Kpj1oS3HZr/MJLirzIeOmBGuze0V2BfOeupdrfAkwDOHQUUvnUqJ6DTPNHt7fcl
 Kyv1Gu+cL6uYme8xPcMPRJ5zjciewwFwqROmx5+3iTnKKjB9MEpbLow/iEtIktUpUDeR6IQ1Iqv MDVb0
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j1xUPyIuC2M49isRespE0Y6uBCVugOBV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfXwfh/4R1vfC6m
 5UPazlK9GqVoJbjFE0pWifB6a5LsVw1auVR8Mtr4ayg6zUNN++G9RWUI7b5x+KRbPXkGA/BTJVk
 BbHR34nbi/xaVkwFj2nr1qnJfm9x/Y+YCBI5guHs57VuCUhOYLLJTtCo1/6expNV6QRD+v21Qjd
 +dISjJZNyjrecNZka+RN9BFVbbKWxqKGThWhT+KZI+pyKuDnHi1yD3LG1ZgdBGhxDhujR4nn/wd
 j4ItnewbwintBO/Z/V1+21BE29MkKjQuOn8Tf3IBap0NX0Gj5glZ/KDRjL+eF0Koj6YvWizzmYV
 L1aGt6io16BtrWOXOHum5+11qhWr+Vazcz5k+Gd+a9AWlf0vhMk6P/ZF9vx5qcNNKFb9FTvr/Mj
 KdvV+ZnYpFCaWNSerJtxjKVUgmElAPrDh9m7Bz1yo8aLYuc091SfWO63Ok+GKDNMk5wNstoHfnn
 99z145S7A097bHAyQUA==
X-Authority-Analysis: v=2.4 cv=fa6gCkQF c=1 sm=1 tr=0 ts=69b9582f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=WsY6cfW8n5MRYgmDw1UA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: j1xUPyIuC2M49isRespE0Y6uBCVugOBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170119

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
Tags
---
 drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 5c020831e318..ff92a5c301b8 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_node *parent)
 static int pnv_php_populate_changeset(struct of_changeset *ocs,
 				      struct device_node *dn)
 {
-	struct device_node *child;
-	int ret = 0;
+	int ret;
 
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		ret = of_changeset_attach_node(ocs, child);
-		if (ret) {
-			of_node_put(child);
-			break;
-		}
+		if (ret)
+			return ret;
 
 		ret = pnv_php_populate_changeset(ocs, child);
-		if (ret) {
-			of_node_put(child);
-			break;
-		}
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
-- 
2.51.0


