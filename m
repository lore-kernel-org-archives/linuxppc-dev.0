Return-Path: <linuxppc-dev+bounces-27124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73A5C88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 12:56:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhF0m2RqCz2yd7;
	Fri, 11 Sep 2026 22:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789131384;
	cv=none; b=V4XbZKEd6DLWqNGQn4+3MvR/agXyCLcf0lQhqjGPdzNj3BS40ialgzwBdLLOoOV6WpawdJoKFYqQ5DnUnKDePZ92CewTXToxsxVa7MTI4FCzWGcQy/KDUQwktjOyU9BMgOr9XDWDTWDdykyorV6ROjoAvdbzo0aEwhGVKroAvP0pgoIeOzyKVSz7up8mov2r4FeTpQsoRe+ZOihLPXftnhLEaofqSOZv5zvT+lJ9Bi5qASMGwHHMKwXQHK3c8MZTW4o8d7qelYF6tfbowLwD4ik1S5s9gi8rtdA3g8Ocy1JOfcnOboXIUyF4+saECeUQs6cvZMzeeW9lLackQ5XMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789131384; c=relaxed/relaxed;
	bh=8mLdXXtYOLbU2LNLcwLfYPs4HhYEoNhpXum+MalzHXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnGvEt6awU1i8MztFRggYjcnI4EBru2tz/+ld52O30YNv72u4o4WUFaeGo536QNKFoxjCk8AF9OhmfamC7HWT+eALtTOgocFoXiAsa9ylO0wg8EaugNUDELIcV8ZgSmznRTtYU5NAIQ/ZGHXrDrBcqpZabNxzNTwgK2eOQZJi2JC7K6EazUrRmSe1Sly1oVgBiLbH+NZx+2Jke4Pzhlh5G5815TT5EBcqX9qSokmEhpnl1JCJ6i2hQoFjibd21+iZiJon4jbup+igXwAyw00+xeQs99zvGmhC3gL0zJu4GDr4t5IAbSWmkIpFlrtg+zN2DcXMXAAdGeODuFPflyaGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GR1t8r6U; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GR1t8r6U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhF0l1Ylpz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:56:22 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BB1pgl1460590;
	Fri, 11 Sep 2026 12:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8mLdXX
	tYOLbU2LNLcwLfYPs4HhYEoNhpXum+MalzHXI=; b=GR1t8r6UDAbMnaWagmD7Op
	GUY0E/q/pHoVczOU5ndD6Fs2iaxzcmfwnHU13ilUG2ZNt7Wth0o1LTgZUE+HcKY1
	rog/nT9yCWhOc4cWHxS6bQBuvaPsNwVAMQ5eyjEj1HSoqBoAXeeBXTg78G/LbXas
	otsXKoK6TLIG4FgtSU97xblZATjV18Vw8OiO2iOZM7t/MEG6QrjSANj9RncvtBlD
	S4NZSXUnx977/C/Xm1PQX0XPyKfE3EOUYqAPnAvpljtQlimTZE+vexgU7mzR0hsI
	bVVK2iZXKduKNQYXANoA6/5cH9vxqaeKNnzIyI/WiHXLF3dBxAnHt8FW7UGvAXUQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sbeqa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:56:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCo3B01676368;
	Fri, 11 Sep 2026 12:56:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvmhpdkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:56:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BCuFxF48038210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 12:56:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7182004D;
	Fri, 11 Sep 2026 12:56:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55D8420043;
	Fri, 11 Sep 2026 12:56:13 +0000 (GMT)
Received: from [9.43.53.28] (unknown [9.43.53.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 12:56:13 +0000 (GMT)
Message-ID: <17f3fd18-835a-4b83-81bb-2b4046ed37f7@linux.ibm.com>
Date: Fri, 11 Sep 2026 18:26:12 +0530
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
Subject: Re: [mainline]ppc64le: NULL pointer dereference in
 sparse_init_subsection_map when crash is triggered with FADUMP enabled
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <d352c3fa-e584-461d-ac95-1ac6dfb4b589@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <d352c3fa-e584-461d-ac95-1ac6dfb4b589@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vdu-Mf0jQmjk8VhcSOIs28MnfLYn8BAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE3NiBTYWx0ZWRfXwiFX73mDSfOJ
 Q9rA90ZDlOoqdMeniy0V+SwA4lrmkcwi4hRox3VdtKHYhvpd7q8Y+rlTdx4Qnhe4xMU5QUcUqlx
 ewWyOV2cnc/PZYB2XbMgypINWNrL3ejrrlity6hjVpDT52EX4/k4IHdqSOVWW0VHU4fw54ncBl3
 Ix2RkITIWfbsMP8dd+Mawr1lWm9dOqcnq4U/v7Q7m4ch8wr30qu/FU8UuW0J4WG9p/80OH5z6PA
 8Dwq6fHF2aylH7dHGGjCl1ptYgNZIkDlzokrSidU9CO65/O3j8sK6OOfYTMXq0Fvg51URa/m6tV
 FHLBeybxgAtjtM9bROzCqi31I5xKEDRysi3cltxP47ero6XQiOFqubTIWavjxuwkeXFKju0+cKS
 Xw6rOl/lcKNNoUfGVW2RucBwSV13Sla25ReXPC5njpthYgrOvMWxOlb7mKdYjCQXk7QJgPqnaER
 7qhcL60Uc04XBMUAG4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE3NiBTYWx0ZWRfX3ruOC80VlEpA
 y70yH5R+H+yaJn2SyvPM2S0rJHuKXZwk9iU49VMQ3DuTTdSR+7/CqAhMMjdCpOpPAp3AC45Z1JX
 sxn2buKdIJrvvG1PgKGZbyuKP6E8PtY=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa3fa73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=L0S9ROj4nagv5cYX7DEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vdu-Mf0jQmjk8VhcSOIs28MnfLYn8BAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110176

Hello,

Here is the root cause analysis of this issue:

The issue is caused by the FADump kernel running out of memory (OOM)
during early boot. Since the OOM occurs very early, the corresponding
OOM trace is not printed or observed. The kernel then hits a NULL pointer
dereference because the component whose memory allocation failed does not
handle the allocation failure correctly and allows the kernel to continue
booting. When the kernel later accesses the memory assuming the allocation
succeeded, it results in a NULL pointer dereference.

The component whose allocation failed due to OOM is sparse:

[    0.000000] sparse_init_nid: node[0] memory map backing failed. Some 
memory will not be available.  <--- allocation failed
<snip...>
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000effffffff]
[    0.000000] BUG: Kernel NULL pointer dereference on read at 
0x00000010                              <----- kernel hitting error

This gap - where the kernel continues booting even after a memory allocation
for a critical data structure fails in the sparse component - has already
been identified and fixed upstream:

commit b3ef855262928c5e80e881895694891164c13fc8
Author: Muchun Song <muchun.song@linux.dev>
Date:   Fri Jun 12 11:58:50 2026 +0800

     mm/sparse: panic on memmap and usemap allocation failure


If you reproduce the same scenario with this commit included, you'll instead
hit the following panic:

[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x00000063ffffffff]
[    0.000000] Kernel panic - not syncing: Failed to allocate memmap for 
section 15619
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.3.0-rc1+ 
#1 PREEMPT(undef)
[    0.000000] Hardware name: IBM,9105-22A Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.00 (RB1110_048) hv:phyp pSeries
[    0.000000] Call Trace:
[    0.000000] [c000000002d4fd50] [c0000000012b56f8] 
dump_stack_lvl+0xd8/0xf0 (unreliable)
[    0.000000] [c000000002d4fd80] [c000000000212d58] vpanic+0x50c/0x550
[    0.000000] [c000000002d4fe20] [c000000000212dd8] 
do_panic_on_target_cpu+0x0/0x28
[    0.000000] [c000000002d4fe40] [c00000000206d83c] 
sparse_init_nid+0x274/0x278
[    0.000000] [c000000002d4fed0] [c00000000206da08] sparse_init+0x1c8/0x290
[    0.000000] [c000000002d4ff20] [c000000002061c5c] 
mm_core_init_early+0x30/0x44
[    0.000000] [c000000002d4ff40] [c000000002005f90] start_kernel+0x90/0x608
[    0.000000] [c000000002d4ffe0] [c00000000000e788] 
start_here_common+0x1c/0x20
[    0.000000] Rebooting in 10 seconds..

The above commit does not resolve the reported issue; it only makes the
failure easier to understand.

Increasing the crashkernel reservation should resolve the issue for this
configuration. I recommend increasing it by 2G or more.

The configured crashkernel value follows the recommendation, but the
recommended value is not sufficient for this particular configuration
because it uses a 4K page size. With 4K pages, the sparse and similar
per-page/per-section allocations require more memory than with 64K pages.
This is why the issue is not observed with the same configuration using a
64K page size.

I’m exploring ways to reduce FADump’s memory footprint by limiting
per-page/per-section allocations to memory actually used by FADump.
Until then, please increase the crashkernel size to avoid this issue.

- Sourabh Jain

On 23/04/26 17:53, Venkat Rao Bagalkote wrote:
> Hello,
>
> IBM CI has observed a kernel crash when testing FADUMP on ppc64le.
> i.e., when a crash is explicitly triggered while FADUMP is active.
>
> System details:
> --------------
> Architecture      : ppc64le
> Platform          : IBM Power11 (pSeries)
> Machine           : 9080-HEX
> Firmware          : FW1110.01 (NH1110_069)
> MMU               : Radix
> Kernel            : 7.0.0+
> Boot mode         : FADUMP enabled
>
> Upstream kernel version: 7.0.0+
> Upstream kernel commit-id: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
>
> kexec-tools 2.0.32.git
> makedumpfile: version 1.7.9 (released on 20 Apr 2026)
>
>
> Attached is the .config file.
>
> Crash Logs:
>
> [    0.000000] BUG: Kernel NULL pointer dereference on read at 0x00000010
> [    0.000000] Faulting instruction address: 0xc000000000aba3d0
> [    0.000000] Oops: Kernel access of bad area, sig: 7 [#1]
> [    0.000000] LE PAGE_SIZE=4K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.0.0+ 
> #1 PREEMPT(undef)
> [    0.000000] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.000000] NIP:  c000000000aba3d0 LR: c000000000708c38 CTR: 
> 0000000000000000
> [    0.000000] REGS: c000000002d6fb10 TRAP: 0300   Not tainted (7.0.0+)
> [    0.000000] MSR:  8000000000001033 <SF,ME,IR,DR,RI,LE> CR: 
> 44000248  XER: 20040001
> [    0.000000] CFAR: c000000000aba41c DAR: 0000000000000010 DSISR: 
> 00080000 IRQMASK: 1
> [    0.000000] GPR00: c0000000020548b8 c000000002d6fdb0 
> c000000001a9a100 0000000000000010
> [    0.000000] GPR04: 0000000000000000 0000000000000008 
> c000000002d6fcc8 0000000000000000
> [    0.000000] GPR08: ffffffffffffffff ffffffffffffffff 
> 0000000000000008 ffffffffffffffc8
> [    0.000000] GPR12: c000000002b30cd0 c00000000307a000 
> 0000000000000000 0000000000000000
> [    0.000000] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [    0.000000] GPR20: 0000000000c00000 0000000000000008 
> 0000000000000000 0000000000306000
> [    0.000000] GPR24: 0000000000000eff 0000000000000bfa 
> c000000001461398 c000000001891c58
> [    0.000000] GPR28: c000000002d44230 c000000002d44268 
> 0000000000bfa000 0000000000001000
> [    0.000000] NIP [c000000000aba3d0] __bitmap_set+0x90/0xe0
> [    0.000000] LR [c000000000708c38] subsection_mask_set+0x38/0x50
> [    0.000000] Call Trace:
> [    0.000000] [c000000002d6fdb0] [c000000002744280] 
> init_task+0x0/0x1d80 (unreliable)
> [    0.000000] [c000000002d6fdd0] [c0000000020548b8] 
> sparse_init_subsection_map+0xac/0x138
> [    0.000000] [c000000002d6fe80] [c00000000204aa8c] 
> free_area_init+0x258/0x4f4
> [    0.000000] [c000000002d6ff50] [c000000002004f5c] 
> start_kernel+0x98/0x5fc
> [    0.000000] [c000000002d6ffe0] [c00000000000e998] 
> start_here_common+0x1c/0x20
> [    0.000000] Code: f92afff8 4200ffe4 55893032 38630008 798c18e8 
> 7d295850 7c636214 7d2907b4 2c290000 4d820020 7d452214 3920ffff 
> <e8e30000> 7d4a00d0 554a06be 7d295436
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000]
> [    0.000000] Kernel panic - not syncing: Fatal exception
>
>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>
>


