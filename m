Return-Path: <linuxppc-dev+bounces-24485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDCBC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:18:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3fgT2JMKz2y8F;
	Mon, 20 Jul 2026 22:18:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784549909;
	cv=none; b=KcQWfwuEqlRyf8/+hBSppNVJFLChTRB82Do0EMeBJa8MW9imRc107ccssPtsGo+nis8mXM9b7fbnAfLXcgZ04+FFETcJfqp6FeUs3lnrf7waipnrbJOIYEwJ7O9gE+LLN1ZyAOnEsNsHBdNXjkopLQRi+az6FKB0DYwAbQcPe161cvLdrPbJ04qFiF4ntu7F615/NaOYf6/8gzVL05lbPIs5hMj2raQIa/m0uFLf0zsI4L0iyqJkAoal4bpIMtGcTH/a3sN7STyxAu1Qpx8xFaeUmE1YTm4Rh+MRDz4ks1jbCuJYhPpLoyClJIXAPb9LiTOHqwBvazcAahc5tsSabw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784549909; c=relaxed/relaxed;
	bh=bnL35Jg6vrtNts/Bi4vUTFv0Basw/EpWEeq/l6PHoUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDUMMQ/LU6auM9X07ufsIRxt15Q9h232UZ7eiuVAZ6uqU9YYO4sv2Pl0v9NOp8egXLhsl++htaxziZLIZS68pKIbM79qp5p8xWfJcfz95qt3PamuxLenvZ7hBQ39HsihAdgpTjjOq+vD+xp4K9nT0bZt0QBL6rC7NZZ6M9ta9uEmxlASSP8jWwJ565SMftDy5Hp5prkJgSE1xC1dLAD0nN/Ly0z3K7VW2KY7klrbxRnna+MjVI8lxRHRexbzwafVBGkbvDnLVqZOaNSOtZjumgggkYlXwZIkuaCZ1O7NM/0XA/iHlduGkTIN/NnSvTMptaBevifwv8tNJXuht6O0XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kwZVjaFg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kwZVjaFg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3fgS012Hz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 22:18:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KBBqKW1935799;
	Mon, 20 Jul 2026 12:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bnL35J
	g6vrtNts/Bi4vUTFv0Basw/EpWEeq/l6PHoUg=; b=kwZVjaFgjAu0bndTpFAurm
	I4lGI/LqR+Fn+3k6jH4Jd9Pr9MxIP92FN+weCN7liC774UM3yAOsIEsQBV5QCcc3
	qCgRPMw7ry0qYVa5b8hbgaNkhbxthjZwj9OOQnVus+SaXTfMGJthrV7/fsR98det
	u90iZ1znFfx8O5QY3cw0pfygIklHnRMPpJP739psv7OE+ayvyf7XYmbeQ05JVrTy
	dL4LpNgYoHf31YIly5mXkAd8+UEjNejjH6dvNfFSF02XFWADcVO3rXLyeLUKUDRv
	sLQ8QBdZC1vicBLudcU3gz2z3lL10CFENDuc9Lg664Jej90C2lxJXNqAJfXnDIdA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fy3c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 12:18:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KC4fdV023514;
	Mon, 20 Jul 2026 12:18:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagwfb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 12:18:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KCHmd125494020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 12:17:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C115805E;
	Mon, 20 Jul 2026 12:18:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532BC58051;
	Mon, 20 Jul 2026 12:18:22 +0000 (GMT)
Received: from [9.39.17.136] (unknown [9.39.17.136])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 12:18:21 +0000 (GMT)
Message-ID: <5901c7f4-9e5a-431d-9d6c-2818afe313ce@linux.ibm.com>
Date: Mon, 20 Jul 2026 17:47:34 +0530
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
Subject: Re: [kvm-unit-tests PATCH v2 0/6] powerpc improvements
To: Thomas Huth <thuth@redhat.com>
Cc: harshpb@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
 <c53b1c7e-ee9b-4c45-95c6-6648f696cf11@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <c53b1c7e-ee9b-4c45-95c6-6648f696cf11@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzNiBTYWx0ZWRfX1ETWCond636j
 intH+a1iBs0xm/z+hNsC9K6Xxp/RH6tk7G7jNM4Z0Bgsdtboih45dnSKTvShFDaH6rDOlwGIGC2
 Nb0cAAy4X/loScbhOrmSHrtQ8uSn1Be1pR1N7WzRlQILY9+qLwyPbFLh+YNdymAoipuZI/OOmCK
 v1f+SOHERYCDq5XkhtIfQTjFxrsQTPMwk78jlgmUwmBp/EJzVCZFrUSQLU8ofaNBus6JHJpo++B
 FVMbhmQ08v2MQu+0z34Tto+hWBQr7eZRDu/Dnu8/aT7rMzg3d+MpzuEfkWoY37DIHL+iZuDPO7X
 dWXlBZXTOC9urHk0uzJtlvpKqSsMsJx7DqaOd4CtetGuEWhquiAEUfqD2M56mPU0KTSRuzf90X/
 8GE8IKAKMuB3Aeo7QnmjP1cXpZwTERcdxSOEW8xTtGTPOn+gGpL0RjVRnvntsWt6sTSAo3Ap2Ko
 zN4M2T7gKymN1ZC6PdA==
X-Proofpoint-GUID: b-CyH9Fynl5inhin1EA_OpMjYxCibEyi
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e1211 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=D1-8KnQKaU7tPh1uK-QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzNiBTYWx0ZWRfX/Z7Gsu9LT25U
 rhjwJJCNmbU7S2sFCpB3Z4oa4dEj5usuPtqN94Kv/8cbIRTMa+MT6xdB7h65zmcDIJjWfetTfJ9
 mNf+I4bFcd8iTPhc7gunQ9J/xHyTS3c=
X-Proofpoint-ORIG-GUID: b-CyH9Fynl5inhin1EA_OpMjYxCibEyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200136


On 7/20/26 15:00, Thomas Huth wrote:
> On 19/07/2026 15.00, Chinmay Rath wrote:
>> This series aims to add a couple of new powerpc tests and improve the
>> powerpc build structure.
>>
>> This is originally Nick's work. The last version (v10) of which can 
>> be seen here :
>> https://lore.kernel.org/linuxppc-dev/20240612052322.218726-1-npiggin@gmail.com/ 
>>
>> Couple of patches from the series are already merged.
>>
>> Since it has been 2 years since this series was posted, I originally
>> posted this as a RFC. This v1 series has changes accomodating the 
>> review comments
>> received in the RFC :
>> https://lore.kernel.org/kvm/20260602064806.3101025-1-rathc@linux.ibm.com/ 
>>
>> v1:
>> https://lore.kernel.org/kvm/20260708105122.1177210-1-rathc@linux.ibm.com/ 
>>
>>
>> I have rebased the patches to the upstream state.
>> For the patches which did not require any changes in the existing 
>> upstream code,
>> I have retained the "Reviewed-by"s and "Acked-by" (patch 3,5 & 6) from
>> Nick's series. I have also added Andrew's "Reviewed-by" received on
>> patch 2 in the RFC. Nick had originally introduced powernv tests as 
>> well.
>> Removed it for now since it was causing CI failure in the current 
>> upstream.
>>
>> Link to Gitlab tree with patches :
>> https://gitlab.com/rathc/kvm-unit-tests/-/tree/ppc64
>> Link to Gitlab pipeline :
>> https://gitlab.com/rathc/kvm-unit-tests/-/pipelines/2688519679
>>
>> Change log from RFC to v1:
>> 1. Patch 2: Added Andrew's "Reviewed-by".
>> 2. Patch 4: Removed usage of gitlab-ci group to run test - Thomas
>>     It would be nice to make use of the gitlab-ci group, but doing the
>>     change of all archs would make sense in a separate series. I look
>>     forward to doing that.
>> 3. Patch 6: Removed addition of panic test in gitlab-ci group - Thomas
>>
>> There was a discussion on the build failing in Travis CI with Clang, 
>> in the
>> RFC, which I have addressed there.
>>
>> Change log from v1 to v2:
>> Patch 4: Addressed all comments by Thomas :
>> 1. Removed extra blank line.
>> 2. Removed accel=kvm test from gitlab-ci.
>> 3. smp = 2 preserved in atmoics test.
> Thanks, looks fine now, so I pushed it to the repository.
>
>  Thomas
Thank you Thomas !

