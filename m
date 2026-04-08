Return-Path: <linuxppc-dev+bounces-19461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD878FD5F6D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:28:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96t63nDz2yqs;
	Wed, 08 Apr 2026 14:28:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622518;
	cv=none; b=hQdSR0C6QCa6QrFQ44s036I513T0W/elddQtIAP7FIxRPXW3XHT45Wn4xw+89L3/sGazv5ciiMkE9lnwac9nHTFat+iLO7qYbpLJzyTIQekEljTpyRks2med1QQmAGVqlyVvXTWEpP97/iX/DjMUe14v/RXIIvk13KNifiF9VIRlMNVByf0j58+hpO2dNJIjC/zFXIxhW1QQOMMD+oy66R39Ib5gJcmsAaOXS4ODO8DD0lhhZ9McO6EKyu+9vZ56/iIcRAIahZj9slk7rfYNxAsh8wXMer+k+N/+rmyXiVxiv9mDWdtych7sdccu7VvcVFKobrvA1IMZ5swkJiA2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622518; c=relaxed/relaxed;
	bh=ESki8c6JcPuF2NUqcgxSD2ZkOv/MdPun93qg+ZRioHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heAbEOKolAQTO1KPBUwFMg+KL5gEomDhuMKMI2ukdtKf9SA2BEZ2xDiELn4kjJ3g2X/zECVcfJQ8O0tqCWGQ73+5husWzZUME8yb3nE2gz+g1Yl11XY5U9hVhF1ZDsm0AThKu556Aii9En5qNzp99Crx6zd8kt2MNVM/BUhe4uqTz6wJqUYhPhdYFOIKb3LteySKQhSlxzDyhs23kpzWyst3TF9qAwwiBuv08L5ECwhTlDy3GRvC0r94PrNgJSxAvul0ntaGyoCUdHZ9nsidyQN9CBlfKWEEpeEJ8nFQggb9d+SXgLd0HOaHuYECFKxyYUemKaglEd7qIPxSTzdoyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EFlYsn0J; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EFlYsn0J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96s70n1z2yqP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:37 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EtMif2211769;
	Wed, 8 Apr 2026 04:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ESki8c
	6JcPuF2NUqcgxSD2ZkOv/MdPun93qg+ZRioHQ=; b=EFlYsn0JK9qp6BhZ0JpBKf
	Q27lxsHZUeLW8rSDg7n5+GGYF0ebsG+zS5m8WahVAqZQo81hatiA+1NFZuOrr93E
	GjlGvj9nU5kenG1zQh9LB3YRiJezXRaEQjLpopI4NIm+IP2KSwWaBhn8O8Ahq1we
	qe8OyV+tK6qsRhIbbTB53uUBbGXQMI/D4uG+41Wtvnr93iRXlMpXHAxo/oSNj9Mu
	5Py0fTcHCdIfShzeKYKicRJF5celrYNur/TA5CF9FMvyFtw6prrOms+NxuISleZv
	OAIuT8eHymSXK3UMJGoFXWQzTzAuBf1lhdXv0AukPRxHKId7Oi0QNDF+huf5uX+g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hdqvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Nt41i013882;
	Wed, 8 Apr 2026 04:28:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf46051-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SNj546072318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 671802004B;
	Wed,  8 Apr 2026 04:28:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E5620043;
	Wed,  8 Apr 2026 04:28:22 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:21 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/align: Convert emulate_spe() to scoped user access
Date: Wed,  8 Apr 2026 09:58:21 +0530
Message-ID: <177562236432.1381144.11990579475809342693.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4ff83cb240da4e2d0c34e2bce4b8b6ef19a33777.1773136880.git.chleroy@kernel.org>
References: <4ff83cb240da4e2d0c34e2bce4b8b6ef19a33777.1773136880.git.chleroy@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX6vy2qaSCH6FV
 lgX3wczUbPp8C4+MzpsDeQanIZxHo6OqEGCx3GHY/WJIgOh9UJWqCZ02UPKMNALwwAgQ1Oh+rn2
 gixH/rhZ0zFICLAnebFU7FsnkhL1a3Vtk80WtzFHRpGfFb4YoRkkypB0nIihMq/gufwqdaOU7vi
 by6OYwNCAPLOKrzw6Kl7dapCiOOVZvOmtl0yEgGu8+xEfDxD/ek4f0/xeYtWwc1ph6e0X4QwN2C
 PgA4Xiv5EUINW2EmtFGX+Gh51eG91/VJNO9axEwHeM04lcId8GDOi9GNmHHbDa7p4GhiRGK7IEg
 LwUSOwC+wtA7ZvpFxn5vSN8H0MeTuNmfSL+alAJCM1nvEwL3xjaM10WWIJaCj2JybbwZb/ru9pU
 IsFXkYVuPJRhuPJPklGsfSovaUBPsE3XDUQsUAO3SVUx/UjzlptLixsD7Qs74daYImpoF2xVt/L
 6E0buSEyLCXVf5YdtlQ==
X-Proofpoint-GUID: JEP8lBCCTqhjJb8kEe_9wU8XL3sWFKjM
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d5d96a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=Xnn0j8UZnTOuyrh_SIYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 4wPuqsSczx8-76iqI99YRsYa4axC4KDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 11:01:31 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> provides optimised user access by avoiding the cost of access_ok().
> 
> Convert emulate_spe() to scoped user access to benefit from masked
> user access.
> 
> Scoped user access also make the code simpler.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/align: Convert emulate_spe() to scoped user access
      https://git.kernel.org/powerpc/c/bf53ede0038fe2a7b02cad85f337aba43ced572a

cheers

