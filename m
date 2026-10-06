Return-Path: <linuxppc-dev+bounces-28948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABBCA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 08:00:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzTFp2Vz9z2ygK;
	Tue, 06 Oct 2026 19:00:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791273630;
	cv=none; b=AmxjOhetw3EiabC+2zTlfituNAiFvJdOSYE6DdNA1E4vzHgoXvUZ5kMoCe4JVqbne/gBrm816BdNeCkXPUOoYzuQf3ysnhlP2GIowGLJzW2BQyq5eB8mopbKeZXODP9/34334Pqyu+kqGom6HmyAKFMDiZfVPTISXYz9S6/fzvu6rDlqd2urIH1YfBnu5cG0nLeh1+Hh35CxJSKHVw51CpnRlj/YRWvfk5139lc+lzyndjYO2FdpVT3iQy8gnmcCRAy98h/aiJvSYYaTT2IzD5a5yCc+3ro5fqgTVM1Gk6pGOOzyxv86dbN4M9tBJ6IMBGx2cI89isogHN3rkcAbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791273630; c=relaxed/relaxed;
	bh=8xXBT5Aked2FEbfHnXuGzWuVbqOHbCJ9UiSAJLcbY9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Figfcm8paI5ovQczGO3hEhpIw4MeDAyH1OtPUOhbM32OZFHCkrZg7Qr/3JQOHCqfJJPo1wtSDjrIs/WgjHovE6+1SyOEfNXoSieyFfRp2MDAZcndVEFPU7LlQQadqmHvZiRXoM1tkBxIJj5A8OfT6ROpWFAejijEhsYO9rHZs/bbfX40fXIryYWGH0itFYk3ozScQhTG+yqyXhRp0vuiYGkAyw17dTQfYRg6MNVPFb0DAU/NjqCTmDpsnHua/sPyziixnz/3rlZIHZavZIYdqX3fwtryJcyQR9LG5MBqqpHVWMvAeSgOHEiJtscMm5A7knxk/SFjvzhH/4b8/AjJXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FJCS2rNu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FJCS2rNu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzTFm677nz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 19:00:28 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966bO5v2906482;
	Tue, 6 Oct 2026 08:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8xXBT5Aked2FEbfHnXuGzWuVbqOHbC
	J9UiSAJLcbY9k=; b=FJCS2rNumivVJyzht2ldJkWwNoN20t6BEHtxNDahiJhamo
	hKQetpxnxrtrKZAAFf4D0kKLnk9Za8Y9+I/qKv2FE9BptAktx1Kjq7/JZVD5BlM2
	8LzAarSq1kqnzQnMDT449HoGm73P864ValBVMv5CJ1K5I8xnab1UWR21dOyZ2e0h
	Qwb2GgK8/Hn1aQovaejzJq/1nlDtHglwjFF0oEM8FV0bhzuZJbROfHYiVmWdpN24
	poXR8M87frGHL1w8MnzYmBEjTQdae/xPfDchKB3UtmAO74iAGINrAkRt05fBO/RG
	P1Sx0GWUAYQ8Qpvzmm5ms3LB97cfVblIbtFGxQFg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5eqwx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 08:00:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6966lkE44086089;
	Tue, 6 Oct 2026 08:00:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1js061-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 08:00:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69680DYc31457542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 08:00:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A98020040;
	Tue,  6 Oct 2026 08:00:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E498420043;
	Tue,  6 Oct 2026 08:00:10 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 08:00:10 +0000 (GMT)
Date: Tue, 6 Oct 2026 13:38:22 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Subject: Re: [PATCH v3] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <20261006133717.4f51adf4-bf-amachhiw@linux.ibm.com>
Mail-Followup-To: Jyoti Gupta <jyoti@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
References: <20261006065945.391637-1-jyoti@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006065945.391637-1-jyoti@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMCBTYWx0ZWRfX2wsLMclrH0TH
 le/B8pKOn9/TTGU/YwX6zfF0RNV/s+0LeAbq1mCtx9is+5PYp8sRz4Ta65Sh/d4bjzaerp/z7gi
 60ZL1jFhE2UHxVkONwD9Z8IHp1ixX4c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMCBTYWx0ZWRfX7dM1b5cNqreJ
 um+KZuzNZnLsIFR4X6EzDYhYmFufHqb2PfG+FMh+GfhjBjDpvRw1YKGUWUbI9JqNxwng0eeHpKT
 t6d9foGwCjDSsRsmuAqq7MC5gQKLIX6Tdis9Xy8osr/kD+H1Q6wEf8U5hDfTMRp1VBDZy+xVy3P
 SEwJKRx1mzxacRqV9+aRYogqXNp187zJBsQULll0/dXmOuOJ6xF9JOjWlSapAq8t9/E4C+qLp4u
 agzrYVgRdSTDHTcPKslyrDOfD55hcq7hvKp5ydg+R9MyXJIyMZp6QohF1VeyUQ6Uqb9PfdZyXnG
 xHFVFps7Z8kaYL+F3LtY/6TFG9XVY34r1mH7yHyYz4OdEfYeVWh6CbRSTVYLNqZooTkSMdm0k3c
 u+SBg3toKfbLgyZTDW6uokOVpNVG5ASwZoDRIN89Pg9J8sUqRq75nt6IADOGR53vy0LF1Jiq5HY
 Ksw+hUnF0wflhunLCpw==
X-Proofpoint-GUID: nLP9f4_aecgwhu5OFrHGCZGDE9QJLOoy
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac4aa92 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=9qWXGQoCvJsV06SDjsEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: JlwDsTYZhylG0-goHJTDwYwjv7UBa-fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060030

On 2026/10/06 12:29 PM, Jyoti Gupta wrote:
> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
> 
> Free the bitmap and the mpic in the common error path before
> dropping the device node reference.
> 
> Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---

Thanks for updating this to use layered error labels.  The patch looks clean and
good to me now.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

