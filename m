Return-Path: <linuxppc-dev+bounces-22686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF7DCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:08:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfc4Y6LQzz2yZ6;
	Tue, 16 Jun 2026 16:08:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781590125;
	cv=none; b=UQRZLl/YR1sD4U9LK2SSogCMkinqynCCmy4AnyMSQD2g/RED5C8s3gp0XXivn08V6YggBpAA29QIQZHHICCYQyDLb+wUff8cqPpydcYKd9jp5SSOqVn6hS9AKKvj9z5i5cs5O5PqLxMNKTLrD7XPLoqZAIWrgsWsah4gdla0RjCfW5X4fNZCsd6fVY4up9QHlkT5r/SnVEVxOLvaXpKFei//gsXzZDVlrR8WRh2OFlgSqR3yCmk9C5rAn8A0Qx2VnO+FZ7HJxyKLeV6TQYGd4OXn9ufO72A2ScyrfkZwudz/Nda5EKRpYfjGMCoqeKKf+mTffe5qWbZVLMDL48eJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781590125; c=relaxed/relaxed;
	bh=LJgaGKqARjo0osqSDzi2xoWh/73ScAzrFZR5nlEU2T4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iF9sCy8aCMYRDVIf08Ko0apqipvA2m6mdqb+6bmiCtMT8usqkAEOeC9aCOe9EmXfiNBHdXOaovWx0l7K0er8ZUwXEFPUPJmim1yMq14AMcTZjGEajIrjMPV9deX2MQp/ifzfJv/RhYjpGnUSO/kI1atZg2SIsdRk/twyqJtSM/8x9m/tFhbkgqheSPXBhogQbWwJnQhjxBLhmCpLovBiDM4cMhhdxXVoKbrFcBQBtNYDUz2teFUAJIYNU77nYmFB2+NJFRMWBEBynAXvzxluiV/1vcPiwqiqSTc9CPxDSEZBt9Yf2zlS516bnJlW0uVaWRNWi6zNcQRgHUfkLCfXQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XWbm+85g; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XWbm+85g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfc4X4rJVz2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 16:08:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0mNNl3954925;
	Tue, 16 Jun 2026 06:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LJgaGK
	qARjo0osqSDzi2xoWh/73ScAzrFZR5nlEU2T4=; b=XWbm+85gkj5w3b3ouTjqUE
	9sf1wj6N4UzXn+1TRvMpHzyPc9tQyfGIbhSYw/n4iQPbyjF4oAL2j6myq/a6109N
	yiBv335Kulp9Oj220zCb5WvRvocA+tmcg/uwRQVSfkUa3efAldsryMkNcind0R4p
	AuptI9gs64BIOr/NN1K+vB9A2wvzlWaRbCY6qqeiOBmOtLBTrvz9jHK/zjuLpM7e
	iq66sF8CiZhgIQXaDOScnQu/FSKV4C3pNMf4ux3bNbh9wWzidKGMHcS9MTQ1Eb3Z
	1ZgwP+vBhmfsWjs9B+5c9r6wIcZyAgAh6v5MLDA1Qqp+y8t81eBte/B69C8cldpg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm44s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:08:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G65qcI024278;
	Tue, 16 Jun 2026 06:08:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk1yt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:08:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G68eIY33882638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:08:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07A458062;
	Tue, 16 Jun 2026 06:08:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 345B658061;
	Tue, 16 Jun 2026 06:08:39 +0000 (GMT)
Received: from [9.123.6.235] (unknown [9.123.6.235])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 06:08:38 +0000 (GMT)
Message-ID: <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>
Date: Tue, 16 Jun 2026 11:38:37 +0530
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
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
To: netdev@vger.kernel.org, venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
 <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfXyx5aBLfS5m37
 yBYevPOebk64gRJgB6Fl7VLNa3Gwf7cTOnRKM6CRys8YqUtP6v+U05IFFokZE54amJm+xyeUd5I
 GR46aXhnNb8K0NNTUz6Sv+Or9qnAKvg=
X-Proofpoint-GUID: i6UJJ8rtR2tPLhfVKCZ1mFqV0o8fR6rL
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a30e86a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Tuhm9eAq2ABGGyuMaTQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfXx+pHnCzCqqh+
 4GgCdx7PKRRrTmxUTF/XidilF37REkopN6I5IPFkMb/+2mEn+nSOB+sjebK3c9XEp9KDAIA/z21
 totCVCP4CTTUfSr2F/K5kr4nhFqR4IXwBK6yX+zpbbUlWjz8ysZL7sswxzvPCtoTMEPu66lN7W+
 1PHjaVEf82dTvHeHsXnMeid1OoHXhSEbDX1E1ocI+yv6+SIaQ+Z9I+3tpjeh/1jR3ZahaQ3xyR1
 i5D/rqqQABWxIDYOZgkcYQfgd+UXdif5LKBG+q5FPkmHx2lx6sRO/axxteEG0XasKPzlm1JiNMC
 cE+AalVsRqATa6vzE52u/5JnhfUzTUbproRBW1Nuduq8nDR0rVCtQp9Rx8hSL2Wp0xmIEi3nPKA
 NbC5xBg7qlMEe/XmcYPAYE3MA+++X3RQuamiXqm1AQaHbXX8cHWxIF52p/SDjnY6zVdryr6ahqB
 XNHAn17qEDshv0JDJYg==
X-Proofpoint-ORIG-GUID: i6UJJ8rtR2tPLhfVKCZ1mFqV0o8fR6rL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160055


> Please add below reported-by tag:
> Reported-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>\
>
>

