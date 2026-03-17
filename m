Return-Path: <linuxppc-dev+bounces-18317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7947FD8769
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZtFr3MSYz2yh4;
	Wed, 18 Mar 2026 00:33:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773754416;
	cv=none; b=M4GO9ZpRdbHvXd94xxzcMizNve2M84aDnuzK13A0wf0ZGsJ1sFFlhZlN6vk6NQ7jz8XYWkQRMaiEgdQ5Zk4IbOZAx/PISw1DoksZx+r3lhIC148VESiRLLUQyfZO6OixiWj6oJh+q9P+6koRWz8eZUdunUqz3fQXfqH815HO3gAtmv4bpCLFh13R9im343boOc++KI0JzrodFx+s1yAn2RjZK7MUNWAdREpVYD0OJBb91c06njWrW678tEQi6VmR1uUbjO4Gah/iE/8Pct6furIAYbHJz35nsPZ9+IMFvg/2/JBMGCeBeC9VbVB/rNqNnjneCRX6JsdM+qj0B7gFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773754416; c=relaxed/relaxed;
	bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB5mgEWrPWCFnKuDuwdzgyvcPkhXNlesxMbzI3hqiMTgLORU7drnYkFq4YaI5/n4d9QVwNdpkO2RpB75eQjSNEBWp3vUNN4L6OONi5rSlEGkkIOPlfg3tOPon80lq4YQ/Qz59xc81mbwu61dszhPUs82TnkRiYPtmX4ny8XXQLl0ELtiqK+ae22O5VZEgFJz1RN2ZK2vM+gx04NX9g96alj04kw/P35hxOCf00e2GrOE56FSjqkxW36ocMsQC8uYDsPzyi2Jz6o2C4yDD8srS9+6YiPpe7iTHB9uwg91sFt0kofQSf8LzDY17obm+gSWDvxacoXtz0d5bYc4Ejy1tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WviHE7c4; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Azswk/0R; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WviHE7c4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Azswk/0R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZtFq3yX0z2ySq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:33:35 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7JHwB3124251
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wClwdHi//EK
	ovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=; b=WviHE7c47v4b8vtDxvJ8wLNIoZF
	wDW5J0+PHQkkFtKsjRWL3zkN7SZtLJ6uZGuM1pjHLf3+EQbVbopONeHZHLTeUtsW
	ypqItiR0/MKI4R2RNqxreyLF/+GuAYYXjBxFsHE8kuPCyBJ1tuKJpheINGAwEF4r
	5vKMn40mnMB2FpSfLO3eFPO0H5cBGJbnvf3N72eXOzQshVmWE0VGoCZknvu6D2ON
	eyqUvSl1Gx8wnL186Cueb/cKbzRTcN9GDK5DPo0+9whQFGXfNlmvg7z95qzQdYdW
	VBUM341PVCfGFAf7vc6iOc3Lu7MP7uExqa1xeQxE9VTuok1K3Q7+2fz+hbA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy2fbsaxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7fec8d44so460778285a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754412; x=1774359212; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
        b=Azswk/0R5x18NpuUjdRMveEtLx1Iz1dPwSx80kEe1TzymgJljkHM2Fr1nq3hQTtN9s
         IBNbBdFJcvWo6pVftPxNiGFYWyo9pXN4htdauVTFtE5wxz4JOp35eBTHPVNknhPVnymf
         pCE6tMgpeeIcDSwV863JMDE/nuLYeVhuUbZMSpp6qI0qg8QpSEmhDQrRvvEYkHn+vTZS
         OgnqpDFeQoINWg61gVGKC54FzjMXRhrzEyGS9nYRCyGsxjylmT+tFkdvn/vwGW0XqO+Y
         7tm2qwR4QJVkMi4UvH+MT/8J2VWycKQnPCBn3lJSkizC7z5Fgl06r7XyhuJpCMbCD7oX
         sqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754412; x=1774359212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
        b=FLlGrVuSlEZmt51XMxtK7PO0IXISfr+NC+Kd+9R5G3japODnCWboxNBDp6P2d8VkVK
         jBcT/oyg8nlC0qVByc6SeWe2aYJmBZZh/u7CMf97bm4tBMa3JddkJOeI+LAla9441nc8
         0dSOq85eVysgBGOtAIoJ5cXgz8TrqrssJe2P/AZ9RaaDQwcxidhr5lBgNzApXWFR1EnN
         rL0pQMDRnYvUjHBlOfufMAMh6V1v1VVyhSGTnrzEQprF1dD+UDV9F5WhnBCpFgq8SDJC
         FOXxQsUNm/IS25ItCmSmZu/VhO0ZMInHcyZctTcHTDAW3gHN4i0zWw6w2lWixJi84NRo
         rr/A==
X-Forwarded-Encrypted: i=1; AJvYcCXl0kh45r/PvM48mVYJA/w4DFjVq3BOOTnf5ud8+M6OujOBNXbLzc4mESLdGI+IeeQXLjGaGDmKfpmUyVQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxmESGJCftgGFc7H/iiF4xf0IG32iaj6yKfsbk0JRUxZH7qmUER
	VaVRrMDQ9gW+ktwmPfb8GXb3GQan8L+KB52wozXycGiawXKgN2+6djk8LzZy0iXVwfF812kgHVd
	Wti7hRGZ+7IzH4MTc4lz4t75NrS0O/MCR2PcF/5pNjQqHMHPn3t8ozDtCN19MMrBnmIm/
X-Gm-Gg: ATEYQzyPTyFkwAA9RD9aNhb9/hHQyH/Vt1ZIqp3Tp6qzElt9+la7TkjSx0PmrfGiFyb
	u41Q1G64o6yPZTjvRi4G6HyJBUKoLl3skaeuKnmdMeYC944beLeGMAcE85YDZbBFLC7Wx3O4wNP
	buU9pwgQGrBPBc4TxdE0Ck8+kLuOmm38UFYi/j3xwpaawqilJjahzdNooK3dP5YF0moT8fOsqY0
	6+KU34lW+5etYPA5xBWbtWnyNm+nxdlKewT56s7KNgfu19ylsypRlKyUEVmNFVR6hkZE4j8Wj2R
	0LZPRLGPNNWryA9DEjx9iUbYuEQr70fl23KDhknMjSqXA3vrCJCAnElhjzNOQtICVQR+wbcnbl2
	VrWhumzx60z/wky4wLwnzYC6xgGBrA090I2Cn
X-Received: by 2002:a05:620a:4415:b0:8cd:c239:12d6 with SMTP id af79cd13be357-8cdc2391360mr1562496785a.57.1773754412597;
        Tue, 17 Mar 2026 06:33:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4415:b0:8cd:c239:12d6 with SMTP id af79cd13be357-8cdc2391360mr1562493985a.57.1773754412127;
        Tue, 17 Mar 2026 06:33:32 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:31 -0700 (PDT)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/4] PCI: mvebu: Keep child node refcnt for probe duration
Date: Tue, 17 Mar 2026 14:33:24 +0100
Message-ID: <20260317133322.266102-6-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=ov8hIF8M1z6R9wDtFRkRAkC1i3judy0L71MjXuy8SHg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVgjxjL35h3b9GCXehstfFtvOosrOCx8JxD2V
 bgJIU/Bh3aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablYIwAKCRDBN2bmhouD
 18tgEACBChVuehaRRjXAcrbdPTAAOq8QiLCEu7p6Pr7DdrcGnP96ZGP6kQRDGpNuLliO0VXS+yR
 jNn9sk6o+QZGrTtyvblDWjoNzUVg1prOXD/W8W7Bry9CbI7qYGRRiurn7iXRM/N1+jM9CBgkeuZ
 oyAMsnTFxY4y1mejiT6HJHuhMAGiE2DPMPCiW22FUkHEty5cDdGNg64oVzKdjjgFVIEOl52mVQe
 n+gfhwwGT0ymaijzo+fDLlae47j31+DioYBLirU3ZNoUCRfYShYjCSm7wVqq1G4HTEVJTTNHHzn
 xr8b7d4BK0GKo0W6IqD5DnL/lDkb0XcENij1mjljbeBd0A/E6HD1CpNpWdLyMuZjCCwpACAjTum
 cXCmlQpySC4nsMjGvAOhmfpQzDYR8XAW9R4fGlezSXROFZw33Eifcmd6yL6PWmh6KIqBeAJIh97
 3ydvTovr/VBY4XsM5Jv6WNkJOZ7OyvJTU0YklLgXfuPQHHSnzzseaAer8RfmKF83jNJeu4lVVwI
 hBYIbU7FlkxAX/l5h1h8upvYM3lB77DeBdfScFy2FYWFg3P6J43T0yEoNfikkNGYV0jBXmzsSfU
 3FRhfSjASj95faSgWbmZEahgvCFpZIBzGG+/C6vtU40xTJzA+Ye2HMwtKyBzV3s4sq8YGw0PaTm zYDaS/53uZbqY/w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ihPOdazdp2l6VGNCfv6uSrJmfwSg43pp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfXz9EUOjS5kR7F
 GJgrXBESRAmHPYY0XgsOCkaAyQWJceOYcqF5w01TUzezLg3KOdvUThQiUM0BLsCkKgHsvi5oNLD
 wHoM3W3opily9QovoPX9n5LqVjbJm7sQN32SIub+zahJu2cxf9Q4zVA0wwnPPllNga5nfGz6bRI
 xXeXObqxI1+Ue+ucUO9MIAJIrPWuQ4nF3dupguuc5kjm/7/O6nY1OICRUbQUmD17nsk5ScnYIvt
 wajjEuuekIbu/pPb5bonstyvHw7abMRlE/Vi10u/oX7cZnmaM8Gcp8M+bSPHbBFr9190KJAUxqj
 JnDssM52IXzXkWJXderYJ8UlTMVGXEAUrkT7qgJkkwb4dLiuxuCAIsYWYaogVbjdn6oseDs21Wn
 QtCRaZEHngpJPdXlkKEMHWuOA+kAVlgdnFgPwQLde0n+Jxj1NzDGwEokL9nd0nAhl3hUYzu8yO+
 VrKZcdpJfrW0qrIbKTA==
X-Authority-Analysis: v=2.4 cv=fa6gCkQF c=1 sm=1 tr=0 ts=69b9582d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pABr9VbpVV2WwmlfmZwA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ihPOdazdp2l6VGNCfv6uSrJmfwSg43pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170119

Driver in probe() first iterates over child device nodes, storing the OF
node pointer but does not take the reference to it for the remaining
part of the probe where it is used.

The pointer thus could become invalid if children OF nodes are being
removed from the Devicetree, e.g. by removing OF overlay, while the
probe is being executed.  That's is highly theoretical issue, thus it
does not look like bug with any effect.

Nevertheless, make the code logically correct, so acquire the OF node
refcnt for entire lifetime of the device, since the pointer is stored in
each port state container structure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch

Note: Not a fix, because practical impact is absolutely zero since
of_node_get is a noop.
---
 drivers/pci/controller/pci-mvebu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 4d3c97b62fe0..7fb9c7393588 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1236,6 +1236,11 @@ static void mvebu_pcie_port_clk_put(void *data)
 	clk_put(port->clk);
 }
 
+static void mvebu_pcie_port_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct mvebu_pcie_port *port, struct device_node *child)
 {
@@ -1482,7 +1487,11 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		else if (ret == 0)
 			continue;
 
-		port->dn = child;
+		port->dn = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, mvebu_pcie_port_of_node_put,
+					       child);
+		if (ret)
+			return ret;
 		i++;
 	}
 	pcie->nports = i;
-- 
2.51.0


