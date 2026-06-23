Return-Path: <linuxppc-dev+bounces-22929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77624CDB479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:05:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl6KW65LGz2xM7;
	Wed, 24 Jun 2026 00:05:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782223535;
	cv=none; b=Iqy5QJBzrFe9t5IIArgKJSVJMn8ylzSOaR5oRNdKTA/FHOBVwt5PDMvR9FeLgZIKaGxdfZ1ksL0+WuxWWlwfF2jzG60/j3SdBbUDjYxEFgbJ/ZhtAP/dQw+wkowZJ3THZEo2SNTRXeupekWnJ3i28tFTeRSRxuyECHCrTvU5GGqgYBOklfwJxGsfmACFPMYloyoviVXeUh+wXrrV4Icw67ls/fHbeXgzWFggnVPqQMjIBb0MGL1SF9cAM1iuLkoGNfLZe5fTzZs2d1SFL29CLKaQC4JVqN6l4v1GF8G4u7jB2/w27u2rO8xQJgyK68OKq2dy5Lad2gTx+xCUdZFtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782223535; c=relaxed/relaxed;
	bh=/OQJjwaAIbyZX727RG1wnNhkFeYx1lZdR2cIcfZnNgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4+XVIuTA7nm3rCAnGSXr03AsGu3SEcf43vJWlviQUTYkDMP5TXIvP9fSZcdlZpB7bm8cxgIJdMPdCkr0UvA6vs+xB9qRd8v3ge+d0CtD47h+BuILXgd0WiZEwNczHcNBdQ5TSFM/p6Il310vmg3TGIp8lr0z+iWMh2/igfg/4p7YEP42VIzjrMzBUBUuh6gS+6can4uxn7KODENAkLU5ma/TR87OJeq4Qh7AT0a1HHCqUCIqboIwrxHwHcF0vdogDDqA0v0DAw3atIRderjUGHyK6t2WvXcY8urFdkCisTsPqpLCT7iRvVq+9kZvcEjxFSZxxCQmN1tVGL/NLmK/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YfB4mphF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YfB4mphF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6KV5VQxz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 00:05:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmueM1806273;
	Tue, 23 Jun 2026 14:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/OQJjwaAIbyZX727RG1wnNhkFeYx1l
	ZdR2cIcfZnNgc=; b=YfB4mphFNuKJ+wUr1qlSrCHl8qJZg1KEAV8YwFbccF+77G
	hVNP7+l5foq1ZxDkQYoQ2Zh/t8LYgvyi8LHQ2ujzUlE0MZO1Fm4tX+QNGVVuF2Qk
	+7c25tERXELNacEP1FouDanlRS191urskwydVwi8lRitPSU3/+I2L6WK3n/BhezK
	mlazj8syfw9Kl8OMNxHr7KlKtejW4au4vyNBlY6vH5xflqSAuo6TvmCIesYbs7CM
	Z3wd6UmwPQx7fwM8syGj+/7IWL76mrdDjxagzDJmmUMGQRZuXK8UJiT0/oPTiHxH
	pSM1FQBgiPK2BikMnFj8+OnjBqG2KUhwLY7BBXrQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gevpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:05:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NE4jwu032543;
	Tue, 23 Jun 2026 14:05:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3kdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:05:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NE5GWj52298014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:05:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6865920043;
	Tue, 23 Jun 2026 14:05:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A018120040;
	Tue, 23 Jun 2026 14:05:13 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 14:05:13 +0000 (GMT)
Date: Tue, 23 Jun 2026 19:35:17 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v4 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260623193128.6db5d6a0-15-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-5-amachhiw@linux.ibm.com>
 <8733yjcb0y.fsf@vajain21.in.ibm.com>
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
In-Reply-To: <8733yjcb0y.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Pqp4b3WvcWnQFDJ2YJ94ma5rUOup3IYB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNCBTYWx0ZWRfX6bJazU3wNt4a
 t51oJGu+6OCgdcL5MoY1XeRdVvEht9g7QLaIGG179HUOWVFtIyKCdWITXaFzzea+waS8tUDpOZ6
 6BTZk0WUZ5//oOnCISKwclyzQH9H0t4=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3a92a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=A5PaLEsKMpW4Njs7qmoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNCBTYWx0ZWRfX+Mh8PG0SAJCA
 SgNKQHid3P3eHxt2z2n6rhNf6/Osq4fdA4ZkZ0Xw6D5YkjQ3tS4UK59PoTOCQSWHDf+wwFkrD8T
 zUvXL+OKil6dcDH8giKU2uYFjuWiB+aYyf7z/iADxsc4wqiEr9HWAaeEkPbgaR/F+xsdc4wxxXM
 zjHu3LbSdW3UXsgkuS+aInTf+gHRlTNzlE8HjvNQwKYS4K1U/hetE0MDyaCXwtRlwMOBPUVlM0/
 BUrqjdRopu7HKclcKTvEWrwS9FZRTvsF/kyy8gBoHzPhvI8ITHwgHmTovJrYjm85RFeR0BtCO2m
 4of8lyXIro3fKPj3P+9QDf8R9VJcsD8Z/MUoIWwet1JT8bvTczuOODenfBVqzJMWkdvqLR5dAhk
 FXXwyyIil3JPP3XaONET0yy5LDlcUotzu27xl0c12lMUD+TaO2OCLyDn9GpCCATYL8w8CZky6Df
 QRaKTI7x+pzAs0kdFOg==
X-Proofpoint-ORIG-GUID: EcCHqrCPo4oWIheH4-4tbQX_84t5qrSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230114

Hi Vaibhav,

Thanks for reviewing this patch. Please find my response below.

On 2026/06/19 11:44 AM, Vaibhav Jain wrote:
> Hi Amit,
> 
> Thanks for the patch and incorporating V3 review comments. Further
> review comments inline below:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> > documentation.
> >
> > The ioctl exposes host processor compatibility modes supported for
> > nested KVM guests on PowerPC systems. The documentation includes
> > comprehensive error code descriptions, structure field definitions
> > including the size field for forward compatibility, and KVM-specific
> > capability bit constants.
> >
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 47 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 52bbbb553ce1..ba6feba74d7d 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6553,6 +6553,53 @@ KVM_S390_KEYOP_SSKE
> >    Sets the storage key for the guest address ``guest_addr`` to the key
> >    specified in ``key``, returning the previous value in ``key``.
> >  
> > +4.145 KVM_PPC_GET_COMPAT_CAPS
> > +-----------------------------
> > +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> > +:Architectures: powerpc
> > +:Type: vm ioctl
> > +:Parameters: struct kvm_ppc_compat_caps (out)
> > +:Returns: 0 on success, negative value on failure
> > +
> > +Errors include:
> > +
> > +  ======== ============================================================
> > +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> > +           written to userspace
> > +  EINVAL   if the ``size`` field is smaller than the current structure
> > +           size, or if the backend implementation fails to retrieve or
> > +           map CPU compatibility capabilities
> > +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> > +           operation (e.g., on non-pseries platforms or when the
> > +           required KVM operations are not available)
> > +  ======== ============================================================
> > +
> > +IBM POWER system server-based processors provide a compatibility mode feature
> > +where an Nth generation processor can operate in modes consistent with earlier
> > +generations such as (N-1) and (N-2).
> > +
> > +This ioctl provides userspace with information about the CPU compatibility modes
> > +supported by the current host processor for booting the nested KVM guests on
> > +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> > +
> 
> Please add a detail on how returned 'size' field can be less than what
> the userspace has sent and how it should be handled.

Good point! However, with the suggested change from patch-1 (using
strict equality check `user_size != sizeof(host_caps)`, the returned
size will always equal what userspace sent, because we reject any size
mismatch with -EINVAL.

I'll update the documentation to clarify the strict size matching
behavior:

- Userspace must set size to sizeof(struct kvm_ppc_compat_caps) before
  the ioctl
- The kernel validates this with strict equality (!= check)
- Returns -EINVAL if size doesn't match
- On success, the returned size will always equal what was sent

This should eliminates the forward-compatibility scenario where returned
size could differ from sent size.

Thank,
Amit

> 
> > +::
> > +
> > +  struct kvm_ppc_compat_caps {
> > +	__u64	flags;			/* Reserved for future use */
> > +	__u64	size;			/* Size of this structure */
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +  };
> > +
> > +The ``compat_capabilities`` bit field describes the processor compatibility
> > +modes supported by the host. For example, the following bits indicate support
> > +for specific processor modes.
> > +
> > +::
> > +
> > +  KVM_PPC_COMPAT_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mode
> > +  KVM_PPC_COMPAT_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor mode
> > +  KVM_PPC_COMPAT_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor mode
> > +
> >  .. _kvm_run:
> >  
> >  5. The kvm_run structure
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> 
> -- 
> Cheers
> ~ Vaibhav

