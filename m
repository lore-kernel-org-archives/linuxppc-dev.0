Return-Path: <linuxppc-dev+bounces-25718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7C9C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJzFS1XXTz2yvG;
	Tue, 11 Aug 2026 14:30:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786422636;
	cv=none; b=JYcindPqwUhd3j0cJWEFBMlAolVjSIoVR3tfqv0W3y1hRCcymzHvNEmqK2HZ622iauMWcXP48rApJ5bDkz5lSGhXfHbfULjaU274sP8dlYGwA4xQH4DhhRYMyulH4S0DBVv71mhhccQuilnBMQmHKGP2k55psQphiOE4B/FntiP1rBYh4p+op3ziDr4Bi718cTpQ0dwRQyErsQRTTeB1QfauuVFgpGxMz/fw3dL9I3FkALH8JDBT0RTKn4l40K4ZGH3axO5dOa9rR3R9swbSxM751hStfkwzMX+fft9Mg4sqts7+wLWAJu3Nof2MiLh7R7xOdCSCUlxpk5OovWiqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786422636; c=relaxed/relaxed;
	bh=DFPjDzCCj189wdHAcDjFnP37aNXb/1wseNGvkY1xcmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=khTXn4eLpWgcR0Ne7EIUO8lVWikUtZJuBd6gi/lti2vKFKxjbLo4MbVVkESDmC1gGSd9co2PiLcUc9BR8bD4UogpUiyvnDPacis57hsBqbqZmr/t5H3NhjAcUJm7+oGNfeIRxHcvplT+eqyiX4Ei6r0DWH8auzfOrbSwc9v/lDAcdK0xX500Xhg0QnmcK6Ox4+LGHfvagRXQaIIDmzt34UdAqvR2AC5RVwZ/JpsGSZ01Q4LqaAp3+gScBNJeY4p8m8rktOFGxlNlgdRb+m3IlP7z9LZaGIaurtYZHP5NmV8Fenmbl6HfBmhZDeU3/344oy9Dr0nY31l++lFvvUD34Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ggW9gw6v; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ggW9gw6v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJzFQ4czGz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:30:34 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1fwj2999629;
	Tue, 11 Aug 2026 04:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DFPjDz
	CCj189wdHAcDjFnP37aNXb/1wseNGvkY1xcmQ=; b=ggW9gw6v5zSLCxr8bqPn1Y
	vNxbVIiidOVCyOeQNnGRLXZAu/zAGXvRYxZDXTBEFpSZDoIq2QUsyFojsO2+qcpX
	jmfG0ieLcGAiF8zYCCKb735nw3T2/wYbRf3vSeBmLAzr6/cOFyE8HzujU31Ld4Z7
	UFAjPfGIU9DtLIg25CVWyiSMmsbCmIKm1YJAgMMgLf6TZYf6YKjbIh7GkOo07wPZ
	hYVXUCRsvWjuFLzq2ClxIXTpTV7fFb13Seyd22eobKALwVpgCq3tRw0UpAg9+yA8
	/d7+KixsOHq63jL5i7UfTHV6Q0J54WIalHf/K5rFICA5UtJj2UzKvljjeOUB21ag
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw2pb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:30:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B4QThx003736;
	Tue, 11 Aug 2026 04:30:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjqj3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:30:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B4UJ8H13697358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 04:30:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 645E32004B;
	Tue, 11 Aug 2026 04:30:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DEF420040;
	Tue, 11 Aug 2026 04:30:17 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 04:30:17 +0000 (GMT)
Message-ID: <8b60d1a4-e211-46a9-8aea-9708a9dcd4a2@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:00:16 +0530
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
Subject: Re: powerpc/pseries: EEH detected with xhci_hcd
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        shivang upadhyay <shivangu@linux.ibm.com>, sbhat@linux.ibm.com
References: <2ad00297-eca5-4f36-ad01-138837f6fa4f@linux.ibm.com>
 <29f33de0-0861-459f-b6a0-440354fac785@linux.ibm.com>
 <cxwnv8p4.ritesh.list@gmail.com>
 <9604f310-9f1d-41fe-bf88-284dbfba8d72@linux.ibm.com>
 <85ac643a-d0bc-41c2-a18b-ac74f31f44a3@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <85ac643a-d0bc-41c2-a18b-ac74f31f44a3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7aa560 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=e5mUnYsNAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=oQ4OCr_CQmN9KzV--FsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: LcW4r4i3IrEpmL2uILUN6M1a5RC7Og23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAzMSBTYWx0ZWRfXzLmbqMsoTgU/
 YwXkHOtQ1an00WXxZoW7mIj8jPCC6zf43mAxiP6r5DlRw0bGUUG984j4LkW0eJ588r62wtbNbDl
 LFZRe9oVjlze78H+omdqhxfXW1QX4hm+7gQzkm4ruznXN46BRcgk0KG7KUNQmNbMX4m4fCpzFxQ
 MRDENMAc/v2aJnjiR1NIp5ZCJvEriR3Io/QCPbjTWZr22Py9TpW2fD7cyJr1FuVdGZ3rKL3umSC
 uoL81zwI86GAg2F3gfItpb83n9WdXdckaq3BIvNT56wWeQngx48G9wx5hy+ksXx0RFytS+88DwB
 egrxXfO2sSzCdJrVBb6k0YYgex4F7PhdBi6Qgy0Ga3XSp4xAYwdx+9P1B06URJYThEp7S9pLCRp
 BVrYVJXjb+aK3gE9rb57LVPpRJDNgnaqrLD8Y5xeRNz+ss7u203PvExQ6hWZ0acM/DNONzzuAOW
 bmwIX8+H4bSIV9LnMzg==
X-Proofpoint-ORIG-GUID: mjNLrQuDmESUF9QzoWZgfQCVuMd9u4Hw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAzMSBTYWx0ZWRfX5P9cZSXkYUhw
 lmu6XAHiFdjcZ7EvjC0Z0bFWJWIBkwr1JdBAnAsI4pcOfPn+ppJRIj7muddWd61LIbgJ9ql3xG8
 DPAOJpxOs/NjbjELgUaM7Ktv9i04nGA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110031



On 07/08/26 14:27, Narayana Murty N wrote:
> HI Sourabh,
>
> On 19/07/26 9:59 AM, Sourabh Jain wrote:
>>
>>
>> On 16/07/26 10:21, Ritesh Harjani (IBM) wrote:
>>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>>
>>>> This issue only occurs with the Radix MMU.
>>>> Booting the same kernel with disable_radix=1 does not reproduce the 
>>>> issue.
>>>>
>>>> The system also has pmem.
>>> @Sourabh,
>>>
>>> Few requests -
>>> 1. Could you also attach the boot logs from the same system with the
>>>     same kernel but with disable_radix=1?
>>>
>>> 2. I can't really tell on how is MMU related to this issue? But I think
>>>     if you could share the working dmesg logs from Hash that might give
>>>     some more info. I am suspecting what if the firmware negotiates
>>>     different page sizes even for TCEs for Radix v/s Hash.
>>
>> Attached the dmesg of the kernel where issue is reproducible with and 
>> without
>> disable_radix=1
>>
>>>
>>> 3. Would it be possible for you to try git bisect and identify the
>>>     culprit commit?
>>
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [1471c517cf7dae1a6342fb821d8ed501af956dd0] powerpc/iommu: 
>> bypass DMA APIs for coherent allocations for pre-mapped memory
>> git bisect good 1471c517cf7dae1a6342fb821d8ed501af956dd0
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [328335a79487ec38d6b0e1aa807785b0f75e594d] 
>> powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs
>> git bisect bad 328335a79487ec38d6b0e1aa807785b0f75e594d
>> # bad: [939faf71cf7ca9ab3d1bd2912ac0e203d4d7156a] Merge tag 'drm- 
>> next-2026-02-11' of https://gitlab.freedesktop.org/drm/kernel
>> git bisect bad 939faf71cf7ca9ab3d1bd2912ac0e203d4d7156a
>> # good: [66bbe4a8ed73f1187a4271c58f0ea30f42debe0d] Merge tag 'irq- 
>> core-2026-02-09' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect good 66bbe4a8ed73f1187a4271c58f0ea30f42debe0d
>> # bad: [d061251387903e8502843ac983553f0b2e098ef8] Merge tag 
>> 'sound-7.0- rc1' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>> git bisect bad d061251387903e8502843ac983553f0b2e098ef8
>> # good: [f51d34065de4f29fd237276a49cad06ac7356a55] Merge tag 
>> 'socfpga_dts_updates_for_v6.20_v3' of git://git.kernel.org/pub/scm/ 
>> linux/kernel/git/dinguyen/linux into soc/dt
>> git bisect good f51d34065de4f29fd237276a49cad06ac7356a55
>> # bad: [e86dda7bde8801d32ffe7d1570fe173cab14d1ba] Merge tag 
>> 'spi-v6.20' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
>> git bisect bad e86dda7bde8801d32ffe7d1570fe173cab14d1ba
>> # good: [bdbddf72a2ab1cfea699959795d70df3931eefe7] Merge tag 'soc- 
>> drivers-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>> git bisect good bdbddf72a2ab1cfea699959795d70df3931eefe7
>> # good: [8ea39d960c9f890e9213cdcfcbe4b3f281acd12f] spi: add 
>> multi-lane support
>> git bisect good 8ea39d960c9f890e9213cdcfcbe4b3f281acd12f
>> # bad: [d5cbd9f332c70be9589201474b9477baf9b5a24d] Merge tag 'regmap- 
>> v6.20' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
>> git bisect bad d5cbd9f332c70be9589201474b9477baf9b5a24d
>> # good: [8ad8d24d962804d3c54b5b7542c4cb7cd6bacb3b] Merge tag 'parisc- 
>> for-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/ 
>> parisc-linux
>> git bisect good 8ad8d24d962804d3c54b5b7542c4cb7cd6bacb3b
>> # bad: [1d72a02d65a733ad124bacc2db3fb90fa81a612b] docs: trusted- 
>> encryped: add PKWM as a new trust source
>> git bisect bad 1d72a02d65a733ad124bacc2db3fb90fa81a612b
>> # bad: [11d45eee9f42f7d3f9c9f190a6f79e570d345fe2] powerpc64/bpf: 
>> Additional NVR handling for bpf_throw
>> git bisect bad 11d45eee9f42f7d3f9c9f190a6f79e570d345fe2
>> # bad: [2ed2d8f6fb3853daa536d79e0799cbac91fac9f5] powerpc64/bpf: 
>> Support tailcalls with subprogs
>> git bisect bad 2ed2d8f6fb3853daa536d79e0799cbac91fac9f5
>> # bad: [815a8d2feb5615ae7f0b5befd206af0b0160614c] powerpc/eeh: fix 
>> recursive pci_lock_rescan_remove locking in EEH event handling
>> git bisect bad 815a8d2feb5615ae7f0b5befd206af0b0160614c
>>
>> Reverting commit 815a8d2feb56 ("powerpc/eeh: fix recursive 
>> pci_lock_rescan_remove locking in EEH event handling")
>> on top of commit fce2dfa773ced15f27d resolves the issue.
>>
>> - Sourabh Jain
>>
>>>
>>>
>>> Btw, to clarify I think there are two issues here:
>>> 1. EEH triggered for the USB adapter - I think you meant that with Hash
>>>     you don't even see EEH error being triggered at all.
>>>
>>> 2. Second problem is - EEH recovery causing this WARNING.
>>>
>>> [   17.375534] [    T118] WARNING: arch/powerpc/kernel/eeh_pe.c:439 
>>> at eeh_pe_tree_remove+0xf8/0x2f0, CPU#10: eehd/118
>>> <...>
>>> [   17.375599] [    T118] CPU: 10 UID: 0 PID: 118 Comm: eehd 
>>> Tainted: G            E       7.2.0-rc3upstream+ #3 PREEMPT(lazy)  
>>> f29942c1738362234fefd88de0d1ed711f1a557e
>>> [   17.375603] [    T118] Tainted: [E]=UNSIGNED_MODULE
>>> [   17.375604] [    T118] Hardware name: IBM,9080-HEX Power11 
>>> (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (NH1120_135) 
>>> hv:phyp pSeries
>>> <...>
>>> [   17.375650] [    T118] NIP [c00000000004a048] 
>>> eeh_pe_tree_remove+0xf8/0x2f0
>>> [   17.375654] [    T118] LR [c00000000004ba6c] 
>>> eeh_pe_detach_dev+0x5c/0xa0
>>> [   17.375658] [    T118] Call Trace:
>>> [   17.375659] [    T118] [c00000000a357c90] [c00000000dd32800] 
>>> 0xc00000000dd32800 (unreliable)
>>> [   17.375668] [    T118] [c00000000a357d30] [c00000000004ba6c] 
>>> eeh_pe_detach_dev+0x5c/0xa0
>>> [   17.375672] [    T118] [c00000000a357d60] [c0000000000496ec] 
>>> eeh_pe_traverse+0x6c/0xf0
>>> [   17.375676] [    T118] [c00000000a357da0] [c00000000004e100] 
>>> eeh_reset_device+0x1f8/0x298
>>> [   17.375680] [    T118] [c00000000a357e50] [c00000000004ce5c] 
>>> eeh_handle_normal_event+0x61c/0xa60
>>> [   17.375685] [    T118] [c00000000a357f30] [c00000000004e298] 
>>> eeh_event_handler+0xf8/0x190
>>> [   17.375689] [    T118] [c00000000a357f90] [c00000000025dab4] 
>>> kthread+0x194/0x1b0
>>>
>>>
>>> -ritesh
>>>
> Thanks for the bisect output — that's very helpful.

>
> Commit 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug safe")
> restructured EEH driver synchronization with the PCI hotplug layer, but
> inadvertently introduced a deadlock that was silently preventing eehd 
> from detecting and recovering from EEH events.
>
> Commit 815a8d2feb56 ("powerpc/eeh: fix recursive pci_lock_rescan_remove
> locking in EEH event handling") resolved that deadlock — but as a
> consequence, EEH processing now proceeds further and exposes this
> pre-existing WARNING in eeh_pe_tree_remove().
>
> This means reverting 815a8d2feb56 makes the issue disappear only because
> it re-introduces the deadlock that was masking it — it is not a real fix.

Thanks for the clarification. So, commit 815a8d2feb56 is not the cause 
of the
problem; instead, it is making the issue visible.


>
> To further validate this, it would be useful to inject an error into the
> PE on a kernel with 815a8d2feb56 applied, and confirm whether EEH
> detection and recovery can proceed correctly end-to-end once the
> WARNING in eeh_pe_tree_remove() is also addressed.

Kernel booting with commit 815a8d2feb56 included exhausts the EEH recovery
limit before even reaching the console, so I’m not sure how injecting 
the error
again would help. What do you think?

Even if I try injecting the error, could you please explain how manual 
error injection
would help in this case?

FYI, this issue is not observed with the HASH MMU. Do you think the MMU 
has a role
here, or could it just be a timing issue?

- Sourabh Jain

