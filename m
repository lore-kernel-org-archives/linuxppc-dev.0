Return-Path: <linuxppc-dev+bounces-22396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279F4CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 09:36:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb0zR5V2Vz2xHK;
	Wed, 10 Jun 2026 19:36:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781084211;
	cv=none; b=NutVQ8yq+i1XSC5ehZ+YQIVbrLqgXFSECR3wK6tqjovUFecNveNf55YvCAdkcaMRfX2tFM4Vkp9IntOQtaqbxnBk5b6DZ7re/DU49tLh/dq3C0MODtMLBKRMfZfFbiyCgJSl9zAwO1/7EvDB0x/UfDqjt8HKViLGMyE811rc46//BnNIGQXe9yX3U1/2Wc27D+Vfpj74ZITU6QlSypis71aIEPjubraKnftC4YuRFL9zoWjJ+KwBJj6rxeRakunTaqUbBUu6jNWgeoF+2RhGPsLuwwXZOgUopcGXI/zH/DsB+7Jj2STZgXQ+Rmf+ugBuxxJPqLm3p3Fnfdqy8LDFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781084211; c=relaxed/relaxed;
	bh=Bag40hx+1NeL9zO6Xwbj4xk8MYmXHavuqatLVEVYQD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uxdznsr5LIj81p5OMvIe+4AE/3fak7f56M+J7ovd4YJgGOBDLaO+nnW4XMEOc3VUbzSbkojSDTUdYEHFmQ7SAbfdb3fN3BAkoN8BukbuM29pplrp0Q926XZBcOdYf12aXNCjTE9HNGIZwN5w4JdbTNUdPXGYB199J03tPAbPZLgkLb0lRr43VOWSAlNGKXOLSYpmG2HdPmhZrSa99KOCZiEFBsFhMKiLgJku3DY+9SUwcOvSTP2tyQ0fQbRpnI09MmESMGQycFAZ4wylUg9mfETP7JYrLJdhfACHyH0VFYSeodcnGNY6cgrw3zC8qzk1nR/+Qx81Wpa2nx8hu26uag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QxX3e/pv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QxX3e/pv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb0zQ6KNKz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 19:36:49 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A4ItXI2567161;
	Wed, 10 Jun 2026 09:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bag40h
	x+1NeL9zO6Xwbj4xk8MYmXHavuqatLVEVYQD4=; b=QxX3e/pvRENsBOlHeZQEsA
	SzAEHGwaz9Q4o+dE3dy0R+HyHMEW1IVo+q05cp9xBH32SqkBgnvENFpIKXUXAaUD
	NDraSyIRSs7hMTI3TrHTQUlRQKXa5enIoJQvjs/3YQKQJ42lO3yhAEjHbuh8vyCr
	ISyRJn+Sfm6WpbYp7bqaFGuj0vupWsbFNbe9coltOfK/0DFkn5jwhfwigwUNEkie
	pMo3kx8liOrDEtTBpaVu7IK2nIcHYMyqAlstjHTTZbdz7CjdmWTWIxAZA/pzKkw+
	sWrkiAHKkP3IIOqdKn1lEmsAfYzSKXdC6Yv9t2jfvW+ozp68KgJ5tJsvBWSHtn7w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb240gfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:36:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A9YikW003723;
	Wed, 10 Jun 2026 09:36:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g5v1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:36:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A9ag3Q15794818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:36:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C6B15805A;
	Wed, 10 Jun 2026 09:36:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A6A958054;
	Wed, 10 Jun 2026 09:36:37 +0000 (GMT)
Received: from [9.39.27.242] (unknown [9.39.27.242])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 09:36:36 +0000 (GMT)
Message-ID: <701d8dce-308f-4c37-a6b2-716db95e24a9@linux.ibm.com>
Date: Wed, 10 Jun 2026 15:06:33 +0530
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
Subject: Re: [kvm-unit-tests RFC PATCH 4/6] powerpc: gitlab CI update
To: Thomas Huth <thuth@redhat.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-5-rathc@linux.ibm.com>
 <e375b2ec-3f60-4403-8b0d-aeb1d6943f65@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <e375b2ec-3f60-4403-8b0d-aeb1d6943f65@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a29302c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=cHRX-pPFaKeZaexz7RQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -1I3YCPEPDOYEjWoHXFIaejC3lJg72vi
X-Proofpoint-GUID: D2SzJx1n-KmNTzOrCQe-MFDRkVgVNJPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA5MCBTYWx0ZWRfX6rVLa/5IHQ6E
 wFNGcKKRMVcxdVLwA2upRuf+x+vLSAAKQiU9+52sWmq0RCjZR2GnrRYrdtD3bMG1S73uIA8FKRq
 cEMi2rhrV3iM2Hebfbe3dZE6Ze1jXNiC9XFlHAxZ2mREsfCP9ZfoZEqWjZUgthtwVgS7LbAYPUZ
 Ydgd7Nauw+N82O+5lKfpwFIhigYVQjcy+zVZGQ3w7Yhw6EtZsVNa1wzWozEQbr3lVEbLhSZc6Qd
 2A5ongMjAJRGfbUaV9BdT3x+EtW0jAz70KmTh3i/cZHbJbT58rdJ6yQ2M7/aI+gXZCB9uJTX0iP
 QYFVqPA6wHhJhZE43hhOJhyZU3Pz6M/st0sJp2CbysDvS1DDlzfm2aukGuLv/mqIDbEHoq96zYy
 gK1Axow3v5HQWAoZ5dm+foWEbd/6HBK+zwNJIzCJ7Nlq2sNLl6HFUXiSna6l26oBDemBTpYV5HI
 RN2WwA9gwKmBoqourxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100090


On 6/8/26 18:18, Thomas Huth wrote:
> On 02/06/2026 08.48, Chinmay Rath wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> Change to using a gitlab-ci test group instead of specifying all
>> tests in .gitlab-ci.yml, and adds a few additional tests (smp, atomics)
>> that are known to work in CI.
>>
>> To control overhead, ppc64be is used to test 64k page size, ppc64le is
>> used to test 4k page size.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   .gitlab-ci.yml        | 53 ++++++++-----------------------------------
>>   powerpc/unittests.cfg | 36 ++++++++++++++++++++++-------
>>   2 files changed, 37 insertions(+), 52 deletions(-)
>
> I don't like the idea of handling this differently for powerpc 
> compared to the other architectures ... so please either also provide 
> (separate) patches for the other architectures, too, or drop this patch.
>
>  Thanks
>   Thomas
Noted. Thanks,
Chinmay

