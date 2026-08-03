Return-Path: <linuxppc-dev+bounces-25248-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB7EC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:59:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vZ6Fwvz3c9y;
	Mon, 03 Aug 2026 16:58:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740298;
	cv=none; b=MZ6cmYnG88H0n1c/KCjRfwd7U7rzs5+g6bFE1ghJh5kCdQj7vsRfsbsjnURGNyW49lYdr4RB2FOtqiFFpviuRSLxma+zYcLMSEfPUVpFljyhezhCnHjabzPgaQggqkyhZoukCaY2hgZoIVEBt3h8ta1ozDBxfINv7/s94Q5/wZ0KfH2i2vC3Y1cpYIsxPQMCfXVFwW/H5ePt+ipNoY5pNqG4lhlrnUr+cHwkpLeMHiEkDQFoXAlGXksjqXUFEKKfrz+wMy+J/QzgkcOypw/EImxquuJ2IX2Ib5F1QbP4M1c4fW8APJvskjNpUS6NIcCRAUQ3v9KICJfy1ric870ZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740298; c=relaxed/relaxed;
	bh=KtoCxENRgnWNnm9NjRHLYj+yk+SY9AYaU0/ZvFcaCcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P99musIwbgwbv9/sAq5ZtVuPYVODoDvGIo4C4lrBwPQ+uGaYhyMoEkR/UPMifChwMdUhapDveFPIqGAtK0zBQJ5E5mK6n2xXgYh0Boh48Elv4SmFMli35FIaNtnhJFL1YMdqKdXpLamaz8u0oRXaTx1y57ETbm9RaNs5Mb7JcQT6xyBjL9AUL/qeEmByoYgT4+62NIUsutkDktO6IKJE3insowfVfLjhXgWsR59aaRKB+MRkOFnn7+9o4UFPWTGNqt77FuYHfSbfvjUbGDkvVLJhWEYen+IoYCDp7Fy8q1T14Eq1b3Z0jVvruLFNy5NlsaW31BmqC+PGD0bh9KPl/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PlbVF9q3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PlbVF9q3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vZ08r6z309r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:17 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmX3V292048;
	Mon, 3 Aug 2026 06:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KtoCxE
	NRgnWNnm9NjRHLYj+yk+SY9AYaU0/ZvFcaCcc=; b=PlbVF9q3XHn+6ZebtPiuJA
	azyciAZ935OBogY8/4JwwFGcQSzZRqyiwc4/WAjMk9ocllJvsGoTMF7byP+vnNex
	kHqd8/Aa5K0dKCgQeZBFRFvrDYreaRakvXvoFFViuxB40cchdF+bKzZMIiAdsG6c
	UG5gf378ZXHc45U/eE8ZcVszq51SLax+VQ9/VDNHD1pBSrl6YkefNzDXqyF7uWKI
	myYeqfsZ40UEkKXADwDeB//OHC7q0t8K3XpU0uw2CuQOdz3xapgxx+zCG1We5eCw
	eT55ScPUdlOXiUkpeVW73xy6hI8PM+R48PxV2rkSctZYetbtJRwgDAqFye2OvE9A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eueym9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:58:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uPDB017223;
	Mon, 3 Aug 2026 06:58:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg3xeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:58:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736w1PI28901716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:58:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEEB2004B;
	Mon,  3 Aug 2026 06:58:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 540042004D;
	Mon,  3 Aug 2026 06:58:00 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:58:00 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/dt_cpu_ftrs: Avoid separate strlen() in scan_callback()
Date: Mon,  3 Aug 2026 12:27:59 +0530
Message-ID: <178574013463.29744.13076129650653396434.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701114428.818748-3-thorsten.blum@linux.dev>
References: <20260701114428.818748-3-thorsten.blum@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UBq8ICGIVMpIIVuOuHn33mlF35fYwNNL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX6DB8izm9OyDA
 5C3cqVXqP2pju7XO7oO3hPlizuROEid2Hrt8y8qZiavDsMagE88jsiTfgo3RsUio9kPq49e+Cct
 9ScFD8P1akjEisl41vKRTfcOcWnNwTs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX18KiIrIgbzBb
 PglltfumOy+h3UN7OWLaNZ4ym6OPGZAWw+YL4x/g5wsv1vAxevS4HyVAQUM2N8SFLEcotYDtwnU
 XUF4pEmFOhAmXHiqdcBPaqKWCvgsTCgZo5lTAkpZgfk1ennkeJK41E7q7JDWN44bJjtBBLd3VQC
 QmsL0xM817nNZoJAB+lVb7T5VxFxwvhRRSedo3KOqPc/YZlfW/ezq5Hb9eGCjeaGgLZtx3giZuQ
 nOc+dEKXUOduGd50xDmQJ1vKvvHM4S1bV6XyoFHF+2o/zjL/tXpTf/ZKrk8Phw4OAteRiwuZ1o1
 QSsL2RVEt9a5ob2WWzIQA/uGz0wxaqS0feBJShP8jS+41b32X03tVdZs94svBB+uUnSUhZ6gq4v
 DYpVoZyTj3weNL3zKAnQnrUIOj4O9e/IFkMbynMUCslKMOGavSo3nIXnUAFeDjUL+Bg0uugFm9L
 kHQPz9ENgkRi0p0aEaA==
X-Proofpoint-GUID: s0gN0S3hSaXgP4UJQYO71FARjIPsUKgs
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a703bfd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=JPVlzMPHVr9AgFw0tlgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Wed, 01 Jul 2026 13:44:28 +0200, Thorsten Blum wrote:
> Check only the first byte instead of scanning the entire string with
> strlen().  While at it, keep dt_cpu_name static, but move it into
> dt_cpu_ftrs_scan_callback(), where it is assigned.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/dt_cpu_ftrs: Avoid separate strlen() in scan_callback()
      https://git.kernel.org/powerpc/c/b6cfbfd6b2992e3f34d255c983dc9f20ef0f5cd8

cheers

