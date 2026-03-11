Return-Path: <linuxppc-dev+bounces-17995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8E1FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:14:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTD36Myz3cCn;
	Wed, 11 Mar 2026 13:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195280;
	cv=none; b=RCk7RlgwIoqQ+XjTia3tEHBjpo+ymswmpO31WWbd2nKNKYs3oDG6lv9T+/vJxdq4fs81uOmJlorHLCG1T05bRlvkJ2u+LNRBMPMHj2FWkyEiNZqNIPZIzq6eJfxg3Ho9thZh+ZlQ/OtJOdrVfZqL5+dGuzLDAaYtCylPjtS7sVk5w+/ryu7oLMSZmLxG0AkINys66pI8DhpLxC6KNa8oI44xE6MC72xliwslxxwUEz9l67D5heYY9Lj/ASynjof0t2856ncAb3/sRPyOd8q28gfDdp9CRONZNXAmJAnZGC1RcNPf3eK7u+11i9g5Fdcvk1J18nQwRV7vj5vr5mYjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195280; c=relaxed/relaxed;
	bh=2ZceOk42rdEXugzjAGSRfQyEii6gNZwu/bJn2eegNWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGbqfv4+/o+sMfTRE+o3NDHb0n6CaTYNaexxAnCFacT6pbf8XOJAgtmodEXi/Kh8Su5zT02d1JJILuFmFOtVdonLF4o4VqhfUQF/zRSLfXnHEv5byATkTWpz981rKrlNIbk5stq3gY9Hct6irxlG6CxNIWMSgrxwQpVfLkfnS7HP0g59fpdC0B95gCFclnnmQlcbGzAqcK/yEx0yoQg4fPjY4WAWQfR201EzhCSJp9vnJ3PycRcQ84UE80a/QubwpbYNi4NOP6oKH7UHVYTEZebsneJlQQN3wSFI4710xDYVmdg/QAkxxq53Eq45seK4T5W/h6gbXuOEcvdPWdHo5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WW3IgNdu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WW3IgNdu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTC63DTz3cBP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:39 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AJkWSZ1524531;
	Wed, 11 Mar 2026 02:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2ZceOk
	42rdEXugzjAGSRfQyEii6gNZwu/bJn2eegNWQ=; b=WW3IgNdutfTc9AYvNYBMDm
	HvoooDuQJBZ40CXMkmv0B8HdG/bdsOfAeKi2uMAcEvnPzZ0ZPGkLA9fKN3vJkeic
	NHX4uAVtqn5b8Z7JHeap+pwVEt2es3//N+AKVVr3Y36VKb+sJMwPhW/SflfiGprF
	C8aB5xJTLIn6k8xHP6SyO6L/EgW1DhAWxE8aH7E1+xAam8WGzh0CFVsvcdMsPJf4
	1ywXE7FZsk1W7euMOWNL0uH85/IMNQZkxJwKkASOMQAKOwv+W/bHaf6EB0K0b90A
	N8gh4VEu8Z48mBuhIPfQG/0wpWMqqsSvljZgbkxDw/8gVNDxAa0/n8Qydm72KiVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmdufc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ALKPFK025052;
	Wed, 11 Mar 2026 02:14:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk3fs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2ESWH23724328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 810072006C;
	Wed, 11 Mar 2026 02:14:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587042006A;
	Wed, 11 Mar 2026 02:14:25 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:25 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: fsl: Drop unused .dtsi files
Date: Wed, 11 Mar 2026 07:44:24 +0530
Message-ID: <177319508337.269267.16812187725403935492.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260128140222.1627203-1-robh@kernel.org>
References: <20260128140222.1627203-1-robh@kernel.org>
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
X-Proofpoint-GUID: hCYDyKHWNdjAoXl8sTBYY5Yk76KZBsq0
X-Proofpoint-ORIG-GUID: ekoJEsiTHtdoQQ4LVuqf-mnYOUpkl9We
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX1Z53069OfAF8
 l9k32Xe/ddRW1NELIzPRxp7EJa62BzLSPQPunOPDJT6UwP63z7XaEwXOGxSolD8FQCmXhsMl3GQ
 w+RCGjClj6hOd21VMljOegCkTlPBMmCyi+5KWyC39Ttm93XAdERlTw3rO+Y2pqWkjA2hFFFLE1M
 fPSMz8+dLsch+CZePHyy9ZWAQ0AGhoc1G1INE1fClpIJDdD2hNBfZwENdiWl1xt9ql1MkPkKnVs
 cgAu715zF8Lh/HYBbD5QsGpelOTKlJ1TGukv0sJ3ADnDhVdVRxZbcfibB40TUfTbEMPZsobcPMY
 Sz+AmEqMXsqkOyowobXc3DmdDosQzvHatiQ2atYDtyvQ3R/NNONwvNdF1eit8dmHBAWY5B9lcP0
 1wtlC5Wlq4uhO8ZfD4hJOIp7neBMPV5qDkbJ1TN68hvZEzBxSKyXVwibT+KPf2jHaZMbvALgaVH
 3p8sfObWh2BcsxFwZvg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b0d007 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=ojrkqjeVVkUaGn_0cJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Wed, 28 Jan 2026 08:02:20 -0600, Rob Herring (Arm) wrote:
> These files are not included by anything and therefore don't get built or
> tested.
> 
> There's also no upstream driver for the interlaken-lac stuff.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc: dts: fsl: Drop unused .dtsi files
      https://git.kernel.org/powerpc/c/0706178339974d4332a782ba851cb6694bd210fe

cheers

