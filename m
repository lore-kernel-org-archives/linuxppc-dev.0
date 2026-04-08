Return-Path: <linuxppc-dev+bounces-19479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B91FD5F68
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97x1yJHz2xm5;
	Wed, 08 Apr 2026 14:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622573;
	cv=none; b=H/8R9D1FMX5H4h/IiqciGpoVulL9H42GxmNTOQeU5VRMWpABgE5dD3GDSrQ3/HamuokSIiCl3NbgyLhidyZufDFXtIEuIe70AS2CXCoFGNVQy+alf/G7gDFDKe14AkByxrr3kR5nwykAVxFiRulGMtfBXPa04R5qEAGxewBtXRMMtK8CopVQysjhwAnKQjO/ZEDBNMCx1HPii4xtB//NOMKJzL5doESeWb4j9j6CFznxk6vp4vwQioyiBRhWEOvFKcNsLbenRSPpzqB5s1r7R6/KZiZZyivXwp4GigNIlOdcnl/UwjXR6pZl3toPUt4gSo34MiXhE753c4dGoKOPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622573; c=relaxed/relaxed;
	bh=VvVp3qdSSZLRimzsulinQPPbMCXRAmz6W6zFA8pWhSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbG2He40LVnCwWDGpMdymjHwS6eO6eCPL/qWIuC72nHvmBFI4KImVJi5d7Fm6I8oeB5ICXDaqYDYhPrQHNCmfghDSF5Plp2L7mgsk3uIrMmrTjNcpBeGfy2kNB+fWJizDlGFesq1u/TC4VDENULmOxEMdlUZuF7XZBPCmcBGY/OhMBs47bMXJOSS/HBGsA6Tlj9m+NQx+mB54ljEVa4eZGDw8YQijgpT7u/dWlb5tC/MhwVlYZmy+s/NE1AReV/bwffTy3BHBXo3NEbZ4gamx9xFPe3munXGb93rMHQeyqfLLvjYsIFl0l1GdZOZkA4PhvITZggz23PYMeBfARXdLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j1d5KMG7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j1d5KMG7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97w38hvz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:32 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EAxde2297413;
	Wed, 8 Apr 2026 04:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VvVp3q
	dSSZLRimzsulinQPPbMCXRAmz6W6zFA8pWhSg=; b=j1d5KMG714Z9XMQV76iLXS
	h8ifGspKVvSnLJNHn74wIgrrREhtn9g9vyUCFWwQwaGsQM7KJw48fjgtIvkRz54b
	yZJn6qDNcnAP9mO3OnJFTwcuxzmQ95cPvKj5X5r+c4m+8LXX/69isSbmbi7FDe58
	DnZ5F3OJuiQgf0/d8BNsmXZ78aFjEk3EILjjC3IjpIuYMR76N40/Y5bQEtfMciY0
	qPZe7F7bduSoetYOF5vTDZCNQbAPK7hsHnnA6wwYqNmCRx6cJTsGO7RRv4e3uacD
	1Kq6Ce0rjL7rw25wG898to2jDHUzwwiKE409mqFjyOPCcsHoXByPeOIm1Y3EPeGg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwrsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380FUsp026665;
	Wed, 8 Apr 2026 04:29:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384T0sA39453150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7761420043;
	Wed,  8 Apr 2026 04:29:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7EA720040;
	Wed,  8 Apr 2026 04:28:58 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:58 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Tiejun Chen <tiejun.chen@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] powerpc: kgdb: fix kernel-doc warnings
Date: Wed,  8 Apr 2026 09:58:57 +0530
Message-ID: <177562236428.1381144.810247013190608739.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225055314.247966-1-rdunlap@infradead.org>
References: <20260225055314.247966-1-rdunlap@infradead.org>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5d98f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=EKa5izcVqjgrP0ay7DQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zOz_aoVaOlm_N-m2ZL4xJQEl-EJ_qXuS
X-Proofpoint-GUID: KyVrDOmEiE4Ip5mmQBkIsT0XXur97qfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX964ALCPRpb3W
 RgwXWL8i80273KOeOr/5arUiQT63N8sOAfm5ckinVO0PkyZfE5VKBrRNt5M02k3zjRIYN7ile8Y
 /QZrkr5UV0R/UvxVzO8P1o2+SBY9nv8r4SQeTEBmF2P/+BfNlN6odE8g4HDZCRwm95Ng1kxrLXg
 4bBlu0Sv5dG2tJy4uRtHA1O/Acaw7sRy4nsCRGHY/UWY93D7qIjmbQSeBDUZion//7kHRKIKrS5
 PgEgqI7/HRxIbHqOLxQdyOLzc2qg4fu8czg+lGbS3KJKVNIOOAs+mhWqYVu4l9+ylhijx77WeBw
 s78pPrM+NPbBZVBA1S89w/u5v2ytglEb4YvZicGIEUHj/TZMwpPghVvOumzTQg7SybzBaYtGin8
 MwNsKkeKzSfVzx7KJdOU3lf3EFBl8F3M5OzalqXHEWJygrq+IGoKU5+BkC41OZHLlr9Ktaie7Mn
 odUAUVXG+ydlYtipsdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 24 Feb 2026 21:53:14 -0800, Randy Dunlap wrote:
> Remove empty comment line at the beginning of a kernel-doc function
> block. Add a "Return:" section for this function.
> 
> These changes prevent 2 kernel-doc warnings:
> 
> Warning: ../arch/powerpc/kernel/kgdb.c:103 Cannot find identifier on line:
>  *
> Warning: kgdb.c:113 No description found for return value of 'kgdb_skipexception'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: kgdb: fix kernel-doc warnings
      https://git.kernel.org/powerpc/c/7695a4e12e5506ddd17b05a5e1ef61a9bd315a14

cheers

