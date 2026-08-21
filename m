Return-Path: <linuxppc-dev+bounces-26043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A8C5DF94
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 22:46:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRb5S3QjKz2xLd;
	Sat, 22 Aug 2026 08:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787352396;
	cv=none; b=XdQEa+hCAcnD4HcwgIONrP8uhGhvVEku3F5+stqSUeu02E32WyWEnUNfJQl8+AuTq6l7jhJreE8qkkRK2T4az7Sa99nSSj8a55ah26zuiSupFJX0luVXD4nLVWbblIO0IHleAxQd2DWDVnSJg1H3tAzGfKHnPa6uoziiVRoHGwOtaame4e5jfAOmblsZg5KZcAR5fSztI98j+K26/eluTU4XeXAZ16qo7gRe4eSsF4VyH6zAmCQHQdB0f20QbKj8A/5Kjuz48AThQTyMB0bZyzJSmhYKw/hI8ZFoX01fcVKRpGhzx3yXedT6KFfRNtRHHoP8LZ6RFh5I0wpjeaWbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787352396; c=relaxed/relaxed;
	bh=0L75nXlFEC8XRnTslyoIJQz0Efxfw9SzcspEKJMQRhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNwrbW9Xy/ptpvJ8ys8LWXNNK3rnp0EaBXU3T6OLDfoumIeo60DYRaYkhjNo8LD61QDbNz8au8cuW7uIKVcpFc98HFzcEuSGiK6BgDS/NumLUsyp7J+Cqrw6mjprVKmzKqxlxWj8X0LhE0UGB6vBjpT7lcKGPzHNAgp774EetnrkBnBSBWlDQoSBnuT+ygKa+S3XVwh/JYYtqqyLvm0hgylLUOWWm2SWiCVvzwk1+EGidP9sUlm0A2Kxzg5PNrD5iT8oNghBkNRuN89sHiN+DBLpd8qPOl7WhyEjQ5uxLR3rJqQnbjukJ9fJ98Hxn3wiJyhzMWnpTskLKGFGNvIsbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U0GefJvU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U0GefJvU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRb5R2DBJz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 08:46:34 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVVsR2314678;
	Fri, 21 Aug 2026 22:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0L75nX
	lFEC8XRnTslyoIJQz0Efxfw9SzcspEKJMQRhU=; b=U0GefJvUK/s7GY720orkBk
	cBu9cIUTDnc2yaBB4bfMqKX/EewB7l3Undgttt/LB0+3iOFhUsS624pSs4y7h9U4
	36vv15suRBZ4RYQaqUSgvu9Se8UtsRkl301KzGBYxyuxULdeg3b8kQTsBm52dUQ6
	HRLwFP48HKiQX+huTD4YN+1Vb5FqHvEORN3QmcXNsY5RmJXy2+DnzpVw83conLjo
	fRVoOFEip+2FV/8NLBz7qD2SQBQYPVSPlmvpz4vhwbNWYQzolfjhjfKlAIJ8cLWf
	pzAkbSQFjl0AHRLq2k1G2XJerYOT2xD2/7DtQnJZPesLo5zinXQkYuF30twGcxmQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1vmfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 22:46:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LMfHmp026606;
	Fri, 21 Aug 2026 22:46:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekqds4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 22:46:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LMkP3t61997472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 22:46:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C83965805D;
	Fri, 21 Aug 2026 22:46:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45D7958056;
	Fri, 21 Aug 2026 22:46:25 +0000 (GMT)
Received: from [9.61.9.186] (unknown [9.61.9.186])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 22:46:25 +0000 (GMT)
Message-ID: <7a8fbc90-3086-4026-a3ac-b683d4c38d28@linux.ibm.com>
Date: Fri, 21 Aug 2026 15:46:24 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ibmvfc: Fix use of uninitialized rport in
 ibmvfc_do_work()
To: Nathan Chancellor <nathan@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a88d543 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VxpQeIyN2eE5DkSZRDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cLZl4OKhtRLSIq0VgK7kfEd2Xzjozdn5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE4MSBTYWx0ZWRfXxHi+D1JP9NXT
 Vkdx7rY/JEktYFfbV10IrR6BpXZTh9farFPfNEO+qAnIvfxuBIHUX/UbiDVTMcXemgzKtuh5kik
 18XP5f6e3b82kEIrisBSHeA34wSUr/o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE4MSBTYWx0ZWRfX8Naul4E8hyTp
 HdmGA72P3g4ZoUQTPEBxG3pwiYPjb9jooy7g2aNf7aIMiqajPd41gRtmOuZkTcZIVoPoeKLY7wT
 FyNN2c0rDfV7Q9ayBE46SEUpAkQyotj8y9uFY0oQ9eYSxY++BXEzXa/mZAwc/5wH3UWBHhx++b1
 xE41+ZDC1wBWl6vPeBkmym0hGgXPLzCQhcBryhoIeL5E/0MsUQMIhaMuRmIz7IuJgUN+hqmU2Lx
 0E5LEymxxmqPwHVkxJJnDmOoZPrNscNWCJcidebyz6hCh501tf7NVIhQZa32stm70jZ4vehsZU9
 ZTufiu6LRBh5oh0W+eqqM2F85/31MK8W0+s/uaVslE75OgykjFmLFXLqtrDTIExq+2jUKv0Vw3y
 MrYWQlq6PRdADG8mo44xT8XbX9nJY3e829upFW/WsO4cAFeXjtYxMejnIGx/3KOTFYo3BWxEFFM
 LGKwOYX8WnBwdT6XVcA==
X-Proofpoint-ORIG-GUID: cLZl4OKhtRLSIq0VgK7kfEd2Xzjozdn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210181

On 8/17/26 12:04 PM, Nathan Chancellor wrote:
> After commit 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work
> thread"), clang warns (or errors with CONFIG_WERROR=y / W=e):
> 
>   drivers/scsi/ibmvscsi/ibmvfc-core.c:6154:15: error: variable 'rport' is uninitialized when used here [-Werror,-Wuninitialized]
>    6154 |                         } else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
>         |                                    ^~~~~
> 
> The check for rport is unnecessary in this block, it was accidentally
> included from copying and pasting. Remove it to clear up the warning.
> 
> Fixes: 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work thread")
> Suggested-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Link: https://lore.kernel.org/6ccbe8c5-beb6-483f-bfa4-c2d3819ad5f2@linux.ibm.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>


