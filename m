Return-Path: <linuxppc-dev+bounces-29213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFC0CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 03:51:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j33S53CYXz2yDc;
	Mon, 12 Oct 2026 14:51:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791777109;
	cv=none; b=Yi2AaseE3ZDmIBsNZKbv996hDCQXeDfnlCmzrQHzsTubsu6BrvRLUDOnmY9HdVRFa9v/+Amixcm0chya0B2BnfSha4uaQctAMPMQCFmKg+UY1TFKQkhGD7YTSoQZ5XmFXK7TR2V93bozz5qSaqOAbXbxHWZmjS3mYw5sAEXm0mW4G+BMCevNw0w5GUQpFoSzUwNZMn6rUum5tlZ85ITRhjn2XzPfjrn9oIiE6bra8bWSe15X4idnh+ogkHNEnuzINt+QfHbZqex8K1I5ek9em+GShwc/e1+6lGFputySa78e9h951pUQ5fQ1GmzEIEqW8cAbR/9W+2gj2fDqLzJgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791777109; c=relaxed/relaxed;
	bh=Fh+cmRtEbXcmwWD44V7PpRx5S2436EpwTjabRkFFgx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwR3FZy0QRJxhLlYlzooubnsIgHy9tKXf7w/gbqIs5urcxmknXhf6NVRcDSlbXuZDUglcoGgsLkuRoxbGq/2Yjc+VxN94eRc/tJ2IlIQkGh+RNS81khoSJi+Uq2vQdmAizLsmKmSGu9ZT43JTrdtbQbY4OIjGkVyX8e31oE3niP6iSzoko+0aISAJE28618uHH32MFQz8tTV/l6fLtR1g7jso/5tf4BEGUsfZh7bkjMx82Z6If3SORBOLCF6uiw+8AANGzNR8Byix/MG9rfRY3GquQQbXDgQpiV5UGAZGpb+Od1H7hyybrYvD1FKwB/cBhj8S+YP3ZMsOQLm0v5CHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RquGCIGj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RquGCIGj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j33S40v4Lz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 14:51:47 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EEDQ3070856;
	Mon, 12 Oct 2026 03:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fh+cmR
	tEbXcmwWD44V7PpRx5S2436EpwTjabRkFFgx8=; b=RquGCIGjKi8FgksoepE589
	1JQmtcH6aeFKmnZCAUFreUSD9guyufUS4spo7Zc9uQWM71Bd9cViaXM7+ju2qIai
	IgIQ2YvRQXQRWcYA+o9OX+Fy1b5FqM7ZB372rs3nUrCuBbU3pZEhThZZoICTKYKP
	C0Kg+5bEX50USssK55JbT9JZn307IbNmDhtiOIuqkqsrSE/fmlbC4KZS7iDHqdvz
	NOZAFRC4JwQ8xEdd/kulvQ2dXzWw8EYsNGiOMmdlQoBsovBjZ/Fc+IyrNqiXf8ZT
	DrXqo8QP3Y0x5G7RNikxQ86J+bRLgi3YNJ2E9x7ywRNBWUNpZXy2W0lS9sKP3Irg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vxqm2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:51:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1o7Av598375;
	Mon, 12 Oct 2026 03:51:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cybaud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:51:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3pYCw54067562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:51:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E40FF58055;
	Mon, 12 Oct 2026 03:51:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9C8A58059;
	Mon, 12 Oct 2026 03:51:30 +0000 (GMT)
Received: from [9.123.8.83] (unknown [9.123.8.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:51:30 +0000 (GMT)
Message-ID: <94cd4203-1be8-4f8d-b015-0c02760e5770@linux.ibm.com>
Date: Mon, 12 Oct 2026 09:21:28 +0530
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
Subject: Re: [PATCH v7 0/8] KVM: selftests: add powerpc support
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy
 <chleroy@kernel.org>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <cover.1791280439.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNCBTYWx0ZWRfXwfcHgwa6F8F1
 8+Xb8jlXeIVF4vbwNLHGxTqCnjqxEVIpcUpgfX4e6fWztGHMs62FTes2xRJU3x56nYbubABrEYp
 idgcS/PW9izzuw0/3IU6Fyyr3Wbf4Rg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNCBTYWx0ZWRfX7Cj0jI8n7Owq
 NqEz8zD2aCoKct+/eQ/KdnVZf6nWcgzy2729OhoUXoj5eTzYrizrJslM25eYSeKdWAFdUoD5aQ2
 +zu928m6BUJRzAbSeQ7Mp6vVSEANUW3fd8pzL137OAHEH7ymWALQTooBBrFwlkZAQJg6sJpI6QT
 I39ueCKqzinYRVvXiaqIac7ASk/CcHsR1An2aN3ot5K3i5l8nU7pZ22J/Zizy+hKQ1bKrHvnzQD
 ImllwfwkP1Re+SE4bl7s/Ul/Q3x9Bl4tr4iYRnwj+khKRPmAgPnA7t0KbCfw+kMb8Qrl4PPh4iq
 lwI+cixxK7ly+6Xtl7DBeX7tYa1kddka04htaYdRNIgF370TxX9oMFe08waYRIOF7q5bCfp7B0L
 lf545DwvdCG+MUHXREq8KUTQFPYpq9XPtzcRvfZSQZFtsfztEg9kDHd4RNwJP7YEjPT7i6hP8Ve
 1nYvYxY7xJU+MjmOluA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc5948 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=XUvtLocL4moM6XFFuJEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wcyoAUsnYWyartj_LMssaGR2zbXpmQ44
X-Proofpoint-GUID: 6L66dTfzpY_Xhq72Nqee6HcVU9AJ5lpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120014


On 10/6/26 3:58 PM, Ritesh Harjani (IBM) wrote:
> Patch v5 -> v7:
> ================
> (Suggestions from Sean):
> 1. Added kvm_is_ppc_pseries_lpar() helper in kvm_util.h to avoid sprinkling
>     multiple #ifdef __powerpc64__ checks.
> 2. Enable all tests via TEST_GEN_PROGS_COMMON for powerpc
> 3. Enable hardware_disable_test and skip when running on powerpc pseries LPAR
>     (nested).
> 4. Re-arranged the fixes in appropriate order.
>
> This is based off v2 of Sean PPC pre-enablement series [1].
> [1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
>
> Patch v4 -> v5:
> ==============
> - Fixed the issues reported by Anushree while running on kvm on powervm
>    (nested).
> - Fixed memslot_perf_test on powerpc.
>
> PATCH v3 -> PATCH v4:
> ==================
> - Rebased on top of Sean's new page allocator patch series v2 [1]
>    This allowed to drop and patch-2 since it will now come from Sean's
>    v2.
> - Addressed review comments from Sean - squashed patches 6-10 in patch-1 of
>    this.
> - Dropped patch-5 to print vcpu_id when KVM_CREATE_VCPU ioctl fails.
> - Added additional patch-3 to this series to allow dirty_log_test to run on all
>    big-endian machines.
>
> [1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
> [v3]: https://lore.kernel.org/linuxppc-dev/2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com/
>
> Testing updates:
> ================
> I have done some fair amount of testing of the selftests both on real HW and
> using various combinations on qemu (powernv+LE (default), pseries+cap-nested-hv,
> pseries+cap-nested-papr, powernv+BE). There were few powerpc kvm kernel fixes
> which were identified as part of this work. I will send those patches separately
> as those anyway needs to go in separately.
>
> <pasted snippet of cover letter from previous versions>
> =======================================================
>
> Hi All,
>
> This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> radix MMU).
>
> This patch series is originally Nick's work. I have mainly only rebased it on
> the latest upstream tree. Since the rebase required few changes to all the four
> patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.
>
> Since the last series was posted three years ago [1], I am resetting the version
> to RFC. This rebase was done as part of a larger effort to improve the selftests
> infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
> help on this.
>
Sean/Paolo, hope you take this via your tree.
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Nicholas Piggin (1):
>    KVM: PPC: selftests: add support for powerpc
>
> Ritesh Harjani (IBM) (7):
>    KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
>    KVM: selftests: Move memslot_perf_test off the 256M ELF load address
>    KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
>    KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
>    KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
>    KVM: selftests: Only warn for idle-page checks on powerpc pseries LPAR
>    KVM: selftests: Skip hardware_disable_test on powerpc pseries LPAR
>
>   MAINTAINERS                                   |   2 +
>   tools/testing/selftests/kvm/Makefile          |   2 +-
>   tools/testing/selftests/kvm/Makefile.kvm      |   9 +
>   .../selftests/kvm/access_tracking_perf_test.c |  10 +
>   tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
>   .../selftests/kvm/hardware_disable_test.c     |   3 +
>   .../testing/selftests/kvm/include/kvm_util.h  |  26 +
>   .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>   .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>   .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>   .../selftests/kvm/include/powerpc/processor.h |  39 ++
>   .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>   .../selftests/kvm/kvm_create_max_vcpus.c      |  14 +-
>   tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>   .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>   .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>   .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>   .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>   .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
>   20 files changed, 898 insertions(+), 13 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>
> --
> 2.39.5
>
>

