Return-Path: <linuxppc-dev+bounces-18318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B8BFD8769
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:33:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZtFs4Fggz2ynC;
	Wed, 18 Mar 2026 00:33:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773754417;
	cv=none; b=jqAVG2b8iho8fa2V8Sks5Fdr9OoyF9dn26UVNAna/i29cLRSLW5A7cj3pU1cG02WEohtQlx0o/wBYlc3uylBu83etbUUdIwKxISz+baNICZbL0R3cwNyUlx+FJQvi2az72Hnx+IipcHau9/abK1i986IU29BdgjIvKuXsqrBfoM+Ye0+tsBJtMpuNb7Hj7GqNNJlY+jv0A4/ur5kxFlzIjaXbCBlRg9L0usIvtZ1FXSBMrre5hUZao9MUt2x/QuIIHIsbFv3+ywG5BmbR1xUV3k0aZm6h0NE51oQkT7niBR1VHK9FHwWD2LPPlHbxpQvtigrcb1y5fAY6rHkkPAGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773754417; c=relaxed/relaxed;
	bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyNHNOgD0xovx5lwRnjtGUOsvhwxtjTp+vMQ/RRBQzQarZAMDpBFmE8tZmmlxPQzrqN4JuHFUUbyAuSsViI9Y6dVMgnNxWMD2FRNRJx45yzNjnr1fwupJxgVLJ12spXzV9l7p2CFHJvgB9F13BLJovog4OGkxhDY/VGUvAjHUpyso8OKzKoOd0zL+3/ZUWwJMO08QrpvGfF5icz3REwUY+Z8icQC5kCrPtAfAV4DloibSLhloblr1bOWF8G36zeIDLmtqzm4HdhWLAgT8W8ijTdtymIL9bUKEKOVZReWPC9MysMun0K3KG2DJAKBuIzviGfOgSeH+e2yZ3hJH/W8ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UoLU4hwr; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fk89jetN; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UoLU4hwr;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fk89jetN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZtFq2w79z2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:33:33 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7JGua3124207
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdt
	G0dTVDoQ=; b=UoLU4hwrC5dC6619mdj2VnbVuT7Aekrcbig4KOnX60dCk5TZGoQ
	ML/pSlTBEj6WjZtUqe3RQQcM8nXBfu60SE5I6aZkNxpMQ+cda0SQBu/hW95PSfaI
	7EEaAkBUB/5KDpZpg+OshLNtLJblnjg7CAlfckG16eTH5tLxcOFdt2KE2OPE8lCh
	Ep6DOa8Z2wWqcaOQiiIt9EmYvUWjHxKF8UEm21fzjiBouEMbN+QsuYo4eWpzOyO6
	UlXQlcjA6l7zQ3DZSvCWVCodKT3a1IyeLXH6IbHSOj5l5bJJROzTJkvpUrVtxVnC
	raCXSEH3TJOHlhQArtY7SvI7CNdh6kpd80Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy2fbsaxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:33:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-509007aea22so231190921cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754411; x=1774359211; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
        b=Fk89jetNDhNgyDkIapxeAduJiP0RLmVbOYaEZvo9FtP6djyGOtlkULohKvfPpIw4Iw
         jInYxfb3uzK47yJgrMu7bf8x4Zd1LcSwuGR2uakyeJMiwcReUstZErYL3+ycTDtTZ8Xs
         h0J/vjO4ppiGCfupA5sIPm9y5FK2VVtZrg+WjXKk2MlOLsv77HZNJqRsWBkUfXHMHNgK
         bwduenJBAisiKWVd9zSRDmDB+rwVIiGTz4+Q0MF26qAbnKZHYkAE9dDxA/+WM4/sgPff
         TcEUk+QoPyI+Q/U4J0JhHnsSSa2IZDvZcqmLaEumFgLAGPhGvDulERlkidZGE7j5bu71
         JFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754411; x=1774359211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFsfPLdNFjVzgQTaCQpOdWom/o9G4/TZWdtG0dTVDoQ=;
        b=ZeAJRX/FlC4GGDbUOwNFqM41wfNeTM+WYnjVSqDLx25wDE5tf0PqyUOzylnbfqdorQ
         N6T/0BvK8PWcsmMXwN8IyUGZixADGLgFsuTJaJk8OGDasP6nRukfGsFLS6I7h07KTsG1
         vaIw7JmdELkhwXIbt7p8vqqqXVFuK8pbj1RKCqkx45upX4M4XbwUKiJu/azP+kqFZsVg
         Y4wWqGTch+7DdQL/rjWAemOJFG7r6p8FwvMPk5eWoriueEIR6PcbpHz+KudPMpS9TvXR
         /ZkkO3o99RI4eIP5jUFRstYgr6yWchSAuthT4wdSxH6YFCe/kyv60zi5mEX3d2yZgnqo
         drfg==
X-Forwarded-Encrypted: i=1; AJvYcCWXhji0RlXqsfVVhCctNMsOyU1urCIop8urDsYUEIAVqTcOj71r9nn+m3HzrSPn+ZgQ9tJ/D8byOqO5CRk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yymm/8PzunvPmqdOl7NdQI1NgwBWYPOjsbzSKH+3xGTA2JRcaFP
	h/4ZpBwDa74IIb/yjTmqKUz9tdG7kHIVPr8aojVnrLd+AvOPKbAeM7iwdPsjEMQEIMbcGLQzn9F
	2kinFv9EVEQruKa5A9Wit0Ylm4pWl7B+/yR596X82o0fK7BSM5srsJ7DXsZM935Q4wR7Q
X-Gm-Gg: ATEYQzzJUgvP6M0Oa2r+9KXG4svch6BFefjZn3anEn7YPTE0aHVDlrQDs+l3FwVM9GZ
	hvlxPRfyUAceM/9a9WuTDizdWh6UHXiHYTtWAOQNfHycycLcoH8gxfAYkCN3jkurX+1wT1Rh8Pa
	cG4SBoBU85FHxpyjLaj9O49lAwAmF0viSlf7oBfyOTw1yUdoLd6tB8YAgvCxpD3riIZiqAJEZF3
	TZFMgCjEmFFsncuAN8xpdfUUeZgZuom+83Vzo2Wyb+35mo3yCaj1zd7/UW7qhoMUUdwskrGQs62
	v/JSbd3Uri8lAUqekENetzbVDTFj1ynm33fqqypepPrAELRoEDYVIHwou9U5pCSXns11mr4GZca
	+NzEZmsebvpflAjXIWytum1M0S+SYLTlQ1N1W
X-Received: by 2002:ac8:7fcd:0:b0:4ee:1c81:b1d5 with SMTP id d75a77b69052e-50957de91c4mr213717071cf.46.1773754410746;
        Tue, 17 Mar 2026 06:33:30 -0700 (PDT)
X-Received: by 2002:ac8:7fcd:0:b0:4ee:1c81:b1d5 with SMTP id d75a77b69052e-50957de91c4mr213716261cf.46.1773754410160;
        Tue, 17 Mar 2026 06:33:30 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:29 -0700 (PDT)
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
Subject: [PATCH v2 1/4] PCI: mvebu: Simplify with scoped for each OF child loop
Date: Tue, 17 Mar 2026 14:33:23 +0100
Message-ID: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=OrdLwue7fdAbDzltDnJtmbESjqt0Rj2YqfvXS7hTKOU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVgiNnmMkn77MrcChhNDnE9rF/K8JQJoK2dTl
 77t/s4gkB2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablYIgAKCRDBN2bmhouD
 1ze4D/9krAOOYWKjH9emdjBtbBAWnahk2EslM5mgi96nhIwDz8xp6zxHv92avzFmuxUITKJG2Ue
 qDQC5EHqKRvpnbsuGY4fBpC5GPhprYTau0XfSKvNFX8xuobGppZ7HolxLls9lynLQ8mY5OIgHpu
 xLEclQTekGqPrstc54kCypI+K/xi3qJ8UVJMzjKE+UpQtLKX8WG0ZIa3c1rJOnPhKegExoZTjQ0
 QtHdt7PChdWXO2442uI3j0QqptigKqDF9bajSMKKTl10vALKZ5jSMT9UTAMJmTCGbC7nPSbnzpA
 xUxWfprrx839uBEtRkNnl4jUaLq6xj6EUqBOE0CCzyz1t3kcy+lVeWVqlZQ7E+KmZZSb2+5yvNd
 6niyQTB5GzbOdROK+aI8D9lwWAmdwRFrpd0uJGb7Fc6xPm+6U/e20FCrpCUS1iS7znNo4dsJaVb
 tx4/E0fV5zc+Cy8ecJbJyGN1Go01OQneL4EUvYPeYbGUWTstF17YeOnsr2VesN125X5KQJIz06J
 JGjMAMUPlf38PF1Ib/uVplTpzUNXUipw34KU07qZNDuBZsQtmvbYaZm7D0KprE17aPlj+1jvsuG
 EfI1zmzfrUQ7/YVVpu32BPtfviMLHZIwplLc6AMHVt8S+EguiBN/qVcU7wSOd5adXkLlqLHkp0p ynjQdNzofm2jI+g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UrRsXgAJtASwjxgN87QWE7MufQ03GyAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX5/VenrAwOHXD
 calDRFPz+p3c4V8beunSKcbDPmuHxnXDot5J+dnml7WYIJfO0ZnOqP1eRCQCDWU5AfXq+KVOb8D
 121cWH6yQnN1pHL+EkGaKX4uMy9uER+941t1vklojBqVShrW81bKw0ZfrnPjQEyWNa5W00powqZ
 MmhjWLZUn28XGhXojdK0HjZQNjLJF5RUfvY9TXh/9o+ZPsXxlL/LHj8UXbfpt0he6z/2A+nbaSt
 h5FqQRT3OxDMwJuvgxag6krEHRxNqgpu84ibWnXO6L0WsDIMLNVLfGRAgmV0iwAjUJPM11fN4D3
 L211q9hLiukJaa3bKnmwGupc4c/akScw0OBORd6zDwb9w1Ve4eontIISxKLKNtIUbz3BCN2Px56
 PhxB5VcmIxK5KcjxUSqK1acgsUBjgIRJFgk5u58LKYZ6+hNvLxiIYD0Lq4AAtOGWEnVxbNaBbWB
 CSlm0gjnlVDTsjGWqCQ==
X-Authority-Analysis: v=2.4 cv=fa6gCkQF c=1 sm=1 tr=0 ts=69b9582b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=r4sBWMy-QYfdzbUQJWcA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: UrRsXgAJtASwjxgN87QWE7MufQ03GyAN
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
None

v1:
https://lore.kernel.org/all/20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com/
---
 drivers/pci/controller/pci-mvebu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a72aa57591c0..4d3c97b62fe0 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1452,7 +1452,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	struct mvebu_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int num, i, ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
@@ -1474,16 +1473,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 
 		ret = mvebu_pcie_parse_port(pcie, port, child);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		} else if (ret == 0) {
+		else if (ret == 0)
 			continue;
-		}
 
 		port->dn = child;
 		i++;
@@ -1493,6 +1490,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		int irq = port->intx_irq;
+		struct device_node *child;
 
 		child = port->dn;
 		if (!child)
-- 
2.51.0


