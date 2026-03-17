Return-Path: <linuxppc-dev+bounces-18320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA46FD876B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:33:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZtFw5FDrz2yrS;
	Wed, 18 Mar 2026 00:33:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773754420;
	cv=none; b=BumJ98jXw3cBHO3jGw1LZgIBcLtomwBzNIhyVRP/i7JcYCNbmFq8jD/dKhaOGBeALw4Bnm8gMoG00zsle+wuggLQ0LN7GzWGn7AbijiEVJrzAdLpgq0V1+JBSWn9xGKwX9k6HHS3wOpfccBfIxLWhzK5BA0Y193MyEce/b+3NPBlFxPSPEG2+y7gC/SESBzKMJeYDxT0c4Dvq1Vv/NgCVkO7bLZNr9b0GzNsnj49X0FfmDGNG/50MGghkwkX2to/xMDJZBeK8uPjxE2AE1QyXWXk3wi9dH+AZInFf8uXOZDViqwXCfXYvyfvvgVj1hUfb5Qt1yYcO0UJjLUnjbjFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773754420; c=relaxed/relaxed;
	bh=tXmfvTYJB8OfseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4N91Q1sol5wj8SNH4JEHvl+z76JdnZRa+LMzWWhARft4mmaENjnNI3T5BF4rXdNbpLcc207UQrjFuvCG8wDr3aJcD6GpfPkG5TedhuGQZbc0efclCBy0/xiWQC6RAEkXEC/vdwR8jah89YL7PYsPCOm6teYgeprxm/Oclv7VtWd0iZdLUgSYB7ggXxybI30Kb7sEX4h2+AWIWcY+q0P3yqa2Vr99OxljmJHsxYjSeXv6pRW5yEEGWzLCwinLpI8O9ORda9FGTHIEBLD+A2CXnHdJfy7gPVgbr7XWw1m2ifzjtUEnoZbq6TwcmN3FhIcs4UuRo3WLYeGDLtfAYoNDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMxosxFZ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jfIs6Hqm; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMxosxFZ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jfIs6Hqm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZtFw0KH2z2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:33:39 +1100 (AEDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HAkCaY254649
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tXmfvTYJB8O
	fseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=; b=cMxosxFZ8lMtSuzLZd9dc1eK8NO
	RPXekCCxrh6w3zA16OeDJNRZx1hvdrq85XrvtodSEJD6cgAB+Cm169juIzbKNSQL
	8GabAcQqBSUq7BFQm4M8lWn85PuWFM/fyldaBF9SeJl7XmW70XkcjX4sGGjllwIs
	VxUxnFjd8p/5vCxY7MNtkJ0pJpVFrqj7cGrGnd7AAD5w+O/FsWezKXKmpxuV4/Gh
	4kDO+Nf/0zo9PPKaSuR4fzNonmSqaZmVBUR8DsNbdpyMg5k5DcnT0fZ/yO4tZCNd
	1iahqJxVKqH2p/wdDcDO/wB5qk/pmD8XqkfXAVHtR9LzzccGZxE5it41GDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8ghn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50900e9803aso385927701cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754417; x=1774359217; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXmfvTYJB8OfseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=;
        b=jfIs6HqmPBpNRxJo3bwbwhsRT5arlcgo/3lSefVB9H25SFmEFl64aQh+eAQmZ+8Lb1
         KbkVw2VpAGwYyqEc/SQT900ufo1jJL2kMjZVIvdml8CBzCuuH9XU617uqTFb8mEk+Rz5
         /4Yf7zcQIRCnNW2cvJpJ36BAhfKMbD1RLifVrHqn298lWpaeRCmo1seb6gOnq0w3yLFK
         8oifo54PIiB1y/vuBqDr0F7DIycERT+jkGHMpCl16bnOvgfhf0V3gAdA+GKwuJj7dE8j
         i0Wfcz12TuRR/Wj7BEY5M1PxG4XYvQcWPPWx1+5h0KRhiFJyO42gbgAoHgwDmOrZHip5
         TZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754417; x=1774359217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXmfvTYJB8OfseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=;
        b=tIQTcKvY3hOSV+0QN7UQSlEEyULSwkJ7Gf38fSCa1X9Xp8TvBJ2DVf1fauxzfFbX1K
         kgVHroh0wHCdbLvA/Feky0kpbjfBVZj+nhzIWIIA3lSSPO4Q8Hzw/ZS7jr85tLghtpiF
         kpHi5r6TdrHkhO5u+GeX+edbcaT8mSH+Mwy2mwL+0RSC+b6q7jXNg7caHZVS90GXHMq3
         UMNPtoM/UukIcE/HoVGK0ndeHylv/l6aM4HfCrB3p0Zfdimfr65Rwjb2yrYTQ6GVJvSc
         9o6DKVFeXaXONPfENmqyi5axuDrgnwKz3lu+IrZS+q4UhMtRydctr7EiZS2zQBxQDx1+
         TRpg==
X-Forwarded-Encrypted: i=1; AJvYcCWyRqtfYqxZmUbnHNRsnve/KJRHtMGoqT5K+9Dsb7y9Jv9kQZ4dsvXfsduJED7QZyWWTbl68AxeowWNQhc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyrYKDjDsqHFxC6ZJYR+DsJLhNYMa6zqhN8TbTAnBmxUwZ0UYs
	HUfFiq0za1p4hRNC8bGh62UmfIp9pxXOktCHvlYmT36TWLFSQy+Aq24Terox7yG07UM/v8bFzAy
	wEaFe5otDHoZ2TGypmlg+4BPXjpkZORl7SKIE6zJwe3K1TFtgiLuEKmjAXlx3jaMLjrWl
X-Gm-Gg: ATEYQzyq0+VWRN10GJsJe/KpOdMViwD16xy4uFG7Y0j4lWwbyT713LBgTAe8rtek4Yz
	co8odDmGTGnRku/w8ETLUN/2vm2yT4LjhpD//pVSv05Bz3jygBUtpapuQywLVkgMVRmaskAEEkp
	kdbPYLWp4z4UEOdcsQ7QygOw5zELpVVKM1Uz/IXwMT9kxWE2YhTJnXMjYPNOrAjKZNRuHK7K2tr
	PkUxX8W0SKvi5RASsFmwT6QNTrOjOkZKEOKOr/DL267IeurlquS/loMTmJzdy3S2X/Yk0ssKGSD
	lsaA4Kxeq6erHiDfWHnyXTZGSDZdsgWw2hDJJI7KyBsTU4d7azVkO9fjqWs+R3EXBTyKqezNJcN
	W3hCt/uDVPCLgzdE05GymhKSTuBpJoCbGGsNt
X-Received: by 2002:a05:622a:22a6:b0:509:5987:f4ff with SMTP id d75a77b69052e-5095987fccbmr240504881cf.61.1773754416977;
        Tue, 17 Mar 2026 06:33:36 -0700 (PDT)
X-Received: by 2002:a05:622a:22a6:b0:509:5987:f4ff with SMTP id d75a77b69052e-5095987fccbmr240504151cf.61.1773754416323;
        Tue, 17 Mar 2026 06:33:36 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:35 -0700 (PDT)
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
Subject: [PATCH v2 4/4] PCI: rpaphp: Simplify with scoped for each OF child loop
Date: Tue, 17 Mar 2026 14:33:26 +0100
Message-ID: <20260317133322.266102-8-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=9DhCCDFm896xvW9DJLZa0Xniri5OwyXWSIHDphJEFYs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVgl+jPVUMZ1Xl2C8Qlcx/qCoESwPPQQ93fLy
 DPdpQXgiXuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablYJQAKCRDBN2bmhouD
 18g/D/9yRaLcZiBvBPgCkpLNKJ5s3HApSEcdu8UX2CGfgGYAHuQpfm74UP1W+AY0IsIPbBm7jU7
 oC7Mt+tXTWlC9RYfv2MsR+wYkbEaYY6V0gdZtIObXmLsqYmMJvLkQkZdHCktv99zxBPp7QhsTx4
 XObU/2EkTdzr3wFJUahjdM8a2feprqGSrY6EK/+TD5pbXeOsl/1Hp8ULTWveF7H15rGznW8Ck5G
 d0FizsAFr5hbgfk7EPLq+fHBsA+UKqJ13lyXoTz1tTgGSMqZ24/47l7RrYTQucxFkMlQEiIHJHb
 GbZD4PmufA/zUmSVCXw9DgujtZz4XmWCgXftbAN2BDAOLJofujvKp4PsKtPmaiEYayUy2e5UHYr
 Wrc9YQRjW6N98OJvyHLLuOii6NX6CO85UVtZKtqNV4uehkYKxznGkvJ6bjGmPuTEnKqJr/iLx+w
 YtI4A5/mJs7rWMYKxtrH7CDDrRIYKs9IAQOpyMGrT2BCsPQHVyFClrhOAxfSOfkdsj4Gp6krEuk
 M9pAY09ONTTpqte8ntrwAUMgJ5CLjJNn9IjnYSftwB6yHb+TunyWIy/T1JmMgxwelgJmy2MwbZc
 M0fzOQScJG7f5MTk3p++jmm4ts3+qBP4MxhhTjDrfOu2moH78UvcuXv1i6MwCZvdYA6kjVZAqlJ ThqBrzVmPBpQhag==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lbe41D8Ai0Swr_KUurYlyVJqIndsxn3w
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b95832 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=d5zWgTKZ4CwGW_Y1MEAA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: lbe41D8Ai0Swr_KUurYlyVJqIndsxn3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX54CJI/xEnUg0
 GqpV3y9cBgl733lQG/4Qz78UJdXhWvEKL0b/2AXUCpQy+C9nd1pwAlNWo1YDembPfZVJBsr0hsL
 LTeiIOZVSEDhV6wsb1Lac1Sq8ravOFaniECHImv2tZmxFIVpp3/WXTd4kQKhcZX8UAC7LXafNIx
 1xykDF7WaEVvYTzAsLuGl/+zJ/Gntz+ydzTaOwIrYzJUb4/xbwWyB3s4cEKcBk5229tDk8WYaV2
 jd6HgAU8/ymCT+Opz2kLEXruoApC1tLl1YtDN+BIWaIB15K3aDUwDw6aqMymL0VV0VA/2UFX/8o
 z/62XWYngqrD1R7ZjcHb0+4UqzIj9hc5CjYFX0wVaf/bK8cd2LhUHu7WGwVBjd952rnfQ1xFcih
 sBGwblIsZPOIMjrr9jaQ/YwxBqS0N0Ddq+khv0dwwFAVCTq2IdM+AN6hM9wF3uI514lUwjjEYDw
 Nfjcr/px6dWYRiulBFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170119

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
Tags
---
 drivers/pci/hotplug/rpaphp_slot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 33ca19200c1b..67362e5b9971 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -82,7 +82,6 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 int rpaphp_register_slot(struct slot *slot)
 {
 	struct hotplug_slot *php_slot = &slot->hotplug_slot;
-	struct device_node *child;
 	u32 my_index;
 	int retval;
 	int slotno = -1;
@@ -97,11 +96,10 @@ int rpaphp_register_slot(struct slot *slot)
 		return -EAGAIN;
 	}
 
-	for_each_child_of_node(slot->dn, child) {
+	for_each_child_of_node_scoped(slot->dn, child) {
 		retval = of_property_read_u32(child, "ibm,my-drc-index", &my_index);
 		if (my_index == slot->index) {
 			slotno = PCI_SLOT(PCI_DN(child)->devfn);
-			of_node_put(child);
 			break;
 		}
 	}
-- 
2.51.0


