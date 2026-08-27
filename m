Return-Path: <linuxppc-dev+bounces-26151-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25454C61DC4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 14:16:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hW3VG21Vlz2y2L;
	Fri, 28 Aug 2026 00:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787840198;
	cv=none; b=Dwiw5/oiU29ISInEzBsxyJQWYkSbZchmdBnwLa/O3uwDgOhe+ZMoGFsK9HjB2wqRLW+KnFTGbi8ib/X46rUExp8KnpIuDxMmbh8/ahJbxFqfdsFnRd/E9ESr6VI/Pn5vTpMHnSIY9GyWD2d9rP3ixYc7wIB/jXT9y88X1yo5d9oZNY4UD9/jWYPpHmU2bvCnnJp4BmD2IwbQoUezWGZSZLefNG462ccMXt9XQpgo0bzWjCDckUuOEdde5eVGwpT28dnc4ye9N2BsyApSbjE/Xkgs1GvFIRUa8BH/YLnleGefRAYWMII/nsdf4crAd6K+eGRgN5+/Mafa2xkrXaoAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787840198; c=relaxed/relaxed;
	bh=dcluX+/mf8lazbWAYbxfRFNoZB8YSwa8nBk94K1KGpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRPX0NPBxAi7BzRBlQDXkvY0Nl7bUJt2WJV4K2nvvrfAejuFDkvvtnnzq8BVS8kf3vnBpvnsAYFyeqv79HL/gyooEecj0yxrVkuszGkUdaYC64obDxcpo3FFdxovSjkrGO6GkTvjKfkDs8Qau5rHvPKbPgai2Bc5wqyR9/GTMfm8gIIqo4S8TfKx6PUzFEenFU4mLgrKCJKdkUBM/e3Ha5i8wFZVNrDdOJZ/BZZKfZDZ6o2kM1Zolu/lT0z4NX5werhRpR05jO5FciNsKYCpAEAKqt+qn+tDb+wjW/apOlyO4KDazl5cqHJGHHWehm7Yy93s+PukEDTyHop9I/bN2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bw2d8TxR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bw2d8TxR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hW3VD1PDdz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 00:16:35 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVh2j3056633;
	Thu, 27 Aug 2026 14:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dcluX+
	/mf8lazbWAYbxfRFNoZB8YSwa8nBk94K1KGpg=; b=bw2d8TxRtdi+hGjnlLQfxQ
	MKhnyHYD+sXET3WLcEpQqRtPUC6z4W/G2RYDYVTFPXYJhm/MbG7GY/ceBPqjlWF5
	SjdGRigMb2W+sb1gW2ixAb3hmufgYSwDEygmtRSGLL87dzrhT2DhZS9fArwaxeoI
	h/hNZ13OBjvAaDiRS8992QFgAHFiQeNzFaa2517I7KprevFCq/KSdYrUaeJWl5nR
	/V2dTxkzRKSFcdyL/DzDaasY7dehO0ttzjHHFprkRWNzy69U2aDq7v7nDb7AR2a+
	8EzD2w4EaI5Fl27DhoiFRrPAt8SOzmNcu0lp4dnvWjaoTlNIV+6locY42vXdCXCg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxngk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 14:16:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RECE1F019730;
	Thu, 27 Aug 2026 14:16:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrakc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 14:16:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67REGNoF38404478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 14:16:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E4B12004D;
	Thu, 27 Aug 2026 14:16:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF66F2004B;
	Thu, 27 Aug 2026 14:16:20 +0000 (GMT)
Received: from [9.67.92.114] (unknown [9.67.92.114])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 14:16:20 +0000 (GMT)
Message-ID: <d8edbbfc-4910-4c0b-b104-2fe51756ecc7@linux.ibm.com>
Date: Thu, 27 Aug 2026 19:46:18 +0530
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
Subject: Re: powerpc: userspace processes crash on abort() from libc.so.6
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, tglx@kernel.org
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com,
        christophe.leroy@csgroup.eu, riteshh@linux.ibm.com
References: <e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com>
 <a147c153-0c73-422c-a183-dad5c5b9aa5c@linux.ibm.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <a147c153-0c73-422c-a183-dad5c5b9aa5c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExOCBTYWx0ZWRfX5OrKWeDBh5AK
 caYK8a9HkZ8MSg7TxO1WDqe+QE+3fgNIeSi1yhceIFJBDN7OxjGfi0QPzua7dlyHaJVGxPXt6r4
 mHwUwhjPXztKAbGJsR3X9Y5VqUmg7M8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9046bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=pnlxZmXi8QIVzasWyfMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A4KgM3yLy7F_mvNhXEZ2ZmrpIZ3EIgL6
X-Proofpoint-GUID: A4KgM3yLy7F_mvNhXEZ2ZmrpIZ3EIgL6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExOCBTYWx0ZWRfXwsr9uiKhzBsw
 Yd3txQv3UExoUhd0S9PryQ8fVxy4OIk3uDHQjna+2JmOWZw34LmmJ92DtVjwgo9xpMLFyg1JLV+
 GGsihZ84G+pBCCMgHa3/wLW8xrYhmjgc6qF6kxfbP/5R9Vy+o09yCJ4QSuL613YJUI+huAJI4qH
 wDk3bPKCejT+A6LsRv8K679XFmNPCkcvFXBhDH8p97to1PboZH+UDp3CextRj+gFha8jSTtLQMl
 PXuZOZZtgNskozJkHG1LF3enDhni75f3hx/ebGXR8eiH7nqpQR+eD51X6K90aVh+yUEX6SJcbcz
 mFNYx3hAyRvj1nRxUub9+QmbxjcdvwyD8/4v9UUkkNnyg1hbGJMVj9a04BCZTMjz791rzz5YRrE
 VKYrEvtR3cEPB2zr85MtIZIB30bILj6gIKKoASRjUU/ed8yfmBnojZ36x8DemytkBzW3voGjpZf
 Fq1T0zs/eW6MqAGWEbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270118

Hi Shrikanth,


On 8/27/26 5:08 PM, Shrikanth Hegde wrote:
> Hi Shivaprasad.
> 
> On 8/27/26 11:13 AM, Shivaprasad G Bhat wrote:
>>
>> Hi All, Thomas,
>>
>> On my PPC64 machine, I see the below systemd crash orginating from 
>> abort() during boot on top of the tree. Complete dmesg can be seen 
>> here [1]
>>        abort (libc.so.6 + 0x29484)
>>        __libc_message_impl (libc.so.6 + 0x9e00c)
>>        __libc_fatal (libc.so.6 + 0x9e06c)
>>        start_thread (libc.so.6 + 0xadffc)
>>        __clone (libc.so.6 + 0x152d68)
>>        __clone (libc.so.6 + 0x152d68)
>>        create_thread.constprop.0 (libc.so.6 + 0xad9c8)
>>
>> The git bisect pointed me to commit 3424d8c18a7da "(Merge tag 'core- 
>> entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/ 
>> tip/tip)"
>>
>> Please find the kernel config used to build the kernel at [2].
>>
>> I have tried applying the pending fixes from Mukesh [3] and Ritesh [4] 
>> for the currently outstanding issues and still see the problem.
>>
>> The system is running Fedora 42, with glibc-2.41-7.fc42.ppc64le. The
>> complete list of toolchain and packages can be found here [5]
>>
>> Thanks and Regards,
>> Shivaprasad
>>
>> References:
>> 1 - https://gist.github.com/ 
>> shivaprasadbhat/6f166374bab12b4f4c1cd4ac829e562c
>> 2 - https://gist.github.com/shivaprasadbhat/ 
>> aa499468e124015eec5932fb13e88e05
>> 3 - https://lore.kernel.org/linuxppc-dev/ 
>> lda1jyut.ritesh.list@gmail.com/#t
>> 4 - https://lore.kernel.org/linuxppc-dev/20260820134718.2176411-1- 
>> mkchauras@gmail.com/
>> 5 - https://gist.github.com/shivaprasadbhat/ 
>> ae56ca849c3009e8642a6313dc465ea7
>>
>> =========
>> Backtrace from dmesg:
>> [   22.039343][ T1833] systemd-coredump[1833]: Module libsystemd- 
>> shared-257.6-1.fc42.so from rpm systemd-257.6-1.fc42.ppc64le
>> [   22.039378][ T1833] systemd-coredump[1833]: Stack trace of thread 
>> 1828:
>> [   22.039378][ T1833] systemd-coredump[1833]: Stack trace of thread 
>> 1828:
>> [   22.039401][ T1833] systemd-coredump[1833]: #0  0x00007fffa4c29484 
>> abort (libc.so.6 + 0x29484)
>> [   22.039401][ T1833] systemd-coredump[1833]: #0  0x00007fffa4c29484 
>> abort (libc.so.6 + 0x29484)
>> [   22.039429][ T1833] systemd-coredump[1833]: #1  0x00007fffa4c9e00c 
>> __libc_message_impl (libc.so.6 + 0x9e00c)
>> [   22.039429][ T1833] systemd-coredump[1833]: #1  0x00007fffa4c9e00c 
>> __libc_message_impl (libc.so.6 + 0x9e00c)
>> [   22.039461][ T1833] systemd-coredump[1833]: #2  0x00007fffa4c9e06c 
>> __libc_fatal (libc.so.6 + 0x9e06c)
>> [   22.039461][ T1833] systemd-coredump[1833]: #2  0x00007fffa4c9e06c 
>> __libc_fatal (libc.so.6 + 0x9e06c)
>> [   22.039491][ T1833] systemd-coredump[1833]: #3  0x00007fffa4cadffc 
>> start_thread (libc.so.6 + 0xadffc)
>> [   22.039491][ T1833] systemd-coredump[1833]: #3  0x00007fffa4cadffc 
>> start_thread (libc.so.6 + 0xadffc)
>> [   22.039521][ T1833] systemd-coredump[1833]: #4  0x00007fffa4d52d68 
>> __clone (libc.so.6 + 0x152d68)
>> [   22.039521][ T1833] systemd-coredump[1833]: #4  0x00007fffa4d52d68 
>> __clone (libc.so.6 + 0x152d68)
>> [   22.039551][ T1833] systemd-coredump[1833]: #5  0x00007fffa4d52d68 
>> __clone (libc.so.6 + 0x152d68)
>> [   22.039551][ T1833] systemd-coredump[1833]: #5  0x00007fffa4d52d68 
>> __clone (libc.so.6 + 0x152d68)
>> [   22.039580][ T1833] systemd-coredump[1833]: #6  0x00007fffa4cad9c8 
>> create_thread.constprop.0 (libc.so.6 + 0xad9c8)
>> [   22.039580][ T1833] systemd-coredump[1833]: #6  0x00007fffa4cad9c8 
>> create_thread.constprop.0 (libc.so.6 + 0xad9c8)
>> [   22.039614][ T1833] systemd-coredump[1833]: #7  0x00000000003af858 
>> n/a (n/a + 0x0)
>> [   22.039614][ T1833] systemd-coredump[1833]: #7  0x00000000003af858 
>> n/a (n/a + 0x0)
>> [   22.039639][ T1833] systemd-coredump[1833]: ELF object binary 
>> architecture: PowerPC64
>> [   22.039639][ T1833] systemd-coredump[1833]: ELF object binary 
>> architecture: PowerPC64
>> [   22.042109][    T1] systemd[1]: systemd-journald.service: Scheduled 
>> restart job, restart counter is at 1.
> 
> I was looking at merge patch and It is possible that TIF_SYSCALL_RET is 
> still set when it is returned
> and maybe causing a mismatch.
> 
> Does below help?
> ---
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,10 @@ notrace long system_call_exception(struct pt_regs 
> *regs, unsigned long r0)
>       long ret;
>       syscall_fn f;
> 
> -    if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, 
> &r0)))
> +    if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, 
> &r0))) {
> +        clear_thread_flag(TIF_SYSCALL_RET);

Yes. This worked.

Thanks,
Shivaprasad>           return syscall_get_error(current, regs);
> +    }
> 
>       if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
>           return syscall_get_error(current, regs);


