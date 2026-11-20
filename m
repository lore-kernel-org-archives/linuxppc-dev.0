Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC01606A33C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jfZeollE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW6DG635Bz2yDm;
	Fri, 20 Nov 2026 18:19:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795159198;
	cv=none; b=h1tMgK9o7IpJLCsgh4oYxQet34myZrMeK/lf16Vi8V3UlKGFZtrfkYp8CdrXpy5DHJXm/6sfKA8KFHmg2FFTqI2/fi6eE+dCI8HrqzJ8VLeeleCz+I+Fumx8f9PgpZ3FCWL7kg5bXkcUeCcfg1MSIn9wYY277Ot1xBdA2V/TKFxDbpSnfEUlnCSrfzIRT75J3wAllpDVTShy8WjS9BJmqDI9jfJyWALsAJX5bwwzIs+X0Q8zLAidYqGgybMPyYjoV2yVGXzSoctM0KzeupmiDeaBGMCPEbcQAdePEwatO2g6WO5k3ZmdeE3i5mRnK1pJGPmfEZFZerTw+029xByx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795159198; c=relaxed/relaxed;
	bh=1vKQPpdu/ypRpROkCywYng/vV1+x0TjDmBtFpI4IKrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZiwuNuEfpyRnAo7SP51N/4k11i9VJqObout89naVy79IhU6oJd5bKqDO0kj6iZmdUhsVMBlmBwdgHkjZRR7Ef/7IVXyijvq/nv45s8zPQeBQjInG6k9tEtBxOwklCkHAOHNsnTt5JfbAGKigSE3mr7ch6TXId1EFsB9TaZm4boILQ/9/RKIQ2ETCPw99B2Tfm+JPYnc/SE9AmxSHyR2WqJXDg2l9N3YXdJ2P2KwLyW22NJHzyb+nBWBwbB9sQVty6VRLc3yt9FKdeYlkgPx/ZnWpMYxX8CjVPzkhKYQdG2wji12ei5ispYXYNTBBsD2hrpGTeVwTVaIy+FMCm5IRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jfZeollE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jfZeollE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW6DF40X3z2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 18:19:57 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uNia1981948;
	Fri, 20 Nov 2026 07:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1vKQPp
	du/ypRpROkCywYng/vV1+x0TjDmBtFpI4IKrM=; b=jfZeollE1IbBJTKB6xGgts
	DErkLPKKgfaMeNVUO70LyV3OQ8NiNDTpm9BFvu/p6ogGcr9su5l/I3w0BUzdd7Tn
	bB7fcAbkvyEqy+z96Q92Kg4ccFHhCbPLUpjcofq8Rwl1GdU3rfzAXD6MBrfYQIau
	39oN7dn9J4RjI7oxv1Zz9M+aXMjELZghBxxvPZtiqqApDwWDmiBmNyWzbILLUWCa
	d71OtO03IKHtVSKsRsvHnMj4sISC/7UsQHAwfzwKcmuP1oB/c0lVxkqmYmkYhJr1
	6jMG4ruxtjRoa7uiTZbcSdXJg+95O0J7Ui6cnAdNO/gNGH7IeTlQzP/Z4zRy0f5Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105tevmn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:19:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK782eS3627471;
	Fri, 20 Nov 2026 07:19:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xep9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:19:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7JXCD43057554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:19:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59D052004B;
	Fri, 20 Nov 2026 07:19:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E441320043;
	Fri, 20 Nov 2026 07:19:29 +0000 (GMT)
Received: from [9.124.218.70] (unknown [9.124.218.70])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:19:29 +0000 (GMT)
Message-ID: <a149f6b8-2aba-4e99-a64a-ef9ec7f0d449@linux.ibm.com>
Date: Fri, 20 Nov 2026 12:49:28 +0530
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
Subject: Re: [PATCH v6 2/5] powerpc/pseries/eeh: Add RTAS error injection
 helpers
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
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
 <20261023073642.59657-3-nnmlinux@linux.ibm.com>
 <864398a6-8a74-43df-9594-452a9edd99e9@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <864398a6-8a74-43df-9594-452a9edd99e9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afff48b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=ixBu7NUsdrZfyz3qS-wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eeMZ-iM_2ZyyVSI9tGB8Wh31tcUIcEjA
X-Proofpoint-GUID: wdZVyLO5ALUo9HSDPak7na1Q-GCYRdz2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyNyBTYWx0ZWRfX+lJsDuIxBMvU
 3NIIeedaAemZy+On3mhg6y+IXpS0Dev3hmNFqBEEa/xhvXtNO37cdyGHJdmD0u3YfdrF4mM7eZe
 fudYx0TYhqAV1u1bQid93+Bgpc+3vRbMvUP8+OOLspE0bu7jXldK6Vsg0b0uB7Q083eOWTlxX57
 yjm/FjFh/tVC5zavGj/XXJ9MnI3BOdam0gpLaUOfrsbH41pSg2GcRX+fXonB26fY6qdxjmpHaPK
 Dhp9uxJyu5Pdes+ro/1S6lkJHvg2pJgcKSZGce2gOgwDIMszb2wwiG44UZDps9YbvVv/437Gd/8
 LwxoDVLmqeo8z9zuriz/6+aZ/hp18vZSpOyyrTdFJzZHWK3+6mklLB9yqlgYTj9raSyjE6zZDgo
 AFbZkqMDJI+rsR9c4zFqFXAd+ZbBTTqMoeOIOvBSUIRXj8LHxbiCVHMk9T11yx6ddau5qi+hg5M
 h063OrMT229yyRPAEBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyNyBTYWx0ZWRfX3c53QemF85v8
 y+gn/1nybU7TMtyL9GllozKKScNWNoWqunTcShgIPzHOk0pKwmJXtj7YXXzxLIMn4+94IOLB+Fk
 15WFbfrYr8sDiOXfPSNP48AmxVIjp40=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200027
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sourabh,

On 18/11/26 10:13 PM, Sourabh Jain wrote:
> Hello Narayana,
> 
> The commit message contains several implementation details that make it 
> difficult to
> understand the actual purpose of this patch. Could you simplify and 
> restructure it to
> focus on the functionality being introduced and why it is needed?
> 
Sure. I'll merge this patch with 3/5 and rework the commit message.
This will also address the unused static functions reported by Sashiko.
> On 23/10/26 13:06, Narayana Murty N wrote:
>> Prepare the pSeries EEH backend for RTAS error injection by adding
>> helpers that:
>>
>>    * map generic EEH error types to RTAS/PAPR error types;
>>    * validate IOA addresses against the target PE.
>>
>> Define pr_fmt unconditionally at the top of eeh_pseries.c so all
>> pr_*() calls carry the "EEH: " prefix.
> 
> I don't think there's a need to mention pr_fmt here, as it's not a key
> objective of the patch. This could simply be a note at the end.
> 
Agreed. I'll drop this from the commit message.
>> Define RTAS firmware error-type encodings as file-local constants.
>> Only the two IOA bus-error types are supported; other PAPR encodings
>> are not reachable through the generic EEH_ERR_TYPE_* UAPI:
>>
>>    RTAS_ERR_TYPE_IOA_BUS_ERROR     0x07
>>    RTAS_ERR_TYPE_IOA_BUS_ERROR_64  0x0f
>>
>> Add RTAS_ERRINJCT_BUF_SIZE for the ibm,errinjct work buffer size.
> 
> I'm not sure RTAS_ERRINJCT_BUF_SIZE needs to be included in this patch,
> as it seems unrelated and isn't used by any of the APIs introduced here.
> Would it make more sense to move this to the patch where it is actually 
> used?
> 
Yes, this will be addressed by merging the two patches.
>> Add pseries_eeh_type_to_rtas() to translate the two generic EEH error
>> types (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64) into the corresponding RTAS
>> ibm,errinjct encodings.
>>
>> Add validate_addr_mask_in_pe() to verify that a caller-provided address
>> falls within a BAR of some device in the PE.  RTAS IOA bus-error
>> injection requires a PCI/IOA bus address; validate_addr_mask_in_pe()
>> accepts only PCI bus addresses.  VFIO userspace resource addresses are
>> normalized to PCI bus addresses in vfio_iommu_spapr_tce.c before
>> reaching this backend; no resource-address fallback is added here.
>>
>> Use pcibios_resource_to_bus() to convert each BAR resource to PCI bus
>> address space before validating the address.  Only standard BARs
>> (BAR0..BAR5) are searched; ROM and bridge resources are not IOA
>> bus-error targets.  Hold pci_rescan_remove_lock while traversing PE
>> devices and their BAR resources so PCI device removal cannot race the
>> address validation.
>>
>> Skip unassigned or disabled BARs explicitly: on pseries,
>> pcibios_fixup_resources() zero-bases unassigned BARs (start=0,
>> end=size-1) and sets IORESOURCE_UNSET, so resource_size() is non-zero
>> for them and pcibios_resource_to_bus() treats them as bus address zero.
>> Use pci_resource_len() (which returns 0 when end==0) instead of
>> resource_size(), and reject BARs with IORESOURCE_UNSET or
>> IORESOURCE_DISABLED set.
>>
>> Returns -EINVAL (Linux errno) rather than a raw RTAS status.
> 
> This is another example where I'm having difficulty understanding
> how the above statement relates to the new APIs introduced by this patch.
>
Agreed. This detail is unnecessary here. >> validate_errinjct_args() and 
prepare_errinjct_buffer() are introduced
>> in the next patch alongside their callers so each intermediate commit
>> builds cleanly with CONFIG_WERROR.
>>
>> pseries_eeh_err_inject() retains the existing MMIO injection body
>> unchanged in this patch.
> 
> 
> Okay, but could you clarify how these are related to the APIs introduced 
> in this patch?
> 
>> It is replaced by the full RTAS session
>> implementation in the next patch.  This keeps the patch bisectable:
>> each commit builds and functions correctly independently.
> 
> Could you help me understand the need to mention git bisect-ability here?
> 
> I'm also not sure why the above two paragraphs are needed. Why do we need
> to document the nuances of other APIs in this patch when they are introduce
> or modified in subsequent patches?
> 
The intention was to introduce the helpers without breaking
intermediate builds. However, the current split still leaves unused
static functions. I'll merge the patches and drop these explanations.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx- 
>> lkp@intel.com/
> 
> 
> Aren't these tags intended for cases where the issue is fixed in a 
> separate patch/commit,
> rather than in a revised version of the same patch? Do we really these 
> tags?
> 
Agreed. I'll drop these tags and retain the details in the changelog.
> 
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 134 +++++++++++++++++++
>>   1 file changed, 134 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>> powerpc/platforms/pseries/eeh_pseries.c
>> index b12ef382fec7..28b1fd19e8bc 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -12,6 +12,8 @@
>>    * Copyright Linas Vepstas 2005, 2006
>>    */
>> +#define pr_fmt(fmt) "EEH: " fmt
>> +
>>   #include <linux/atomic.h>
>>   #include <linux/delay.h>
>>   #include <linux/export.h>
>> @@ -23,6 +25,7 @@
>>   #include <linux/rbtree.h>
>>   #include <linux/sched.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/sizes.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/crash_dump.h>
>> @@ -786,6 +789,137 @@ static int pseries_notify_resume(struct eeh_dev 
>> *edev)
>>   }
>>   #endif
>> +/*
>> + * RTAS firmware error-type encodings (PAPR).  These are pseries- 
>> private;
>> + * user-space sees only the generic EEH_ERR_TYPE_* values from eeh.h.
>> + * Only IOA bus-error types are supported; other PAPR encodings are not
>> + * reachable through the generic EEH_ERR_TYPE_* UAPI.
>> + */
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR        0x07
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64        0x0f
>> +
>> +/* Size of the ibm,errinjct work buffer as defined by PAPR */
>> +#define RTAS_ERRINJCT_BUF_SIZE            SZ_1K
> 
> Wouldn't it be better to move this to the first patch where it is used?
> 
Yes. Addressed by merging 2/5 and 3/5.
>> +
>> +/**
>> + * pseries_eeh_type_to_rtas - Map generic EEH error type to RTAS 
>> encoding
>> + * @type: generic EEH error type (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64)
>> + *
>> + * Translates the generic VFIO/EEH error type passed from userspace into
>> + * the RTAS-specific ibm,errinjct error type encoding defined by PAPR.
>> + *
>> + * Return: RTAS error type on success, -EINVAL for unknown types.
>> + */
>> +static int pseries_eeh_type_to_rtas(int type)
>> +{
>> +    switch (type) {
>> +    case EEH_ERR_TYPE_32:
>> +        return RTAS_ERR_TYPE_IOA_BUS_ERROR;
>> +    case EEH_ERR_TYPE_64:
>> +        return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +/**
>> + * validate_addr_mask_in_pe - Validate addr against PCI bus BAR 
>> addresses in PE
>> + * @pe:   EEH PE containing one or more PCI devices
>> + * @addr: PCI bus address to validate
>> + * @mask: address mask (passed to firmware unchanged)
> 
> Is the mask really necessary?
> 
No. It is only used to identify the no-address injection case
where both addr and mask are zero. I'll move that check to
the caller and remove the mask argument from this helper.
> 
>> + *
>> + * RTAS IOA bus-error injection uses PCI bus addresses.  Linux PCI 
>> resources
>> + * are CPU/resource addresses and may differ on pseries due to PHB 
>> window
>> + * translation.  Convert each BAR resource to PCI bus address space 
>> before
>> + * validating @addr.
> 
> The same comment is also present inside the function. Could we drop one to
> avoid duplication? I think keeping it inside the function would be better.
> 
> 
Sure.
>> + *
>> + * Zero addr and mask are accepted without BAR lookup (no-address 
>> injection).
>> + *
>> + * Return: 0 if valid, -EINVAL on invalid input.
> 
> I think, -EINVAL otherwise. would be more accurate.
> 
Agreed.
>> + */
>> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long 
>> addr,
>> +                    unsigned long mask)
>> +{
>> +    struct pci_bus_region region;
>> +    struct eeh_dev *edev, *tmp;
>> +    struct pci_dev *pdev;
>> +    struct resource *res;
>> +    resource_size_t bus_start;
>> +    resource_size_t bus_len;
>> +    bool found = false;
>> +    int bar;
>> +
>> +    if (!addr && !mask)
>> +        return 0;
>> +
>> +    if (!pe)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * RTAS IOA bus-error injection uses PCI bus addresses. Linux PCI
>> +     * resources are CPU/resource addresses and may differ on pseries 
>> due
>> +     * to PHB window translation. Convert each BAR resource to PCI bus
>> +     * address space before validating @addr.
>> +     *
>> +     * Hold pci_rescan_remove_lock across the traversal to protect pdev
>> +     * lifetime: pci_stop_and_remove_bus_device() requires this lock.
> 
> Wouldn't it be more meaningful to explain why this lock is needed here
> rather than listing other APIs that use it?
> 
Agreed. The lock is intended to protect the traversal against
concurrent PCI device removal. I'll simplify the comment.
>> +     */
>> +    pci_lock_rescan_remove();
>> +    eeh_pe_for_each_dev(pe, edev, tmp) {
>> +        pdev = eeh_dev_to_pci_dev(edev);
>> +        if (!pdev)
>> +            continue;
>> +
>> +        /*
>> +         * Validate against standard BARs (BAR0..BAR5) only.
>> +         * ROM and bridge resources are not IOA bus-error targets.
>> +         */
>> +        for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>> +            res = &pdev->resource[bar];
>> +
>> +            /*
>> +             * Skip unassigned or disabled BARs.  On pseries,
>> +             * pcibios_fixup_resources() zero-bases unassigned BARs
>> +             * (start=0, end=size-1) and sets IORESOURCE_UNSET.
>> +             * resource_size() is non-zero for such BARs, and
>> +             * pcibios_resource_to_bus() treats them as bus address
>> +             * zero, so they must be excluded explicitly.
>> +             * Use pci_resource_len() which returns 0 when end==0.
>> +             */
>> +            if (!pci_resource_len(pdev, bar))
>> +                continue;
>> +
>> +            if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>> +                continue;
>> +
>> +            if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
>> +                continue;
> 
> Nit: Would it be better to check the above conditions before calling 
> pci_resource_len()?
> 
Sure. I'll check the resource flags first.
>> +
>> +            pcibios_resource_to_bus(pdev->bus, &region, res);
>> +
>> +            bus_start = region.start;
>> +            bus_len = pci_resource_len(pdev, bar);
> 
> How the bus_len returned by pci_resource_len(...) is different from?
> bus_len = region.end - region.start + 1;
> 
There is no difference for a valid BAR, as the translation
preserves the resource size. I'll avoid the redundant calculation.
>> +
>> +            if ((resource_size_t)addr >= bus_start &&
>> +                ((resource_size_t)addr - bus_start) < bus_len) {
>> +                pr_debug("addr=0x%lx mask=0x%lx validated in PCI bus 
>> BAR[%d] of %s: bus range 0x%llx-0x%llx\n",
>> +                     addr, mask, bar, pci_name(pdev),
>> +                     (unsigned long long)region.start,
>> +                     (unsigned long long)region.end);
>> +                found = true;
>> +                goto done;
>> +            }
>> +        }
>> +    }
>> +done:
>> +    pci_unlock_rescan_remove();
>> +
>> +    if (!found)
>> +        pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of 
>> any device in PE\n",
>> +               addr, mask);
>> +    return found ? 0 : -EINVAL;
> 
> This check is repeated twice here. I think we can improve this. How about
> restructuring the function as follows:
> 
> 
> static bool addr_in_pdev_bars(pdev, addr)
> {
>      for (bar = 0; bar < 6; bar++) {
>          len = pci_resource_len(pdev, bar);
>          if (!len || !is_mem_or_io(res) || is_unset_or_disabled(res))
>              continue;
> 
>          pcibios_resource_to_bus(pdev->bus, &region, res);
>          if (addr >= region.start && addr - region.start < len)
>              return true;
>      }
>      return false;
> }
> 
> static int validate_addr_mask_in_pe(pe, addr, mask)
> {
>      if (!addr && !mask)
>          return 0;
>      if (!pe)
>          return -EINVAL;
> 
>      pci_lock_rescan_remove();
>      for_each_dev(pe, pdev) {
>          if (pdev && addr_in_pdev_bars(pdev, addr)) {
>              pci_unlock_rescan_remove();
>              return 0;
>          }
>      }
>      pci_unlock_rescan_remove();
> 
>      pr_err("addr not in any BAR of PE\n");
>      return -EINVAL;
> }
> 
> 
> Splitting out the BAR check gets rid of the goto and the found flag.
> The lock and unlock now sit around one simple loop.
> 
Agreed. I'll split the per-device BAR lookup from the PE
traversal as suggested, with the no-address check moved to
the caller.
> - Sourabh Jain
> 
>> +}
>> +
>>   /**
>>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>    * @pe: the indicated PE
Thnks,
Narayana Murty.
> 


