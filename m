Return-Path: <linuxppc-dev+bounces-25483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C31C56207
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:57:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG9PV4Hytz308Q;
	Fri, 07 Aug 2026 00:57:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786028270;
	cv=none; b=KZoHuEnm1D/QUG0qpqtDXVOAOYvCbi0TOfp8Hm11kpVdRTK1cYiL0BJvK7h5TGvyjhVtLe7Pv85ITPR/kZ2ZdWn3hgEGNInttKomupCZ4I3Z9+JXmdf6nv6WQhmWAZMb3URm3DrT70fpC5oH2iol+cmJIKS/3vT0Yl85BrvmZ08bduhuu1d8YdUHU84/kywhSflkqsORg6Qj5+1WwtPpote31wawDrhhXGm76e+/payOk7CdWcDmCVOmV7+5kgoHodrQDCyHFepk44OmhTxwEgOLttN7wUDfrxWhfFBBpcS+DLqxfNymwNuATGB85OGoCsU/DwOeOb6wsG/kVq0L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786028270; c=relaxed/relaxed;
	bh=X9ZCWoFyjqoTs1Wdrr0tb85vfPjmxaw5shuuiJIRD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu2WEx5E/exM+HiNYldz6QEsS4m3lnJo71eWvCiA9p3p2rT9UOomL9p0De56wR0BS4mbDgkDEfjBSQIJDwql1c/+KCKVbhjHc26fOV5icEPRyoBvDdysQMf+kk6O3iBvFybxUTAHbJ+fTmKRGwKNLs1GSS0iPGW/kJNRa+SGtxin/cAWEpFO3yTNBN8wN6RWh6gxtMiZhiyeNPGv99s5FVUjsVe5te27pGA2bdRpUbVMFoCFmGSKzN6O+YIpbvukznTwl0FhjIzONdShC9RehTROfXIg76NKiWwJ/gTnnR9udAo3+/2XmC7M65cQzFpp1AmfWlnEMUQIfBh/74aqQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dLPxqC82; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dLPxqC82;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG9PT1t4Vz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 00:57:48 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnKXm2964507;
	Thu, 6 Aug 2026 14:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X9ZCWo
	FyjqoTs1Wdrr0tb85vfPjmxaw5shuuiJIRD9c=; b=dLPxqC82CNPm8yAXvvjdHV
	EXeLsk1Q70u12l5ZtG7B++FsNwYiiMA5hcweezFYsvXzPTnSYUDBcx0CjFz0BJV4
	6JGVCNfxV0OZmEGYbm4YmIP0DCiZE70PjTmDFVYkVvSp4jXCf/7FdU1KOtBe71aR
	F+EsPufZZaqTBC35Qo06cmdV5CU5VAO5CWfHkLnp8f/bMK7ajxD0FuJmFvz9njnp
	r4SfWk7mrm0sLfIwpIXeotDbd1V/uzWqbvTze6FaIKJXP0Pcv2UgntNjMecT/kmp
	RJi5/52BlBqrt9E0Acyo5zrhNS7iHYq8/2VVKaDpEA00keJyNnRhf5Dm9jm/P7Ng
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h58v8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:57:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676EugwZ003358;
	Thu, 6 Aug 2026 14:57:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhkj0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:57:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676EvPfR52035930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:57:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E25C2004B;
	Thu,  6 Aug 2026 14:57:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D90220043;
	Thu,  6 Aug 2026 14:57:22 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 14:57:22 +0000 (GMT)
Date: Thu, 6 Aug 2026 20:28:11 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for
 nested guests
Message-ID: <20260806195943.1fa6cacd-be-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <tsp8l8cw.ritesh.list@gmail.com>
 <20260806104222.7e435b28-8d-amachhiw@linux.ibm.com>
 <mruzl7qc.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mruzl7qc.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXyb8VSYwFs6jy
 CvdE88yiGqnbT0NJ3ZS/jf+dZQZ4bFs00IiqXhiMERgghrSpP1xwpOrGC/44dSwKC+H3Bie75DM
 CpFcnXKh2DaIbUMV82pbfuTVjuMhdfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfX7AasYGKtMULE
 wNZ03bxfJgQaD6K13xy9P5TuotuqHOK6Fnpv2NfK7/9osndLEa/TIL/0ftJHqaMZqpHp0qq6gKd
 QUxAtVoL2KRrVUNUyBDuI/uwEwVK9ZTh2+Blviq9ePhASgW/kZmxtDoCTDRB2/dJAYoa3T9lGIK
 QLPkd46QwZ9liv57u05YL4bw3DVewT3A1UugWdA7Oigggcm3FqRc7S5EDQg+kLAzLITLkFjHKDU
 kCBf0eVgytcwDP3OJq4zXb2Lm7VwWYl4DUyUmwPX7VpjxYl2NeFhkq7NZ1LdPpmh7ZWH5EYG+g/
 5Df5jZYBHsa1IVSQS3iEPVIfmAYfmrL0oekeE0xF3gYGDngd0W8q0pn5hjcw/rkMwUjXb8yh4fg
 4W6r3afwBczoH3eOKd2XTBJiQVNfdfH/RQTvrR0hJRTuNC4oycimtmUR5kiTfeiJXdxT2U/wXh7
 jQOtRc/+AIUDcv7I7Pw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74a0db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=a07hoUeaLZJ5nhunpkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ACYYhBt_gOpV2mwcDM734kjCwx89R1Zm
X-Proofpoint-GUID: YeR6JNO4hYzHddb9dOpKTjsRYLFqsOp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060115

On 2026/08/06 06:35 PM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Hi Ritesh,
> >
> > Thanks for taking a look. Please find my response inline.
> >
> > On 2026/08/06 12:09 AM, Ritesh Harjani wrote:
> >> 
> >> Hi Amit,
> >> 
> >> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> >> 
> >> > On POWER systems, newer processor generations can operate in compatibility
> >> > modes corresponding to earlier generations (e.g., a Power11 system running
> >> > in Power10 compatibility mode). In such cases, the effective CPU level
> >> > exposed to guests differs from the physical processor generation.
> >> >
> >> > This creates a problem for nested virtualization. When booting a nested KVM
> >> > guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> >> > userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> >> > and attempt to configure the nested guest accordingly. However, the L1
> >> > partition is constrained by the compatibility level negotiated with the
> >> > hypervisor (L0), and requests exceeding that level are rejected, leading to
> >> > guest boot failures such as:
> >> >
> >> >   KVM-NESTEDv2: couldn't set guest wide elements
> >> >
> >> > This series provides a mechanism for userspace to query the effective CPU
> >> > compatibility modes supported by the host, so it can select an appropriate
> >> > CPU model for nested guests.
> >> >
> >> > To achieve this, the series introduces a new KVM capability and ioctl
> >> > (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> >> > compatibility modes supported by the host.
> >> >
> >> 
> >> Sorry, but I am somehow not convinced on whether we need all of this
> >> machinary just to get these 3 bits of information, which we are
> >> returning today.
> >> 
> >> Since KVM_CHECK_EXTENSION can already return an int, so why can't we use
> >> KVM_CAP_PPC_COMPAT_CAPS itself and return the bitmap of supported compat
> >> modes to the user?
> >> Say if the cap is not supported, we can return 0, otherwise we can
> >> return the bitmap of supported compat modes. This will easily allow us
> >> to use 31-bits which as I see would be hardly a problem in the near
> >> future. In the future if it grows - we can always use KVM_CAP_PPC_COMPAT_CAPS2.
> >> 
> >> This should reduce the code complexity both in the kernel and
> >> userspace and we don't even need a new ioctl then.
> >
> > Thanks for the suggestion. I considered this approach
> 
> Then we should have brought that up early on during the design
> discussion. But for the sake of discussion let's call this as
> approach-2.
> 
> > but would like to
> > go with a dedicated ioctl for the following reasons:
> >
> 
> > 1. Intended semantics: The KVM API documentation states:
> >
> >    ..kvm defines extension identifiers and a facility to query
> >    whether a particular extension identifier is available.  If it is, a
> >    set of ioctls is available for application use.
> >
> >    [...]
> >
> >    KVM defines many constants of the form KVM_CAP_*, each corresponding
> >    to a set of functionality provided by one or more ioctls. Availability
> >    of these capabilities can be checked with KVM_CHECK_EXTENSION.
> >
> >    The intended role of KVM_CAP_* is to signal ioctl availability, not
> >    to serve as a data retrieval mechanism itself.
> 
> That's not entirely true. We do return data as part of check extension
> for e.g. for getting the SMT modes check KVM_CAP_PPC_SMT_POSSIBLE.
> 
> >
> >    You may take a look at KVM_CAP_PPC_GET_CPU_CHAR for instance.
> >
> > 2. Return type constraint: KVM_CHECK_EXTENSION returns a signed 32-bit int. The
> >    capability bits are defined as (1ULL << 62), (1ULL << 61), and (1ULL << 60) —
> >    64-bit values that cannot fit in a 32-bit return. Renumbering them to small
> >    integers would be a UAPI change and would lose alignment with the
> 
> There is no _change_ in the UAPI so far. This is the patch which is
> defining that in the first place.
> 
> >    H_GUEST_CAP_* values from the hypervisor ABI.
> 
> No please. Those are 2 different ABIs and there is no need to set a hard
> dependency among the two.
> 
> >
> > 3. Extensibility: The struct-based approach with the size field provides clean
> >    forward and backward ABI versioning via copy_struct_from/to_user(), without
> >    needing a KVM_CAP_PPC_COMPAT_CAPS2 in the future.
> >
> 
> This only make sense if we really have a usecase already in mind which
> you are planning to extend it for. Otherwise, IMO, this is a lot of
> machinary and I think we should consider the simpler approach.
> 
> IMO - I think approach-2 is a much simpler for this usecase. I don't see
> any valid reason on why we should not do that instead. We don't need an
> extra ioctl and all the struct machinary along with that just for
> returning a bitmask. The existing check extension ioctl can be
> easily used for this purpose.
> 
> Would it be possible for you to give, approach-2 a try? Do you see any
> geniunine roadblock or limitation with that?

As discussed, one additional and deeper technical reason is that the
Power Hypervisor (PHYP) returns a 64-bit capabilities mask as part of
the H_GUEST_GET_CAPABILITIES hcall (defined in the PAPR specification).
Our KVM_PPC_COMPAT_CAP_* bits are deliberately aligned to this 64-bit
mask so that the cached nested_capabilities value can be used directly
without any translation.

The PAPR spec reserves bits beyond the current processor modes and
capability flags for future capabilities. As new processor generations
arrive, some of those reserved bits may become relevant for them — at
which point a 32-bit return from KVM_CHECK_EXTENSION would be
insufficient, forcing a KVM_CAP_PPC_COMPAT_CAPS2.

The struct-based ioctl avoids this problem cleanly.

Thanks,
Amit

> 
> -ritesh
> 

