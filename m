Return-Path: <linuxppc-dev+bounces-20572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73634CD3439
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 15:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBGCh62RTz2xQC;
	Fri, 08 May 2026 01:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778167232;
	cv=none; b=j71J4JHuRAZIm3nEA/iJbuesO2JAUQSIXB7w2pEcxEMEdtCQHy2qz0v9xGQ8YqB7aOIFB/ovrb0msjG+f7fZdlz1FKgWzacu4B65u3aGdjWD5MmPv0pe4ujCG3IQuwnnz90XFlDZyIi8KBfSkfEChZ+Nqei9p+5/maE9ndZJRFYdxLSYv4cWukYc1P+oFWBhH9ibYyo5Q0mfJG3Pbcn9aaceT9meCfVVJbfGVeEgCR3IMkDKO1UmGCL8oUPacYxu8uT/UyweFsGK8grdBlAMxmHaKXe0pmBKkDFMZ0qU5D24pk4d5qZ+qEsUMMtMfZK41e1OlDWWGX+AlINP6rFE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778167232; c=relaxed/relaxed;
	bh=Mq0oQliX2jfdvzCuQTD+5Vg1x+CebNs1jWtDlDkyf9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH62X0cd+XYz6hjTOMx5JtQIvxE4jvW8c/c+o+KY2v/JEEGXi/kDw9WzzXV9lK7d/hF8LF/Sdt8abNZCqJXnpNsIAsVTvav0sUvUKzSN8Xa7/B/axqC5ghxlWxHe+H5Vlm7jvYmbBT4oqjmt0N796nud/U6+WRMmW9QSsJpoAZB2IG4ZrPnFC61PhkFWomwuMJ2DA36VmSQRJF5aNdHJlAREfQa1KCaQMuuvaP6LqmB4PvKgnKNHJ/9MROS3ZeSC7BVITVX8wBfA6nMUUsYKVkcCDQyG9n2m7IbfeLbEyLzbc5MIzapn45Zw8MgesJbSIr9sOglsKWK16mQWwCRu7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QsOKyDWB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QsOKyDWB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBGCg5vrVz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 01:20:31 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647CF1Jt2437018;
	Thu, 7 May 2026 15:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mq0oQl
	iX2jfdvzCuQTD+5Vg1x+CebNs1jWtDlDkyf9c=; b=QsOKyDWBo2DgVvbJwJFTvo
	N1YD4raN7oP6qSi43KgfPP9CN/lORvc6rux7rvux8HXMM4SrjOkgJ50y3IH3MU7+
	Z1mdo+esIxV3XbacZuDhCdope2yvgWBQfXtJSGPBMkagK3uNNOZ3bj7+CS2FZY+U
	zJbcDLOb/xPu7w5YwfMFkfcRy9VcFV0NPMjXgWol2W7BZSCdoK0u02gGny9W5zYm
	eEmBCkgMo6X676HKsGzHt9zXi+Sbma1CKBq5tboVBhxeIEr6bH5L42611cqRKUGz
	Bs2kJNpTLa9aehYwU//fPuNFOszPvHEa2AX1SvWvWGvg/hDmlwQRjWmR3ZaFMQJQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1qaah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 15:20:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647F9Qk8024468;
	Thu, 7 May 2026 15:20:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqmd1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 15:20:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647FKO9k30147046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 15:20:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA9520043;
	Thu,  7 May 2026 15:20:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD2E22004B;
	Thu,  7 May 2026 15:20:20 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.124.211.112])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 15:20:20 +0000 (GMT)
Date: Thu, 7 May 2026 20:50:17 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260507204149.593a749a-e7-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-7-amachhiw@linux.ibm.com>
 <81b9d00f-7568-4bcd-9b77-2f6de3162d65@linux.ibm.com>
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
In-Reply-To: <81b9d00f-7568-4bcd-9b77-2f6de3162d65@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _GRVGeuooRgFfRFu6BAqMzxBWdIDt1nG
X-Proofpoint-GUID: _GRVGeuooRgFfRFu6BAqMzxBWdIDt1nG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MSBTYWx0ZWRfX5Nx4Y81I/MKJ
 4VKZR+UY3eS13OOhySHiskovVwSRk/B1X9sKCCbkYjs+C8NaNCgGjS4TSds1mDHK7YFb05EV2mK
 BUOyG4MXNLfVdacy6aaCfumKT/XXbD7cg+Mlu8TVAFsUGBeP6PW6/J8Vu68c3/QHoRoUS6Rzltt
 WPhUng8P52MyHOVjuUSghsmMogmhActU7tK6t6QCjeucBe+GTM7CxbyfcjYSYuRAb53k6sNCPKf
 Iq7KIKZE+vEE4z8/TysitOMLAk/iVNSnnsqmN4UUoWKga+zR+NRqM6INlnu//wX8zQw2gFnxGjU
 l4bY/RHvgu8mnM8cnP7Kmzerg8j70Yo5eh2iFlRP/5PiyBeJHXHzEGfnIdm5iyThXq0l0HrySdy
 +FMRMAOfmbGYlDuH5bze8uECvVodizO+G2rLuKE6YrnHwIfu4wF2Xle/BgIx2rrMw0TZm1A+Mbt
 lQIwz3ETTMc6vwuG4XA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fcadbc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qrTcMcv5DQrz4xUTKAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070151

On 2026/05/05 03:25 PM, Harsh Prateek Bora wrote:
> 
> 
> On 30/04/26 11:19 am, Amit Machhiwal wrote:
> > Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> > documentation.
> > 
> > The ioctl exposes host processor compatibility modes supported for
> > nested KVM guests on PowerPC systems.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   Documentation/virt/kvm/api.rst | 35 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 52bbbb553ce1..7a10c3c6cbf1 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
> >   .. _kvm_run:
> > +4.145 KVM_PPC_GET_COMPAT_CAPS
> > +-----------------------------
> > +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> > +:Architectures: powerpc
> > +:Type: vm ioctl
> > +:Parameters: struct kvm_ppc_compat_caps (out)
> > +:Returns:
> > +	0 on successful completion,
> > +	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written
> 
> -EINVAL also needs to be documented?

We do not currently return -EINVAL for this ioctl, so I did not document it. As
implemented, the only explicit error documented here is -EFAULT when struct
kvm_ppc_compat_caps cannot be written. Please let me know if I am missing a case
where -EINVAL should be returned.

> 
> > +
> > +IBM POWER system server-based processors provide a compatibility mode feature
> > +where an Nth generation processor can operate in modes consistent with earlier
> > +generations such as (N-1) and (N-2).
> > +
> > +This ioctl provides userspace with information about the CPU compatibility modes
> > +supported by the current host processor for booting the nested KVM guests on
> > +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> > +
> > +::
> > +
> > +  struct kvm_ppc_compat_caps {
> > +         __u32   flags;
> > +         __u64   compat_capabilities;    /* Capabilities supported by the host */
> > +  };
> > +
> > +The ``compat_capabilities`` bit field describes the processor compatibility
> > +modes supported by the host. For example, the following bits indicate support
> > +for specific processor modes.
> > +
> > +::
> > +
> > + bit 1: KVM guests can run in Power9 processor mode
> > + bit 2: KVM guests can run in Power10 processor mode
> > + bit 3: KVM guests can run in Power11 processor mode
> 
> May be use H_GUEST_CAP_POWER9 and friends ?

I used the bit descriptions directly since this is documenting the uAPI bitmap
layout, which felt clearer for userspace than using only H_GUEST_CAP_POWER9 and
friends. But I’m happy to mention those macros as well if you think that
improves clarity.

Thanks again for reviewing the series. I will wait a little longer for any
further feedback before posting v2.

Thanks,
Amit

> 
> > +
> >   5. The kvm_run structure
> >   ========================
> 

