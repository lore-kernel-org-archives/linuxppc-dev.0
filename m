Return-Path: <linuxppc-dev+bounces-19056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5592EFF60ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flMCk6xYNz2ybQ;
	Tue, 31 Mar 2026 19:46:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774946770;
	cv=none; b=AXF2OjvEhYqcB2Z9zVGvcnKvbLdfpJhOn0MNXAebK/wqXaDLbnL4TJBbIKrhJHtmsEoYpWOXj85toaKSFHqDlauZk4EpH+0LKLGkQnTbKuXGesFJToq6KnBw+M3vlbHAozleWdvzN2kmkATnZoNoWeuK+ECP47F6DUdESYxoPgc5jagfPPrXUXErpU/WjuAa5kcMIXh0KL6O33gfxTdek+pjn0Cof6drHPE089G2IUluKkc3+0bJHTogAwLYkekLNnNePUVF9k2hv6jHGt83LlaE4BmLM9I0iDx6SrGfgaPtDBKdqb8EW9TRSoNDB+RZyyyvgsj+q/lri/QOizq+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774946770; c=relaxed/relaxed;
	bh=/J2n3zAh+mvzXgeJooTlLjzjYqARfa7wAV9TDXB2EGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZdnIcHkyaKyUbnmU6qNnROZZvjUO9aIpuzp/9yDchRqLqH2kyncC8IKwjxP+D5A5/3jLiCZx66f0ziBjpGAoW1/P9CLpfm05sdtCuQpYBEpOm2hprQdCHkcptlrhVoTo58soavWLt3PREDmGZCcUYCdMiRdWZTocdqgiz1iAdunDYkFZlQivc/qENKKm7K3j2Ust038fpuS8eafkB33LchSLG8co1R60H7+fpLWg22xeLBO3+/XH/cwu1YmEllvcYUgQlwnb5rCd4QwRjwc7OVGA5JSZodGGonrjYeE7uDBfJFW59r7sQXaU7GUBm1rW4iWipBOZssx2YdA4gybv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VH+xjNiX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VH+xjNiX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flMCd5f1xz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:46:05 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5meoI003273;
	Tue, 31 Mar 2026 08:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/J2n3z
	Ah+mvzXgeJooTlLjzjYqARfa7wAV9TDXB2EGA=; b=VH+xjNiXwTfRpen1pVYU8Q
	purIDX4bAtv+C+bjYqVxAncqccln/1KF1xH57CHbdWFCDP4lV3yTQ9az1SAkmROk
	YamIH74cUGDTajy3SrNyXsDikZOT4ib30WV2NsppEhz8bzQ083u8lxYEYtIb1vFs
	t4nlvQUFTZ7x1fbfpbZNAZrTi8Djr+Fo/IVANmz5u94ZLQnRlZi3hlWH6oXlZZMf
	vY9UWkPcU0Aa/Kd/VgW0eoMuk6fZmAeXWJ43cK1O8Rg0RQi8qCt5ZBvIm1xcCl/F
	mHpD456yRM6X9hnngcft1XZKQkTML0OV3xB7BUqCcacDDormZHr3nnJ1NkqrRgtQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms1w19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:46:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V7KTTn013919;
	Tue, 31 Mar 2026 08:46:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkg5m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:46:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V8k07o13632202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:46:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EC825811D;
	Tue, 31 Mar 2026 08:46:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB3DC5811C;
	Tue, 31 Mar 2026 08:45:56 +0000 (GMT)
Received: from [9.43.68.136] (unknown [9.43.68.136])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 08:45:56 +0000 (GMT)
Message-ID: <65282bee-62e4-4411-adf2-17106104f744@linux.ibm.com>
Date: Tue, 31 Mar 2026 14:15:54 +0530
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
Subject: Re: [PATCH] MAINTAINERS: Update ocxl maintainer details
To: Andrew Donnellan <andrew@donnellan.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Christophe Lombard <clombard@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20251210-ocxl-maintainer-status-v1-1-d73981866db9@linux.ibm.com>
 <7bc40b84-4f1a-453f-9040-4ceae4d7e638@linux.ibm.com>
 <09db4bdb-6c87-484a-a2c9-87a1a2af2a8a@donnellan.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <09db4bdb-6c87-484a-a2c9-87a1a2af2a8a@donnellan.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cb89ca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6m5Fvto4qzXWlnG7YQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OCBTYWx0ZWRfXyweBYpiaR36y
 c/5NOoBIe9WdvPEmvVyzGxlHONrVjkb8eZVv+BN9xAPOTO+BgZ9aLAx85X7WWhhISTAPa+xef39
 ZQZAnyPeI4PkW1R8ZnNLqqK5Cl1TjXkxWnPrQy0D/8lTtByIsladzV033X2u1JEwQK07F07uXqt
 v0/xZlhBIoJAaIOt2aTUfkkKurY5Ol15XO2QyWpPjWAWa7zOwiggYWrmlQFJXF4fHqAYZh4Ga+1
 ZUcUGvwl+fZ70xh5WU1gjwQ2NevMrETKcc9g2JeN9eSqfR0Y1XbYq8FjZa/ecNbnqe1KnbfG5ZN
 Hn/psYso1uFnNsAvkAIgdBmCnO+TAbZVtxhcAI1I3QSdYAPTEk48lfmufrruX42r6cCf9HYtZTJ
 2i4EBiUcvUHVQwOrrKwQoiwB7uQMzopaZ+0trth2ZYlTbF5RzzLYr88jkaM4rrZOwMnHaXfCkEI
 Sc4a4bcbxz1ju5FROUA==
X-Proofpoint-GUID: j1bm-6GFRfCq6g7CaGquBw9IcvSjbJqE
X-Proofpoint-ORIG-GUID: j1bm-6GFRfCq6g7CaGquBw9IcvSjbJqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310078


On 3/31/26 1:51 PM, Andrew Donnellan wrote:
> On 12/11/25 00:53, Frederic Barrat wrote:
>>
>>
>> Le 10/12/2025 à 11:49, Andrew Donnellan a écrit :
>>> I am leaving IBM, and Fred isn't working on OpenCAPI either. Mahesh has
>>> kindly agreed to take over as maintainer to review the odd fixes that
>>> still come in, and he has plenty of powerpc-specific experience.
>>>
>>> Add Mahesh as ocxl maintainer, remove Fred as a maintainer, and 
>>> downgrade
>>> myself to reviewer using my personal email address.
>>>
>>> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>>> ---
>>
>> Thanks Andrew! It's in good hands with Mahesh!
>>
>> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
>
> Can we get this merged?

Gregkh,

can you pull this in

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

or I can take this via powerpc too. Just wanted to check thanks.

Maddy

>
> Thanks,
> Andrew

