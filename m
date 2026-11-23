Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11184606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y+Z5tlms
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY8492jT4z2xyj;
	Tue, 24 Nov 2026 01:50:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795445401;
	cv=none; b=CkOXH2DvjN/kmL1q3x2oQhf0WSYtggfxIs4xZs9lHXoaAaMJme5VZ6Q3zxGCAv4gETndzGtL/q+gtH/NLzs6C66w9ZWwJaZ8XQCBcYUmJ49sRxU/E48Uvps5IyOcFkHbtVcbgRgs569MuTExp1Jya7KnGywgjfHgK1nXQhe48ueFOx6JVTe3EdaLpwWx3g7mN4Nosm4kIxhDF+Mw6Fg1AoHjl15JCY8BAJbsz8HaCRUaKQLqfzRBs+tUDpHrO0EArTXqIyVJPDJVXwffnaUMzuFWpWys4lYd+fdBfwQs3TofVJGjnbbxzdb4ClYp+avH0pkL7Ndzl3C29sXZ0PY7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795445401; c=relaxed/relaxed;
	bh=E/7XSULRzHrEqrz72YFJ7FMyvKJVanU1VPdQYLw5WeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJC2mjGfqf825cx3TyNCAKksKx2aI0LQoJJCDfym1Dezz3g7H4xM5IIkYu/DYlWdxkuMBn4wPGhNBaxZNuk3vq4XLju3cb9oe18blePjIJwTFhKMq5cXYwHhYq71vGw8o/JMCaZqtc5P+hQ0PLyuXxQOtYhK2364NmKCBdK8Liipm6VKTXjX4cLjyrTHsSlwrieK8hxRFdl3KQGbUGDt2u1/z3foNyLpbc8U6wayBB4GN+zN5J6decCBToxS08AJtsJb5w+GBdvOBd5zq/bQ037a4tdLHXHrYkkJuNdQy6+LQTz/sJ9qRKDpPaqQ5gJC9pCjj7dDVg3l0S34TaQrBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y+Z5tlms; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y+Z5tlms;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY8476X3Wz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 01:49:59 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYtJH3696211;
	Mon, 23 Nov 2026 14:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E/7XSU
	LRzHrEqrz72YFJ7FMyvKJVanU1VPdQYLw5WeA=; b=Y+Z5tlmswxWN9hMAg/GLCT
	TEWDUmKzcTCgIa0zbPbENZz7ymwMpWVVCJ7Sb/AwY/gp88i10WsVOVHdQxlhGNXZ
	FcKqVix7G3aYDZedLvktRJ/s8MzPGpPY8vug1uTFUr7xOOt3B0dbXTRYd6ALkKCH
	YUWcnaaclhRK4iz887gX+9/gRAZzyOtzDINzepzvcKwkzP0EXoNFs2U7OGfHCAL+
	11jQizXnJwYumQ4PfFag1+OcBh3vF8/eHLgKKaSB2GeSE28B7koL74Jgv0zKn0/p
	xD/KN4VWrDHF52pZp17SZ/1jgirl9yoZ16zIxWFroOli6uuCm8yNQUoWOWw+rCew
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv3bw5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 14:49:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDJUtN1222864;
	Mon, 23 Nov 2026 14:49:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vf9j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 14:49:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANEnb5B42008974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 14:49:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08B072004B;
	Mon, 23 Nov 2026 14:49:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47EE320043;
	Mon, 23 Nov 2026 14:49:33 +0000 (GMT)
Received: from [9.124.210.23] (unknown [9.124.210.23])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 14:49:33 +0000 (GMT)
Message-ID: <55a6ca4a-d58e-4203-a806-c6eac3849aeb@linux.ibm.com>
Date: Mon, 23 Nov 2026 20:19:31 +0530
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
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
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
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <f9d72183-419c-42cc-9d52-592d4ae34b71@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b045286 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=x82tw3cb6yPwOLY93PQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX4nBE1RxhVHoy
 jxsJqBY5/2oUZ7YR4Pq5mLVTkKaHL7wCyx3PxVSAMgA8voPEWfWdF9Puw26LiTVCFRaFBwteLpO
 VFOJQzWqOVD8jzlfU9clYe5DqTN5kHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX61A7fqyuWpmC
 WwwqhtNn/e0D/F/hy2zG1y6VwsLXMRJhjojIC9nznv7rQ447XlX3KdpI9bHDjGlUSXQqZFhDdYn
 /2ufxA4Kja6k+Sg1QrTJgOVYDKZ8J1jQhPmAgyoqQ5OSObo84gu1PVvH8sS18PnvJryo7ELoDJg
 yUW2/JmvEXyw3tbquU4UEjhSSLrkB3wtujNG4mf6gE/H2l0Ghlan7CJ2egrHlenMTULIoZhAB9/
 H6Td6q3eUu+GcaLsybgER4FHuWbqscN+q1nNrXaAR0kDqgt2iQ/1mwcDxnUHS/Y0541K8J8weD0
 oekUUKs13CVbO+5WbbbQd9Iqhdxsnbz0vhJsdm4RdmMEqFdhlP/WFDEJwf8ULtzBzfyWfwBXxv1
 6eXQU1BizxVqeYTaU6sgLPEzH339rJAI0QyMGBcdHTy4dZ1E5gv2bWMjrDhKQuH/dHs0lVO/BV4
 wM4LCshFHew12UM79hQ==
X-Proofpoint-ORIG-GUID: 6dMVjiPGen94XOzkGtuGNbaMNqdiOFDW
X-Proofpoint-GUID: JMo3OwEPkphURADkOdbzIiPtSALT34EX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230058
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sourabh,

On 23/11/26 6:33 PM, Sourabh Jain wrote:
> 
> 
> On 20/11/26 13:02, Narayana Murty N wrote:
>> Hi Sourah,
>>
>> On 19/11/26 12:44 AM, Sourabh Jain wrote:
>>> Similar to 2/5, I'm finding this commit message a bit difficult to 
>>> follow.
>>> Could you please rework it to make the changes and their purpose 
>>> clearer?
>>>
>>>
>> Agreed. I'll merge 2/5 and 3/5 and rework the commit message.
> 
> I didn't recommend merging 2/5 and 3/5.
> 
Regarding merging 2/5 and 3/5, most helpers in 2/5 are used only by 3/5. 
I merged them to keep the helpers alongside their callers and avoid an 
intermediate patch with unused static functions.

>>> On 23/10/26 13:06, Narayana Murty N wrote:
>>>> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
>>>> PAPR-compliant RTAS error injection path.
>>>>
>>>> Serialize each ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct
>>>> session with errinjct_mutex because RTAS maintains state between these
>>>> calls.
>>> I don't quite understand this point. What RTAS state are we referring to
>>> here? Also, could you clarify how keeping all three calls under a 
>>> lock helps
>>> maintain the RTAS state mentioned above?
>>>
>> I was referring to the error injection session established by
>> ibm,open-errinjct and identified by the returned session token.
>>
>> The RTAS lock serializes individual RTAS calls, but not the complete
>> open/inject/close sequence. The intention of errinjct_mutex is to
>> prevent concurrent EEH injection requests from interleaving their
>> sessions.
> 
> Ok the intent is to synchronize multiple err_injection requests? So
> kernel would do open/inject/close together for 1 request and then
> move to another request do open/inject/close.....
> 
> Could you please help me understand what is wrong with concurrent EEH
> injection requests with an interleaved open/inject/close sequence?
> 
> Is this restriction coming from PAPR? If yes, please share the section no.
As per LoPAPR v1.1, Section 7.3.13 (R1-7.3.13-2 and R1-7.3.13-3), only 
one ERRINJCT facility can be open at a time. A concurrent 
ibm,open-errinjct returns -4 (already open).

The mutex serializes kernel-initiated EEH injection requests so that 
each open/inject/close sequence completes before the next begins, 
avoiding unnecessary -EBUSY failures.

It does not serialize external sys_rtas() callers. If an external 
process already owns the facility, firmware returns -4, which the kernel 
handles accordingly.

Thanks,
Narayana
> 
> - Sourabh Jain
> 
>>
>> I'll recheck the PAPR session ownership requirements to determine
>> whether this additional serialization is necessary.
>>>>
>>>> Once ibm,open-errinjct succeeds, ibm,close-errinjct is attempted
>>>> after parameter preparation or ibm,errinjct failures.  The RTAS work
>>>> area is allocated after a successful open to avoid holding it while
>>>> waiting for the mutex or if open fails.
>>> RTAS work area is mentioned here, but the next paragraph discusses
>>> something else. The details about the RTAS work area only appear in a
>>> later paragraph. I think the flow could be improved by keeping related
>>> information together.
>>>
>> Agreed. I'll keep the work-area allocation and lifetime details
>> together in the revised commit message.
>>>
>>>> VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
>>>> the generic EEH error types to RTAS ibm,errinjct encodings via
>>>> pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
>>>> unchanged; their values are defined in arch/powerpc/include/uapi/ 
>>>> asm/ eeh.h
>>>> and are not renumbered.
>>>>
>>>> The RTAS work-area allocator guarantees that returned memory is within
>>>> the range accessible by RTAS (below min(ppc64_rma_size,
>>>> RTAS_INSTANTIATE_MAX), which is at most RTAS_INSTANTIATE_MAX = 1 GiB),
>>>> so the physical address fits in the 32-bit RTAS argument without
>>>> truncation.
>>>>
>>>> Remove eeh_pe_inject_mmio_error() and its declaration; this patch
>>>> removes its only caller.  The only remaining caller of
>>>> eeh_break_device() is eeh_dev_break_write() inside CONFIG_DEBUG_FS,
>>>> so move eeh_break_device() back inside the CONFIG_DEBUG_FS block to
>>>> avoid an unused-function warning when CONFIG_DEBUG_FS=n.
>>>>
>>>> Also introduce validate_errinjct_args() and prepare_errinjct_buffer()
>>>> here alongside their callers, so each intermediate commit builds
>>>> cleanly with CONFIG_WERROR.
>>>
>>> Could you clarify what this intermediate commit is for?
>>>
>> The intention was to separate the helper infrastructure from the
>> RTAS implementation. However, given the unused static helpers
>> and the additional complexity introduced by the split, I'll merge
>> the two patches.
>>>
>>>> The addr argument to ibm,errinjct is function-dependent.  Memory and IO
>>>> load/store functions (EEH_ERR_FUNC_LD/ST_MEM_* and EEH_ERR_FUNC_LD/ 
>>>> ST_IO_*)
>>>> target BAR-backed PCI bus addresses; these are validated against the PE
>>>> via validate_addr_mask_in_pe().  Config-space functions carry PCI 
>>>> config
>>>> register offsets and DMA functions carry IOVA/TCE addresses; addr for
>>>> these functions is passed directly to RTAS without BAR membership
>>>> validation.
>>>>
>>>> For the 32-bit RTAS encoding (RTAS_ERR_TYPE_IOA_BUS_ERROR), addr and
>>>> mask are checked to fit in 32 bits before buffer encoding. This is an
>>>> RTAS format constraint independent of function type.
>>>>
>>>> Tested with corresponding QEMU patches:
>>>> https://lore.kernel.org/all/20251029150618.186803-1- 
>>>> nnmlinux@linux.ibm.com/
>>>
>>> Wouldn't this be better suited for the cover letter?
>>>
>> Agreed. I'll move the reference to the corresponding QEMU series
>> to the cover letter.
>>>
>>>>
>>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/include/asm/eeh.h               |   2 -
>>>>   arch/powerpc/kernel/eeh.c                    |  10 +-
>>>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 246 +++++++++++++++ 
>>>> ++--
>>>>   3 files changed, 228 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/ 
>>>> asm/eeh.h
>>>> index b7ebb4ac2c71..083ac58e7eb7 100644
>>>> --- a/arch/powerpc/include/asm/eeh.h
>>>> +++ b/arch/powerpc/include/asm/eeh.h
>>>> @@ -310,8 +310,6 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, 
>>>> bool include_passed);
>>>>   int eeh_pe_configure(struct eeh_pe *pe);
>>>>   int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>>>                 unsigned long addr, unsigned long mask);
>>>> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>>>> -
>>>>   /**
>>>>    * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>>>    *
>>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>>> index bb836f02101c..bae7ca2bd399 100644
>>>> --- a/arch/powerpc/kernel/eeh.c
>>>> +++ b/arch/powerpc/kernel/eeh.c
>>> [...]
>>>> @@ -1571,6 +1571,8 @@ static int proc_eeh_show(struct seq_file *m, 
>>>> void *v)
>>>>   }
>>>>   #endif /* CONFIG_PROC_FS */
>>>> +#ifdef CONFIG_DEBUG_FS
>>>> +
>>>>   static int eeh_break_device(struct pci_dev *pdev)
>>>>   {
>>>>       struct resource *bar = NULL;
>>>> @@ -1664,14 +1666,6 @@ static int eeh_break_device(struct pci_dev 
>>>> *pdev)
>>>>       return 0;
>>>>   }
>>>> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>>>> -{
>>>> -    return eeh_break_device(pdev);
>>>> -}
>>>> -
>>>> -#ifdef CONFIG_DEBUG_FS
>>>> -
>>>> -
>>>>   static struct pci_dev *eeh_debug_lookup_pdev(struct file *filp,
>>>>                            const char __user *user_buf,
>>>>                            size_t count, loff_t *ppos)
>>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>>>> powerpc/platforms/pseries/eeh_pseries.c
>>>> index 28b1fd19e8bc..2a2ec1a237e6 100644
>>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> [...]
>>>> @@ -35,6 +35,7 @@
>>>>   #include <asm/machdep.h>
>>>>   #include <asm/ppc-pci.h>
>>>>   #include <asm/rtas.h>
>>>> +#include <asm/rtas-work-area.h>
>>>>   /* RTAS tokens */
>>>>   static int ibm_set_eeh_option;
>>>> @@ -915,48 +916,253 @@ static int validate_addr_mask_in_pe(struct 
>>>> eeh_pe *pe, unsigned long addr,
>>>>       pci_unlock_rescan_remove();
>>>>       if (!found)
>>>> -        pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of 
>>>> any device in PE\n",
>>>> -               addr, mask);
>>>> +        pr_debug("addr=0x%lx mask=0x%lx not within any PCI bus BAR 
>>>> of any device in PE\n",
>>>> +             addr, mask);
>>>
>>> IIUC, the previous patch adds pr_err(), and this patch changes it to 
>>> pr_debug().
>>> Could we avoid this intermediate change?
>>>
>> Yes. I'll introduce pr_debug() directly in the merged patch.
>>
>>>>       return found ? 0 : -EINVAL;
>>>>   }
>>>>   /**
>>>> - * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>>> - * @pe: the indicated PE
>>>> - * @type: error type
>>>> - * @func: specific error type
>>>> - * @addr: address
>>>> - * @mask: address mask
>>>> - * The routine is called to inject specified error, which is
>>>> - * determined by @type and @func, to the indicated PE
>>>> + * validate_errinjct_args - Top-level validation for RTAS error 
>>>> injection arguments
>>>> + * @pe:   EEH PE for the target device
>>>> + * @type: generic EEH error type
>>>> + * @func: error function selector
>>>> + * @addr: address argument (type-dependent, may be zero)
>>>> + * @mask: mask argument (type-dependent, may be zero)
>>> Are addr and mask really needed as function arguments?
>>>
>> No, they are not used by validate_errinjct_args().
>> I'll simplify the validation and avoid the duplicate error-type
>> mapping.
>>>> + *
>>>> + * Validates all parameters before opening an RTAS injection session.
>>>> + * Returns Linux errno values; does not return raw RTAS status codes.
>>>
>>> Wouldn't it be better for the function comment to describe what the
>>> function does, rather than how an RTAS injection session should be 
>>> opened?
>>>
>> Agreed. I will shorten the comment.
>>>> + *
>>>> + * Return: 0 if all parameters are valid, negative errno otherwise.
>>>>    */
>>>> -static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>>>> func,
>>>> +static int validate_errinjct_args(struct eeh_pe *pe, int type, int 
>>>> func,
>>>>                     unsigned long addr, unsigned long mask)
>>>>   {
>>>> -    struct    eeh_dev    *pdev;
>>>> +    if (!pe || !pe->phb)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (pseries_eeh_type_to_rtas(type) < 0)
>>>> +        return -EINVAL;
>>>> -    /* Check on PCI error type */
>>>> -    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>>>> +    if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>>>>           return -EINVAL;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * pseries_eeh_func_needs_bar_addr - return true for error 
>>>> functions whose
>>>> + * addr argument is a BAR-backed PCI MMIO or IO address.
>>>> + *
>>>> + * Memory and IO load/store functions target specific BAR addresses 
>>>> and
>>>> + * require PCI bus address validation against the PE. Config-space
>>>> + * functions carry PCI config register offsets and DMA functions carry
>>>> + * IOVA/TCE addresses; neither is a BAR address.
>>>
>>> This seems like useful information, but perhaps it belongs elsewhere.
>>> The function itself looks fairly simple, and the comment conveys quite a
>>> bit of information that I’m not sure how to relate to what the 
>>> function actually does.
>>>
>> Agreed. I'll keep the helper comment focused.
>>>
>>>> + */
>>>> +static bool pseries_eeh_func_needs_bar_addr(int func)
>>>> +{
>>>>       switch (func) {
>>>>       case EEH_ERR_FUNC_LD_MEM_ADDR:
>>>>       case EEH_ERR_FUNC_LD_MEM_DATA:
>>>> +    case EEH_ERR_FUNC_LD_IO_ADDR:
>>>> +    case EEH_ERR_FUNC_LD_IO_DATA:
>>>>       case EEH_ERR_FUNC_ST_MEM_ADDR:
>>>>       case EEH_ERR_FUNC_ST_MEM_DATA:
>>>> -        /* injects a MMIO error for all pdev's belonging to PE */
>>>> -        pci_lock_rescan_remove();
>>>> -        list_for_each_entry(pdev, &pe->edevs, entry)
>>>> -            eeh_pe_inject_mmio_error(pdev->pdev);
>>>> -        pci_unlock_rescan_remove();
>>>> +    case EEH_ERR_FUNC_ST_IO_ADDR:
>>>> +    case EEH_ERR_FUNC_ST_IO_DATA:
>>>> +        return true;
>>>> +    default:
>>>> +        return false;
>>>> +    }
>>>> +}
>>>> +
>>>> +/**
>>>> + * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
>>>> + * @buf: RTAS error-injection work buffer
>>>> + * @pe: EEH PE associated with the injection target
>>>> + * @rtas_err_type: RTAS firmware error-injection type
>>>> + * @func: Error function selector
>>>> + * @addr: Address argument interpreted according to @func:
>>>> + *        MEM/IO functions: BAR-backed PCI bus address;
>>>> + *        CFG functions: PCI configuration-space offset;
>>>> + *        DMA functions: DMA/IOVA/TCE address.
>>>> + * @mask: Address mask passed to firmware
>>>> + *
>>>> + * Zeroes @buf and populates it according to the PAPR layout for the
>>>> + * selected IOA bus-error injection type.
>>>> + *
>>>> + * BAR membership validation is performed only for MEM/IO functions
>>>> + * whose @addr is a BAR-backed PCI bus address.  CFG and DMA function
>>>> + * addresses are encoded directly without BAR lookup.
>>>> + *
>>>> + * The caller provides an exclusive per-call RTAS work-area buffer.
>>>> + * Firmware session serialization is handled by 
>>>> pseries_eeh_err_inject().
>>> Wouldn't this be better documented elsewhere? This function only 
>>> populates
>>> the given work area; it doesn't make the RTAS call.
>>>
>> Agreed. I'll keep the comment focused on encoding the RTAS
>> parameter buffer and move the session-related details to the caller.
>>>> + *
>>>> + * Return: 0 on success or a negative errno on invalid input.
>>>> + */
>>>> +static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>>>> +                   int rtas_err_type, int func,
>>>> +                   unsigned long addr, unsigned long mask)
>>>> +{
>>>> +    __be64 *buf64 = (__be64 *)buf;
>>>> +    __be32 *buf32 = (__be32 *)buf;
>>>> +    int rc;
>>>> +
>>>> +    if (!buf || !pe || !pe->phb)
>>>> +        return -EINVAL;
>>>> +
>>>> +    memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
>>>> +
>>>> +    switch (rtas_err_type) {
>>>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
>>>> +        /*
>>>> +         * 32-bit RTAS format: addr and mask must fit in 32 bits.
>>>> +         * This is an RTAS encoding constraint, not BAR validation.
>>>> +         */
>>>> +        if (upper_32_bits(addr) || upper_32_bits(mask))
>>>> +            return -EINVAL;
>>>> +
>>> [...]
>>>> +        if (pseries_eeh_func_needs_bar_addr(func)) {
>>>> +            rc = validate_addr_mask_in_pe(pe, addr, mask);
>>>> +            if (rc)
>>>> +                return rc;
>>>> +        }
>>>> +
>>>> +        buf32[0] = cpu_to_be32((u32)addr);
>>>> +        buf32[1] = cpu_to_be32((u32)mask);
>>>> +        buf32[2] = cpu_to_be32(pe->addr);
>>>> +        buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
>>>> +        buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
>>>> +        buf32[5] = cpu_to_be32(func);
>>>> +        break;
>>>> +
>>>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
>>>> +        if (pseries_eeh_func_needs_bar_addr(func)) {
>>>> +            rc = validate_addr_mask_in_pe(pe, addr, mask);
>>>> +            if (rc)
>>>> +                return rc;
>>>> +        }
>>>> +
>>>> +        buf64[0] = cpu_to_be64(addr);
>>>> +        buf64[1] = cpu_to_be64(mask);
>>>> +        buf32[4] = cpu_to_be32(pe->addr);
>>>> +        buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
>>>> +        buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
>>>> +        buf32[7] = cpu_to_be32(func);
>>>>           break;
>>>> +
>>>>       default:
>>>> -        return -ERANGE;
>>>> +        pr_err("unsupported RTAS error injection type 0x%x\n", 
>>>> rtas_err_type);
>>>> +        return -EINVAL;
>>>>       }
>>> [...]
>>>> +    pr_debug("errinjct buffer ready: rtas_err_type=0x%x func=%d 
>>>> addr=0x%lx mask=0x%lx\n",
>>>> +         rtas_err_type, func, addr, mask);
>>>>       return 0;
>>>>   }
>>>> +/* Serializes the open/inject/close RTAS error injection session */
>>>> +static DEFINE_MUTEX(errinjct_mutex);
>>>> +
>>>> +/**
>>>> + * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>>> + * @pe: the indicated PE
>>>> + * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
>>>> + * @func: specific error function
>>>> + * @addr: address argument (type-dependent, may be zero)
>>>> + * @mask: address mask (type-dependent, may be zero)
>>>> + *
>>>> + * Implements PAPR-compliant error injection using:
>>>> + *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
>>>> + *
>>>> + * errinjct_mutex serializes the open/inject/close session sequence
>>>> + * because RTAS maintains state between these calls.  A short-lived
>>>> + * RTAS work area is allocated after a successful open and freed 
>>>> before
>>>> + * close.
>>>> + *
>>>> + * Return: 0 on success, negative errno on failure.
>>>> + */
>>>> +static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>>>> func,
>>>> +                  unsigned long addr, unsigned long mask)
>>>> +{
>>>> +    struct rtas_work_area *area;
>>>> +    phys_addr_t area_phys;
>>>> +    void *buf;
>>>> +    int open_token, errinjct_token, close_token;
>>>> +    int session_token;
>>>> +    int rtas_err_type;
>>>
>>> The name rtas_err_type seems a bit confusing for the error injection 
>>> class.
>>> Would err_injct_class or errinjct_class be clearer?
>>>
>> Agreed. I'll use errinjct_class.
>>>> +    int close_rc;
>>>> +    int rc;
>>>> +
>>>> +    rc = validate_errinjct_args(pe, type, func, addr, mask);
>>>> +    if (rc)
>>>> +        return rc;
>>>> +
>>>> +    rtas_err_type = pseries_eeh_type_to_rtas(type);
>>>> +    if (rtas_err_type < 0)
>>>> +        return -EINVAL;
>>>> +
>>>> +    open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>>>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>>>> +    close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
>>>> +
>>>> +    if (open_token == RTAS_UNKNOWN_SERVICE ||
>>>> +        errinjct_token == RTAS_UNKNOWN_SERVICE ||
>>>> +        close_token == RTAS_UNKNOWN_SERVICE)
>>>> +        return -ENODEV;
>>>> +
>>>> +    mutex_lock(&errinjct_mutex);
>>> Is this lock really necessary?
>>>
>> As mentioned above, the intention is to serialize complete error
>> injection sessions initiated through the EEH backend rather than
>> individual RTAS calls.
>>
>> However, this mutex does not serialize direct userspace RTAS
>> callers. I'll verify the firmware session ownership semantics
>> before deciding whether to retain it.
>>
>>> - Sourabh Jain
>>>
>>>> +
>>>> +    do {
>>>> +        rc = rtas_call(open_token, 0, 2, &session_token);
>>>> +    } while (rtas_busy_delay(rc));
>>>> +
>>>> +    if (rc) {
>>>> +        pr_err("ibm,open-errinjct failed: status=%d\n", rc);
>>>> +        rc = rtas_error_rc(rc);
>>>> +        goto out_unlock;
>>>> +    }
>>>> +
>>>> +    area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
>>>> +    buf = rtas_work_area_raw_buf(area);
>>>> +    area_phys = rtas_work_area_phys(area);
>>>> +
>>>> +    rc = prepare_errinjct_buffer(buf, pe, rtas_err_type, func, 
>>>> addr, mask);
>>>> +    if (rc)
>>>> +        goto out_free_area;
>>>> +
>>>> +    /*
>>>> +     * RTAS work areas are allocated below RTAS_INSTANTIATE_MAX, so
>>>> +     * area_phys fits in the 32-bit RTAS argument.
>>>> +     */
>>>> +    do {
>>>> +        rc = rtas_call(errinjct_token, 3, 1, NULL,
>>>> +                   rtas_err_type, session_token,
>>>> +                   (u32)area_phys);
>>>> +    } while (rtas_busy_delay(rc));
>>>> +
>>>> +    if (rc) {
>>>> +        pr_err("ibm,errinjct failed: status=%d\n", rc);
>>>> +        rc = rtas_error_rc(rc);
>>>> +    }
>>>> +
>>>> +out_free_area:
>>>> +    rtas_work_area_free(area);
>>>> +
>>>> +    do {
>>>> +        close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
>>>> +    } while (rtas_busy_delay(close_rc));
>>>> +
>>>> +    if (close_rc) {
>>>> +        pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
>>>> +        if (!rc)
>>>> +            rc = rtas_error_rc(close_rc);
>>>> +    }
>>>> +
>>>> +out_unlock:
>>>> +    mutex_unlock(&errinjct_mutex);
>>>> +    return rc;
>>>> +}
>>>> +
>>>>   static struct eeh_ops pseries_eeh_ops = {
>>>>       .name            = "pseries",
>>>>       .probe            = pseries_eeh_probe,
>>
>> Thanks,
>> Narayana Murty.
>>
>>>
>>
> 


