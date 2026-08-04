Return-Path: <linuxppc-dev+bounces-25329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C491C55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:30:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkFW1CZ6z30DH;
	Tue, 04 Aug 2026 16:30:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825055;
	cv=none; b=NTjjjgM84dasYDaXMn93PLEeszqYpYBKWXyShwsrjN3qmLC4posjuM91PB+rpdRNuUvzIxhvMdWqT1TZmIcvl76mfOJ2ib79V4OBmWCfSPJ8TOuPWYhd6c5t8lWc/XFdo0bI003LEzPt3ynxZrFAahfk6/jlbfkKpmOji4njn9nIT4SyzTfnVvgJT+9PJyoZhmQIBxwsJfnqU/4j7oefm3OdOqMxjJQMBts+UU84TiX62EBHfVmIF5/iJ3OmRByB7i7xrMj6zYZlQJW189XC6vYaaY8VS0lRmsCiJFCxHll/RrFVlJNqXRwM6YPT5Rhodemam02pm1Z2bG7TRVivRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825055; c=relaxed/relaxed;
	bh=JN2TV52gyjEYB575+y+sUs5qvJBpRg6AdDnzkTqLoFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e60ai0SruwHGcHZknzZ8WpHJs5nAQfa8J89S6PQhQXKN1EeCI7X0B/gptwscSPUs3uAwpbAU8MxHMiq0ffrATr7LLIMzRllIIKM0Fk7an1SmRMCgrzVsLxtXdn8QBNvDRoyzM8Qug0bx652pRxireY+9O3xtbMOZKvjV3MsAKzl3HKQuFXjoev5urF20yWwwhETm+1undiSklP4p6mCw+Xsp3D3B0ItJRBfxmeG+dOwSyzbAl866htf4W9/1EnWx30KdFffnbF2uXQiBH+kvCzdjxDXabVgI4jmr+RJ3JRKArED4qyGfZ+X//MBOo02jK2et5fLYZ0TA/aB7sykf3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f/SSvgW7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f/SSvgW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkFT73xlz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:30:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741JEAt3574076;
	Tue, 4 Aug 2026 06:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JN2TV5
	2gyjEYB575+y+sUs5qvJBpRg6AdDnzkTqLoFM=; b=f/SSvgW77AhKthEE5i49Kw
	yhSILdb4DoqVd+V4i099akQ8DJKxAIk6kYNjSE/tT6zkqxiz8Ty8DzkEBUELjnrz
	Bv/L80LSo1U3gro9d/b9ycl7TEwOQQN91G2l6vmPpp9jaay9w43nX25dVvW9NgP4
	tokyTsABJhGVjr0WtaJuqD9+VCTBwz5BYcMLOJ1m/kCmm4bcSflcCpHXxcZJcoSJ
	EtgAcPoQqZit4v+1pRq0if73AezJLMlifAH+FhZItCzO14wBPv91pO57FCZD9oma
	GpDRJlBeseTcBqkmwjH+sCp0ODqJWycAc4+AS9e8dn0vkO4o8y2uWsw7NSnQzsRQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hmc39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:30:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746QHpp023659;
	Tue, 4 Aug 2026 06:30:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg8j0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:30:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746UZha50528618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:30:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D8420043;
	Tue,  4 Aug 2026 06:30:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B9A320040;
	Tue,  4 Aug 2026 06:30:31 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 06:30:31 +0000 (GMT)
Message-ID: <92f64054-0419-4a87-a69d-f920aff1bcfd@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:00:30 +0530
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
Subject: Re: [PATCH v2 4/5] powerpc/pseries: Implement RTAS error injection
 via pseries_eeh_err_inject
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-5-nnmlinux@linux.ibm.com>
 <5388c50b-e43b-4a3a-bd59-28568f5d84cb@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <5388c50b-e43b-4a3a-bd59-28568f5d84cb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX3XXMgGKHaJlu
 v6HE5J4x3AP5EIG6L0K5IQlVDAKowyZE9o9/ix0Tcgf2MrPSaVB6nZXEFTCsC9Gg1RGC1UPVwpO
 x2OUzZwR4C3GesETHnSDX9WCtri62IE=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a718712 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=5LOzdb_oUaMgFwGie8EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfXyWETgVu424Qd
 5lMhfpgoHO+8ybekMNhHi4cQ4BJrsgd7coMqeDzDhTach0iRE1KOrtX1NqX+xOnzlt/1eAwhMv4
 Ix/7ChnPiGxfM5DrJzQYmXncFJ2OpzjCexC6yKhJDbV+MWWuUueiaeqWsweVt8MXftAiUtc3dh7
 /9KwUpV4ZRAcy6SAosexIqw8IXvac5HrJcYRtaKRisxOIxMQ/pTyGu3pwdzKA71mIE880F79nOC
 VoHUviqZ/Gm6u626+I5+EMGTDkzHKVBa8PwhMdGjSzHkdKtvcsFI0ix4IzLy7Pwtfy4sAwi6jqu
 iHTXhnPK0ZyvjJ7WjDLzEODvmouhfpPAbEblASViE6lvpkElrcK+3AyZMhvgdfTR1M8mDvnKjvo
 ++zKjkGWasVB6lgzmbMIJi/ETXy/5Bsu0TtZxlFcAz7yT+iLnv6eUZH7mnvOiBVefQyqwsgTWgA
 S1A+o2Rpfu8W53nJrQA==
X-Proofpoint-ORIG-GUID: 3DAtJmyQudrXtcVdx74e9kk64dQiEGaf
X-Proofpoint-GUID: pAVQhLS4TFkRJ6-C2w13ljjuQluFkLVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040048


Hi Sourabh,

Thanks for the review.


On 07/06/26 7:05 PM, Sourabh Jain wrote:
>>
>
> session_token 0 is considered valid here. Where as it was considered 
> invalid in other
> function above.
Agreed. |rtas_open_errinjct_session()|is expected to return a positive 
session token on
success, while zero is not considered a valid token by 
|rtas_close_errinjct_session()|.
>
>> +        return session_token;
>> +
>> +    /* get errinjct token */
>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>> +    if (errinjct_token == RTAS_UNKNOWN_SERVICE) {
> How about checking this before getting the session token?
Agreed. I will obtain and validate the |ibm,errinjct|RTAS token before
opening the error-injection session. This avoids opening a session when 
the injection service is unavailable.
>
>> +        pr_err("RTAS: ibm,errinjct not available\n");
>> +        rc = -ENODEV;
>> +        goto out_close;
>> +    }
>> +
>> +    /* prepare shared buffer while holding lock */
>> +    spin_lock(&rtas_errinjct_buf_lock);
>> +    rc = prepare_errinjct_buffer(pe, type, func, addr, mask);
>> +    if (rc) {
>> +        spin_unlock(&rtas_errinjct_buf_lock);
>> +        goto out_close;
>> +    }
>> +
>> +    /* perform the errinjct RTAS call */
>> +    rc = do_errinjct_call(errinjct_token, type, session_token);
>> +    spin_unlock(&rtas_errinjct_buf_lock);
>> +
>> +out_close:
>> +    /* always attempt close if we opened a session */
>> +    rtas_close_errinjct_session(session_token);
>> +    return rc;
>>   }
>>   +
>
> This new line seems unnecessary.

Agreed. I will remove the extra blank line.

Thanks,
Narayana

>
>
>>   static struct eeh_ops pseries_eeh_ops = {
>>       .name            = "pseries",
>>       .probe            = pseries_eeh_probe, 


