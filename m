Return-Path: <linuxppc-dev+bounces-19041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC18F1061B2D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 02:59:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flCX72lrQz2yhV;
	Tue, 31 Mar 2026 13:59:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774925991;
	cv=none; b=oPu8B7/7yYJwX/xkzv2g8PqUC3s3aENqzwBcoT36ryzKOu9kXtbVxL+bTLThFo7+O+xQI97flLzAeuflUHCSTPNlkyarJWal0gUL3ssbgeEE8qvAEGy9M3bYRm41JBT73wWgKjZaxz1EpXT0UPLSSmTfJ4yEcFxp4luACpd+7D18hGJO2xcs9QuEJuxLYORZZfeTkjv4RyzJ2A9iQ8M9PvzvgmHMTQujTBQ3oz/FXar12dwnq9FC1FriXaGr+FngHcAzZYAY0reOPghqC3T1jf/PjS50MYEG6I09Dyypto5H2mhhB0GVGRhtsDAfRikLp3aE+foWifyhLn8Oo9nf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774925991; c=relaxed/relaxed;
	bh=5fKujfaOs1CvJz41afMOpE3gzb53IJdHs7W44s+aQeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2/NzrKSkC996DENqojs5o5yXNs+G5bMMK2tdMHmUNmqfUE71bEVPSOyEXl2R12DzS7e0ZLwy2LOvngKFsLKCMQN/r13u3IhJ8WVXvxtHWEpJ23TcysE6V/T7dsE1UFdGwKx4TTK/0CHrGdVXPbIRCk9ZGXvDRmpAHUZT3Ovb2CWpxw0N4fV4a1+R0Rk7FSmtQ/duk+LW8s6KCiKRfsgch+zWyr+Pc1JEqJrsIM3XdgygLWLjOMzrLYOJe9W2WbykoK7gdTbAM9FPmkkHkal9SrE4VUYnguE6i+HZdKRCq4whc7PtnrhfUY0sIVq3g66EztbFfZLQ+JuVVQnSf3ejw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LGivwkTB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LGivwkTB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flCX64kr6z2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 13:59:50 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UF6H4f216795;
	Tue, 31 Mar 2026 02:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5fKujf
	aOs1CvJz41afMOpE3gzb53IJdHs7W44s+aQeE=; b=LGivwkTBKMCXiPUEhfsKSe
	g/b4b14h4jmfRo4GVi5EBd5P1usxlOKtUDIQo4+mVF3oWjRtUwGRrjbxqVMi/nXK
	kGUCzLfYsny/3jda6acWnQ2aB6NHsivI8vQm4qN2FfrZCOlAT3EH7amNpHbWg51L
	2SgkaXqLMbHZ9eheULook33+77xPPZL5TFL3YcdaEVtEhn4FEcF/RrpxzV5pq8o4
	fD4TdNUvjJ74BhUw33LiqCjf+XlTBpXz24HJN4oRlAVtQsBl6rVM+kuZJSzV5jGX
	MVu4bfNhmXySbhLnNLbW+hVaYpVigweYcIMYJ0T+Ihg6VngSApcjCZJX9RckOMSQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms0ydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 02:59:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V0K24c022227;
	Tue, 31 Mar 2026 02:59:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamyb23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 02:59:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V2xJQ515532312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 02:59:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDB1420073;
	Tue, 31 Mar 2026 02:59:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7279320070;
	Tue, 31 Mar 2026 02:59:17 +0000 (GMT)
Received: from [9.124.208.25] (unknown [9.124.208.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 02:59:17 +0000 (GMT)
Message-ID: <dc0c5eff-a55a-4673-806c-00da1177dfea@linux.ibm.com>
Date: Tue, 31 Mar 2026 08:29:02 +0530
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
Subject: Re: [PATCH 2/2] powerpc/xive: rework xive_find_target_in_mask()
To: Yury Norov <ynorov@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Nam Cao <namcao@linutronix.de>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260319033647.881246-1-ynorov@nvidia.com>
 <20260319033647.881246-3-ynorov@nvidia.com>
 <275be5b0-9680-4d85-84f7-cf57142f20df@linux.ibm.com> <acqtJ2WUkg0ZtiHE@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <acqtJ2WUkg0ZtiHE@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cb388a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=I3plDqcRQC2QVIO9dGgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAyNSBTYWx0ZWRfX61VPpci9zG24
 cXjRc9hazA5HeZRdkZrHTN17nHZZwwu49k6/x2f4JsLJ0tYiXgnFTkLILncf4sStvE0zCg53kvg
 tnqymYI00/7hgdexgJXxQAaaJjNRjf0DVvKDQQrqZYZmsdia7No5YH9BATBhN38ggZJaRVXbyY9
 to8+AUZ6WeiPr6ARHXiChatqaiJsIv/VgcFGHI4KCC/OpmIruiWXhcru9Y8iLWE5KV8vI0logNG
 3V3mbNmcwJ6o8VBFGj3+Jd7l7bjzlpt3Bpfcoxlf+5WZc3oHVYal+Ohfk0PYZG9SE9714HxVrBH
 YI/sdd1waCq2qDRqqMTa2Z31CIOamk4tc5lXElm7gk2VsWQfEr4ptjaaDWQSzKvCOzlWMJhcJMM
 si0/vWqJZ3d+BaE3yiMcH7QMLZzPI4WJwL/zY503ONTf6obX/RAx13uvMfKslvVKylx3QEpygEr
 mYdDZvwUvPtHww+IygA==
X-Proofpoint-GUID: RbYYer-RfR8Nl2tlHlxrZaEGUrk_xRsQ
X-Proofpoint-ORIG-GUID: q7X1DulAg9ORLASuUw6lWczFWsqxDHiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310025

Hi Yury,

On 3/30/26 10:34 PM, Yury Norov wrote:
> On Sun, Mar 29, 2026 at 02:43:27PM +0530, Shrikanth Hegde wrote:
>> Hi Yury.
>>
>> On 3/19/26 9:06 AM, Yury Norov wrote:
>>> Switch the function to using modern cpumask API and drop most of the
>>> housekeeping code.
>>>
>>> Notice, if first >= nr_cpu_ids, for_each_cpu_wrap() iterator behaves just
>>> like for_each_cpu(), i.e. begins from 0. So even if WARN_ON() is triggered,
>>> no special handling is needed.
>>>
>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>> ---
>>>    arch/powerpc/sysdev/xive/common.c | 31 ++++++-------------------------
>>>    1 file changed, 6 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
>>> index e91ec9036ad8..4e05f678e171 100644
>>> --- a/arch/powerpc/sysdev/xive/common.c
>>> +++ b/arch/powerpc/sysdev/xive/common.c
>>> @@ -548,40 +548,21 @@ static void xive_dec_target_count(int cpu)
>>>    static int xive_find_target_in_mask(const struct cpumask *mask,
>>>    				    unsigned int fuzz)
>>>    {
>>> -	int cpu, first, num, i;
>>> +	int cpu, first;
>>>    	/* Pick up a starting point CPU in the mask based on  fuzz */
>>> -	num = cpumask_weight(mask);
>>> -	first = fuzz % num;
>>> -
>>> -	/* Locate it */
>>> -	cpu = cpumask_first(mask);
>>> -	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
>>> -		cpu = cpumask_next(cpu, mask);
>>> -
>>> -	/* Sanity check */
>>> -	if (WARN_ON(cpu >= nr_cpu_ids))
>>> -		cpu = cpumask_first(cpu_online_mask);
>>> -
>>> -	/* Remember first one to handle wrap-around */
>>> -	first = cpu;
>>> +	fuzz %= cpumask_weight(mask);
>>> +	first = cpumask_nth(fuzz, mask);
>>> +	WARN_ON(first >= nr_cpu_ids);
>>>    	/*
>>>    	 * Now go through the entire mask until we find a valid
>>>    	 * target.
>>>    	 */
>>> -	do {
>>> -		/*
>>> -		 * We re-check online as the fallback case passes us
>>> -		 * an untested affinity mask
>>> -		 */
>>> +	for_each_cpu_wrap(cpu, mask, first) {
>>>    		if (cpu_online(cpu) && xive_try_pick_target(cpu))
>>>    			return cpu;
>>> -		cpu = cpumask_next(cpu, mask);
>>> -		/* Wrap around */
>>> -		if (cpu >= nr_cpu_ids)
>>> -			cpu = cpumask_first(mask);
>>> -	} while (cpu != first);
>>> +	}
>>>    	return -1;
>>>    }
>>
>> Only concern i have, (which could potentially leads to while(1) loop
>> today if it), is if mask is empty. atleast for_each_cpu_wrap will not
>> be a while(1) loop.
>>
>> So, IMO this is better than what we have today.
>>
>> nit: maybe a good to add a WARN_ON(cpu >= nr_cpu_ids) in the end.
>>
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>   
> The iterator of for_each_cpu() is always >= nr_cpu_ids when it exits the
> loop because it's the exit condition. If you want to warn user before
> returning -1, just do __WARN().

Ok.

It might take a while a while to send the next version out since i am
working on getting the next version of that paravirt series out soon.


