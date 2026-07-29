Return-Path: <linuxppc-dev+bounces-24960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27850C53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 03:45:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8ysB32XMz2xwN;
	Wed, 29 Jul 2026 13:45:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785296718;
	cv=none; b=BbhS/8DMsOsp6ONStl3GopSFlCpMHKhpeRhi2bpT9s4km56TEBoB6xkduRhP1WZmdWNSM4z8qOVLyHMunuFMniPbpeJlRixmBrlrPqrOehKmDEPUnIDDoizmlC16leR5IqZMfX8giVcHF3jlpXVwv++yyWyCXPlitihC7TcEUNDIgASNMQ4f555HLGC1jOQTfd+KJzc/CKlKx1H4rg4o9Ll3yMAD+vM1E+hEZertG938kkf9fCBvB4CCLh6KdSyfMviIXrlhMGWu9xEm1Qkkt7DljfQLnyCFPpnZd/wpNejXDX1BOUzpBngOSC9QocLjJYZrReWMtqhnx4+l0Gu7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785296718; c=relaxed/relaxed;
	bh=gG+j70gu8VYGxdMvtcVuphnlh4woU8rBQ1ySkxGXmhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFwxpmJjgaR8JxwgDpijbC6iR+1R2g02HC62sWDvpo022aNg4TwZbq3+UA2D5l9QX/qUgwFwilGskSh2JHfmQd/U/OcPgoazxKP3BbJt6WktCJhOIlzwZO98FceVjz3yrzHJrL8Wn292D1mNxnnenI4V2QRVG586uvDmzMr96+IDGQNGO6XaxShPBEc4Dthu8fll+A+Up3Yj6AFCFz3Fli6qaGtJmM/UOfaorhDXDVjh+m2CXNgk2lfjsRhHWakviOCs/JI2BPrr5+vcflu7cAMJgY1SCZYdzOIcOHFsJ2Z83oBHlVDPgVh0CXizj0o8Z252XEjYGOCwmyhMpfjKSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mSwIFVq+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mSwIFVq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8ys91q8jz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 13:45:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T1Jed1931845;
	Wed, 29 Jul 2026 03:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gG+j70
	gu8VYGxdMvtcVuphnlh4woU8rBQ1ySkxGXmhA=; b=mSwIFVq+23hqwXCKBkoUMb
	fnLhGgmJMUKIT9ut6Teuf81i7cgibfQfBKQUPN7CvhL+Hv/yy6U930Fe+9dKXJ5Q
	hisgnUEAyuMhvYlVky7l+GeNpRxujTsyEpczBqYhjDtNmdU12xTMOUwdvAYiGa/o
	LY0zqd6y04VTJTiqOPwO1BJM5rXJGCkFbYS06ggZROqob4RAo/fBHEALtP0fR9I8
	LH4TTV1R7+/p5nl9rVk76PF2gOSU2g1MOZRxOempL6hpzpyG9BKsqEOvV3ec3hUo
	2rAW8lrC3w3kYgdtvVoCwTZOZZLkHoTt++FZVhM50Xc9U/mnJaSvrS/XcVVExDPw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycgmqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 03:44:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T3faKg014575;
	Wed, 29 Jul 2026 03:44:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw55k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 03:44:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T3isFG30278388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 03:44:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17DFC2004D;
	Wed, 29 Jul 2026 03:44:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0DEE20040;
	Wed, 29 Jul 2026 03:44:50 +0000 (GMT)
Received: from [9.39.23.157] (unknown [9.39.23.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 03:44:50 +0000 (GMT)
Message-ID: <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
Date: Wed, 29 Jul 2026 09:14:49 +0530
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
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is lesser
 than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NK0jheBhRmYut8iGY_APwhGLbkIS65MR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAyMyBTYWx0ZWRfX0G6pMJGEHdw1
 Umr4lOl8BMEmq0bxYt1lUHBVBqOfHjknBGpSpd1EEJsQrlyUQFKy+An8qpy3PdjDOOGEDwZjqGI
 k2uP99b6fp6zT0NA6dbjGZk2CkdICWlheULmwcgt0Wluo2a5/WHu6AamuG2g4gc0j0esi111lqV
 En4n+HvxZbWGPupDLgswkvL4jTww54zc94Sx5h9ehNuyBTekjbZ/hSzByXbH2WuxOjyQlOQuXmb
 SDyFqsOXLmtTvyzmewLqzVboOH3aKDjgfcqFidxV74is0XIxSGKCmw+WRUtaCRYyhRPoS0lcP9P
 hRFcIOnxJafNk6HARZw7aQjXbLqXFKy9EVd2fHS+TdW8EI+aVv6DNXoLVcwoY1LMsQwWJwPWWqa
 URHHQKk1/PTjEjo/3acf7hECAtvzxp+QcYUxgTwB1bG3Z6ohascvEKM87DcFbT3aXouptJupPeJ
 JpiqQhC/0cE/NJ1lATw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAyMyBTYWx0ZWRfX9AldfSH8Tn13
 p9zVaZ4L2z0R17KqrqQcGfBSvB4sia+zHeauzTZrkfuifBnhbPtsnY+ZfvJuGI9wrPvfC7KVrFE
 aHrCLYB4VLP4jC+Hbh0t1l2TWgJT5N8=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69773b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=18G3W26MpR2SuqhIUjEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EUN3BkBrzfChz7aRLSQd-gdM_ljxyXpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290023



On 22/07/26 14:41, Shivang Upadhyay wrote:
> On Sun, 2026-07-19 at 12:39 +0530, Sourabh Jain wrote:
>> Could you please reword the commit title to make it a bit clearer?
>>
>>
>> On 14/07/26 23:00, Shivang Upadhyay wrote:
>>> When a machine is subjected to CPUs add/remove, using dlpar
>>> operations, the number of collected CPU_NOTES can change.
>>> As per PAPR, collected dump size should not be more than
>>> allocated size. Reflecting the same in source.
>> Can you add more details about the problem you are trying to solve
>> with this patch and how.
>>
>> Adding the error message and scenario would be really helpful in
>> understanding the problem.
>>
> Hi Sourabh,
>
>   When a qemu ppc machine is booted with fadump=on and `-
> smp=x,maxcpus=y`, on the panic kernel, /proc/vmcore is not generated
> because dump_bytes and source_len does'nt match for CPU_STATE_DATA
> region in fadump, then we just give up on parsing rest of the data.
>
>
>> Can you add Closes tag if it is reported upstream and if possible
>> fixes
>> tag too.
>>
>>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>>> ---
>>>    arch/powerpc/platforms/pseries/rtas-fadump.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> b/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> index 3bb4ac2ab6cc..19a5adaf326b 100644
>>> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> @@ -469,7 +469,8 @@ static int __init rtas_fadump_process(struct
>>> fw_dump *fadump_conf)
>>>    				pr_err("Dump taken by platform is
>>> not valid (%d)\n", i);
>>>    				rc = -EINVAL;
>>>    			}
>>> -			if (fdm_active->rgn[i].bytes_dumped !=
>>> fdm_active->rgn[i].source_len) {
>>> +			if (be64_to_cpu(fdm_active-
>>>> rgn[i].bytes_dumped)
>>> +			    > be64_to_cpu(fdm_active-
>>>> rgn[i].source_len)) {
>> Can you please share your observations about `bytes_dump` for both
>> QEMU
>> and a
>> real system (LPAR) where the number of online CPUs is not equal to
>> the
>> maximum
> I have the following observation.
>
> I booted LPAR with 8 cpus. After crashing it I saw that fadump
> CPU_STATE_DATA has notes for total 16 cpus, and only top 8 notes have
> valid entries.when trying with 16, I see all NOTES have entried
> filled.

Yes even I noticed the same on a LPAR with (Min=1 Desired=1 Max=2 with 
SMT=8 CPUs) maxcpus as 16 and online CPUs as 8.

[    0.036128] rtas fadump: --------CPU State Data------------
[    0.036129] rtas fadump: Magic Number: 5245475341564500
[    0.036131] rtas fadump: NumCpuOffset: 1c
[    0.036132] rtas fadump: NumCpus     : 16
[    0.036135] fadump: Allocated buffer for cpu notes of size 65536 at 
0xc000000006a30000
[    0.036138] rtas fadump: Reading register data for cpu 0...
[    0.036173] rtas fadump: Reading register data for cpu 1...
[    0.036178] rtas fadump: Reading register data for cpu 2...
[    0.036209] rtas fadump: Reading register data for cpu 3...
[    0.036240] rtas fadump: Reading register data for cpu 4...
[    0.036272] rtas fadump: Reading register data for cpu 5...
[    0.036304] rtas fadump: Reading register data for cpu 6...
[    0.036335] rtas fadump: Reading register data for cpu 7...
[    0.036390] rtas fadump: Updating elfcore header (c000000006a20000) 
with cpu notes

The NumCpus is populated to be 16 CPUs by the firmware (RTAS/PHYP) even 
though only 8 CPUs were online.

Kernel avoid processing reg entries of CPUs which were offline using 
below condition.
code snippet from rtas_fadump_build_cpu_notes()/rtas-faudmp.c

         if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_mask)) {
             RTAS_FADUMP_SKIP_TO_NEXT_CPU(reg_entry);
             continue;
         }

But when I removed the avoid condition kernel failed to process the reg 
entries and
below logs were printed.

[    0.037877] rtas fadump: --------CPU State Data------------
[    0.037879] rtas fadump: Magic Number: 5245475341564500
[    0.037881] rtas fadump: NumCpuOffset: 1c
[    0.037883] rtas fadump: NumCpus     : 16
[    0.037889] fadump: Allocated buffer for cpu notes of size 65536 at 
0xc000000007a50000
[    0.037891] rtas fadump: Reading register data for cpu 0...
[    0.037937] rtas fadump: Reading register data for cpu 1...
[    0.037974] rtas fadump: Reading register data for cpu 2...
[    0.038009] rtas fadump: Reading register data for cpu 3...
[    0.038044] rtas fadump: Reading register data for cpu 4...
[    0.038079] rtas fadump: Reading register data for cpu 5...
[    0.038082] rtas fadump: Reading register data for cpu 6...
[    0.038117] rtas fadump: Reading register data for cpu 7...
[    0.038155] rtas fadump: CPU 8 was offline
[    0.038157] rtas fadump: Reading register data for cpu 8...
[    0.038195] rtas fadump: CPU 10 was offline
[    0.038197] rtas fadump: Reading register data for cpu 10...
[    0.038235] rtas fadump: CPU 12 was offline
[    0.038236] rtas fadump: Reading register data for cpu 12...
[    0.038273] rtas fadump: CPU 14 was offline
[    0.038275] rtas fadump: Reading register data for cpu 14...
[    0.038311] rtas fadump: Unable to read CPU state data
[    0.038319] fadump: Invalidating firmware-assisted dump registration
[    0.038370] rtas fadump: Firmware busy during fadump invalidate, 
waiting 1ms (total 0ms)
[    0.039403] fadump: reserved_memory_range[0] 
[0x00000040000000-0x000000800305c7], 0x400305c8 bytes
[    0.039408] fadump: freeing reserved memory (0x80030000 - 0xa00000000)

For some reason, only CPUs with even-numbered IDs were present from 
offline CPUs list. This suggests that although
NumCpus was 16, only 8 CPUs had valid reg entries. I think we should 
discuss this case with the firmware team before
finalizing the solution.

On the other hand when I increased the CPUs count on the same system 
(Min=2 Desired=4 and max=8 with SMT 8) the
system was booted with 32 possible CPUs instead of 64 CPUs. And NumCpus 
was 32 in fadump kernel.

>
> I previously proposed this fake entries fix in qemu [1]. But that is
> not compliant with PAPR, which states that cpu notes should be
> collected for current_cpus only.
Yes, that solution does not appear to be PAPR-compliant. However, based 
on our experiments, it is unclear why the firmware reports NumCpus as 16 
when only 8 CPUs are actually online.
> As per current states of things, reservation is always done for
> maxcpus, (LPAR and QEMU both), NOTES collections is done for current
> cpus on QEMU, and maxcpus on LPARs.
>
> My proposal here is that we make the check for bytes_dumped and
> source_len, less restrictive to let QEMU also generate /proc/vmcore,
> when current_cpus != maxcpus.

By the way, the changes proposed in this patch also apply to other regions,
such as HPTE and REAL_MODE. That is not the intended behavior, right?

- Sourabh Jain

>
>
> Regards
> ~Shivang.
>
> [1]
> https://lore.kernel.org/qemu-devel/20260520092857.1079193-1-shivangu@linux.ibm.com/
>


