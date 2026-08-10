Return-Path: <linuxppc-dev+bounces-25670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B5C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:49:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJY2c1nxXz300M;
	Mon, 10 Aug 2026 21:49:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786362584;
	cv=none; b=I1J51QMCkjXbxiuvj548dvI3x4BLVZQ4rLJ7sVxWtCzg0zwMgvdVIxXixwrr9qVBYuqS6pCG4SvtcAkc4I1otnD0Jv5XkhB9x6ySFKtyZLeyoXZ6HEgzWfoeuWFcq66f0IFumFy++d9nq1lIRjOc9DjaJxJm1q/cVJfmji3q6TxeZaHzTHQiG7Qyw0JXcYAybTIToVVB+7Kc3QnyTFnN1lcQ5Yc9bqPxryICuEU4LgRLQdCXXnpu+dyDb0hBWEh8i+W4yPwKzy+5dwoyaH/IQx+plMMkeZ0ZwwMTksM/p+P8mScqcD//HhhaE8UXjerkiGGzGu2lmdjX6nC/yhkmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786362584; c=relaxed/relaxed;
	bh=SkgRUS4c93y+2V/09S6KXon8js5smOTqr/cQGwFnQJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvyqOHL6vKJa8+/rJ3M/PRkXJopsZZhq4pvVuMKgkwXX/mlLk8/u8T0R7ibTSnaPnuH556Ii9FsVuH5J2OTNq9Kby1o9uDYvhr9xTQEsbqUx2ricUjQjfsStbSP2XQ0aBIgSHx6aaSbO56HveKwXKhqVgp54EMXls+xwt/bFj0nfBPlU39l4TFGgpo8ieqsIN2JFF3OjwVO5dOOVI3op/+LzpikIZrx3vbvNG9Vw33xG3AtA4Th5+Qku9zoHpoq7lPDvv31bk2TSmeOtfyuWpyx/z0Nbedw3o98sgBPAXFYgtL17keBZPkZGWCSW9/JLoh0QnYj+SH3BizfeWlcUAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IwQQnxyj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IwQQnxyj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJY2b2nPnz2yvM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 21:49:43 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9W83K1290796;
	Mon, 10 Aug 2026 11:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SkgRUS
	4c93y+2V/09S6KXon8js5smOTqr/cQGwFnQJM=; b=IwQQnxyjBtqaXkbd4EADM9
	YYZyhQREtGDwKU4KSuwWbxksv444iP2Tljy4LkcpWO4BP6tA2XrAZuj0Nb+Tcrko
	tkKemMBJLa9kotD26ufKCtJkI713+1ydGYypqEnyhRCnCW4wfENuH73ffUayeZws
	l9VGCibNYm8bG91UDBk6FfMKYtfdbHmmebcrvQW+vQ+0AwVrK09dVFuwMJK3UWOc
	M6J+p6KH7N8SCh+ZTGbipvYCvebapmcFK2nLuCQRgBQRo6dy4h6VJbEHwiNqBSa0
	jQDJt6lAJNbQporXsjgfKpUvUPwrltheWT8+fQydUPtDoXgYiBCbWVQVe/Dqbaaw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvyc1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:49:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABfGNc030951;
	Mon, 10 Aug 2026 11:49:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespvs6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:49:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABnVVR31392352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:49:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FB9B5805A;
	Mon, 10 Aug 2026 11:49:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F4B5803F;
	Mon, 10 Aug 2026 11:49:29 +0000 (GMT)
Received: from [9.61.242.9] (unknown [9.61.242.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 11:49:29 +0000 (GMT)
Message-ID: <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:19:27 +0530
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
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
Content-Language: en-GB
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
 <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a79bacd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=plJz23ppZ1qP7UB_1pIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: guFQ0oo0TQiDzo-BRrZ3lXsakR4jRL_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX/pPYAa61JxhC
 r5WIauspdhFFEKqj5NNhOSYswrG7tzycevfWBFcA3MCzS0Atb8txcZPexEgLFwcOWsZk4kF2rwD
 pqHP+BkWe3A2sN4D+xZsOztWbKw3NvZ9zOIo7nZazfjqXrET9R1Kj0KWZDK6bZcTnzuFNJud1Zu
 HCIqdD6s7HevDKIuNb5bDBrBM8FwuNau4yMBTlObetPpUEQ0sfQ2brxGN/ApTJnrNiCcS5bWrgp
 29boigD1SLsPjpZNIEH7wyM09PJkUSnlT0w0tI/1VTmgzAYMD1Zj8tkmKHwuZITQlEPfsqNUlh/
 5OFmeLvMVmOjzRgrnWr9dgVRnxrPYTMimq9h8XQjs3YCjSc4NzD84HdhMUCHjh5hCfEQSYQCDxY
 DK1vnNcUH0zoktZyB1JO/fzfWWcYrG1ycdziYHUdJyR8VgCPZQDuLohxmX9jQT+3QgfoTeoLd4n
 cjHBHEVhLAkW1CNFAVQ==
X-Proofpoint-ORIG-GUID: le5p0A4EKy4c2iPKSvJ3aiF91qf6kc5P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX4NFCztzwfxt4
 kYUn7yD9+mfM/jxgPIoftGkE/RuiQV8zs7u9Oqy7BjJ8jG+KwWsbH7iscPHEtQO73rc4grNN1a4
 z9XaQypoaMp/TAKk4xES0Hu2nGI5IuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100101

Hi Shrikanth,


On 04/08/26 8:23 pm, Shrikanth Hegde wrote:
> Hi Venkat.
>
> On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
>> Hi,
>>
>> I'm seeing a boot regression on a Power9 pseries LPAR. The system 
>> hangs very early during boot after:
>>
>> Quiescing Open Firmware ...
>> Booting Linux via __start() ...
>>
>
> That is strange. not sure where to look at without any logs.
> Is it a specific config that fails or this specific LPAR that fails?
>
>> No further kernel output is produced.
>>
>> Known good:8cd9520d35a6 ("Linux 7.1")
>> Known bad: 075b74841bd0 ("Linux 7.2-rc6")
>>
>
> Is the kernel built correct at 075b74841bd0 without any errors?

The known bad revision 075b74841bd0 ("Linux 7.2-rc6") builds 
successfully with my configuration and the issue is observed at boot 
time only.

>
>> Initial bisect:
>>
>> A full bisect from v7.1 to v7.2-rc6 converged to:
>>
>> c5e8e224eb7a
>> MIPS: RB532: attach the software node to its target GPIO controller
>>
>>
>> However this commit only modifies:
>>
>> arch/mips/rb532/devices.c
>> arch/mips/rb532/gpio.c
>>
>> and appears unrelated to a Power9/pseries boot hang.
>>
>> I then narrowed the investigation to the PowerPC pull.
>>
>> The following commits were tested and boot successfully:
>>
>> baa590018fbf powerpc: rename arch_irq_disabled_regs
>> dec63ea6faff powerpc: Prepare to build with generic entry/exit framework
>> 09a9d3a8499d powerpc: introduce arch_enter_from_user_mode
>> 893082ac769b powerpc: Prepare for IRQ entry exit
>>
>> The following commit reproduces the hang:
>>
>> 334f3f6d7a16 powerpc/entry: Disable interrupts before irqentry_exit
>>
>>
>>
>> Between the last known good and first known bad points:
>>
>>
>> 893082ac769b powerpc: Prepare for IRQ entry exit
>> ...
>> bee25f97ad24 powerpc: Enable GENERIC_ENTRY feature
>> ...
>> 334f3f6d7a16 powerpc/entry: Disable interrupts before irqentry_exit
>>
>>
>> The only substantial architectural/runtime change in this window 
>> appears to be:
>>
>> bee25f97ad24 powerpc: Enable GENERIC_ENTRY feature
>>
>>
>>
>> I attempted to test:
>>
>> bee25f97ad24 powerpc: Enable GENERIC_ENTRY feature
>>
>> directly, however that commit does not build with my configuration 
>> due to:
>>
>> arch/powerpc/kernel/ptrace/ptrace.c
>>
>> error: implicit declaration of function 'trace_sys_enter'
>> error: implicit declaration of function 'trace_sys_exit'
>>
>> Therefore I could not directly classify bee25f97ad24 as good or bad.
>>
>>
>
> Can you try one commit after this and see if it builds?
> i.e  "powerpc: Remove unused functions"
>
I tested:

6ed60999d33d ("powerpc: Remove unused functions")

The kernel builds successfully with my configuration, but the system 
still hangs during boot on the Power9 pseries LPAR after:

   Quiescing Open Firmware ...
   Booting Linux via __start() ...

with no further output.

So currently I have:

   893082ac769b ("powerpc: Prepare for IRQ entry exit")  GOOD
   bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") UNTESTABLE
   6ed60999d33d ("powerpc: Remove unused functions")      BAD

Given that 6ed60999d33d builds and reproduces the hang, the regression 
appears to be present immediately after the introduction of GENERIC_ENTRY.


Regards,

Venkat.

>> Please let me know if there are specific debug patches or boot 
>> parameters you'd like me to test.
>>
>>
>> Attached is the config file I used.
>>
>>
>> Regards,
>>
>> Venkat.
>
>

