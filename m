Return-Path: <linuxppc-dev+bounces-23918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD5C44507
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 08:49:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpYW1Sk2z3c6n;
	Thu, 09 Jul 2026 18:49:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783586975;
	cv=none; b=PTtQ87fIqjAfEtwMPojYdkxDTQXbBvLKudhh6UwnUE6mDH+97Gru06ijbzEjhqPCQVc8Lw93eFtCwrDsYMLGNa2abRqeYzxUUIUX2FQA8tFRmunsuA7MiWO5kiFPcFCQSeF5lOlib4qbjGuK8yXvKITu5UZsRDQsCYFen85EkFviZGJhCL3NQ9Ste6SLbDcCFHpoY6pKLubQcPpPCRKeInAsRm685Dc+TT53l6UJ7EUCFWbMy6TOfcXymEYcedTVhDv7SAmRYmIRH3+qaL9jcorOic3c6+qG7VfSwRvgXgrLD0ficExq6ERhNgy2iQcvKVeJWhQj/OGR4FIRHKXbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783586975; c=relaxed/relaxed;
	bh=QxqMyyELcoPLCOnceqkZYKaZhHxorYENz84bJREuy1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z92BuGn1u6J/fr9JJDo+KhipRvcLsDvE/CbTwme1U4WfQgRXFSZHlQBgtveTOlqC8akAQwVUAgse4L3VaWymJlmnkz4+WFMh9FGy5dFDoKS8zOS+s7Yop2R0GITCZR61pQSg0Si7Zb/dU60Kg32qlB5csP1E3Hv2+zP/grasGJL5jA+0mAaT/U9pwtFq3+UyElcw4Z8fwfz1K+LSwusNh0NAPtSwAlNeS7SJGXsWGu5kg2MWCca/zzDu+Ai1CBE0bzhKXjA0jNq99+iC1p9fsCDnejxoMIOX4jK9ZPtY5dMY86rcl+3A+g1MlebEYHMysi4oPXau9pIuKDN8SWvzFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vy9lXI3a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vy9lXI3a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwpYT1VTsz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 18:49:32 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696ILeb479979;
	Thu, 9 Jul 2026 08:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QxqMyy
	ELcoPLCOnceqkZYKaZhHxorYENz84bJREuy1w=; b=Vy9lXI3a0bXIZ8ZFD/JvBZ
	ptmpzRBWHRR2FQNrwfxKirzgRTpJu0GmWyd+o3sQ3zG+8qCtvU8LQpEybmEJ3pkI
	M5apXkPK7ueqQmgTjhTZqzzbtqhcgWzm/KtIHV0D4ZdhtFT5xFDxRaHyxFNGQNtU
	vB/nkd4fDUyUwbYSgQcHclOw9Fe57gpAHTTNuMgLZ9kCzIziCzV/xE49HfblNGlz
	BENc0jAEftLxzsTiyebTrKPSf8PT8kqScFLEa6+uVrBAMd5S8XlFPSlr44ym9Hqm
	JHbdU7HZJ9jztv9XfoUODmqwyLPp5rStlbfcIzY12rm/4GIB2i3859OjLVyOl3RA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt14q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 08:49:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6698Ya92019285;
	Thu, 9 Jul 2026 08:49:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgc4dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 08:49:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6698nLlw23265616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 08:49:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A9942004D;
	Thu,  9 Jul 2026 08:49:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D166F20040;
	Thu,  9 Jul 2026 08:49:18 +0000 (GMT)
Received: from [9.123.1.138] (unknown [9.123.1.138])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 08:49:18 +0000 (GMT)
Message-ID: <afb9bf4d-2258-4731-a28e-7f4eaa01ee0b@linux.ibm.com>
Date: Thu, 9 Jul 2026 14:19:17 +0530
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
Subject: Re: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
To: David Matlack <dmatlack@google.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <akwyZvbv7Fg8mfB2@google.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <akwyZvbv7Fg8mfB2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TdtOjoZw52V3LxMSYgVcH93H6d3ymUJn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4MyBTYWx0ZWRfXz90cxHTG4Fh4
 ALJzMSZ1q0NLfynz6xGHzahjAE/1BAStWp218zZkP83poQTKKCloLMbSVw3qbeL0FT1iLZies2B
 XD38K5wsatF4GXPtasqopDd9JNDnUdo=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f6096 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Hgq_jSvlLlN-46ChCOsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q3D5RgkkFA9AsxJAip9BZAGKVNTkHHno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4MyBTYWx0ZWRfX6CogzajSCG+e
 NzmgFKBdXTGwER/S6FI715b6sFDR1UYcKqHIOHWiZRr/w/Ma5jthghSOcn5C6+HAWmrUUH36sAm
 ocnHcYIRjn0tr2JX0AC4j6EyPNDJe4qbL2nI9C9qzB7EwrpYST/mZHIcgNLrVftFEz+J/mvxFSM
 S2AjOgezH0i4ZgZBDVZAB5xjUUbc/engbRmHChcyFxeK6WNXleCj2mPk+p7EFggTlA7FQCKv3EB
 9PIMY9ykdQJ8sX+zsWdFhe1QMaaKbhdXC54SRVqMI6EySq8iNIDMH2klqhD0BLGFPJR0kZG2Wwd
 V/Efnvn30J2Mf7HZmQpZplVG4/m3qYw8hk2rj1qT2wfTcrodW+ydfbncpe1EXcv4KFQnhj2psAi
 EzjwOhFXoY482drfsdDFvI0vNAWkTLO7HhQZlvPJF1Xsc5/0YbAFAipzRC3C4EhPoSHSExgXXaG
 Zd+GIJszdGmuIESDpZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090083


Hi David,
Thank you for your detailed review comments on this series.

On 07/07/26 4:25 AM, David Matlack wrote:
> On 2026-07-02 11:28 PM, Narayana Murty N wrote:
>> This RFC adds PowerPC sPAPR TCE v2 support to VFIO selftests.
> nit: Please use "vfio: selftests: ..." for commit shortlogs.
Agree, will fix all commit shortlogs in v2.
>
>> The series adds a selftest IOMMU mode for the legacy VFIO container
>> backend, adds helpers for default and dynamic DMA windows, and exercises
>> the sPAPR DDW path through the DMA mapping tests.
> Thanks for sending. Is there anyway I could run these tests on PowerPC,
> e.g. with QEMU, to try things out? I don't have access to any hardware.
I had tested this patch series on real power h/w (pseries and powernv).
However I am not sure if the required firmware support is implemented in 
QEMU.
I will check and get back on this.
>> sPAPR TCE v2 remains a legacy VFIO container backend. This series does
>> not add iommufd or VFIO cdev support for sPAPR.
>>
>> The main points are
>> 1. add VFIO_SELFTESTS_IOMMU_MODE for selecting a backend
>> 2. add vfio_spapr_tce_v2_iommu as the PowerPC VFIO backend
>> 3. preserve the platform default DMA window
>> 4. create and tear down only selftest-created DDWs
>> 5. prepare the DMA window before IOVA allocation
>> 6. exercise DDW creation for hugepage DMA mappings
>> 7. accept sPAPR-specific errno for invalid DMA ranges
>>
>> Example:
>>
>> VFIO_SELFTESTS_IOMMU_MODE=vfio_spapr_tce_v2_iommu
>> ./vfio_dma_mapping_test <BDF>
>>
>> Observed coverage includes anonymous mappings through the default window
>> and 2MB hugetlb mappings through a DDW. 1GB hugetlb mappings may skip when
>> the platform rejects the requested DDW characteristics.
>>
>> Feedback is requested from the VFIO and PowerPC communities on:
>> 1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
>> selftest library or move into a sPAPR-specific test helper?
> Responded in the patch. Let's move to their own file.
Will do. v2 will have:

   lib/iommu_spapr.c         — all sPAPR logic, compiled only on powerpc
   lib/iommu_spapr_stub.c    — empty stubs returning -EOPNOTSUPP,
                               compiled on all other architectures
   lib/include/libvfio/iommu_spapr.h — declarations

iommu.c will call the sPAPR helpers unconditionally with no #ifdefs in
function bodies.
>> 2. whether DDW setup through hugepage mappings is the right initial
>> coverage?
> One thing I'm not sure is how much value you get out of exercising the
> DDW stuff through that test specifically. Would it make more sense to
> have a DDW-specific test so you can test all the edge cases you care
> about directly instead? Then vfio_dma_mapping_test can stay generic.
Agreed. For v2 I plan to introduce a dedicated vfio_spapr_ddw_test that
covers DDW creation, window selection, page-size negotiation, and
removal directly, and keep vfio_dma_mapping_test generic. The hugepage
variants in vfio_dma_mapping_test will then just exercise the mapping
path itself without being the primary DDW coverage vehicle.
>
> BTW, is that the only test that passes right now? What is the status of
> the other VFIO selftests on PowerPC after this series?
   vfio_dma_mapping_test    — anonymous and 2 MB hugetlb variants PASS;
   vfio_dma_mapping_mmio_test  — PASS (overflow test passes with -ENXIO 
fix).
   vfio_pci_device_test     — PASS.
Below tests are not supported:
   vfio_pci_driver_test
   vfio_iommufd_setup_test
currently it fails unsupported tests when triggred via scripts/run.sh

I will start including test logs in cover letter starting with RFC V2.
>
>> 3. whether the sPAPR-specific overflow errno expectation should be
>> accepted, skipped, or hidden behind a backend helper?
> Responded in the patch. Let's keep the check but base it off IOMMU mode
> not __powerpc__. Also it'd be good to avoid duplicating the code with a
> helper function or macro but that's a small thing.
Agreed. Will replace the #ifdef __powerpc__ guard with a runtime check:

   int expected = iommu_is_spapr(self->iommu) ? -ENXIO : -EOVERFLOW;
   ASSERT_EQ(rc, expected);
I will add a helper to avoid code duplication.
>> 4. whether PowerPC should generate only the sPAPR TCE v2 fixture variants,
>> or keep the generic IOMMU-mode matrix and skip unsupported modes.
> For (4), I think skipping unsupported modes would be a good improvement.
> Even on x86 and ARM we would want that feature. e.g. It's possible for
> someone to run VFIO selftests on a kernel that has VFIO Type1 IOMMUs
> enabled but not IOMMUFD. Today that will cause all the tests to fail.
> But ideally it would wouldn't. Tests that just want the default IOMMU
> mode should use Type1, and tests that want to replicate across all IOMMU
> modes should skip the IOMMUFD variants. Same thing applies to the SPAPR
> IOMMU mode.
This is a great point and it also addresses the concern raised in the
Patch 1/6 review about forcing the user to set VFIO_SELFTESTS_IOMMU_MODE.

Once again thanks for the thorough review.
I shall address all the review comments on the series before sending v2.

Regards,
Narayana
>> TODO: vfio_spapr_tce_v1_iommu yet to be covered.
>>
>> Narayana Murty N (6):
>>    selftests/vfio: allow selecting IOMMU backend from environment
>>    selftests/vfio: add sPAPR TCE v2 IOMMU mode
>>    selftests/vfio: add sPAPR TCE v2 DMA window helpers
>>    selftests/vfio: Exercise sPAPR DDW path for hugepage DMA mappings
>>    selftests/vfio: Accept sPAPR errno for DMA range overflow
>>    selftests/vfio: Enable VFIO selftests on ppc64 and ppc64le
>>
>>   .../selftests/vfio/lib/include/libvfio.h      |   9 +
>>   .../vfio/lib/include/libvfio/iommu.h          |  26 ++
>>   tools/testing/selftests/vfio/lib/iommu.c      | 280 +++++++++++++++++-
>>   tools/testing/selftests/vfio/lib/libvfio.c    |  37 +++
>>   .../selftests/vfio/vfio_dma_mapping_test.c    |  30 ++
>>   .../selftests/vfio/vfio_pci_device_test.c     |   4 +-
>>   tools/testing/selftests/vfio/Makefile         |   2 +-
>>   7 files changed, 382 insertions(+), 6 deletions(-)
>>
>> -- 
>> 2.51.1
>>


