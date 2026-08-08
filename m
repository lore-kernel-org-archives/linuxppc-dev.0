Return-Path: <linuxppc-dev+bounces-25642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF63C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 15:47:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHQPd1cyYz2y1F;
	Sun, 09 Aug 2026 01:47:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786204037;
	cv=none; b=ODmAaocKt7Ypyfl/ySDqr7DvEQN15pFmZE6+w1dkMQwUGGYTM48DmIXiq1m33J4QGQZFc6EEqpyVmsixQ2Bztl9nA9O5C0tvGQoQJ/9GL3jIDXARg7FRYROM8Em+k3BLnn9bKVTO83TY24cBSq5hf6tCN4usvrqAnaPgO0Kd48Ck3bMnSDZLCi7Tj7wDshrNCM7+8DINa1YZpjKDLM5R+Ifm3a7nTmVBb0fICGUChKjHadW6Gf//8w1mEOlMrwqfdnDpyrZCaGP0uFgvCv1g3DyCEeO5thhscefAjHnfk+kAurAmC9Uh3ADvP7o6H48SHVy9b9hZiBITOix4pThC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786204037; c=relaxed/relaxed;
	bh=FrIH1BwpV+FxMvs8gwOSN9G7HnHmcc/DVjgKEncP+Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxMgG1YNE009i9s0QO6Z7L2ehwt/o3MLC0sGGHb+zqU8LsX9BLLX5s+jSrLgz/zHucxnFrK1Nvd7oAuPiSoqiuZEwvdXRpm17t2EqczWCUJEl+QOpWxj6Po3pJx9CDFlTlysXm9TVD/+sGDSxmYmh1TDCVCJW8lhZ+xiBHh8DGNmlvYdvx+AdVGt5/pHjkBhP0YzFEkX2jq0HcnvRWcCT7e1Ncy1fFS7kLsJpQBGMcFgYHFbUjfnPR5r1ewDkYt9GXO9jSJjVB7JAxoVg9flzqmNIE/ctw3TB1NHWbU3CwbLmzMJWSYi26132vZfWjYuOG0759Z/ix7/NyHk+7LB4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IXluFmCR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IXluFmCR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHQPb6VKvz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 01:47:15 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678E1ln6259289;
	Sat, 8 Aug 2026 15:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FrIH1BwpV+FxMvs8gwOSN9G7HnHmcc
	/DVjgKEncP+Fk=; b=IXluFmCReS72oCFUx9rLFcMJ9f/yJdrKe5X9V3sbloZYdF
	SRiO3uQ4VQ+Z0KwLnPVbfMYiFIK5emc5VDCv+2flpeU/u8hnfob8pqUYu40W21rS
	8Q/yMej0hPicV3ezcB85Nsxe8f8Nh+8pvmyhP1CknuZiOMBbRh0ZFJSb1ssc2068
	+AlUpzVotJNWsjevvV0mtW1pTsx7NctXI0w854/KlTYFXxvIhxIaqEKJLbY3NzCX
	5oIQK6xwhGwzJToCLBMyzoqXtBlYLP91tC6cH06do92me7S5MSo7nFpUjSj2WkIz
	MjMqnxV2V4G/vqcR4NXP7LHeri5K6ZMvqAT3M85Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkchfgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 15:47:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678FfM2W022128;
	Sat, 8 Aug 2026 15:47:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r411y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 15:47:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678FkvIP49807640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 15:46:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 007A120043;
	Sat,  8 Aug 2026 15:46:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B6BA20040;
	Sat,  8 Aug 2026 15:46:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 15:46:53 +0000 (GMT)
Date: Sat, 8 Aug 2026 21:17:01 +0530
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <20260808211615.fb580df8-72-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
 <20260807172433.82045-2-amachhiw@linux.ibm.com>
 <33wpl93b.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33wpl93b.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: j4pVYzYdoZRZ-U3rgaTnNgutwnthaIxI
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a774f76 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=GS9XHCjG0vJnGz0bkuEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rwUD4KyU_OQVmlz7QKZ90lFsrhrZs0_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzMyBTYWx0ZWRfX3M1+TSfnxxfC
 kNTxMImUEns/RGp0MoyOHwl8hCQhc4Y9L7GuFefCQX8+MXGun1o3Q4nQwu57xWLe+TRxqdbivEd
 Yh7mowd0L1YjD2yJusRP3Cv8W+fCWkj+oyjeibgCey0DH2VHS3g0cjhCKrGwShkEaRVOcY1jXFn
 LPPmzOhDsO5hQyfr4VqQl97x3c4/fJw+qB6buWUAXLHyKdS/fYOFHDaXlJ+THLEp7qhAxikHazr
 plI8MDxiXQ2pm4o2b3DKP89lKzrcIdDUZ8AAtKO+P6cIdG4eko4Lr/9WJLyQd2gLaC1LBGaPrx8
 mo1ER1RH9at3HISLN+9F2kxZxMIeL9UzGrTaDCVp8uzGuCljBvvq1dGeUNTP6sf0ZHsnYhM/L/I
 PWwuIfOFk5m9NPdCpLAAn0n4PxqhEeeLfir3jkMw0Pqpg4ujwqg5VGZECKsMEUy9Y61y9JShqVW
 6yqQZG3cDp52GpeGj3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzMyBTYWx0ZWRfX7AV8sYm4erfQ
 QAnykkoVE3sZlYx44mNJt5hIiChyiND/cRGHZzDgzwIf5n11XX4yqFX4OPUF4xfe52QFdF3s9+k
 QI2fXQnPkaJb6xINllP7B+UqNWf2le8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080133

On 2026/08/08 06:30 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Introduce a new capability and ioctl to expose CPU compatibility modes
> > supported by the host processor for nested guests.
> >
> > On IBM POWER systems, newer processor generations (N) can operate in
> > compatibility modes corresponding to earlier generations, like (N-1) and
> > (N-2). This is particularly relevant for nested virtualization, where
> > nested KVM guests may need to run with a specific processor compatibility
> > level.
> >
> > Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> > KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> > the compatibility modes supported by the host in respective bit numbers,
> > allowing userspace (e.g., QEMU) to select an appropriate compatibility
> > level when configuring nested KVM guests.
> >
> > The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> > CPU compatibility capabilities via a PowerPC-specific backend
> > implementation when available.
> >
> > The struct kvm_ppc_compat_caps places the 'size' field first so it can
> > be read alone via get_user() before copy_struct_from_user() is called,
> > avoiding pointer arithmetic to locate the size field.
> >
> > The ioctl is defined using _IO so the ioctl number remains stable even if
> > the struct grows in future versions. It uses copy_struct_from_user() and
> > copy_struct_to_user() to provide forward- and backward-compatible
> > extensibility: older userspace passing a smaller struct to a newer kernel
> > gets zero-padded trailing fields. Newer userspace passing a larger struct to
> > an older kernel (usize > ksize) succeeds if trailing bytes are zero (the
> > kernel reports back min(usize, ksize) as the filled size); if trailing bytes
> > are non-zero, the kernel writes back ksize into host_caps.size and returns
> > -E2BIG so userspace can retry with the correct size.
> >
> > KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> > (24) marking the size of the initial struct version, used as the
> > minimum floor for size field validation, similar to other versioned
> > struct interfaces in the kernel.
> >
> > The 'flags' field is reserved for future use. The kernel rejects any
> > call where flags is non-zero with -EINVAL, preventing garbage values
> > from being baked into ABI permanently.
> >
> > The ioctl returns appropriate error codes: E2BIG if usize exceeds
> > PAGE_SIZE, or if new userspace provides a larger struct with non-zero
> > trailing bytes (with ksize written back into host_caps.size for the
> > retry); EINVAL for an invalid size or non-zero reserved fields; EFAULT
> > for failed copy operations; and ENOTTY if the backend doesn't implement
> > get_compat_caps.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Changes in this version:
> >   - Add PAGE_SIZE guard after get_user() to bound the check_zeroed_user()
> >     scan in the usize > ksize path [Ritesh]
> >   - Drop manual usize > sizeof(host_caps) pre-check; delegate entirely to
> >     copy_struct_from_user() which succeeds on zero trailing bytes and
> >     returns -E2BIG only on non-zero trailing bytes; handle -E2BIG with
> >     ksize writeback and -EFAULT escalation if put_user() fails [Ritesh]
> >   - Fix host_caps.size on success path: use min_t(u64, usize,
> >     sizeof(host_caps)) so new userspace with zero trailing bytes gets back
> >     the number of bytes the kernel actually populated, not usize [Ritesh]
> >
> 
> Thanks for addressing them!
> The only remaining comments from Sashiko now are because, it cannot find
> the implementation of ->get_compat_caps() since it is in the next patch.

Yes, correct.

> 
> So as for this patch, the changes looks good to me. Please feel free to
> add:
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for the review, Ritesh! Will carry the Reviewed-by in v9.

~Amit

