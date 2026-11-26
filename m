Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF7606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lqATgQuj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZr4W4HcBz2yDc;
	Thu, 26 Nov 2026 19:56:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795683371;
	cv=none; b=D0+37FUmNcTQ/UVn9H3S1aPav9yE3PffRfTfJuHTUHgRUAV75lfuN5/PJUTwnV92M7c11dgNUjTmMvWUuKcZ5LgRWapX8sj3Bv3bfR8KS1CjJtviYIeCKAe94PSYhndw4lH0oadHq0jKptZTh4LdroLhm37sgsTqnBGDmgNrAoHJ9HqRUK6Rmz7u96+sBNHwGrA2BPUGd5qEy/Smx23F2vdj2QMvFK5Nl5AQrhY+MKdQvKXiuj2CotPHZQj6U6P6DF88GO8zs7wNHVI+YkjFFopf2Kcv9nQJdkgMV/qZqyTdmpqsteblXJJFDHUKT4xNw4Ssa+RMSjt/ZDWWZp/HyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795683371; c=relaxed/relaxed;
	bh=10SXRTDgF6c1g5LxWd3C6YX7ddAYyS/0L6rBk3QeLBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EsqdQh/N/PBdZX2XF3p7+3iR1ISZcW/Hy0FkIXoHwAsgdOP9vJxPQ2CBkkAqx2Igeaq2d0J6li3wNssXbUligwAx7pXkq/ez8YEbWz1hFICR11/7q3GcUaiSuWonARLduycxlV7Y4OHhCpfhYq7KTpS6HjoBY+/eejJolb/NrJpAIrLUpC5csladH9PF/yJEm8p7B2+vZaBEuibPnX/MrGqFyJ1raHYpdPIZ2m4vi8MXHKIDyscudr5rHxyWnIHkWxiLcvziGNSaWMpkC+2MPBeNEd53Us0wSoeCIsQnuYN3XDEgAGGO0XtKqnNv4BlYS984eAXWWdFDhkOIGHRt5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lqATgQuj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lqATgQuj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZr4V62ZWz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:56:10 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Z4wk3849722;
	Thu, 26 Nov 2026 08:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=10SXRT
	DgF6c1g5LxWd3C6YX7ddAYyS/0L6rBk3QeLBk=; b=lqATgQujH1jtlZNlfPDd4g
	ReuYgREmqo1Ev/kFSpWCMTQjujcqAt4/4BoMyrwccuAPsbUDZDzXezWiFmIoB7uw
	amzKpxT78JKf3SN9UpkLOZg+of2y0czJMgaoGb6sS4jtn/Hvk0UfupEDOYvxGq9q
	fm2zeti0VY28JWN+j/FlG3da09Zi+WfY1/cgMTOMxjVGKjgVj8si4hjJ35sYWZQx
	0Tgj47fO8hN7TBjAm7QMc6FoHY5xonr5xsS95Ymw0vrc8BocdlOnNbwvj8UkH4rU
	BTECrsKX7UduX+O7oB+X7PXcT+tMbbubV312AEt3jw9CSHIeeBtMxbmcWn0qyAJA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fagjfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:55:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JGNx1263827;
	Thu, 26 Nov 2026 08:55:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx43gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:55:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8tgph44499356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:55:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBEA92004B;
	Thu, 26 Nov 2026 08:55:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D270F20040;
	Thu, 26 Nov 2026 08:55:39 +0000 (GMT)
Received: from [9.123.4.64] (unknown [9.123.4.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:55:39 +0000 (GMT)
Message-ID: <91e72b02-52e3-4f79-92a3-7b5871258cfd@linux.ibm.com>
Date: Thu, 26 Nov 2026 14:25:38 +0530
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
Subject: Re: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks
 with RCU
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexey Kardashevskiy
 <aik@ozlabs.ru>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
 <5wyjwakz.ritesh.list@gmail.com>
 <1b0fa006-67fb-4da0-a670-257ad4c4fefa@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1b0fa006-67fb-4da0-a670-257ad4c4fefa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX4BAo0mPqgl4U
 z5au0Wm6tuWqgDLE2sOgntIM+Rj1NpZxXYvSv2rgFcGVoW2GGQvrNDd7fEZa8bg2RNh0s2hjcms
 /NbWdftkm95Q8PnwtzEQGbD0tJol8i3G21Iwsuf7OQhO29k8CQu7Op3+6lUnC3Aj09QFhECaIth
 blwEKJuF+sxiZvnI+3VUFk5KFturk80V9AWuvdQaRWDbXuy+mfs1JMOCQ04BiUIhmd8XxgMP+lr
 jR6UbMUrrMLar0J4VN83ExvB7WDD46WS/WkIfSpiOzDeblFS0z49YeT65sfD0/h+/TnPxwIwiiK
 HhXhgKwnIP9iDyZHcglAS4e9fqW4eYPGqiiVwY7dHm4/nwzGujGS+BzYeTAHRkDuM/EojNKzQAL
 ke30AnnQrPidHvKyu1fyC/1u/OHGmsJWqeluqtaMEKg0rd12DnUWwflb9ssrJc6HF3hGGXAQcdl
 zKEqk0RXmHVSXErF7Iw==
X-Proofpoint-ORIG-GUID: 94NvaN24nypKlFvs1GgoH9iJOJ9IzQFj
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b07f415 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=suAPYu1tQ8-ruUDPIjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8s3AlvqwBhPcwXU3WQJH1MQGcsXOcy5J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfXyR0sDX0X65K3
 5eFFK1l4ne2Oh/ogDD0SYaBKuHVgm0MghiYVttEymq2fBYIrhRsnuCC4WLl8qGD5PwFFBbIlPcS
 lM2tkb5WgVuc//UyOjUXVvrLa3oYzQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260033
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

On 31/10/26 8:34 AM, Narayana Murty N wrote:
> Hi Ritesh,
> 
> Thanks for the review.
> 
> On 30/10/26 7:32 PM, Ritesh Harjani (IBM) wrote:
>> Hi Narayana,
>>
>> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>>
>>> Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode
>>> handlers") moved the TCE hcalls from real mode to preemptible virtual
>>> mode.
>>>
>>> The stt->iommu_tables list is RCU managed. Entries are added with
>>> list_add_rcu(), removed with list_del_rcu(), and released after an RCU
>>> grace period with call_rcu().
>>>
>>> However, kvmppc_h_put_tce(), kvmppc_h_put_tce_indirect(), and
>>> kvmppc_h_stuff_tce() traverse iommu_tables using
>>> list_for_each_entry_lockless() without an RCU read-side critical
>>> section.
>>>
>>> A concurrent IOMMU table detach can therefore remove an entry while a
>>> TCE hcall is traversing or using it, without the traversal preventing
>>> the entry from being reclaimed.
>>>
>>> Use list_for_each_entry_rcu() under rcu_read_lock() for these walks so
>>> that an entry removed concurrently is not reclaimed until the reader
>>> has completed.
>>>
>>> Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real 
>>> mode handlers")
>>
>> I am not sure if this is the right fix. On doing git blame, I see the
>> following patch introduced this:
>>
>> 121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO") - 
>> Alexey Kardashevskiy
>>
> Regarding the Fixes: tag, thanks for pointing this out. I will re-check 
> the history around 121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration 
> for VFIO") and update the commit message/Fixes tag accordingly, since 
> that appears to be where the lockless iommu_tables traversal was 
> originally introduced rather than cad32d9d42e8.
>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>   arch/powerpc/kvm/book3s_64_vio.c | 18 ++++++++++++++----
>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>>
>> Sashiko pointed out few more bugs around this path:
>>
>> Thank you for your contribution! Sashiko AI review found 2 potential 
>> issue(s) to consider:
>> - [High] kvm: ppc: UAF of spapr_tce_table due to missing rcu_read_lock()
>> - [High] kvmppc_clear_tce: pinned memory leak on partial IOMMU map 
>> failure
>>
>> So, even though these looks to be pre-existing bugs - do you think we
>> can address them in a single patch series itself? This will reduce your
>> testing/validation as well?
>> Also since we are anyway fixing RCU specific bugs in patch-1, so I think
>> we can also fix rcu handling for stt as well?
>>
>> Do you mind working on v2 and addressing Sashiko review comments please?
> Yes, I will address the Sashiko findings in the next version. I will 
> include the stt lifetime/RCU handling along with the existing stt- 
>  >iommu_tables RCU fix, and handle the partial IOMMU map failure/pinned- 
> memory leak as part of the same series.
> 
> I'll rework this as v2 addressing these points.
>>
>> -ritesh
>>
>>
I adressed the review comments in V2 posted
https://lore.kernel.org/all/20261126084351.32375-5-nnmlinux@linux.ibm.com/

Thanks,
Narayana Murty.
> 


