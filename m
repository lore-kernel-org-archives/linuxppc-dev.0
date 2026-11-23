Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F80606A31F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jCfldrd4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY5kd24WKz2xyj;
	Tue, 24 Nov 2026 00:04:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795439081;
	cv=none; b=aCG5hVs61v9d6zqoHe91zsHYjzcA97dqnb8c+NbuczF2fLg84FWrbYCEb7E2Yt8EUPcjOiFUpUlZ+UDdLi0y9TFDd1K0ylQu8Lba4bb0QL4+/Ty0anTPhFuk1WWeidZ6p2v9o3tLJiXVb/bcq3l8Ce7SOq8gWGgr5XIW2H/8XMVrgh7Cq7faSkcnZqvt58Rx8/W28stc/ViqHaiSgC4fvNtcVpWGaBVX1KGmxPToC27L+0ncd21epc3oNQgGc3NBEuTpEYkN+mow90BHUmOm4zS0oGu7ZdeoLuZE0KU/yFVHtM7gP4GiCaIkV/ImcreHMYmGTeTJ/SQzUg4Y1B92xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795439081; c=relaxed/relaxed;
	bh=r10sg7TzkzD8dWdjCsot3JbJN2QP7zMau02OGPqHj5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYlEtcDod313jheEDTIrunFqxxwpWKLXxxwhK9q7UQ8kgijmAR/a3s97Gjb4YiKqrCSK3auuBIg5vlwZB8w3vLRxUPVaeD7w6u3Ea26Gpal3ZUNRDr+0SXMeAwYypJT8hz1dTR0cQ7mr2BF3YUYJ2qlx1Z8L5wSMAhFeS7UNxmKcbB8nkb23E24ExHB1qI0/nMz0IgeH44G0XskRzDVmSrXih2RVklzlwUtDziqykKPG04wGiKVjiwj4TWaMq45lQe9Z+QmA1u8I+9KGD9cNKHXhLkr+66velHO5RbhfwohAH0wVZad2NP8wMVsbvn2GJyk2F9grR1PpuF59qVOAnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jCfldrd4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jCfldrd4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY5kc0WgNz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:04:39 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCZ3kH3621328;
	Mon, 23 Nov 2026 13:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r10sg7
	TzkzD8dWdjCsot3JbJN2QP7zMau02OGPqHj5w=; b=jCfldrd4k+eEwQNyUzDEju
	/GjoE2yGqEoCrR/aqqeggCQZ/iNPvztfEgdvDz0GSUkrA90ZTf3D4otarPexiMIy
	ftmXG48436SFr40tDTD63b0dHeh5ppCqBjFrUOD+AL1q+yJ5rN1DjA9zbspA6uHg
	kiITxKvnkWGbvrF3qO9P2gSzYhF2ApMVbg6d9eFPEZLrVZLZaBd1PmqojMWRx8mg
	ZgYNqEBSkI7kQB0fheyF6XiyDrlVkqmZrVlGc5f6EVo97nJcuWWgpknl35/Mu9K9
	hcBTopZRFD2GClzVmHt0BzP/cDDb6dNWodS42kO5sv4UiPKos86C+7RDrRQdgX3w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkb8wa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:04:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJUw31819075;
	Mon, 23 Nov 2026 13:04:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqf29j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:04:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AND467049611216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:04:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3977C2004E;
	Mon, 23 Nov 2026 13:04:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30AFE20040;
	Mon, 23 Nov 2026 13:04:00 +0000 (GMT)
Received: from [9.39.25.215] (unknown [9.39.25.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:03:59 +0000 (GMT)
Message-ID: <f9d72183-419c-42cc-9d52-592d4ae34b71@linux.ibm.com>
Date: Mon, 23 Nov 2026 18:33:58 +0530
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
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <cc2e7244-e2d3-419e-a732-9440d6f89cc3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfX9/Ek+304D/4z
 /tCsrvszpaDgInhudplL6OTYSp5OsjY4ESEAgVIZ7IqrtwXkEGKO1lQGInIwi3fApINlUFYa6dV
 FcPurLYr+5iNQi7U9GkfbF53vsynyFLGDGzFZwpmt3Vn+SUvp+Ol94Fp+/1m4A4g2HEP8EzOrVb
 O2180TT6mHcp5f7Hfpj2GPqs+kQa1ZCOr6BZX5VhEWrxy4AU5SfoHedDxvetQwHKCDlwnT3XM/s
 pMNBdHgaOtnIHFDZyu6PETsp0lYUJ2/+hJwClS7qD8d774KarKz6V1XJ2D1nn4VJGMPnlLfncaf
 Id77WqX+3A48tC3h1iwm/H1Dz70Wgfjdsz2mhZne30rt82ejl2Fd9qYOfK6gmJhnM2/CmlF19N4
 fuzMGheYKE+mWax7H/VeMw5K55mIOUqg5BFGM70GrPT7kE9A3Ffpm3YX5vewui9xxyIiuRAcwNV
 nR2ckrB89um5dIpU1AQ==
X-Proofpoint-ORIG-GUID: zusFLdfn4MdJSU7M1TLaus74I0PFPOQ0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfX8VIyEWj4aWJS
 +WwVvVLHF8FsS0MqHc23h4u3/IWbNn4hcWAzqOR2c1Oj2Bxq4LL7mF8dxlOdLdFUeG3dsLbpOa0
 PMa7gLP6D1sEwc87waz4De2ex3yRDd0=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0439cb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Fsvh7gNPGuxWjlyFHk0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I66Dv4Ish5_1FN_xtUPpoSIYmmxhKco0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230052
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/11/26 13:02, Narayana Murty N wrote:
> Hi Sourah,
>
> On 19/11/26 12:44 AM, Sourabh Jain wrote:
>> Similar to 2/5, I'm finding this commit message a bit difficult to 
>> follow.
>> Could you please rework it to make the changes and their purpose 
>> clearer?
>>
>>
> Agreed. I'll merge 2/5 and 3/5 and rework the commit message.

I didn't recommend merging 2/5 and 3/5.

>> On 23/10/26 13:06, Narayana Murty N wrote:
>>> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
>>> PAPR-compliant RTAS error injection path.
>>>
>>> Serialize each ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct
>>> session with errinjct_mutex because RTAS maintains state between these
>>> calls.
>> I don't quite understand this point. What RTAS state are we referring to
>> here? Also, could you clarify how keeping all three calls under a 
>> lock helps
>> maintain the RTAS state mentioned above?
>>
> I was referring to the error injection session established by
> ibm,open-errinjct and identified by the returned session token.
>
> The RTAS lock serializes individual RTAS calls, but not the complete
> open/inject/close sequence. The intention of errinjct_mutex is to
> prevent concurrent EEH injection requests from interleaving their
> sessions.

Ok the intent is to synchronize multiple err_injection requests? So
kernel would do open/inject/close together for 1 request and then
move to another request do open/inject/close.....

Could you please help me understand what is wrong with concurrent EEH
injection requests with an interleaved open/inject/close sequence?

Is this restriction coming from PAPR? If yes, please share the section no.

- Sourabh Jain

>
> I'll recheck the PAPR session ownership requirements to determine
> whether this additional serialization is necessary.
>>>
>>> Once ibm,open-errinjct succeeds, ibm,close-errinjct is attempted
>>> after parameter preparation or ibm,errinjct failures.  The RTAS work
>>> area is allocated after a successful open to avoid holding it while
>>> waiting for the mutex or if open fails.
>> RTAS work area is mentioned here, but the next paragraph discusses
>> something else. The details about the RTAS work area only appear in a
>> later paragraph. I think the flow could be improved by keeping related
>> information together.
>>
> Agreed. I'll keep the work-area allocation and lifetime details
> together in the revised commit message.
>>
>>> VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
>>> the generic EEH error types to RTAS ibm,errinjct encodings via
>>> pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
>>> unchanged; their values are defined in 
>>> arch/powerpc/include/uapi/asm/ eeh.h
>>> and are not renumbered.
>>>
>>> The RTAS work-area allocator guarantees that returned memory is within
>>> the range accessible by RTAS (below min(ppc64_rma_size,
>>> RTAS_INSTANTIATE_MAX), which is at most RTAS_INSTANTIATE_MAX = 1 GiB),
>>> so the physical address fits in the 32-bit RTAS argument without
>>> truncation.
>>>
>>> Remove eeh_pe_inject_mmio_error() and its declaration; this patch
>>> removes its only caller.  The only remaining caller of
>>> eeh_break_device() is eeh_dev_break_write() inside CONFIG_DEBUG_FS,
>>> so move eeh_break_device() back inside the CONFIG_DEBUG_FS block to
>>> avoid an unused-function warning when CONFIG_DEBUG_FS=n.
>>>
>>> Also introduce validate_errinjct_args() and prepare_errinjct_buffer()
>>> here alongside their callers, so each intermediate commit builds
>>> cleanly with CONFIG_WERROR.
>>
>> Could you clarify what this intermediate commit is for?
>>
> The intention was to separate the helper infrastructure from the
> RTAS implementation. However, given the unused static helpers
> and the additional complexity introduced by the split, I'll merge
> the two patches.
>>
>>> The addr argument to ibm,errinjct is function-dependent.  Memory and IO
>>> load/store functions (EEH_ERR_FUNC_LD/ST_MEM_* and EEH_ERR_FUNC_LD/ 
>>> ST_IO_*)
>>> target BAR-backed PCI bus addresses; these are validated against the PE
>>> via validate_addr_mask_in_pe().  Config-space functions carry PCI 
>>> config
>>> register offsets and DMA functions carry IOVA/TCE addresses; addr for
>>> these functions is passed directly to RTAS without BAR membership
>>> validation.
>>>
>>> For the 32-bit RTAS encoding (RTAS_ERR_TYPE_IOA_BUS_ERROR), addr and
>>> mask are checked to fit in 32 bits before buffer encoding. This is an
>>> RTAS format constraint independent of function type.
>>>
>>> Tested with corresponding QEMU patches:
>>> https://lore.kernel.org/all/20251029150618.186803-1- 
>>> nnmlinux@linux.ibm.com/
>>
>> Wouldn't this be better suited for the cover letter?
>>
> Agreed. I'll move the reference to the corresponding QEMU series
> to the cover letter.
>>
>>>
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/eeh.h               |   2 -
>>>   arch/powerpc/kernel/eeh.c                    |  10 +-
>>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 246 
>>> +++++++++++++++++--
>>>   3 files changed, 228 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/ 
>>> asm/eeh.h
>>> index b7ebb4ac2c71..083ac58e7eb7 100644
>>> --- a/arch/powerpc/include/asm/eeh.h
>>> +++ b/arch/powerpc/include/asm/eeh.h
>>> @@ -310,8 +310,6 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, 
>>> bool include_passed);
>>>   int eeh_pe_configure(struct eeh_pe *pe);
>>>   int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>>                 unsigned long addr, unsigned long mask);
>>> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>>> -
>>>   /**
>>>    * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>>    *
>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>> index bb836f02101c..bae7ca2bd399 100644
>>> --- a/arch/powerpc/kernel/eeh.c
>>> +++ b/arch/powerpc/kernel/eeh.c
>> [...]
>>> @@ -1571,6 +1571,8 @@ static int proc_eeh_show(struct seq_file *m, 
>>> void *v)
>>>   }
>>>   #endif /* CONFIG_PROC_FS */
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>>   static int eeh_break_device(struct pci_dev *pdev)
>>>   {
>>>       struct resource *bar = NULL;
>>> @@ -1664,14 +1666,6 @@ static int eeh_break_device(struct pci_dev 
>>> *pdev)
>>>       return 0;
>>>   }
>>> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>>> -{
>>> -    return eeh_break_device(pdev);
>>> -}
>>> -
>>> -#ifdef CONFIG_DEBUG_FS
>>> -
>>> -
>>>   static struct pci_dev *eeh_debug_lookup_pdev(struct file *filp,
>>>                            const char __user *user_buf,
>>>                            size_t count, loff_t *ppos)
>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>>> powerpc/platforms/pseries/eeh_pseries.c
>>> index 28b1fd19e8bc..2a2ec1a237e6 100644
>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> [...]
>>> @@ -35,6 +35,7 @@
>>>   #include <asm/machdep.h>
>>>   #include <asm/ppc-pci.h>
>>>   #include <asm/rtas.h>
>>> +#include <asm/rtas-work-area.h>
>>>   /* RTAS tokens */
>>>   static int ibm_set_eeh_option;
>>> @@ -915,48 +916,253 @@ static int validate_addr_mask_in_pe(struct 
>>> eeh_pe *pe, unsigned long addr,
>>>       pci_unlock_rescan_remove();
>>>       if (!found)
>>> -        pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of 
>>> any device in PE\n",
>>> -               addr, mask);
>>> +        pr_debug("addr=0x%lx mask=0x%lx not within any PCI bus BAR 
>>> of any device in PE\n",
>>> +             addr, mask);
>>
>> IIUC, the previous patch adds pr_err(), and this patch changes it to 
>> pr_debug().
>> Could we avoid this intermediate change?
>>
> Yes. I'll introduce pr_debug() directly in the merged patch.
>
>>>       return found ? 0 : -EINVAL;
>>>   }
>>>   /**
>>> - * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>> - * @pe: the indicated PE
>>> - * @type: error type
>>> - * @func: specific error type
>>> - * @addr: address
>>> - * @mask: address mask
>>> - * The routine is called to inject specified error, which is
>>> - * determined by @type and @func, to the indicated PE
>>> + * validate_errinjct_args - Top-level validation for RTAS error 
>>> injection arguments
>>> + * @pe:   EEH PE for the target device
>>> + * @type: generic EEH error type
>>> + * @func: error function selector
>>> + * @addr: address argument (type-dependent, may be zero)
>>> + * @mask: mask argument (type-dependent, may be zero)
>> Are addr and mask really needed as function arguments?
>>
> No, they are not used by validate_errinjct_args().
> I'll simplify the validation and avoid the duplicate error-type
> mapping.
>>> + *
>>> + * Validates all parameters before opening an RTAS injection session.
>>> + * Returns Linux errno values; does not return raw RTAS status codes.
>>
>> Wouldn't it be better for the function comment to describe what the
>> function does, rather than how an RTAS injection session should be 
>> opened?
>>
> Agreed. I will shorten the comment.
>>> + *
>>> + * Return: 0 if all parameters are valid, negative errno otherwise.
>>>    */
>>> -static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>>> func,
>>> +static int validate_errinjct_args(struct eeh_pe *pe, int type, int 
>>> func,
>>>                     unsigned long addr, unsigned long mask)
>>>   {
>>> -    struct    eeh_dev    *pdev;
>>> +    if (!pe || !pe->phb)
>>> +        return -EINVAL;
>>> +
>>> +    if (pseries_eeh_type_to_rtas(type) < 0)
>>> +        return -EINVAL;
>>> -    /* Check on PCI error type */
>>> -    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>>> +    if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>>>           return -EINVAL;
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * pseries_eeh_func_needs_bar_addr - return true for error 
>>> functions whose
>>> + * addr argument is a BAR-backed PCI MMIO or IO address.
>>> + *
>>> + * Memory and IO load/store functions target specific BAR addresses 
>>> and
>>> + * require PCI bus address validation against the PE. Config-space
>>> + * functions carry PCI config register offsets and DMA functions carry
>>> + * IOVA/TCE addresses; neither is a BAR address.
>>
>> This seems like useful information, but perhaps it belongs elsewhere.
>> The function itself looks fairly simple, and the comment conveys quite a
>> bit of information that I’m not sure how to relate to what the 
>> function actually does.
>>
> Agreed. I'll keep the helper comment focused.
>>
>>> + */
>>> +static bool pseries_eeh_func_needs_bar_addr(int func)
>>> +{
>>>       switch (func) {
>>>       case EEH_ERR_FUNC_LD_MEM_ADDR:
>>>       case EEH_ERR_FUNC_LD_MEM_DATA:
>>> +    case EEH_ERR_FUNC_LD_IO_ADDR:
>>> +    case EEH_ERR_FUNC_LD_IO_DATA:
>>>       case EEH_ERR_FUNC_ST_MEM_ADDR:
>>>       case EEH_ERR_FUNC_ST_MEM_DATA:
>>> -        /* injects a MMIO error for all pdev's belonging to PE */
>>> -        pci_lock_rescan_remove();
>>> -        list_for_each_entry(pdev, &pe->edevs, entry)
>>> -            eeh_pe_inject_mmio_error(pdev->pdev);
>>> -        pci_unlock_rescan_remove();
>>> +    case EEH_ERR_FUNC_ST_IO_ADDR:
>>> +    case EEH_ERR_FUNC_ST_IO_DATA:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    }
>>> +}
>>> +
>>> +/**
>>> + * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
>>> + * @buf: RTAS error-injection work buffer
>>> + * @pe: EEH PE associated with the injection target
>>> + * @rtas_err_type: RTAS firmware error-injection type
>>> + * @func: Error function selector
>>> + * @addr: Address argument interpreted according to @func:
>>> + *        MEM/IO functions: BAR-backed PCI bus address;
>>> + *        CFG functions: PCI configuration-space offset;
>>> + *        DMA functions: DMA/IOVA/TCE address.
>>> + * @mask: Address mask passed to firmware
>>> + *
>>> + * Zeroes @buf and populates it according to the PAPR layout for the
>>> + * selected IOA bus-error injection type.
>>> + *
>>> + * BAR membership validation is performed only for MEM/IO functions
>>> + * whose @addr is a BAR-backed PCI bus address.  CFG and DMA function
>>> + * addresses are encoded directly without BAR lookup.
>>> + *
>>> + * The caller provides an exclusive per-call RTAS work-area buffer.
>>> + * Firmware session serialization is handled by 
>>> pseries_eeh_err_inject().
>> Wouldn't this be better documented elsewhere? This function only 
>> populates
>> the given work area; it doesn't make the RTAS call.
>>
> Agreed. I'll keep the comment focused on encoding the RTAS
> parameter buffer and move the session-related details to the caller.
>>> + *
>>> + * Return: 0 on success or a negative errno on invalid input.
>>> + */
>>> +static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>>> +                   int rtas_err_type, int func,
>>> +                   unsigned long addr, unsigned long mask)
>>> +{
>>> +    __be64 *buf64 = (__be64 *)buf;
>>> +    __be32 *buf32 = (__be32 *)buf;
>>> +    int rc;
>>> +
>>> +    if (!buf || !pe || !pe->phb)
>>> +        return -EINVAL;
>>> +
>>> +    memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
>>> +
>>> +    switch (rtas_err_type) {
>>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
>>> +        /*
>>> +         * 32-bit RTAS format: addr and mask must fit in 32 bits.
>>> +         * This is an RTAS encoding constraint, not BAR validation.
>>> +         */
>>> +        if (upper_32_bits(addr) || upper_32_bits(mask))
>>> +            return -EINVAL;
>>> +
>> [...]
>>> +        if (pseries_eeh_func_needs_bar_addr(func)) {
>>> +            rc = validate_addr_mask_in_pe(pe, addr, mask);
>>> +            if (rc)
>>> +                return rc;
>>> +        }
>>> +
>>> +        buf32[0] = cpu_to_be32((u32)addr);
>>> +        buf32[1] = cpu_to_be32((u32)mask);
>>> +        buf32[2] = cpu_to_be32(pe->addr);
>>> +        buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
>>> +        buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
>>> +        buf32[5] = cpu_to_be32(func);
>>> +        break;
>>> +
>>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
>>> +        if (pseries_eeh_func_needs_bar_addr(func)) {
>>> +            rc = validate_addr_mask_in_pe(pe, addr, mask);
>>> +            if (rc)
>>> +                return rc;
>>> +        }
>>> +
>>> +        buf64[0] = cpu_to_be64(addr);
>>> +        buf64[1] = cpu_to_be64(mask);
>>> +        buf32[4] = cpu_to_be32(pe->addr);
>>> +        buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
>>> +        buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
>>> +        buf32[7] = cpu_to_be32(func);
>>>           break;
>>> +
>>>       default:
>>> -        return -ERANGE;
>>> +        pr_err("unsupported RTAS error injection type 0x%x\n", 
>>> rtas_err_type);
>>> +        return -EINVAL;
>>>       }
>> [...]
>>> +    pr_debug("errinjct buffer ready: rtas_err_type=0x%x func=%d 
>>> addr=0x%lx mask=0x%lx\n",
>>> +         rtas_err_type, func, addr, mask);
>>>       return 0;
>>>   }
>>> +/* Serializes the open/inject/close RTAS error injection session */
>>> +static DEFINE_MUTEX(errinjct_mutex);
>>> +
>>> +/**
>>> + * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>> + * @pe: the indicated PE
>>> + * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
>>> + * @func: specific error function
>>> + * @addr: address argument (type-dependent, may be zero)
>>> + * @mask: address mask (type-dependent, may be zero)
>>> + *
>>> + * Implements PAPR-compliant error injection using:
>>> + *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
>>> + *
>>> + * errinjct_mutex serializes the open/inject/close session sequence
>>> + * because RTAS maintains state between these calls.  A short-lived
>>> + * RTAS work area is allocated after a successful open and freed 
>>> before
>>> + * close.
>>> + *
>>> + * Return: 0 on success, negative errno on failure.
>>> + */
>>> +static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>>> func,
>>> +                  unsigned long addr, unsigned long mask)
>>> +{
>>> +    struct rtas_work_area *area;
>>> +    phys_addr_t area_phys;
>>> +    void *buf;
>>> +    int open_token, errinjct_token, close_token;
>>> +    int session_token;
>>> +    int rtas_err_type;
>>
>> The name rtas_err_type seems a bit confusing for the error injection 
>> class.
>> Would err_injct_class or errinjct_class be clearer?
>>
> Agreed. I'll use errinjct_class.
>>> +    int close_rc;
>>> +    int rc;
>>> +
>>> +    rc = validate_errinjct_args(pe, type, func, addr, mask);
>>> +    if (rc)
>>> +        return rc;
>>> +
>>> +    rtas_err_type = pseries_eeh_type_to_rtas(type);
>>> +    if (rtas_err_type < 0)
>>> +        return -EINVAL;
>>> +
>>> +    open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>>> +    close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
>>> +
>>> +    if (open_token == RTAS_UNKNOWN_SERVICE ||
>>> +        errinjct_token == RTAS_UNKNOWN_SERVICE ||
>>> +        close_token == RTAS_UNKNOWN_SERVICE)
>>> +        return -ENODEV;
>>> +
>>> +    mutex_lock(&errinjct_mutex);
>> Is this lock really necessary?
>>
> As mentioned above, the intention is to serialize complete error
> injection sessions initiated through the EEH backend rather than
> individual RTAS calls.
>
> However, this mutex does not serialize direct userspace RTAS
> callers. I'll verify the firmware session ownership semantics
> before deciding whether to retain it.
>
>> - Sourabh Jain
>>
>>> +
>>> +    do {
>>> +        rc = rtas_call(open_token, 0, 2, &session_token);
>>> +    } while (rtas_busy_delay(rc));
>>> +
>>> +    if (rc) {
>>> +        pr_err("ibm,open-errinjct failed: status=%d\n", rc);
>>> +        rc = rtas_error_rc(rc);
>>> +        goto out_unlock;
>>> +    }
>>> +
>>> +    area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
>>> +    buf = rtas_work_area_raw_buf(area);
>>> +    area_phys = rtas_work_area_phys(area);
>>> +
>>> +    rc = prepare_errinjct_buffer(buf, pe, rtas_err_type, func, 
>>> addr, mask);
>>> +    if (rc)
>>> +        goto out_free_area;
>>> +
>>> +    /*
>>> +     * RTAS work areas are allocated below RTAS_INSTANTIATE_MAX, so
>>> +     * area_phys fits in the 32-bit RTAS argument.
>>> +     */
>>> +    do {
>>> +        rc = rtas_call(errinjct_token, 3, 1, NULL,
>>> +                   rtas_err_type, session_token,
>>> +                   (u32)area_phys);
>>> +    } while (rtas_busy_delay(rc));
>>> +
>>> +    if (rc) {
>>> +        pr_err("ibm,errinjct failed: status=%d\n", rc);
>>> +        rc = rtas_error_rc(rc);
>>> +    }
>>> +
>>> +out_free_area:
>>> +    rtas_work_area_free(area);
>>> +
>>> +    do {
>>> +        close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
>>> +    } while (rtas_busy_delay(close_rc));
>>> +
>>> +    if (close_rc) {
>>> +        pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
>>> +        if (!rc)
>>> +            rc = rtas_error_rc(close_rc);
>>> +    }
>>> +
>>> +out_unlock:
>>> +    mutex_unlock(&errinjct_mutex);
>>> +    return rc;
>>> +}
>>> +
>>>   static struct eeh_ops pseries_eeh_ops = {
>>>       .name            = "pseries",
>>>       .probe            = pseries_eeh_probe,
>
> Thanks,
> Narayana Murty.
>
>>
>


