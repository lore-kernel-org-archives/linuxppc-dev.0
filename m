Return-Path: <linuxppc-dev+bounces-26180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5901CC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 06:01:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX4QM2BNpz2xZV;
	Sat, 29 Aug 2026 16:01:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787983307;
	cv=none; b=OTfyVe7Km9uvx4r2UoYraVa9iE56lMfDnsYT4OaT/azlMNmUvhog+a1/M4N9KAUtwlnNSIwgWaWV2k4KUl+6ISADQe8m5AFFysZ9Gk/jKy3CD6pnCOstGxZ6VL0fun4O8+jsd3ZrLdBJ3cCCvr+PjUC27vJW2QqEx00F5zkTN+304sq/8aMfu37PowEqgBb1cUL1hIY9elh6gpxJ6ioUf91gcdgjA/Qk6JubKSDRmG7DPay2+QIJnLNXl6IAIjGGaNLC4plsRyjWfbijX5J15xNqt7srYPYz3Rtl38f34IWfI5/oGaHrXGjYI9UIklcDSySnbP1bgviyIwPV/kQEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787983307; c=relaxed/relaxed;
	bh=AaDKgNP7tS5uhJsSj7XETVKlrKT2aG/BC+he6aXTK1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2Hd7+rKzqeZOyKb5TagNctfFBImesmgg0EgRTZrYyl0CXziuQBLt1wXGtKnTjLTyzAHLLYrhQNfLJxS+p7FBP5k5NBm33Y0TJ9ApPkr9v7MMisXCn39KMSpVfDx32oHnwSleNkIpUmbMIe/lkcviWN5pt3n6FtWyzpy854xTGBW4G5JMeW4y6Iqtx/KzY77u7jxXtj9BC74Uyh1De9KF0I6Lqe10WJl//WJ2zMhIkIDvH5i9p8wvxFbYe07z3ub23eD3kMeJ5Xs80HkDrSTcvplw2H/nmLEOPW9JgjZfJbXEg0SF5TPIxRbL/g0/Ij4mPBWW+PhXknGVi7+iz8zAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=elwscUp+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=elwscUp+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX4QL2lmyz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 16:01:46 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T5VXZb4193302;
	Sat, 29 Aug 2026 06:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AaDKgN
	P7tS5uhJsSj7XETVKlrKT2aG/BC+he6aXTK1k=; b=elwscUp+df8j6uI0k9AgaW
	IJX1qOnhU1kva29BdkJPoAX3TKHyZKxG+q4oZUbatrxoSKH6GHJo4abA9uGtrKZ8
	can0IG4OZzECwj1IyjdXX/UKiJL0IdlZSo3m8dJCXwfaazQ9z31bbT7VkAqhdPwI
	zEl9bVHpGGJM/SsdPLj5KL20lQGxx7Qm+1W4dw2XRqPC57XwwR/AAOa7hyHMVSY8
	XM2FL/d6w+Mud4lSRLkKmW8ZkjDcudO5WluWwTtNYZJyya1opCaYGfZR1NRZMsMv
	Cl32rLoWwhQJ6B9k5MAZjtqqWqn5OG1qv7v+tTZ2vYHb/bSKli0Se7Kcaw7ALHzg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx50fgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 06:01:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67T5uHBN028034;
	Sat, 29 Aug 2026 06:01:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qteaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 06:01:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67T61b1p43843844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Aug 2026 06:01:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D74872004E;
	Sat, 29 Aug 2026 06:01:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738C720040;
	Sat, 29 Aug 2026 06:01:33 +0000 (GMT)
Received: from [9.67.115.193] (unknown [9.67.115.193])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 29 Aug 2026 06:01:32 +0000 (GMT)
Message-ID: <987fa1d6-7328-467b-af7e-5c1c4ef1598d@linux.ibm.com>
Date: Sat, 29 Aug 2026 11:31:30 +0530
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>, tglx@kernel.org,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, chleroy@kernel.org, mkchauras@gmail.com
References: <20260828053811.1042300-1-sshegde@linux.ibm.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20260828053811.1042300-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9275c6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jdSCQhKvPWLdp4stf3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HVjFEIdgwemuqmI9z8eU4-eJlZdy-LXo
X-Proofpoint-ORIG-GUID: hcwM8te7jPxMa8-YShyZoik4gWAFLguC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA1MCBTYWx0ZWRfX20sYYoqH7zAa
 KCAZeYYLTGkyVQ92/ogsDW+oYS3jgN0QxEVrvxJkEBKOAhIAZart7AqToJbIhwxTWoOsomgh7Im
 AV5gmyWugOC+NrLwFsSV6R/egx7zE4k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA1MCBTYWx0ZWRfX8ANJJ74W3K7h
 DrM/dTDpmqd5esQf7kdzXgDfdM1yy6v6cdMEYRb93pYvbqGfs/lhoIHjQcHapLI8yDmUUbDjGRb
 2KighS+gIOTI6OK4PbU89aF8nzBYYyVguSNHVjkY7KgRJ/wxg3U9+lU7rui+PQY2tNUvsdvlhLO
 Xun+0WnnqFnYDcHJMjAfQH2DIV7s9ygRp2prZ2k6Jh2YV+fbxL9L501MTgaMXk3qThz+BEtt0Xb
 75wGZA3/Uywb5l5U0iAvo38pkBvUNx9BgJBiNPpjE6zIqTdiCruypgkkm9aVSW3TctLKLvOwmey
 q0h5UEQmpMyrnbtUey19H5LBdP1XC4qUsBkgZL2kEWd14i74IW8OEZ5Kips1UvJo/R75cPTnGRz
 MVYaR5O0c45gLxJubyCuniG/emoz+Pgr0sSLGTyWeodrVwfMlSVDcKz7smMM/nZIqhFRJl4zo7r
 N4T5B6iqICaWuBPh7bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290050

On 8/28/26 11:08 AM, Shrikanth Hegde wrote:
> Shivaprasad reported a boot failure due to userspace processes crash on
> abort() from libc.so.6. It was bisected to merge request
> commit '3424d8c18a7d ("Merge tag  'core-entry-2026-08-17' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")'
> 
> Upon checking the merge, when syscall_enter_from_user_mode_randomize_stack
> fails, which could happen when a tracer like seccomp or ptrace intercepts
> and skips the syscall, the code returns to userspace immediately without
> clearing the intermediate flag which was set.
> 
> When the next syscall is made, it immediately aborts the valid syscall
> since the flag is still set. Hence clear the flag on occurrence of first
> failure.
> 
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Closes: https://lore.kernel.org/all/e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com/
> Fixes: 3424d8c18a7d ("Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Thanks,
Shivaprasad

> ---
> PS: I have kept the block below since earlier code was checking it
> regardless of result of syscall_enter_from_user_mode. If it turns out
> to be a redundant, it can be removed later.
> 
>   arch/powerpc/kernel/syscall.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index 4916c205c4bb..fbefe1927b10 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,8 +18,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	long ret;
>   	syscall_fn f;
>   
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> +		clear_thread_flag(TIF_SYSCALL_RET);
>   		return syscall_get_error(current, regs);
> +	}
>   
>   	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
>   		return syscall_get_error(current, regs);


