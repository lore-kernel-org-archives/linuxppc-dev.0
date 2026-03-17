Return-Path: <linuxppc-dev+bounces-18308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6B6FD8766
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:09:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZsjf6spvz2ynH;
	Wed, 18 Mar 2026 00:09:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773752950;
	cv=none; b=FVdCsyzLcqeR/+Jkxv0DlipLxdu7Y/j6W+rmumGnMMeyv0zbp485oMaAwRmqS5hWK/ISJkpWzZxLcVbvVpe36ZoBhg4lUKCa/ZxGfBoUxwzonfB8H2nofJ80Jgjd16oQI4auTEmR7kOJJZalU+lAVwCHv5LU6zbuvdsL9ceI44kyn8urkKYD9368ABCqP7I+73HeYyhnmtkv052vFjq3qWAo8H8RuhSGmpMYZVADbclwI6q2rrU88z9tMgZNbNxkk0MnSb5T3QwWYlTMiUc7SNkCQaeIKgWIvZ6hL2pOtkJL5rnEZVIERlEs59DyrluO2MMI18Hl+MIVm9D8ZshQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773752950; c=relaxed/relaxed;
	bh=GQfb/tx4D3dbMU3wHuC9nFeG4ztBltIEORMYAwmiZS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDqddfZteizoEDVNjFfColoNDBnFqP58U+gupFkLRgXsMe+a86xLXrflTD+CsTUInNcI0BColto6J6h+o/UwurqHr9Rth6L/Y2uisF6qnYFqk9N1cmMr8iEeRmQuTFly20nwYRjiQKK743KJSo2efJdDzxOb0azmAAp78ywSvtbm9h9TvyoxQLLQQ3VaRkzgfbKKzaY3dC9bXKR/GdohtAvzeCZ22EaZeABdKifX4lphAVoBLN1rumX3MQ/zbZNJsnyG/ODYkJ2zAYQP4mlTBjfcx/qEkT4k40kvG1vPItOqkOhfVmfIZRkwOA2qOOB0kszU3mhGfy1FOi0MMU6Vzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aCb7Qnvx; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SctnAmUM; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aCb7Qnvx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SctnAmUM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZsjf168Pz2yfP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:09:09 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7JHCO3124248
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GQfb/tx4D3d
	bMU3wHuC9nFeG4ztBltIEORMYAwmiZS4=; b=aCb7QnvxVBIt8Rg5Y2sp4jsI7cc
	nQCHxQGS2H7wq793AuK2tA2+Uy4bOWgRIFHTMnF0DueWMcUa8SwuGUQ7Ac7tfFpR
	8NkH0teazLN1wzs/5GK4DFB18xIWQGoYxaGAqt44NGHmuGeWGR0IYvHMYhdMjfW8
	9IiKtz4jL+b3I6TmhVSyAxO6+UZTfjzJ5QhHLMy9NB2bbVT99GbM0bIQta3mJSp2
	PwsErY6zHN5YvokkesdNe1fC8b0Sj23D7npfN8NI58KpZKXzwXazAqzBjeULmgcX
	A5eDV3/EHYdSmmwggAwB2PV87mI82wSwCWGStmp10dJ8f0MosGPbJcaOMEw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy2fbs8fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:09:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd773dd409so785257385a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773752946; x=1774357746; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQfb/tx4D3dbMU3wHuC9nFeG4ztBltIEORMYAwmiZS4=;
        b=SctnAmUM1nkqWrqK+G8610d4BN8Xq19l6XNxuuQEz4nNnZJeqC9Sh5nf6GweNfkdLR
         kFMPt5NNhA5mr0VYMc9iqSX/bLdHYd3WqtJrNGi7uClri/X5aP4M5Xk8vv0/ZnAfA0K5
         2G0IYIsT0pwA1NB9Fudj1qouHNme9xTEPl5jqqwnHuxi8o09nHvLqUBG38tBLUp++11a
         b8WHxI9r4KtqNoMuzVzfr0hHj3fVxT/QW50K6jpwYT4kYxJu99cauy4eD2wsZTkAE/Sk
         UJVTeYlsEzbEicfkS4oz4cKw1aWENwCHMMWMbS89Z35BdG55oC41QKJhfteszf/T3VHn
         lvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752946; x=1774357746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQfb/tx4D3dbMU3wHuC9nFeG4ztBltIEORMYAwmiZS4=;
        b=ns77jHXR/bUPVgwnrIn2b1kbp22pvVlVi2JIVDXWqVSlPMQry4690kG2yUiLyz5qLP
         1Wu6lJ/uhGhlyI+5CeoAKx9H10+mJS1JhEJJogX5QlPIKkCCqC967rrv72UVr4t5+TPo
         bqLZ+DgWO27IOuNqIJNZuS56oze6rOvS1qEuUDTWpLI3Yz6Tr3XMkFujYHKmkfu7sGc5
         eXKPRYMmsNfLdJRyrTdElGn1SrP1iwIVVOn4ACbMcOvD357n87TFPwe6crxGOfZOR8+0
         c3qvnGzYdYjnZ1Vy97otk2Z+cqE3vK2Ci565VlcFibp4srHz3pJc/G1Vs75/bB646ASd
         8iBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvysysDnss4xcWNGZjdn9oTeN45HFF4TvJGENw78jQtORGxzWFePCFCYIn8yzSwXpa93Fy1D8mzZt1cXQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPlWjBC28zVxt1CWWw6KGuoFVXU+4iAsgnwKTRLJHQr7wAAp3o
	b243wAgZ8p4NI1C+xafXGOrVsjid45CQqM30KsUufBrQkQHZZreqMzKYZTrqjsg0WDh/j56y7oh
	qj2vI0SS6Jl+njQW/gZ49avoUTtMsRM+vKLZZgRrvIXcdZRlV+AifbLOjkZ9n2rIJoKGv
X-Gm-Gg: ATEYQzzhD0RCAzEVbLe5V1alTI1QmnqgVzmnaAiBeFzQWwWiafxXKQQR7j7nKTq7rbi
	lAbni4vtPVTeijOugBz7KFzG+75WN8TMTZ9T28nCyOV6Nnj9D7Ym71WvGN2Kuug0uxzXKLoOsWZ
	dStiU76fAU/GnrMnmTkHahc1Zyxz0f1W104TtDD7foTQiwaKRY1ZtbvWFPjriOEUYr8IFaSxKs6
	OscjnlzKsWKtqujktHOl6g/6IOCzFoy88A9Izkse8gBsPZhyQE4Yrd16V0WbdRV3Q2mGwcQrlgx
	SWkFxU1kB23U+X63xy8eGhsJYfWaObaTxHm4YFcfpDX9YCcncC8hqpbUlXCUw4eOT5vQ9WIbJRK
	WT5CUfV4tlQzSF5JuDv1isYh1IO7XNRniwI3N
X-Received: by 2002:a05:620a:2590:b0:8cd:aba9:d1d8 with SMTP id af79cd13be357-8cdb59ec31fmr2194718385a.7.1773752946408;
        Tue, 17 Mar 2026 06:09:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2590:b0:8cd:aba9:d1d8 with SMTP id af79cd13be357-8cdb59ec31fmr2194706585a.7.1773752945512;
        Tue, 17 Mar 2026 06:09:05 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b46b41eb2sm14570171f8f.1.2026.03.17.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:09:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH RESEND 2/2] powerpc/pasemi: Drop redundant res assignment
Date: Tue, 17 Mar 2026 14:08:25 +0100
Message-ID: <20260317130823.240279-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=96SWoAibFV3tjtjEQPk9F17pt6xqar6t60Ckzs1eJk0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVJIwjT4JHgKt+40M9i+eQ/qn1bin5yLqCfJi
 fq42xL0wUuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablSSAAKCRDBN2bmhouD
 1x/rD/91QuQeyjntuB6bcfyRqBBT4uZec6/6DliAsD101EpLame/EOIb7GntPK+OYBqhWCLx/AQ
 JQlAXbW36oKt/oYnhIU+1/JKDKR/eFMdsaWAOTbBIMk9GD8x+0Z38/qaTQrr626dR95YyVpcKKt
 8sePby+myDxWCOnyRZLsmJW5ftRm0wdRcWINao/RvPg7gkSENeUo0cGywbskyRj7f1vjwFn7foi
 /DBSAtNEQ6zg9WhlfYmp1bSmK8MOlSFdZV81OoeatBEQSrt6eMNgPb/78GlpYPj2CDExZ4pB7/X
 9Dux6Uf83R1tKlTcDT1La1kn8BPrhhsx5vPl7qD1UbCzyW4Lp0Z3XIWq2crsRtBvYipHsO9GWu1
 bJn3CxSpEDJ9ruXeYROAPS+4ks2NRagBtI5NRrMnQWze46ZgFEyewL07K0k5RYMWEaaRNDtfSbC
 F1tKdjQUd8pvLWBGYAH2ot7+NRnp10gMoSGbIgWR1kKPAGJnvMMN28t0hpp/s4t/BQjGrfiCAfS
 ie3f87BM6V16ALIDkBDbUmOv0YozVDUudcr1FKvo9fB6vKkf2rOWAj5xLM0x+HnGLWuzCdmmwAT
 6f8LxFbaimYBnv8djnrZRy5C5n/wgBJjt8+LpjFzdNqKV+n1EVAmE8jnGkfHb3Qgcm0S2f8xF8v yCl5VuMAGjzlUXA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DzJBxjFVy9VBRJ8qOe1drHBVcv7V96Dj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNiBTYWx0ZWRfX+V6mI/EBd7wz
 gRVvb7DqsWBF3D1+U76p9188X8HF5ypKWEJTe6k5Mz/DiSBeU4BIIzqQSkyJxZ/LJwnSC2QbJil
 2tUm243PCO1oDWuDfhdVq40mguGN/P2Lhk3hK1m/Te+FABoxvEMe25oSdt0RvRNz5vGfm9w1CjW
 t2CDODCj7op7MECwM9aCbJDkO2HWK39skK5inTeNnjhUE4lTwW+lFtpuPOsxog2so2+maUcT353
 VBcOnYBNYhrtg+bV+3LKji5bbCOVT8twGoTZUHM2ms2rObpB9eaxMAG2I1cW8ROsH1RfWrB/ZdT
 +0EjsJixl+MOiu4FDoBOFP6OsS6QqEQRCEDf2oGxt4ZR0EMMu5d+5dcowCkdcWe06zXbTVXt6+X
 1IAykZ1a8fQBufDVyiRwUOHsHgPD2XuckZgEQ6p+j1oP5FbX2VKuyOES8aNp6rfz+z6WTvOwoT3
 b5u5StD11YWprTT3Dgg==
X-Authority-Analysis: v=2.4 cv=fa6gCkQF c=1 sm=1 tr=0 ts=69b95273 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=qHUQlxOfq5TjuF48b3EA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: DzJBxjFVy9VBRJ8qOe1drHBVcv7V96Dj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170116

Return value of pas_add_bridge() is not used, so code can be simplified
to fix W=1 clang warnings:

  arch/powerpc/platforms/pasemi/pci.c:275:6: error: variable 'res' set but not used [-Werror,-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Resend after ~2.5 months

 arch/powerpc/platforms/pasemi/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 60f990a336c4..2df955274652 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -272,13 +272,12 @@ void __init pas_pci_init(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
 	struct device_node *np;
-	int res;
 
 	pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
 
 	np = of_find_compatible_node(root, NULL, "pasemi,rootbus");
 	if (np) {
-		res = pas_add_bridge(np);
+		pas_add_bridge(np);
 		of_node_put(np);
 	}
 	of_node_put(root);
-- 
2.51.0


