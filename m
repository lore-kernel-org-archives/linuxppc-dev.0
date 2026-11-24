Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1B606A322
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zr6kGY6w
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYXD33c6Qz2y2b;
	Tue, 24 Nov 2026 16:58:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795499891;
	cv=none; b=F2tgichNKiC6UFiESzpvrYdDD9CnyGZ+6035MOYUh3hg6l3HryrX606po7CIOxRCFxdzSKgZKd0q5V1+GqfO2cVp4mXHgNP+KXHTyQrK+QIJw8izluf4Wf4NBzeqiWjBukQqWys6JR+mi6DAHNcA+CQ4S5yI7Ar/4y4hBALwnANOL7wTROVYPGrlm98fuWjfsy6ZFcqfLCPxppXdrRE1T62EtifFGqvWX3431i2HKRr2mfdqQB6clhIifr3IJQPgpYgqistch2j7SsWP+S3ikTz4v2csPnimZ2vcLcduHa1/r0PjyWcS8HK1xdKLuzAJk284g5DMKMkGN2xLtVf/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795499891; c=relaxed/relaxed;
	bh=9Mz40zD+lssDZubcXG2AZXdGV9ngXXp8p2E56VVQHWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/4wxpymppVtMh9UNBFLlfuB2Y34MfpJtNpW70nFWi/hZupbWfpdwBQdLXzmKzWbRVQibgaE71Zz8yBBeMDXQ1+ZawjA7S2Qv2HcdNs8IwPTSAmMHZDlOseGqa8A9dT46KPzIkCMhq8GGeWT3vj/XSMATjwraKrPt00+HVqXDk3nIMBwhpJQ6OD7Lk5dFQUz4LzMa47rJoavDcHbDMmIyBkf+5pobROSXnC+6G4wN3mI9qZTPiz7lfGVMC1WA7nMYzfeFf18UIEN2WsPY2MI3h9a1zXwMLNDnoeN96zXXELAsWjZqranWWRgYG2ey3JhGOh5S0iAThlU/eSKKFAIfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zr6kGY6w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zr6kGY6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYXD1600pz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 16:58:08 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO359731261188;
	Tue, 24 Nov 2026 05:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Mz40z
	D+lssDZubcXG2AZXdGV9ngXXp8p2E56VVQHWo=; b=Zr6kGY6wduiOd8QGw9nqlJ
	PBfmG9FKgpeg9+1f8gAffneLWACAPk6PDJ0kA/D4H/nKMzMvhePqgW6I/H3HCGCs
	nIxWXLDDIsE8hb8+AxuPFODzg8ht24/5NgTzrwwiA8QR2vvgE1fbWnFlBtfjGi00
	rTaSLfzJBQVGrVwMibCsTOlULU0MO4g5hq9LQBMCO/YmekEC88mWYsLvPMUGRlpB
	LtP9Wa6YumGZSPpLkodF4sGBGr41LGnf2G8SX/ryvs/d7InUnURCs4PEYwR/p+fE
	HRpf3Eu1YYpdC/SK7qnT4IBIyHEFeh3i+xXBDkb1BKFn7NXw6MAT4NrW/lL3DQkA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkeamp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 05:57:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2nAfa021820;
	Tue, 24 Nov 2026 05:57:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmk1fyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 05:57:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO5viVx47448472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 05:57:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E83320049;
	Tue, 24 Nov 2026 05:57:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9E52004B;
	Tue, 24 Nov 2026 05:57:39 +0000 (GMT)
Received: from [9.39.26.144] (unknown [9.39.26.144])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 05:57:39 +0000 (GMT)
Message-ID: <7a841990-f4f5-44f9-b49b-30183a85368d@linux.ibm.com>
Date: Tue, 24 Nov 2026 11:27:37 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] powerpc/pseries/eeh: Implement RTAS-based EEH
 error injection
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-4-nnmlinux@linux.ibm.com>
 <9b19c777-e48c-42b4-95da-bfc1a377b3da@linux.ibm.com>
 <cc2e7244-e2d3-419e-a732-9440d6f89cc3@linux.ibm.com>
 <f9d72183-419c-42cc-9d52-592d4ae34b71@linux.ibm.com>
 <55a6ca4a-d58e-4203-a806-c6eac3849aeb@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <55a6ca4a-d58e-4203-a806-c6eac3849aeb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMiBTYWx0ZWRfXwFDr/sn6iF+f
 OzHQwwpKFSW4OH1+BVkfKR8B3c7Hw45+5BswEZ3rOZNR9aJlap+nvysW65XyAjVlTX/j6j50ofs
 2vg7QLbKSFesRVNAEwgxAv3zSkmdz0A7rPg2UA4l8QcP4iwbQK4M34BbXi+Zq3nIhIjsaGAhFw5
 FobuyfM2wlDsrRDubE2UJGrSsPrmnPpc2t+BXusRFWkx/jIRoV//LM9KdiAISxMNPO5d0gmTlTf
 3bxhz6c1uU5dGo8Zet1rL0HtrdVxW2lybWzTitk8eV8e6rwdkz8wtTWN/rJMdn+ljMYzrKyVBVd
 BTiN7SYNz9hyzcUODJZu3idyAveLmOyxIhRMkNS6+kvos2MjfVDAbysfGLv7otiQvF6aOMw8alp
 m20CWB94hE+/ef6S8ZZEz70sXKwSdOWnFAObrJwbEHQDqaeWTNygCNAbwzgTiHUCYpe8vnsDOmi
 LdSOfbcwf+lE9Rkhd5w==
X-Proofpoint-ORIG-GUID: Sw329DzQKt-zt_-R7RXcDQoINfpbVcs4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMiBTYWx0ZWRfX8laWUrvPhfTD
 De/CvzFR1mqjmfkLjjf17ZL9qxD+goeEabhl5evvTOTXuxRJAB5Vm5N3VD2VawpUiNIFdlGAcoz
 Sd6VdVAU0VagDqJmwUbtrrGN1gsI87c=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b05275e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9bXLFRi-r-FfHyNwOZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lQDKo2UasJxt7sGHqQh4GkDTMeCIaEbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240022
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 23/11/26 20:19, Narayana Murty N wrote:
> Hi Sourabh,
>
> On 23/11/26 6:33 PM, Sourabh Jain wrote:
>>
>>
>> On 20/11/26 13:02, Narayana Murty N wrote:
>>> Hi Sourah,
>>>
>>> On 19/11/26 12:44 AM, Sourabh Jain wrote:
>>>> Similar to 2/5, I'm finding this commit message a bit difficult to 
>>>> follow.
>>>> Could you please rework it to make the changes and their purpose 
>>>> clearer?
>>>>
>>>>
>>> Agreed. I'll merge 2/5 and 3/5 and rework the commit message.
>>
>> I didn't recommend merging 2/5 and 3/5.
>>
> Regarding merging 2/5 and 3/5, most helpers in 2/5 are used only by 
> 3/5. I merged them to keep the helpers alongside their callers and 
> avoid an intermediate patch with unused static functions.
>
>>>> On 23/10/26 13:06, Narayana Murty N wrote:
>>>>> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
>>>>> PAPR-compliant RTAS error injection path.
>>>>>
[...]
>>>>> Serialize each ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct
>>>>> session with errinjct_mutex because RTAS maintains state between 
>>>>> these
>>>>> calls.
>>>> I don't quite understand this point. What RTAS state are we 
>>>> referring to
>>>> here? Also, could you clarify how keeping all three calls under a 
>>>> lock helps
>>>> maintain the RTAS state mentioned above?
>>>>
>>> I was referring to the error injection session established by
>>> ibm,open-errinjct and identified by the returned session token.
>>>
>>> The RTAS lock serializes individual RTAS calls, but not the complete
>>> open/inject/close sequence. The intention of errinjct_mutex is to
>>> prevent concurrent EEH injection requests from interleaving their
>>> sessions.
>>
[...]
>> Ok the intent is to synchronize multiple err_injection requests? So
>> kernel would do open/inject/close together for 1 request and then
>> move to another request do open/inject/close.....
>>
>> Could you please help me understand what is wrong with concurrent EEH
>> injection requests with an interleaved open/inject/close sequence?
>>
>> Is this restriction coming from PAPR? If yes, please share the 
>> section no.
> As per LoPAPR v1.1, Section 7.3.13 (R1-7.3.13-2 and R1-7.3.13-3), only 
> one ERRINJCT facility can be open at a time. A concurrent 
> ibm,open-errinjct returns -4 (already open).

Yes, that's a good enough reason to protect the open/inject/close sequence
with a lock. I tested the -4 condition using a kernel module by calling
open-err-injection twice in succession. The second open returns -4.

Could you please add a short comment explaining this at the point where the
lock is acquired?

Also, please handle the -4 case in pseries_eeh_err_inject(), as it can 
be interleaved
with a sys_call open-err-injection call.

>
> The mutex serializes kernel-initiated EEH injection requests so that 
> each open/inject/close sequence completes before the next begins, 
> avoiding unnecessary -EBUSY failures.
>
> It does not serialize external sys_rtas() callers. If an external 
> process already owns the facility, firmware returns -4, which the 
> kernel handles accordingly.

Yes, open-err-injection from the sys_rtas call can still be interleaved 
with open-err-injection
from pseries_eeh_err_inject(). However, there is nothing more we can do 
in this patch other
than handle the -4 case in pseries_eeh_err_inject() and log the event.

- Sourabh Jain

>
> Thanks,
> Narayana
>>
>> - Sourabh Jain
>>
>>>
>>> I'll recheck the PAPR session ownership requirements to determine
>>> whether this additional serialization is necessary.
>>>>>
>>>>> Once ibm,open-errinjct succeeds, ibm,close-errinjct is attempted
>>>>> after parameter preparation or ibm,errinjct failures.  The RTAS work
>>>>> area is allocated after a successful open to avoid holding it while
>>>>> waiting for the mutex or if open fails.
>>>> RTAS work area is mentioned here, but the next paragraph discusses
>>>> something else. The details about the RTAS work area only appear in a
>>>> later paragraph. I think the flow could be improved by keeping related
>>>> information together.
>>>>
>>> Agreed. I'll keep the work-area allocation and lifetime details
>>> together in the revised commit message.
>>>>
>>>>> VFIO EEH error injection exposes a generic userspace ABI.  pSeries 
>>>>> maps
>>>>> the generic EEH error types to RTAS ibm,errinjct encodings via
>>>>> pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
>>>>> unchanged; their values are defined in arch/powerpc/include/uapi/ 
>>>>> asm/ eeh.h
>>>>> and are not renumbered.
>>>>>
>>>>> The RTAS work-area allocator guarantees that returned memory is 
>>>>> within
>>>>> the range accessible by RTAS (below min(ppc64_rma_size,
>>>>> RTAS_INSTANTIATE_MAX), which is at most RTAS_INSTANTIATE_MAX = 1 
>>>>> GiB),
>>>>> so the physical address fits in the 32-bit RTAS argument without
>>>>> truncation.
>>>>>
>>>>> Remove eeh_pe_inject_mmio_error() and its declaration; this patch
>>>>> removes its only caller.  The only remaining caller of
>>>>> eeh_break_device() is eeh_dev_break_write() inside CONFIG_DEBUG_FS,
>>>>> so move eeh_break_device() back inside the CONFIG_DEBUG_FS block to
>>>>> avoid an unused-function warning when CONFIG_DEBUG_FS=n.
>>>>>
>>>>> Also introduce validate_errinjct_args() and prepare_errinjct_buffer()
>>>>> here alongside their callers, so each intermediate commit builds
>>>>> cleanly with CONFIG_WERROR.
>>>>
>>>> Could you clarify what this intermediate commit is for?
>>>>
>>> The intention was to separate the helper infrastructure from the
>>> RTAS implementation. However, given the unused static helpers
>>> and the additional complexity introduced by the split, I'll merge
>>> the two patches.
>>>>
>>>>> The addr argument to ibm,errinjct is function-dependent.  Memory 
>>>>> and IO
>>>>> load/store functions (EEH_ERR_FUNC_LD/ST_MEM_* and 
>>>>> EEH_ERR_FUNC_LD/ ST_IO_*)
>>>>> target BAR-backed PCI bus addresses; these are validated against 
>>>>> the PE
>>>>> via validate_addr_mask_in_pe().  Config-space functions carry PCI 
>>>>> config
>>>>> register offsets and DMA functions carry IOVA/TCE addresses; addr for
>>>>> these functions is passed directly to RTAS without BAR membership
>>>>> validation.
>>>>>
>>>>> For the 32-bit RTAS encoding (RTAS_ERR_TYPE_IOA_BUS_ERROR), addr and
>>>>> mask are checked to fit in 32 bits before buffer encoding. This is an
>>>>> RTAS format constraint independent of function type.
>>>>>
>>>>> Tested with corresponding QEMU patches:
>>>>> https://lore.kernel.org/all/20251029150618.186803-1- 
>>>>> nnmlinux@linux.ibm.com/
>>>>
>>>> Wouldn't this be better suited for the cover letter?
>>>>
>>> Agreed. I'll move the reference to the corresponding QEMU series
>>> to the cover letter.
>>>>
>>>>>
>>>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>>>> ---
>>>>>   arch/powerpc/include/asm/eeh.h               |   2 -
>>>>>   arch/powerpc/kernel/eeh.c                    |  10 +-
>>>>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 246 
>>>>> +++++++++++++++ ++--
>>>>>   3 files changed, 228 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/eeh.h 
>>>>> b/arch/powerpc/include/ asm/eeh.h
>>>>> index b7ebb4ac2c71..083ac58e7eb7 100644
>>>>> --- a/arch/powerpc/include/asm/eeh.h
>>>>> +++ b/arch/powerpc/include/asm/eeh.h
>>>>> @@ -310,8 +310,6 @@ int eeh_pe_reset(struct eeh_pe *pe, int 
>>>>> option, bool include_passed);
>>>>>   int eeh_pe_configure(struct eeh_pe *pe);
>>>>>   int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>>>>                 unsigned long addr, unsigned long mask);
>>>>> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>>>>> -
>>>>>   /**
>>>>>    * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>>>>    *
>>>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>>>> index bb836f02101c..bae7ca2bd399 100644
>>>>> --- a/arch/powerpc/kernel/eeh.c
>>>>> +++ b/arch/powerpc/kernel/eeh.c
>>>> [...]
>>>>> @@ -1571,6 +1571,8 @@ static int proc_eeh_show(struct seq_file *m, 
>>>>> void *v)
>>>>>   }
>>>>>   #endif /* CONFIG_PROC_FS */
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>> +
>>>>>   static int eeh_break_device(struct pci_dev *pdev)
>>>>>   {
>>>>>       struct resource *bar = NULL;
>>>>> @@ -1664,14 +1666,6 @@ static int eeh_break_device(struct pci_dev 
>>>>> *pdev)
>>>>>       return 0;
>>>>>   }
>>>>> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>>>>> -{
>>>>> -    return eeh_break_device(pdev);
>>>>> -}
>>>>> -
>>>>> -#ifdef CONFIG_DEBUG_FS
>>>>> -
>>>>> -
>>>>>   static struct pci_dev *eeh_debug_lookup_pdev(struct file *filp,
>>>>>                            const char __user *user_buf,
>>>>>                            size_t count, loff_t *ppos)
>>>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>>>>> powerpc/platforms/pseries/eeh_pseries.c
>>>>> index 28b1fd19e8bc..2a2ec1a237e6 100644
>>>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> [...]
>>>>> @@ -35,6 +35,7 @@
>>>>>   #include <asm/machdep.h>
>>>>>   #include <asm/ppc-pci.h>
>>>>>   #include <asm/rtas.h>
>>>>> +#include <asm/rtas-work-area.h>
>>>>>   /* RTAS tokens */
>>>>>   static int ibm_set_eeh_option;
>>>>> @@ -915,48 +916,253 @@ static int validate_addr_mask_in_pe(struct 
>>>>> eeh_pe *pe, unsigned long addr,
>>>>>       pci_unlock_rescan_remove();
>>>>>       if (!found)
>>>>> -        pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR 
>>>>> of any device in PE\n",
>>>>> -               addr, mask);
>>>>> +        pr_debug("addr=0x%lx mask=0x%lx not within any PCI bus 
>>>>> BAR of any device in PE\n",
>>>>> +             addr, mask);
>>>>
>>>> IIUC, the previous patch adds pr_err(), and this patch changes it 
>>>> to pr_debug().
>>>> Could we avoid this intermediate change?
>>>>
>>> Yes. I'll introduce pr_debug() directly in the merged patch.
>>>
>>>>>       return found ? 0 : -EINVAL;
>>>>>   }
>>>>>   /**
>>>>> - * pseries_eeh_err_inject - Inject specified error to the 
>>>>> indicated PE
>>>>> - * @pe: the indicated PE
>>>>> - * @type: error type
>>>>> - * @func: specific error type
>>>>> - * @addr: address
>>>>> - * @mask: address mask
>>>>> - * The routine is called to inject specified error, which is
>>>>> - * determined by @type and @func, to the indicated PE
>>>>> + * validate_errinjct_args - Top-level validation for RTAS error 
>>>>> injection arguments
>>>>> + * @pe:   EEH PE for the target device
>>>>> + * @type: generic EEH error type
>>>>> + * @func: error function selector
>>>>> + * @addr: address argument (type-dependent, may be zero)
>>>>> + * @mask: mask argument (type-dependent, may be zero)
>>>> Are addr and mask really needed as function arguments?
>>>>
>>> No, they are not used by validate_errinjct_args().
>>> I'll simplify the validation and avoid the duplicate error-type
>>> mapping.
>>>>> + *
>>>>> + * Validates all parameters before opening an RTAS injection 
>>>>> session.
>>>>> + * Returns Linux errno values; does not return raw RTAS status 
>>>>> codes.
>>>>
>>>> Wouldn't it be better for the function comment to describe what the
>>>> function does, rather than how an RTAS injection session should be 
>>>> opened?
>>>>
>>> Agreed. I will shorten the comment.
>>>>> + *
>>>>> + * Return: 0 if all parameters are valid, negative errno otherwise.
>>>>>    */
>>>>> -static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, 
>>>>> int func,
>>>>> +static int validate_errinjct_args(struct eeh_pe *pe, int type, 
>>>>> int func,
>>>>>                     unsigned long addr, unsigned long mask)
>>>>>   {
>>>>> -    struct    eeh_dev    *pdev;
>>>>> +    if (!pe || !pe->phb)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (pseries_eeh_type_to_rtas(type) < 0)
>>>>> +        return -EINVAL;
>>>>> -    /* Check on PCI error type */
>>>>> -    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>>>>> +    if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>>>>>           return -EINVAL;
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * pseries_eeh_func_needs_bar_addr - return true for error 
>>>>> functions whose
>>>>> + * addr argument is a BAR-backed PCI MMIO or IO address.
>>>>> + *
>>>>> + * Memory and IO load/store functions target specific BAR 
>>>>> addresses and
>>>>> + * require PCI bus address validation against the PE. Config-space
>>>>> + * functions carry PCI config register offsets and DMA functions 
>>>>> carry
>>>>> + * IOVA/TCE addresses; neither is a BAR address.
>>>>
>>>> This seems like useful information, but perhaps it belongs elsewhere.
>>>> The function itself looks fairly simple, and the comment conveys 
>>>> quite a
>>>> bit of information that I’m not sure how to relate to what the 
>>>> function actually does.
>>>>
>>> Agreed. I'll keep the helper comment focused.
>>>>
>>>>> + */
>>>>> +static bool pseries_eeh_func_needs_bar_addr(int func)
>>>>> +{
>>>>>       switch (func) {
>>>>>       case EEH_ERR_FUNC_LD_MEM_ADDR:
>>>>>       case EEH_ERR_FUNC_LD_MEM_DATA:
>>>>> +    case EEH_ERR_FUNC_LD_IO_ADDR:
>>>>> +    case EEH_ERR_FUNC_LD_IO_DATA:
>>>>>       case EEH_ERR_FUNC_ST_MEM_ADDR:
>>>>>       case EEH_ERR_FUNC_ST_MEM_DATA:
>>>>> -        /* injects a MMIO error for all pdev's belonging to PE */
>>>>> -        pci_lock_rescan_remove();
>>>>> -        list_for_each_entry(pdev, &pe->edevs, entry)
>>>>> -            eeh_pe_inject_mmio_error(pdev->pdev);
>>>>> -        pci_unlock_rescan_remove();
>>>>> +    case EEH_ERR_FUNC_ST_IO_ADDR:
>>>>> +    case EEH_ERR_FUNC_ST_IO_DATA:
>>>>> +        return true;
>>>>> +    default:
>>>>> +        return false;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
>>>>> + * @buf: RTAS error-injection work buffer
>>>>> + * @pe: EEH PE associated with the injection target
>>>>> + * @rtas_err_type: RTAS firmware error-injection type
>>>>> + * @func: Error function selector
>>>>> + * @addr: Address argument interpreted according to @func:
>>>>> + *        MEM/IO functions: BAR-backed PCI bus address;
>>>>> + *        CFG functions: PCI configuration-space offset;
>>>>> + *        DMA functions: DMA/IOVA/TCE address.
>>>>> + * @mask: Address mask passed to firmware
>>>>> + *
>>>>> + * Zeroes @buf and populates it according to the PAPR layout for the
>>>>> + * selected IOA bus-error injection type.
>>>>> + *
>>>>> + * BAR membership validation is performed only for MEM/IO functions
>>>>> + * whose @addr is a BAR-backed PCI bus address.  CFG and DMA 
>>>>> function
>>>>> + * addresses are encoded directly without BAR lookup.
>>>>> + *
>>>>> + * The caller provides an exclusive per-call RTAS work-area buffer.
>>>>> + * Firmware session serialization is handled by 
>>>>> pseries_eeh_err_inject().
>>>> Wouldn't this be better documented elsewhere? This function only 
>>>> populates
>>>> the given work area; it doesn't make the RTAS call.
>>>>
>>> Agreed. I'll keep the comment focused on encoding the RTAS
>>> parameter buffer and move the session-related details to the caller.
>>>>> + *
>>>>> + * Return: 0 on success or a negative errno on invalid input.
>>>>> + */
>>>>> +static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>>>>> +                   int rtas_err_type, int func,
>>>>> +                   unsigned long addr, unsigned long mask)
>>>>> +{
>>>>> +    __be64 *buf64 = (__be64 *)buf;
>>>>> +    __be32 *buf32 = (__be32 *)buf;
>>>>> +    int rc;
>>>>> +
>>>>> +    if (!buf || !pe || !pe->phb)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
>>>>> +
>>>>> +    switch (rtas_err_type) {
>>>>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
>>>>> +        /*
>>>>> +         * 32-bit RTAS format: addr and mask must fit in 32 bits.
>>>>> +         * This is an RTAS encoding constraint, not BAR validation.
>>>>> +         */
>>>>> +        if (upper_32_bits(addr) || upper_32_bits(mask))
>>>>> +            return -EINVAL;
>>>>> +
>>>> [...]
>>>>> +        if (pseries_eeh_func_needs_bar_addr(func)) {
>>>>> +            rc = validate_addr_mask_in_pe(pe, addr, mask);
>>>>> +            if (rc)
>>>>> +                return rc;
>>>>> +        }
>>>>> +
>>>>> +        buf32[0] = cpu_to_be32((u32)addr);
>>>>> +        buf32[1] = cpu_to_be32((u32)mask);
>>>>> +        buf32[2] = cpu_to_be32(pe->addr);
>>>>> +        buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
>>>>> +        buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
>>>>> +        buf32[5] = cpu_to_be32(func);
>>>>> +        break;
>>>>> +
>>>>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
>>>>> +        if (pseries_eeh_func_needs_bar_addr(func)) {
>>>>> +            rc = validate_addr_mask_in_pe(pe, addr, mask);
>>>>> +            if (rc)
>>>>> +                return rc;
>>>>> +        }
>>>>> +
>>>>> +        buf64[0] = cpu_to_be64(addr);
>>>>> +        buf64[1] = cpu_to_be64(mask);
>>>>> +        buf32[4] = cpu_to_be32(pe->addr);
>>>>> +        buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
>>>>> +        buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
>>>>> +        buf32[7] = cpu_to_be32(func);
>>>>>           break;
>>>>> +
>>>>>       default:
>>>>> -        return -ERANGE;
>>>>> +        pr_err("unsupported RTAS error injection type 0x%x\n", 
>>>>> rtas_err_type);
>>>>> +        return -EINVAL;
>>>>>       }
>>>> [...]
>>>>> +    pr_debug("errinjct buffer ready: rtas_err_type=0x%x func=%d 
>>>>> addr=0x%lx mask=0x%lx\n",
>>>>> +         rtas_err_type, func, addr, mask);
>>>>>       return 0;
>>>>>   }
>>>>> +/* Serializes the open/inject/close RTAS error injection session */
>>>>> +static DEFINE_MUTEX(errinjct_mutex);
>>>>> +
>>>>> +/**
>>>>> + * pseries_eeh_err_inject - Inject specified error to the 
>>>>> indicated PE
>>>>> + * @pe: the indicated PE
>>>>> + * @type: generic EEH error type (EEH_ERR_TYPE_32 or 
>>>>> EEH_ERR_TYPE_64)
>>>>> + * @func: specific error function
>>>>> + * @addr: address argument (type-dependent, may be zero)
>>>>> + * @mask: address mask (type-dependent, may be zero)
>>>>> + *
>>>>> + * Implements PAPR-compliant error injection using:
>>>>> + *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
>>>>> + *
>>>>> + * errinjct_mutex serializes the open/inject/close session sequence
>>>>> + * because RTAS maintains state between these calls.  A short-lived
>>>>> + * RTAS work area is allocated after a successful open and freed 
>>>>> before
>>>>> + * close.
>>>>> + *
>>>>> + * Return: 0 on success, negative errno on failure.
>>>>> + */
>>>>> +static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, 
>>>>> int func,
>>>>> +                  unsigned long addr, unsigned long mask)
>>>>> +{
>>>>> +    struct rtas_work_area *area;
>>>>> +    phys_addr_t area_phys;
>>>>> +    void *buf;
>>>>> +    int open_token, errinjct_token, close_token;
>>>>> +    int session_token;
>>>>> +    int rtas_err_type;
>>>>
>>>> The name rtas_err_type seems a bit confusing for the error 
>>>> injection class.
>>>> Would err_injct_class or errinjct_class be clearer?
>>>>
>>> Agreed. I'll use errinjct_class.
>>>>> +    int close_rc;
>>>>> +    int rc;
>>>>> +
>>>>> +    rc = validate_errinjct_args(pe, type, func, addr, mask);
>>>>> +    if (rc)
>>>>> +        return rc;
>>>>> +
>>>>> +    rtas_err_type = pseries_eeh_type_to_rtas(type);
>>>>> +    if (rtas_err_type < 0)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>>>>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>>>>> +    close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
>>>>> +
>>>>> +    if (open_token == RTAS_UNKNOWN_SERVICE ||
>>>>> +        errinjct_token == RTAS_UNKNOWN_SERVICE ||
>>>>> +        close_token == RTAS_UNKNOWN_SERVICE)
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    mutex_lock(&errinjct_mutex);
>>>> Is this lock really necessary?
>>>>
>>> As mentioned above, the intention is to serialize complete error
>>> injection sessions initiated through the EEH backend rather than
>>> individual RTAS calls.
>>>
>>> However, this mutex does not serialize direct userspace RTAS
>>> callers. I'll verify the firmware session ownership semantics
>>> before deciding whether to retain it.
>>>
>>>> - Sourabh Jain
>>>>
>>>>> +
>>>>> +    do {
>>>>> +        rc = rtas_call(open_token, 0, 2, &session_token);
>>>>> +    } while (rtas_busy_delay(rc));
>>>>> +
>>>>> +    if (rc) {
>>>>> +        pr_err("ibm,open-errinjct failed: status=%d\n", rc);
>>>>> +        rc = rtas_error_rc(rc);
>>>>> +        goto out_unlock;
>>>>> +    }
>>>>> +
>>>>> +    area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
>>>>> +    buf = rtas_work_area_raw_buf(area);
>>>>> +    area_phys = rtas_work_area_phys(area);
>>>>> +
>>>>> +    rc = prepare_errinjct_buffer(buf, pe, rtas_err_type, func, 
>>>>> addr, mask);
>>>>> +    if (rc)
>>>>> +        goto out_free_area;
>>>>> +
>>>>> +    /*
>>>>> +     * RTAS work areas are allocated below RTAS_INSTANTIATE_MAX, so
>>>>> +     * area_phys fits in the 32-bit RTAS argument.
>>>>> +     */
>>>>> +    do {
>>>>> +        rc = rtas_call(errinjct_token, 3, 1, NULL,
>>>>> +                   rtas_err_type, session_token,
>>>>> +                   (u32)area_phys);
>>>>> +    } while (rtas_busy_delay(rc));
>>>>> +
>>>>> +    if (rc) {
>>>>> +        pr_err("ibm,errinjct failed: status=%d\n", rc);
>>>>> +        rc = rtas_error_rc(rc);
>>>>> +    }
>>>>> +
>>>>> +out_free_area:
>>>>> +    rtas_work_area_free(area);
>>>>> +
>>>>> +    do {
>>>>> +        close_rc = rtas_call(close_token, 1, 1, NULL, 
>>>>> session_token);
>>>>> +    } while (rtas_busy_delay(close_rc));
>>>>> +
>>>>> +    if (close_rc) {
>>>>> +        pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
>>>>> +        if (!rc)
>>>>> +            rc = rtas_error_rc(close_rc);
>>>>> +    }
>>>>> +
>>>>> +out_unlock:
>>>>> +    mutex_unlock(&errinjct_mutex);
>>>>> +    return rc;
>>>>> +}
>>>>> +
>>>>>   static struct eeh_ops pseries_eeh_ops = {
>>>>>       .name            = "pseries",
>>>>>       .probe            = pseries_eeh_probe,
>>>
>>> Thanks,
>>> Narayana Murty.
>>>
>>>>
>>>
>>
>


