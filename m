Return-Path: <linuxppc-dev+bounces-20952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71E3CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 10:05:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGQtv4vjJz2xy8;
	Thu, 14 May 2026 20:05:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778753127;
	cv=none; b=ek0jsZgwQclZaRLIJ9U45NDiu6uLcOJKHfCb1xjJH3PuGAX9yFVMG9oRBFVckPCnXB68N5otTG+va3tCjOPahL8sOxPbGdC+u3HRbTTafkrX7kSq0AKHAe6iqE3m7GBlTjv2gEn3KDRbq7p3JF9tVX3DPpbG1m5m5gYjAJTiXViwMNqfZHkqu7ZAsJPEIZa6ezK6dFlCRumyhWBHbMwB8qZjdKfdmlmbnyE1RaMmhnlIi+tx7pEeGWqYXovtbp43LEx+99DTzQ9n7VDT1Gyve9642YcPvEqHnZ1aKhPXfJQ/OKClUg+FpAVHqf/TGxNLqWX5Tw/pQ22RwEjAQqL2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778753127; c=relaxed/relaxed;
	bh=Af/BdJqD45t8qNOLx315vRMVFrP03JVrShiBq1i949A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo39e4A8hzM3DDSz0Qn+cjR5KYSI2dZkmTFTm5veCvr4tU/nac1mJlGxBOjn0NUB2tA2vIVzjshcoYw0ZGYC5wj3AADX5jrDKsJncjELfDZDMCiQ78bg+QuGaTQBJzRbJ5IRULIZdnM4/VWRJ/vWaKB3ijXiUfCmkIKeN5aqQuq/lpIkCV7LMuTtNIKxg5SAhGT5m/hsz+lj9LEPyB0sJ2c9i4C4I2KlOY827ZVTEuwjl5vBtBf8o/XDF9G8bz1J3r4w/6gHhI+bPe6nsgOeHscgfi7Q1b1pg46BWGPaSKUBdYClX1LBkUZORD/9csEr4VQjksF2AOzJ3Ej4PIlr/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TRwJYUiR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TRwJYUiR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGQtt2fGbz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 20:05:25 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6bNxr3773759;
	Thu, 14 May 2026 10:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Af/BdJqD45t8qNOLx315vRMVFrP03J
	VrShiBq1i949A=; b=TRwJYUiRt883EuwdI2JIPQrLychxHyIoCjmifxevnrR9Om
	1qPj9pTDCIJc2vFS3Op28hz4O7DDcoDgY3Yp29ggv9RcC76TsNMrluR6rL+QBGTP
	egpC9CTHfLFjbmQcuS+n9q2goqvZLJNkdJbinXo20+efUeYFYS6YjwjIC5+YSI7O
	BmfGJCH5E0kgruJ4PX3Du5C63loVZX0BXGSYq2yyTpMLJZLWV49RMITTcEgRdCw+
	YClY8i/N/4DkH9gtljpPafAjdpT4wIAnsemoHznDHGXaR0oibdc3aeUp2Jucm3uG
	7Y6RvNavxhbD+iucYzN13lHRbYLP1lJMa/42R9GA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6ubr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:05:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64E9safm006877;
	Thu, 14 May 2026 10:05:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfh3w5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:05:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EA57gC49021370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 10:05:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4F7020067;
	Thu, 14 May 2026 10:05:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C34B920063;
	Thu, 14 May 2026 10:05:03 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.209.153])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 May 2026 10:05:03 +0000 (GMT)
Date: Thu, 14 May 2026 15:34:58 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] KVM: PPC: Handle CPU compatibility mode for
 nested guests
Message-ID: <20260514151719.b7ea3fdd-9b-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
 <o6iir82o.ritesh.list@gmail.com>
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
In-Reply-To: <o6iir82o.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a059e58 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=i22HGULVa775TzVH9QoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5NSBTYWx0ZWRfX918kfqsQK0XT
 fQqlTF2/LIFYk8ExLBawLpcm4t4wXs8AkLFlxbdlNQEcBD7eCWVT1lgUhhUqxoX4NwZIew2uQuS
 W+D6qCdBSjUv8X8mViguKluejCRHqzqP/2gs1E5OX1vpgadmDmNZLtViLobZH9GGF3o0wiszLCk
 esYh6An9EccbFhjN2neQQpaTarwIdaUq93aM2KEedj7mNoGBgCrVnVDXy7WXs9DGMSecmR+5ZaB
 +ICQL9T3qnpHEteApyH9ZhLHBQzJK3RtO70/fm0DaLqEKK2bKBLWVtKRNIxEnhHUvgFrQEWNd6C
 QT2cykrqq81znxY+h2mA28TZzlRRzNU8HZRaFP3Vn26sJfWh7YN9nVDC6BdpSG3jsF7EIxuef0b
 +/RPvFA/npwBqg3Ico5x2w6gqNmwNR6QJgLH5djXZ181GadCbcyfcZ7Au6Uuq8dLe0fo5v9zBY5
 wV4AFBbbm9fJW42Rz2g==
X-Proofpoint-GUID: mWigg6i4TIUXe3RphRc177hdpIWcF7QH
X-Proofpoint-ORIG-GUID: OCds5ZSKTFOuOWVRRk572-yCfhIyWWJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140095

Hi Ritesh,

Thanks for taking a look at this series. Please find my comment inline below:

On 2026/05/14 08:49 AM, Ritesh Harjani wrote:
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
> > This series addresses the issue in two steps:
> >
> > 1. Detect and reject invalid compatibility requests early in KVM to avoid
> >    late failures.
> >
> > 2. Provide a mechanism for userspace to query the effective CPU
> >    compatibility modes supported by the host, so it can select an
> >    appropriate CPU model for nested guests.
> >
>
> Do we really need to add a uapi change for this? Tools like Qemu can
> read the device tree info of the host, isn't it?

While cpu-version is available in /proc/device-tree/cpus/<cpu#>/cpu-version on
both L1 booted on PowerNV and PowerVM LPARs, I believe the UAPI change is still
preferable for several reasons:

1. We would want to rely on the capabilities negotiated with pHYP (L0) in KVM on
   PowerVM case instead of device tree property. Also, the cpu-version property
   only depicts the current compat mode host (L1) is booted in but doesn't
   really point to what all compat modes are supported for the nested guest
   (L2).

2. procfs dependency: Not all systems run with procfs enabled (CONFIG_PROC_FS is
   optional). For example, minimal configurations (like buildroot) might disable
   it. The KVM ioctl works regardless of procfs availability since it accesses
   kernel data structures directly.

3. Kernel validation: The kernel validates and normalizes the compatibility
   information. For example, patch 1 adds validation logic that rejects invalid
   compatibility requests early. The ioctl ensures userspace gets validated,
   consistent data.

4. Abstraction & stability: While /proc/device-tree works today, it's an
   implementation detail. The UAPI provides a stable interface that won't break
   if the underlying mechanism changes.

5. Semantic clarity: KVM_PPC_GET_COMPAT_CAPS clearly expresses what
   compatibility modes can I use for KVM guests vs. parsing device tree which
   requires understanding the semantic meaning of cpu-version.

>
> > To achieve this, the series introduces a new KVM capability and ioctl
> > (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> > compatibility modes supported by the host.
> >
> > The implementation supports both:
> >
> >   - PowerVM (nested API v2), where compatibility information is obtained
> >     via the H_GUEST_GET_CAPABILITIES hypercall.
> >   - PowerNV (nested API v1), where compatibility is derived from the device
> >     tree ("cpu-version") representing the effective processor compatibility
> >     level.
> 
> See there you go, for PowerNV if this info is provided in the device
> tree, then Qemu could as well just read that info, no?
>
> ... yup, kvmppc_read_int_dt() can do that I guess.
> 
> So, my request is, can we look into this to see, if there is a possible
> alternative to this? maybe we already have a mechanism which Qemu could
> use to get this info already?

You're right that QEMU could read the device tree from procfs. We had discussed
this approach internally as well. However, we believe the UAPI approach offers
additional benefits and looks more robust and future proof as outlined above.

> 
> btw - I haven't given a full read of the patch series, but reading the
> cover letter, I felt  we should atleast add this info to the cover
> letter on, why a uapi change is really needed here, why can't the
> existing alternatives work for us.

I have described above why we did the UAPI change for the approach followed in
this series. Could you please suggest what else can be added?

Thanks,
Amit

> -ritesh
> 
> >
> > This allows userspace (e.g., QEMU) to select a CPU model consistent with
> > the host compatibility mode, avoiding mismatches and enabling successful
> > nested guest boot.
> >

