Return-Path: <linuxppc-dev+bounces-20577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25281CD37AA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 22:15:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBRQw0bzdz2xLr;
	Fri, 08 May 2026 08:15:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778192152;
	cv=none; b=Lb7cdE53K4g7x4vB6vCB9qkoW6dciwm76uCfmJBhu778fRMkylnRa3FpTOBaf7gUh8jcDxMVuRLBPFSv+E9swQwfoyEJvKs5zW5qZuj2V8/JhdKVEzKzOY3GBtjbU3QxD9x1OY1zKzyVi27E1IeQbulZeQg0gX/dnVpmb8P/He3ZvERjMB7UYlL8tluan+2kuZiExVl2Wnd9W3cpSRp8cNdEj/onyYIBO4En+CyNNafutrNFV9OZoZGMVlzZSqYgk/zrnzKi5EEsPt4Tn3JgZx2E6u84MzqPn1lLqEO5UAD/mIIgjQwvd7jGQqmlA0zJrH0Naa8ILqUxR+P9hlwBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778192152; c=relaxed/relaxed;
	bh=pd82kARYfF/OWtzxBeksCCwC0hCxORVn9PbdtBQRWWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYwPAEpq6Xb9UIDiq2o8znZQu25e1n/1mCkEl1wcva0PWJyY2b8qIwM/TI9Yn2/wJqSPQ8AjLww7Nop6WW9rLptcVnVvRwfPoSiekFnQxeNhYQcEdFB/RqqJAbZ243QOdz69oREEZlZGVg654oONDFFqY+q55CqlS/zeROTqEpfkFTfOJX29/U1Du0PB7w8clKF6qIievPkNyL2c+8FRNV3+uTkYFjjo6k7voQersheR/+ONKmlNINzpD4MN6F04fbVC5R9cwEsF7nHPVpZ9O0ClOCNvlb+f3ZaqnGEkKTXgGovGw9sU8mgfUWylLm21aF2SH/C0W2MjuCytXYYavQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D4++BCZ3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D4++BCZ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBRQt3BPnz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 08:15:49 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647L9v403352054;
	Thu, 7 May 2026 22:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pd82kARYfF/OWtzxBeksCCwC0hCxOR
	Vn9PbdtBQRWWg=; b=D4++BCZ3D+7j2LA7GsJpK+bkl9wjKG1H2ZyFs65Rg90pqa
	uPnDbAnyF7UdzabhRFdBTgw8NSrnxb4CpS6k3Qb6Xyu1ZCyTWUGpcfuFpScHEEAk
	U2R8b1KFFUKVWiR552xAcIiUUqoTJddZux4MDd8ogtbK2FugeUxtJ6Js0ktID+Ci
	VIc0Dhh3NYgx4T/8vYvx3sIshdFDvgtwI24Z6AJYmDRpXFy0TprYpKytIEwseKUr
	PaQs46vZx1Ff2HJPGZw9vAz2oMUeTquoSjcSS0MqXrF6t3ZDpeFpJEoEIA/b/V7r
	5tP79wLqQipXlkLExgioBuZF8JbML+DJzJWQ2OyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxyvyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 22:15:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647LsYeO022588;
	Thu, 7 May 2026 22:15:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yngc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 22:15:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647MFYA832768692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 22:15:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B16BB58068;
	Thu,  7 May 2026 22:15:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F21A55806B;
	Thu,  7 May 2026 22:15:33 +0000 (GMT)
Received: from d (unknown [9.61.133.117])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 22:15:33 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Brian King <brking@linux.ibm.com>, Greg
 Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
Subject: Re: [PATCH 0/5] ibmvfc: make ibmvfc support FPIN messages
In-Reply-To: <yq1a4uke7rz.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
	message of "Thu, 30 Apr 2026 12:25:22 -0400")
References: <20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com>
	<yq1a4uke7rz.fsf@ca-mkp.ca.oracle.com>
Date: Thu, 07 May 2026 17:15:33 -0500
Message-ID: <87v7cyeuii.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIyNCBTYWx0ZWRfX+qjfXbOyhclf
 VezDIHFxM/2ZaMomx2kdC/GdRGbE1+/1yGnmBZLuMcWAz5Szd2przKfe4Hj47azl38hgGTmP1ek
 vdz7/QJShRsvVJ01EzwHquP9Yt6ArO+7+WvSQccpi+NMOfbX6vfadG05YPY2IIaDm4/vcQ2tu9p
 TKKFfS9YhvnQ3lhtUYsyjtOla8EjdYTw0w3CsaMuLOm6cbZVLVxe2jZof+O82nEARdF/X2qmYgE
 C/8wCNPP8B7x31IW7JW6rVsbNqZvfid5US5y49TihMCeSCDhO1sdrgkFuv7WESTKrwIU56YSUOr
 tk8G9r+NKBmV6gf1+WQtcGCxXf+OTXD8zsYIXLoJjO7RUE2Hne15G2Fmfb+yjh63oTWPxpMVa4D
 +fKvlrecgERwGilDJGTF5328qDkaJaL1ykl/stj4wrsyoUNpwBGc5Zv4KVTea9aAIHoJGHasRZ8
 vdfXBDMGFerIaz5K/VA==
X-Proofpoint-ORIG-GUID: Gy7avUC0bnSDmK0CpbJvLuEBhqReEdci
X-Proofpoint-GUID: epTfpkS0T04FAU6WcH2o3u4Rtv0FNcuX
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fd0f09 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=WTrqvD6glLJKJjPRz98A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070224

"Martin K. Petersen" <martin.petersen@oracle.com> writes:

> Dave,
>
>> This patch series adds FPIN (fabric performance impact notification)
>> support to the ibmvfc (IBM Virtual Fibre Channel) driver. This comes
>> in three flavors:
>
> https://sashiko.dev/#/patchset/20260408-ibmvfc-fpin-support-v1-0-52b06c464e03%40linux.ibm.com

Thanks for this. I'm working through the comments and fixing things up
before sending out a v2 patch series.

-Dave

