Return-Path: <linuxppc-dev+bounces-26271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC49C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 09:04:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYNN672Cyz2y2f;
	Mon, 31 Aug 2026 19:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788167062;
	cv=none; b=YnP1MntKNdRlbrY57vwxl3bOYD33ln6TYoNq6C+HOrD66D+YFfJXHyX99JWCyXr9fSmiS+Ki1UXjBiCqX/I5JcV+J2xmFf9vG50UdEVTa78KLmkM4a7jt1r2LGtf/x+w8cMXDvnyEOuXMxDcX2RDxyM+3+5Qzi0We8zxDyvcB6sNUJSUlry4G3M23cTywffysQ8S8lA9WjeYYcTAs+8l43SEwt9Jp7R7hrxMPvfLMYOCgZ7JkHe2Goz88+o2wSUocko2Z6dCVXDyK5/35j6FT2eP60NHQ81CpATXvC9RJvk1L62b1dQ0l0yZXffmQBMJwJZqeUc0K+TGto2w4m+cFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788167062; c=relaxed/relaxed;
	bh=z70lFI2sFxK6u43xH5E2e2Ans30vhEIrhDYKlweLjnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1Vv6UjEj3hkl4/DrrSwggyCSgCGWzZdB2QBlYTTFhLP2lOuWwl6s5K/7lv1BMBxIxVCAYV0v26VTApQ85TsUPrQjA/5aOeqdsilA4Sg9x17Nh9Mi9Bkoed0/ijAaEAM4qiEfwIrdrlDMEW4+WpT1o6Jf+I3StVyqSlrfYUHaBvu9XJxIDo6g1X56r4ePaqNoFsjPLAjTvXrQQtGv32Klupt8XwW2ZHYCL29dZkblqHle5Vg/JnGQU5xt9ck+upN7chNHqIywr0Lsajgw5YqQcrlElw+Q5c/U0mEazThg/9Lo6u8z22Oqv63Sf8aYsj5qe4dV6n+XTubmfgiiFHt5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4kLC/XB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b4kLC/XB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYNN61RK3z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 19:04:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V829hp1639246;
	Mon, 31 Aug 2026 09:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z70lFI
	2sFxK6u43xH5E2e2Ans30vhEIrhDYKlweLjnc=; b=b4kLC/XBjo5Th7Wk/jMo8k
	1qKROjB6uBl+BDucN1MNLkgMmH+eMJWxchHzpr5KOrj4Ki73PVI9rehmc34qnMX3
	+8L2yqZ8D5p1ecVtzfeEPgKHNW3RLsAatHh8MbK4tufnp7mJ4fiMD96SdaIgRSSh
	dyKPAmin0sBH4tweejEnws0/PGBrpajZv5XeObnwOtxpV75XDQl4FT8LJGBki9q3
	qQ/LBSGS7vIqto/MCaGjXpQvwiIDyTw2ddDiRoWsfkYjZqQV5oU8vRRnTZA4PQJ7
	AdzUt2jk5W6RS02x0aYC1LsvFXFw8dqC8HBnnVJf6sAWDC12zqq10HN1kr3+CQOw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54g7vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:04:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V8uGiV010700;
	Mon, 31 Aug 2026 09:04:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexvs34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:04:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V94D3e31392400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:04:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5765C2004F;
	Mon, 31 Aug 2026 09:04:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A69182004B;
	Mon, 31 Aug 2026 09:04:11 +0000 (GMT)
Received: from [9.124.216.182] (unknown [9.124.216.182])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:04:11 +0000 (GMT)
Message-ID: <46786528-4e56-4df3-b142-bcf047bacbb0@linux.ibm.com>
Date: Mon, 31 Aug 2026 14:34:10 +0530
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
Subject: Re: [PATCH] powerpc/entry: Clear TIF_SYSCALL_RET before syscall error
 return
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: tglx@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, chleroy@kernel.org, sbhat@linux.ibm.com
References: <20260828053811.1042300-1-sshegde@linux.ibm.com>
 <apUBdKP1ytHSvuQd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <apUBdKP1ytHSvuQd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3NyBTYWx0ZWRfXzFTolJvah5Pv
 yXAdmp8GoYhyKqANmB+cmk/heofkgBh9unib0ih/i5QNoufGulrKztfOcUZZU5nLfun7xClsKHF
 /hsS+Ba4US28T7RqaXE8fL7MEnzxFZTPMuE4gExb2yQf2CLMgKd8dR8IyTP+BB03XjsohSYUTt+
 9fzDm9P95y6kOJdIs8bZV5xx0TPTjU/it53RRBRCBPriLvQ9xDjjD2/F+z0Mfmf+3KWHZ0o3WnY
 gsewf98QKQdu8QwPlbY1+iZRI8Jh8UbfwCPjURLK9Y/Ye6MnGiX/hMxjUxvKSoN4vqHZ+EB5AyV
 DNbp16PU6livTGu6vB25WXX2vB/Tt/zkHDEANc2DQ20HZJDsD3kojYKWzOzKTtQ8FBoX3jtAyLj
 49DYbP5XnA5aZNk5lj1S5jRdwWszQdSDOIOJRjpcF82+sOrV+l1ALGffnqLoTzy9EBUoauPDUnQ
 JZn+oLyi+ll0jAZ29Aw==
X-Proofpoint-ORIG-GUID: giTcipX-Ij6HT5ku43W8HViuvLD3ftBL
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a954392 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xwUu9NtTp7HEtEivpooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vqNarg_kRM04mj0aHMgucFMMve6HZIGl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3NyBTYWx0ZWRfX/tZaDeWsH9/0
 jx8nb3MStiJBoBKU4nHlI/J0aaZpJD19Glj6xv+r5IudYPIj1a7RgnpF/Mk6v3+G+rIeZsuuciC
 WtCrf41024KGyhqvqgKi0o5eeY/aNZY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310077



On 8/31/26 10:09 AM, Mukesh Kumar Chaurasiya wrote:
> On Fri, Aug 28, 2026 at 11:08:11AM +0530, Shrikanth Hegde wrote:
>> Shivaprasad reported a boot failure due to userspace processes crash on
>> abort() from libc.so.6. It was bisected to merge request
>> commit '3424d8c18a7d ("Merge tag  'core-entry-2026-08-17' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")'
>>
>> Upon checking the merge, when syscall_enter_from_user_mode_randomize_stack
>> fails, which could happen when a tracer like seccomp or ptrace intercepts
>> and skips the syscall, the code returns to userspace immediately without
>> clearing the intermediate flag which was set.
>>
>> When the next syscall is made, it immediately aborts the valid syscall
>> since the flag is still set. Hence clear the flag on occurrence of first
>> failure.
>>
>> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com/
>> Fixes: 3424d8c18a7d ("Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>> PS: I have kept the block below since earlier code was checking it
>> regardless of result of syscall_enter_from_user_mode. If it turns out
>> to be a redundant, it can be removed later.
>>
> I think it is redundant as of now. The TIF_SYSCALL_RET flag is set when
> error is set by the ptrace or seccomp, If the error value is set then
> the syscall_enter_from_user_mode_randomize_stack will return false.
> Hence the next check will become redundant.
> 
> I also see that TIF_SYSCALL_RET is also set when processing the ptrace
> syscall, Which can leave the flag set for next syscall execution. Which
> can again trigger the same issue.
> 

I believe it is a pre-existing bug which can be fixed independent of this issue.
Since merge request broke the userspace it is better we fix it right away and
this pre-existing issue fix can be done subsequently.

No?

> Regards,
> Mukesh
>>   arch/powerpc/kernel/syscall.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
>> index 4916c205c4bb..fbefe1927b10 100644
>> --- a/arch/powerpc/kernel/syscall.c
>> +++ b/arch/powerpc/kernel/syscall.c
>> @@ -18,8 +18,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>>   	long ret;
>>   	syscall_fn f;
>>   
>> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
>> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
>> +		clear_thread_flag(TIF_SYSCALL_RET);
>>   		return syscall_get_error(current, regs);
>> +	}
>>   
>>   	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
>>   		return syscall_get_error(current, regs);
>> -- 
>> 2.47.3
>>


