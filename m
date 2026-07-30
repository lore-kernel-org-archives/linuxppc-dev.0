Return-Path: <linuxppc-dev+bounces-25131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF58C5516D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 17:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9xZT0MqJz2yMy;
	Fri, 31 Jul 2026 03:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785433856;
	cv=none; b=ZEXQ1OLHKXetTCcrd7prh954Yn3/obH4KdwR6iYSNWmRaGTBFQR755MoCzXN4h1xVCZJll+CKWDK8uIo7ALP+Yu3oFypNyoAdtd5RqDoksY3O/F5OyGW4RG3aYA6EajteWkhqFoZ6DkKWRERo7y9YkJEYRs7x26uhEW6mA6sqjnJ76nplfD2HnyNDYBk1vfsNUyISx/8dRVF6j+x95juArDjleshNilstl62+5qRUICVh10xwp97d7wGuptEM9XNsmi7SvfbJY5Cp9dbgMVc5L+ZXYy3zUafVUsr7kFNGYxjeJYHDaRjfvT6Y1/gj+n3mN1hV/5pOjqkh8D0IFTJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785433856; c=relaxed/relaxed;
	bh=7em1cBMEMpMhNlbyYNBbEymH9fpZxs+SQjr+U/Wagt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOax9CaHqzD6xeMpXmxLabFpBFeTpjXpqvwWB8RW6VibKgQIeZ7WrVFenZhld7qNNmwhim8ZAidFiF9MrM2w1SW8YrkbZSRmm89KOZqHB81h5ckT5jNRDZTA64GKkM/X4VMkdD840i/2ocFc/Sjlx4+IAhryIyVqvHMikAOZmigwqbXvnzaIHY7WQAoudkQDtZ15tzVJCg4CnoSXM5d6Ht7vKoXnN6vXoKuN10Lz/Gf6NMPhmJaZIwyqt1qKXHsD3qYxvy88CchyP0YRw7gZTIuVs8t7epYWc1b+6cN4x2Hmb8MgT7Yt9Z1kXlIt/iKVCXRmnWb6lXVSfq0MEt9n6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b7Pnc0TJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b7Pnc0TJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9xZS0sWJz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 03:50:55 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGlq7l3612667;
	Thu, 30 Jul 2026 17:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7em1cB
	MEMpMhNlbyYNBbEymH9fpZxs+SQjr+U/Wagt0=; b=b7Pnc0TJ7pkFnoL66NN6aX
	ldejvscqCvgthgF4v6HSy1P7TbGKZSXR3jG0SJYNnI/jjIXygGqi5uvai0qjTfQC
	boQqZeyeqgNpqxcSZWpMBHfPHVjH8YYa0dsjTiv6TMZ7h0Z47ooe2ARHCh99rAdJ
	DnVIYS0ltvaniAj3C7xiY/rk/F1yisSJFQ7foKbvgLgPqwd5tIYiwHj+/VJJqoYl
	qJ0NvWVk5gcqTTjY4FYt83id1114w+y/U6obWCuSl7b/Jr2KFGnyuh6avbQusACd
	+PGbx2jvkEXc5mcgh3hfWlLn1QAitE8v6V8p3Adst3Svf0LfBkuvSztNgPjbfUzw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd87px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 17:50:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UHfMHZ008228;
	Thu, 30 Jul 2026 17:50:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqmkv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 17:50:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UHoQWa32768322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 17:50:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEE7420043;
	Thu, 30 Jul 2026 17:50:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1496F20040;
	Thu, 30 Jul 2026 17:50:22 +0000 (GMT)
Received: from [9.39.25.33] (unknown [9.39.25.33])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 17:50:21 +0000 (GMT)
Message-ID: <e5491106-6724-48f1-a052-a061622d83d5@linux.ibm.com>
Date: Thu, 30 Jul 2026 23:20:21 +0530
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
Subject: Re: [PATCH v3 1/5] powerpc/xive: make xive IPI allocation NULL-safe
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Gou Hao <gouhao@uniontech.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gouhaojake@163.com, kernel@uniontech.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        namcao@linutronix.de, peterz@infradead.org, kees@kernel.org,
        lgs201920130244@gmail.com, srikar@linux.ibm.com, ynorov@nvidia.com,
        nilay@linux.ibm.com, benh@kernel.crashing.org, miltonm@bga.com,
        mkchauras@gmail.com, akpm@linux-foundation.org
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-2-gouhao@uniontech.com>
 <ff80d246-1bc6-4092-861c-9169d0fc599b@linux.ibm.com>
 <5dd79d09-d064-4bbe-9a97-215968252b83@kaod.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <5dd79d09-d064-4bbe-9a97-215968252b83@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6kt2HcM_o7Y5ltvyRWsRUAm_yBADu_wa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzMiBTYWx0ZWRfXzlZ+26S2v5Op
 T0plBlFUhEmS5WidU0RHFAh8HmN3Vk+IFSNYzd+/geaQ14floFr4LvNmMmt+7jWS9MHWZjObXRf
 Q+uXKYV5r7wGmUM+TtXIg6izBeOrMEU=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b8ee8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-7eVWd63tfUETFCwFhAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzMiBTYWx0ZWRfX2xDjqgvt5TQ7
 Zi2aeg5lh2JDwpLLSILuCL6V/dpgD/t2PlxKty2ctDWx9h2n+9+5mUeMTMktabnlrRYT5rQ93fj
 KmnVqzOK3iX74mQDr6I8UBTpLDqqJpwYak2J0Y7JfwqlBA8HgfeJ8fid5zQe57Q7ighdBIefxPm
 W3qOluzy64jIfdUd8HOag60+w7V7L0edn3qFyAjRJMiQ4v2re74iL2stMW50dJTkj4jtXDrd6z6
 MEzKGljmF0C17KvnwxsFGcw5ieLsbHYmV8vdcr/plYbyT8ELXEVwUY9OGxPUUiraKCtxIb0RawB
 Dz+7QC+gBhI29t4uEqnYp8a1Oci8LMwcPFaAZ8khhZSgWWyfJBLN/WqKflPkUKUrgudW3b2UtBs
 gz96Mwdtto+UAETfHZq+1hXFqj+gaGxAAatTK/7PZ9vq3hBBugbFWexq53qslLRpHnsGBRmn8jk
 P/rsQmvVysm27GgzD2A==
X-Proofpoint-GUID: IrYtVb9Tu1syS2wSSd2WOcMbRUszoYjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300132



On 7/30/26 7:36 PM, Cédric Le Goater wrote:
> On 7/30/26 15:53, Shrikanth Hegde wrote:
>>
>>
>> On 7/27/26 4:12 PM, Gou Hao wrote:
>>> __GFP_NOFAIL should not be used in new code [1].  xive_init_ipis()
>>> allocates the xive_ipis array with __GFP_NOFAIL, which makes the
>>> subsequent NULL check unreachable dead code.
>>>
>>> Remove __GFP_NOFAIL so the allocation can fail, and make all xive_ipis
>>> access paths NULL-safe:
>>>
>>> - Return XIVE_BAD_IRQ from xive_ipi_cpu_to_irq() when xive_ipis is NULL.
>>> - Set xive_ipis to NULL after kfree() in the error path to prevent
>>>    use-after-free.
>>> - Guard xive_setup_cpu_ipi() and xive_cleanup_cpu_ipi() against
>>>    xive_ipi_irq == XIVE_BAD_IRQ to avoid dereferencing an uninitialized
>>>    or already-freed xive_ipis array.
>>
>> I would rather prefer a BUG_ON if the allocation fails. That keeps the 
>> earlier
>> semantic.
>>
>> - If xive fails, then who will send the interrupts?. It is better to 
>> crash instead
>> of leaving the system in weird state.
> 
> Then do like XICS, which has BUG_ON().

Yes. Either panic() or BUG_ON(). panic maybe a better option.

I don't like this code bloat which might leave it in inconsistent state.
Either recover properly such that ipi works or just crash the system as 
it is early in the system booting process.

> I don't know why we took this
> direction when XIVE was first introduced.
> 
> C.

Maybe due to NOFAIL, no one expected to ever fail.

