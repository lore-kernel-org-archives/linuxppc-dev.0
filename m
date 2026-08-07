Return-Path: <linuxppc-dev+bounces-25569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAEBC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:08:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGjb65kcGz3c4D;
	Fri, 07 Aug 2026 22:08:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786104482;
	cv=none; b=BiqRanrkZmDYiWnimF4BgK9olfMWEm9Mvjbx1EG9lns0O5mItdGy46yXKQRxJXNUYGo2r8DoxTDDKI5QKg9DA85/UgIi4G9GH7xqgvJwmcMxa6gC811ObTbib2TacJRQPZ9AnwNhcgwKRA15ym2GKVuahmulR8nPAqBLoJBC4+Z5ajMma8qmwTLeYbYbfo82pA+pcEMaOE9IT5KkI5vSm5r2smJ75u3vCX5ZNFZKeCKFq7JOZHJOgLNRDDyqX5lpz32V/89llB14mwf0HpZPvUxu4gh+BdwfV/x6BoS9vhH2lk2ui2FTiCt7FhL7DDbxjghoSWv5Kd7s9K/7gYvnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786104482; c=relaxed/relaxed;
	bh=BfZRbETEo3DVte5hEdWjaM9qnh99mmSlCn36/NdyqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njxVCs3v1eLo5r76/ajcC10eweyk5PX/wzWg35BOQ2c7iCSaD74UnUoO7NuXV5m5083z19vMC6WmtXH3Eude2ljlKYhX1R9EUPxKj8Hk2eEysWh1eiEnAZ6jenGuIGq8dXmOwZEWCH1aQnhL5e9nJvkaYN/e+hatvQxHrL7ENpJlFKSmONF7C5zabyxkR4pzDvdYNzESOfthfOGYE+5/iPo7YRcV79F7s722fCH5wJFk7wnUe7cbzPdxk64qcqo88Sk2sEqKVlj7mM3Vmry7wFDv4MdL0aJZfvqZ1cMxkJ2cl//0wUwSGOE6M9qjeecKmN2CUMY4vCTwCWZ3YViL+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e2KVrDgm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e2KVrDgm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGjb564cXz3c3v
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 22:08:01 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770I3pK4135292;
	Fri, 7 Aug 2026 12:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BfZRbE
	TEo3DVte5hEdWjaM9qnh99mmSlCn36/NdyqnE=; b=e2KVrDgmyXUj3ITOJZZVoc
	tkCcCfJsPng8Iksgk3JXSEKilFeIH9+BL8rcFHETI65BBLAFfoznMb3QIDiLLuGW
	Ow74hTlp+izJpHd8XohBTbuw84+8eebYAsx374GWegeah7SAWGfr3ViyAE6+OGQD
	gMUG600PPl2Iv2JOGzBGIOA/zmUP5ZFY4sY7wIaX1wUAkhy39sKNChv6cw1TklbX
	v5F37/ZEkTkr3qGaVbU8wuYS6CQgOcvyrJhzsFT6PhqvLkw3no9w/uHcWMNL0Yue
	mteztkhQipmwKiKgZ1QUsU5aF7SoESII/mBYz/HSFvta1dLbvSBQY65vReh6RJVA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043rb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:07:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BuJDq029357;
	Fri, 7 Aug 2026 12:07:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kfknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:07:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677C7icQ52494812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:07:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 737552004D;
	Fri,  7 Aug 2026 12:07:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210FD20043;
	Fri,  7 Aug 2026 12:07:41 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 12:07:40 +0000 (GMT)
Date: Fri, 7 Aug 2026 17:37:47 +0530
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
Subject: Re: [PATCH v7 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Message-ID: <20260807170704.3280f54c-e2-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-4-amachhiw@linux.ibm.com>
 <bjbeledh.ritesh.list@gmail.com>
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
In-Reply-To: <bjbeledh.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX5TzLKCqXDqZu
 b6BiRef/oECz9G4XMeWgvA3fRyFHPyA4v0D6/QI66iMXht8JO4WINYvKcNOhEt85PpoV8J2a4Ey
 Ep62KKeD9up0soUyfqq97/Agaf+ofRa9IAov4qPkmW8kgpr6EEtPAH5c6kcuAh74iZzDDOJmfiw
 C11ETLzDAv+8v9CtmCVrYaKj/QlvcE4W8bduXqN9iShbOpd4pClixHWB4PA12rRgbuCLdAIu8D9
 4Z8wFDrEWPiLRjfOvIESpnxmdR40/39S/fjIXGWrDvVVIiwiWcl4SMnOXHNjJOMEdRM/nDnA/+K
 Z/pWhxnM6K6B+XOC8jgpDsop0AFKnexR9tZOtzY/6HJk7vOVEdTKdNFhMjNo8mRDoNfSJiFRtCU
 y3vQhfWTQjN91c/lpMkAm8VJltSo3Wwc5TxsVSNZvL4f0/Rzr+cgdRkj4srds+m25/GP6hJLDY6
 pymDQfkM1f/vH/29dhQ==
X-Proofpoint-ORIG-GUID: ERwgD-8BR_5ciBrCIKEi1d0ZZbgjqrpg
X-Proofpoint-GUID: CGhTxUgT4QzOkim8g4v8w8QZtS1Ros_H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX5fEiy5kiu5dz
 /9UUwCHcAhK6LahuHI127uI9T+aO2PrM3naXuobCTQWLYO3zlX3oofWQNlmvzDD1esHQHSrWOFw
 flOx3ORG5JleaUuuz9TdTzA5Mb/G1WA=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75ca96 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=H9A0j7aUrpR-r5edhhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070091

On 2026/08/07 10:24 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:

<snip>

> >  
> >  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> >  {
> > +	struct device_node *np;
> >  	unsigned long capabilities = 0;
> >  	long rc = -EINVAL;
> > +	u32 cpu_version = 0;
> >  
> >  	if (kvmhv_on_pseries()) {
> >  		if (kvmhv_is_nestedv2()) {
> >  			WARN_ON_ONCE(!nested_capabilities);
> >  			capabilities = nested_capabilities;
> >  			rc = 0;
> > +		} else {
> > +			for_each_node_by_type(np, "cpu") {
> > +				if (!of_property_read_u32(np, "cpu-version",
> > +							  &cpu_version)) {
> > +					of_node_put(np);
> > +					break;
> > +				}
> > +			}
> 
> What happens when we don't have "cpu-version" DT property?
> Check this commit
> 5a61ef74f269f2 ("powerpc/64s: Support new device tree binding for discovering CPU features")
> 
> And also why do we need to parse the DT properties again?
> Shouldn't we check something like this?
> 
> 	if (cpu_has_feature(CPU_FTR_P11_PVR))
> 		capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
> 	if (cpu_has_feature(CPU_FTR_ARCH_31))
> 		capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
> 	if (cpu_has_feature(CPU_FTR_ARCH_300))
> 		capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
> 	

Thanks for the suggestion, Ritesh! After closer analysis, cpu_has_feature()
would give the same result on pseries, but I believe that using 'cpu-version'
directly is both more correct and more explicit for this context.

Here's why:

1. 'ibm,powerpc-cpu-features' / dt-cpu-ftrs is baremetal (powernv/OPAL) only.
   SLOF firmware used by pseries guests never provides that node. On pseries,
   dt_cpu_ftrs_in_use() is always false, and CPU feature bits including
   CPU_FTR_ARCH_300, CPU_FTR_ARCH_31, CPU_FTR_P11_PVR are set by identify_cpu()
   from the cpu-version DT property at prom.c:423:

     if (!dt_cpu_ftrs_in_use()) {
         prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
         if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000) {
             identify_cpu(0, be32_to_cpup(prop));

   So cpu_has_feature() on pseries is just an indirect readback of what
   identify_cpu() already derived from 'cpu-version' — the source of truth is
   still cpu-version.

2. Commit e4de1b9cb3b5 ("powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11
   and later processors") explicitly documents this split:

     "This issue does not affect pseries guests, where SLOF firmware
      does not provide this node, causing the kernel to fall back to
      the traditional cputable path (identify_cpu) which correctly
      sets CPU_FTR_P11_PVR during PVR-based CPU identification."

   That fix was needed on powernv only — and our code is in the
   kvmhv_on_pseries() branch, so the dt-cpu-ftrs path is never taken.

3. 'cpu-version' is the PAPR-defined compat level indicator — it is what PHYP
   and QEMU explicitly set to communicate the negotiated compat mode. Reading it
   directly is semantically correct: we are reporting the compat level the
   hypervisor advertised, not a kernel-internal feature bit derived from it.

I also responded to a similar concern from Sashiko covering points 1 and 3 here:

  https://lore.kernel.org/all/20260806214117.8a2ca150-97-amachhiw@linux.ibm.com/

So I'd prefer to keep the direct cpu-version lookup.

Thanks,
Amit


