Return-Path: <linuxppc-dev+bounces-25478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864EEC55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:32:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwsS71xcz304x;
	Thu, 06 Aug 2026 15:32:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785994364;
	cv=none; b=bUeEQhwcyKlJSWDJwiKPuPD/sYHjq1Zu3gLVKZOvVKX1tJmWUevvtY7qSIFemmRDgD5hoiRLrnJ2RHR3RqqFlbss90JPRvpJuwaL1fxBdJrW/4uf5X6CJ0UV2Ks2Dyw8rPF0xBa3f7jrzsp0YBxa4Z+/9z9V0k+bN1wggYRLJH5dubOnfhFj7gxzv7FCJJnO1FFr5crL4oUxMpEbRkyNTvtRO0CWWP8JMofIhAZ2TYniwJSFGpK4terkEzl8dXI5lNhU4MWUWvd7IImCZ0Ng10NMVg4jNZm1YWlODwbtXNEWwvjY9wOJSYQ3qV1X+TNTojOm170yvOeSokQSFxMMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785994364; c=relaxed/relaxed;
	bh=5N50+m2zoR8QgMtQJOG5cgx3HnsvWgqZ/qJQqqpOCcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBLHJg/FEc0HJFvhlw10iWvJZBIaMvVgh0IyyWa3haG56YcxWa6wQQV75oe7uDmCInzKMf0A60LHTXCaMfSC+8HAqS23u9uHaKUK2N5QMlqKLMdis5jH4rDCMPZA1AbYfzZuYGAfW6vpf+fhbzi67ngVSFgqD2AYHP6UU6Qv7oW2nlhzUFpHNLP0/IhJDKyuQMnraRoD00ukX2DZSkPOERUSklHHgVvLjcLf+9Sxn1aI9pdMs+vjoMhe0TuRoMuQ+BsDuVQ4lC2kq3PnepYx3N8M66i/do/7mUtHKVP0eg7aYAz75fbuhCDNkynFL7qj+lNe/wM8zpnBQyU67AeLIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UceCzOuO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UceCzOuO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwsS0FP3z2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:32:43 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlmYv1066244;
	Thu, 6 Aug 2026 05:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5N50+m
	2zoR8QgMtQJOG5cgx3HnsvWgqZ/qJQqqpOCcQ=; b=UceCzOuOikzEia2zKThPuF
	RIijKjycECVMsK4wz0aTOifpYcQX0y7FP7RLYqJtfVNRlvK+W54qnjecmDuQRG97
	Td6xrhkIZEp8UtfLJBIswjgqvMP+PSQrWY6SU37sPYvcbWHqFwTGrtSRQl1PEXDG
	f6EpyzJWDZWMhdz2XBiwYDRHOuYh2SKq9cNvwXQWQxBXwX5eleVf+8UjItlaH94g
	agqzpyuMHkzurAKcdLZiDu4gyxrYJHn/RS9n5+cmQB0yNp4Ep2HsbKgKx6iVuKeu
	2mWsozWDpLQ6wJu1/W/14G1XGPszYvmJUjDlfomcKfI42JZpYw8OUDkLTFaqziow
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a46hfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:32:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765QRCF019794;
	Thu, 6 Aug 2026 05:32:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhhr1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:32:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765WSDN34669016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:32:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4460C20043;
	Thu,  6 Aug 2026 05:32:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 754DE20040;
	Thu,  6 Aug 2026 05:32:25 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 05:32:25 +0000 (GMT)
Date: Thu, 6 Aug 2026 11:03:13 +0530
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
Message-ID: <20260806104222.7e435b28-8d-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <tsp8l8cw.ritesh.list@gmail.com>
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
In-Reply-To: <tsp8l8cw.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a741c71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=OftZMxRC31MPY7VeiR4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MyyNFwdmT0f70Rm3IuUqkBLKBF-dUUra
X-Proofpoint-GUID: V9VhITl5Ho-nq0FPK_2YHD01ieiGFWbc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX0YQHMt1bIBoh
 7cr9Mw6GGpFzDfzaF9FWn13Y6OybGzq3MoOHMnQjMnpkCmQ7zExmrjuA+ic4+iOVJFR0PwBHnxi
 7nr3W2Ndvy/gvk/WeFkf3CpkZXeOh/c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX6pQzU9SilWre
 ymh6JSiv75Y5qMSfpS5k4+vjtjJAQ7/M5w47CoU8UvTpusnvjznoIq9OTfHaPoslUquk5CCl78D
 iCNlM820dnxgLpjuBEwdCSIYX0gWCQDM0BdrR+5qHIWHOYMhbgMscaVcvQQUs3vrvwh+lqhvA9C
 EeRV/A7C8lWeZGhlWQpR00AXB5KQgI0Nq7yK2RpZDduR8FCG6Ez3gxpfYwy0pNg32X+wfmymGlc
 EIM6L45pxXFHhuNi4w0GpbKWhKuBkq1tO3r6Sg5XaBs7Ok3VHjHSIkSQE+N99NBUm7FlE/Oe+uY
 861m//ValZ2qd+9EiTHyA7XoKj5UwH4G5q2aQjAz5S+Q8VSjCgOffj996cxfHrb+TLKWrVK6aHX
 YSSn222wkND45yrVZWiUgVcYXrG6j6aT/WzXG+bS9fkQdyHDOl6IwAJT2/PeKnadQ+uZwNPa4sP
 Q1GYwJdyPJtt4u6sTWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060038

Hi Ritesh,

Thanks for taking a look. Please find my response inline.

On 2026/08/06 12:09 AM, Ritesh Harjani wrote:
> 
> Hi Amit,
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On POWER systems, newer processor generations can operate in compatibility
> > modes corresponding to earlier generations (e.g., a Power11 system running
> > in Power10 compatibility mode). In such cases, the effective CPU level
> > exposed to guests differs from the physical processor generation.
> >
> > This creates a problem for nested virtualization. When booting a nested KVM
> > guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> > userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> > and attempt to configure the nested guest accordingly. However, the L1
> > partition is constrained by the compatibility level negotiated with the
> > hypervisor (L0), and requests exceeding that level are rejected, leading to
> > guest boot failures such as:
> >
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >
> > This series provides a mechanism for userspace to query the effective CPU
> > compatibility modes supported by the host, so it can select an appropriate
> > CPU model for nested guests.
> >
> > To achieve this, the series introduces a new KVM capability and ioctl
> > (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> > compatibility modes supported by the host.
> >
> 
> Sorry, but I am somehow not convinced on whether we need all of this
> machinary just to get these 3 bits of information, which we are
> returning today.
> 
> Since KVM_CHECK_EXTENSION can already return an int, so why can't we use
> KVM_CAP_PPC_COMPAT_CAPS itself and return the bitmap of supported compat
> modes to the user?
> Say if the cap is not supported, we can return 0, otherwise we can
> return the bitmap of supported compat modes. This will easily allow us
> to use 31-bits which as I see would be hardly a problem in the near
> future. In the future if it grows - we can always use KVM_CAP_PPC_COMPAT_CAPS2.
> 
> This should reduce the code complexity both in the kernel and
> userspace and we don't even need a new ioctl then.

Thanks for the suggestion. I considered this approach but would like to
go with a dedicated ioctl for the following reasons:

1. Intended semantics: The KVM API documentation states:

   ..kvm defines extension identifiers and a facility to query
   whether a particular extension identifier is available.  If it is, a
   set of ioctls is available for application use.

   [...]

   KVM defines many constants of the form KVM_CAP_*, each corresponding
   to a set of functionality provided by one or more ioctls. Availability
   of these capabilities can be checked with KVM_CHECK_EXTENSION.

   The intended role of KVM_CAP_* is to signal ioctl availability, not
   to serve as a data retrieval mechanism itself.

   You may take a look at KVM_CAP_PPC_GET_CPU_CHAR for instance.

2. Return type constraint: KVM_CHECK_EXTENSION returns a signed 32-bit int. The
   capability bits are defined as (1ULL << 62), (1ULL << 61), and (1ULL << 60) —
   64-bit values that cannot fit in a 32-bit return. Renumbering them to small
   integers would be a UAPI change and would lose alignment with the
   H_GUEST_CAP_* values from the hypervisor ABI.

3. Extensibility: The struct-based approach with the size field provides clean
   forward and backward ABI versioning via copy_struct_from/to_user(), without
   needing a KVM_CAP_PPC_COMPAT_CAPS2 in the future.

Thanks,
Amit

