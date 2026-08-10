Return-Path: <linuxppc-dev+bounces-25684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA14EC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:34:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJf2Q0YVQz2yxG;
	Tue, 11 Aug 2026 01:34:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786376094;
	cv=none; b=oaexQ3KiPpvuHtMbYbd5CeALsBbhq7CXdzMjHBwG4WtAH+NrEl4EYugEnEGSe1k3eWWJiPMMoY3fOroiNbQYo93JKf1PnVK3a6RwuUXBlhQe+qpeaLidQIo/JZrwoePfwZv+lX9ioVnlqLem5k/Z4jHYIeBgQ1CRsmFE2O6IBGu9dILyCwC7w1RrA/lxNo1C8q+EueQNja/IBVmZySYaXbXxfEyXZqK2U1aB4UWrFa3CrkYGISmHxRhL+n9CX3CYMMX7OSGAA36/4uD7SxFZTUKLn27ASe89h1TC5RcUgNgqwYF3yB6IXZOMx/U1u/wrbaH3UxQOJU4NqivQQ6GVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786376094; c=relaxed/relaxed;
	bh=2DeM7WXjFZl8WHJdXm3/DNomsbVwyb0vu7Xd/rI2ODM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpGk7oE+BBT9qza9KrjABvswe8QP6vgy8Gv8Fy4/EBvL6b75CT1zram9zSgtYQVksiqRE9vja/Ls4j1n7s3KnmG5zFd0S10J1HleAYvwSqsLT5v2wO2R3JuuoDVIyU4Gy2JPrjBOSlsMUzvRfa8R3r2xUqDpJrtgecUOANAbDHAQDlI275vjO/gPpHXEsHy4JicQZvjFMzkj7Vtl3kRp5Ep5NHfz259GWOcrrYgEQOTAY/OUurtq0AB13woIg/YiYDEpTsJVbtv1i6A80APkHtG1CHXJ++iDk9iz1hEy44kAk0Glc7Fc58uGWpuRkOK5lNfP1ou4BLAfGeRmBkp8zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TzZ2HwVv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TzZ2HwVv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJf2N2s88z2ywn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 01:34:52 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWe7c2026029;
	Mon, 10 Aug 2026 15:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2DeM7W
	XjFZl8WHJdXm3/DNomsbVwyb0vu7Xd/rI2ODM=; b=TzZ2HwVvcy66hOjZP4gg+0
	sFDihjhnhA35kwRO+vOkEESDCxt0yt7FSaB7uPKzfKN4/gvY+IHFsY0hEyouz+QK
	TQfSxhwPc1/NDuVSAzkvDNezm1voKXkg7jfRFZ1oqWCGqrozJZ4vfhyVEF9xiRtl
	oZ/DsYAZ5DN/xmXqCZojUrpO1zFKU9HMDOtkW8lKN4LqL+W2pzVPU3T+/CeR6WQA
	9Aa+foedAwniUtbWDCMzk6BouWOW133hDwduN3QiMPCNK54vv4wF4E21SBXu3z4r
	/clJEEyoovufZnvNCi1wUFIAX9FJTKaQX/B9zxaHk5Nta10J6MpymRFa7YzOWHHA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9grfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:34:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFTMVv032651;
	Mon, 10 Aug 2026 15:34:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gwa1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:34:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFYd9U17105584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:34:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09AF58056;
	Mon, 10 Aug 2026 15:34:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A752F58060;
	Mon, 10 Aug 2026 15:34:36 +0000 (GMT)
Received: from [9.61.242.9] (unknown [9.61.242.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:34:36 +0000 (GMT)
Message-ID: <4505448b-59af-433c-93c8-05b13da1a6a0@linux.ibm.com>
Date: Mon, 10 Aug 2026 21:04:34 +0530
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
Subject: Re: [BUG] powerpc/pseries: WARN in __replay_soft_interrupts() during
 SMP bringup on Power11 (7.2.0-rc5)
Content-Language: en-GB
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com>
 <e9a6d82c-8ce1-45a5-a5cf-e4476f97cecf@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <e9a6d82c-8ce1-45a5-a5cf-e4476f97cecf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX0wKOuNQhXXkJ
 Quhx78wsfZRjAkVNDjqlhJNL9vIeR1svblp46tHzPWVpU2+/0FYgVW8Y+5in2aB7RNVkhqSyNuL
 oVybwRbsn2UqPsM/GNvGLNcPzpxg/pl8TIpTFtBDQ7+mSewVU627xjD5jbCXAB/z3V00M4mkrQf
 dm3vCGKcxS6PLcgNmVKQskTTpyAG9E8caZexKThJhqoHQn2wL3XmolTs026SBb3UrFRzZL/SrOt
 yhLJAtsVu0YbfD7G4iyy2ELKki65d7RGB0d1um6sPTHUYz3RQNbCHPtzbBeoI1MIp1i1PVY9rLB
 X26QxQC7CmL2OOE3yMMUIn+vx/Dq7zY2pYkJVnbG0r4xOvQlUY8+SifNaXMyQninY6RzsJhHqUF
 fXTjN0WbRNsgRkPIIZg+QBhvQZe1AIi5gAeDQMyrPddt49vDkdQgzczhjr66k88acQix22xW60F
 ZCD9i3YtJ5tGWhjHTrA==
X-Proofpoint-ORIG-GUID: JOOnFBs7TzxSKIL-hYVfzlJyo3khPdzC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX0QktlA3HLo+e
 hjbroELu9G2OAXHEA8LZVSx0z9f2p9JKD4jUJCgJ0r09Dj8UTYgvYiu1Jrt+0ABFLeO9vWHbPTn
 4++bSuMeZRCWCin/rrvOClJ6vEDKmig=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a79ef92 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=R5rMUDM2oHGd-pj5jkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -ls-P4BfWoaG1klzp7d5XRAG2Le3Th4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

Hi Shrikanth,


On 04/08/26 12:06 pm, Shrikanth Hegde wrote:
> hi venkat,
>
> On 8/4/26 11:39 AM, Venkat Rao Bagalkote wrote:
>> Greetings!!
>>
>>
>> I'm seeing a reproducible warning during early boot on a Power11 
>> pSeries LPAR with Linux 7.2.0-rc5.
>>
>> The kernel starts booting normally and reaches SMP initialization, 
>> but then begins emitting continuous warnings from 
>> __replay_soft_interrupts().The warnings continue indefinitely and the 
>> system never completes boot.
>>
>
> Can you try bisecting it?


I have bisected this and its pointing to 334f3f6d7a16 ("powerpc/entry: 
Disable interrupts before irqentry_exit").


Git Bisect Log:

# git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
git bisect bad dc59e4fea9d83f03bad6bddf3fa2e52491777482
# good: [8cd9520d35a6c38db6567e97dd93b1f11f185dc6] Linux 7.1
git bisect good 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
# good: [056e065a6b6e01ab54bb9770c0d5a15350e571e2] Merge tag 
'sound-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 056e065a6b6e01ab54bb9770c0d5a15350e571e2
# bad: [5e2e14749c3d969e263a879db104db6e9f0eb484] Merge tag 
'landlock-7.2-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux
git bisect bad 5e2e14749c3d969e263a879db104db6e9f0eb484
# good: [3dc7c001169d112b3e514cacff6c93091c57af9a] Merge tag 'nfsd-7.2' 
of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 3dc7c001169d112b3e514cacff6c93091c57af9a
# good: [9ecfb2f7287a967b418ba69f10d45ead0d360593] Merge tag 
'trace-ring-buffer-v7.2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect good 9ecfb2f7287a967b418ba69f10d45ead0d360593
# bad: [c98d767b34574be82b74d77d02264a830ae1cadd] Merge tag 'for-linus' 
of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad c98d767b34574be82b74d77d02264a830ae1cadd
# good: [4e6df939687caf878bb493570ff1c583bba86e7c] Merge branch 
'kvm-single-pdptrs' into HEAD
git bisect good 4e6df939687caf878bb493570ff1c583bba86e7c
# good: [c6f1b611c66f835180e3cb0d3a5df31a61f74d08] Merge tag 
'kvm-riscv-7.2-1' of https://github.com/kvm-riscv/linux into HEAD
git bisect good c6f1b611c66f835180e3cb0d3a5df31a61f74d08
# bad: [91981f96d2831a73cd4dbe4383b4d7e1dcdfcc06] Merge tag 
'powerpc-7.2-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad 91981f96d2831a73cd4dbe4383b4d7e1dcdfcc06
# good: [d585018a9258efed01514bae369ab3d4f21e7b1a] riscv: misaligned: 
Fix fast_unaligned_access_speed_key init
git bisect good d585018a9258efed01514bae369ab3d4f21e7b1a
# good: [0521dbbc5710aca3b3d189747781761732289623] powerpc/xive: Add 
warning if target CPU not found
git bisect good 0521dbbc5710aca3b3d189747781761732289623
# bad: [90b45dbf59d50e32c4f86072545ff44bec9cb28e] powerpc: Simplify 
access_ok()
git bisect bad 90b45dbf59d50e32c4f86072545ff44bec9cb28e
# good: [ab8bbf8024b7434e2b630965fd373fba5b89f29f] powerpc/rtas: Replace 
one-element array with flexible array member
git bisect good ab8bbf8024b7434e2b630965fd373fba5b89f29f
# good: [c8f80f95da32618d49c2a068ee561b85655b761d] 
powerpc/pseries/lparcfg: Replace deprecated strcpy in 
parse_system_parameter_string
git bisect good c8f80f95da32618d49c2a068ee561b85655b761d
# bad: [334f3f6d7a1660fd65597bad9960bfa33a716d35] powerpc/entry: Disable 
interrupts before irqentry_exit
git bisect bad 334f3f6d7a1660fd65597bad9960bfa33a716d35
# good: [052f67a1ae6ffa6e43c82193bf2e6c0dfd2e6d8f] powerpc/8xx: 
implement get_direction() in cpm1
git bisect good 052f67a1ae6ffa6e43c82193bf2e6c0dfd2e6d8f
# first bad commit: [334f3f6d7a1660fd65597bad9960bfa33a716d35] 
powerpc/entry: Disable interrupts before irqentry_exit


Regards,

Venkat.

>
>>
>> Call Trace:
>>
>>
>> [ 2513.069347] WARNING: arch/powerpc/kernel/irq_64.c:75 at 
>> __replay_soft_interrupts+0x14c/0x220, CPU#0: swapper/0/0
>> [ 2513.069354] Modules linked in: bonding tls nft_fib_inet 
>> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 
>> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack 
>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables rfkill sg pseries_rng 
>> vmx_crypto fuse loop vsock_loopback vmw_vsock_virtio_transport_common 
>> vsock xfs sd_mod ibmvscsi ibmveth scsi_transport_srp dm_mirror 
>> dm_region_hash dm_log dm_mod
>> [ 2513.069380] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G   
>> W         7.2.0-rc5 #2 PREEMPTLAZY
>> [ 2513.069385] Tainted: [W]=WARN
>> [ 2513.069386] Hardware name: IBM,9080-HEX Power11 (architected) 
>> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [ 2513.069390] NIP:  c00000000003b2dc LR: c00000000003b2b8 CTR: 
>> c000000000190af0
>> [ 2513.069393] REGS: c000000002d074d0 TRAP: 0700   Tainted: G W     
>> (7.2.0-rc5)
>> [ 2513.069397] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE> CR: 
>> 84002288 XER: 00000001
>> [ 2513.069404] CFAR: c0000000000189cc IRQMASK: 1
>> [ 2513.069404] GPR00: c00000000003b2b8 c000000002d07790 
>> c000000001938100 c000000002d077b8
>> [ 2513.069404] GPR04: 0000000000000001 0000000000000001 
>> 0000000000000004 0000000ef44c0000
>> [ 2513.069404] GPR08: 0000000000000001 0000000000000041 
>> 0000000000000001 0000000000002000
>> [ 2513.069404] GPR12: c000000000190af0 c000000003030000 
>> 0000000000000000 0000000000000000
>> [ 2513.069404] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 2513.069404] GPR20: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 2513.069404] GPR24: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 2513.069404] GPR28: 0000000000000000 fcffffffffffffff 
>> 0000000000000000 c000000002d079f0
>> [ 2513.069440] NIP [c00000000003b2dc] 
>> __replay_soft_interrupts+0x14c/0x220
>> [ 2513.069445] LR [c00000000003b2b8] 
>> __replay_soft_interrupts+0x128/0x220
>> [ 2513.069449] Call Trace:
>> [ 2513.069451] [c000000002d07790] [c00000000003b2b8] 
>> __replay_soft_interrupts+0x128/0x220 (unreliable)
>> [ 2513.069456] [c000000002d07960] [c00000000003b6e4] 
>> replay_soft_interrupts+0x24/0x40
>> [ 2513.069462] [c000000002d07980] [c0000000000338f0] 
>> interrupt_exit_kernel_prepare+0x250/0x280
>> [ 2513.069467] [c000000002d079c0] [c00000000000da68] 
>> interrupt_return_srr_kernel+0x8/0x18c
>> [ 2513.069472] ---- interrupt: 900 at 
>> plpar_hcall_norets_notrace+0x18/0x2c
>> [ 2513.069477] NIP:  c0000000001bdb68 LR: c000000001318c98 CTR: 
>> 0000000000000000
>> [ 2513.069480] REGS: c000000002d079f0 TRAP: 0900   Tainted: G W     
>> (7.2.0-rc5)
>> [ 2513.069483] MSR:  800000000280b033 
>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> CR: 24000282  XER: 00000001
>> [ 2513.069492] CFAR: 0000000000000000 IRQMASK: 0
>> [ 2513.069492] GPR00: 0000000000000000 c000000002d07cb0 
>> c000000001938100 0000000000000000
>> [ 2513.069492] GPR04: 0000000000000000 8004000038667c10 
>> 0000000000000000 0000000000000001
>> [ 2513.069492] GPR08: 0000000000000000 0000000000000000 
>> 0000000000000090 0000000000000001
>> [ 2513.069492] GPR12: 8004000038667c00 c000000003030000 
>> 0000000000000000 0000000000000000
>> [ 2513.069492] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [ 2513.069492] GPR20: 0000000000c00000 0000000000000008 
>> 0000000000000000 0000000000000000
>> [ 2513.069492] GPR24: 0000000000000000 0000000000000000 
>> 000002491e026596 0000000000000000
>> [ 2513.069492] GPR28: 0000000000000000 0000000000000001 
>> c0000000022918e8 c0000000022918f0
>> [ 2513.069527] NIP [c0000000001bdb68] 
>> plpar_hcall_norets_notrace+0x18/0x2c
>> [ 2513.069531] LR [c000000001318c98] check_and_cede_processor+0x48/0x60
>> [ 2513.069535] ---- interrupt: 900
>> [ 2513.069537] [c000000002d07cb0] [c000000002d07d00] 
>> init_stack+0x7d00/0x8000 (unreliable)
>> [ 2513.069543] [c000000002d07d10] [c000000001319124] 
>> dedicated_cede_loop+0x94/0x19c
>> [ 2513.069547] [c000000002d07d60] [c000000001318300] 
>> cpuidle_enter_state+0x2f0/0x738
>> [ 2513.069551] [c000000002d07e00] [c000000000e6eea0] 
>> cpuidle_enter+0x50/0x80
>> [ 2513.069556] [c000000002d07e40] [c0000000002c1978] 
>> call_cpuidle+0x48/0x90
>> [ 2513.069560] [c000000002d07e60] [c0000000002ca1b0] 
>> cpuidle_idle_call+0x160/0x2e0
>> [ 2513.069565] [c000000002d07eb0] [c0000000002ca434] do_idle+0x104/0x200
>> [ 2513.069569] [c000000002d07ef0] [c0000000002ca7e8] 
>> cpu_startup_entry+0x48/0x50
>> [ 2513.069574] [c000000002d07f20] [c000000000011764] 
>> rest_init+0x114/0x118
>> [ 2513.069578] [c000000002d07f50] [c0000000020052a8] 
>> do_initcalls+0x0/0x18c
>> [ 2513.069582] [c000000002d07fe0] [c00000000000ea9c] 
>> start_here_common+0x1c/0x20
>> [ 2513.069585] Code: 992d0933 f9010168 4bfdd665 60000000 892d0933 
>> 7d2a48f8 554a07fe 0b0a0000 890d0932 39400001 2c280003 7d40509e 
>> <0b0a0000> 712a0002 41820044 552907fa
>> [ 2513.069598] ---[ end trace 0000000000000000 ]---
>> [ 2513.099343] ------------[ cut here ]------------
>>
>> This I am seeing this issue with attached .config.
>>
>>
>
> I don't see GENERIC_ENTRY in your config. So it maybe a older bug
> seen with CONFIG_PPC_IRQ_SOFT_MASK_DEBUG.

