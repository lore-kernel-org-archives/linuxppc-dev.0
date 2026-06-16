Return-Path: <linuxppc-dev+bounces-22715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE24CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:00:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfnCL0shYz2ykX;
	Tue, 16 Jun 2026 23:00:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781614814;
	cv=none; b=Ouu/Tthm5HO9fI+LaZiIxePqA7YQMkbFldXY0i6DfKndHZoFVDX+UVpvO/ybw+vRYCZGzvfvHy1W1XGE5aiAJpsr4UiFl4Dd59q39k9x4RJeZPm9wbFvN/fP6m3piXJCbeRrpeFKUHwXLcNFZFW2qU8oE0l+oAelxhoqdZE215WRYqypVOPHvmE/GDVRDbrwIEISuioTrfNxcFikW2qgDVk6XpqlyJ3iTb4UzjJ4z8JERs6neZ8N3ivcIuzZG0MOm7/ebHDRmZAewbPnCxf82q+QUjH7s+MULL/ux2bVpUKKjvwqo6HYgzdlx6Nc+pVPCKUoecWIjUWVrdeEkKuLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781614814; c=relaxed/relaxed;
	bh=o0OMGFCLWCHw+FRZ2MHpY20rhePg8t0ws3AIq6+7GZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/R8NB7Z6TX3O1/OILE5aGTzixswbnR39/c+XdtjoKsz+VRZOkHWLl+Jf5DNqHYQQiFp6gwAvTn2piFwHTKOWtrd5jcDevzZfJcGwpE6iMwb31O/Rk6fbHr1sxHgvCT5Xz2uSWRv6qVpWTyrSewg02/1bo7/qHBaM+pAEK9WPMoToqBgNLtQQIYLK4yvIo56f6c2joAmNU55TFa87rJKqv+YRko/dHKO+M/00Sn2Ml2vQXsS0GCzpBgOjB7rIyXvIplxSZgXfekNZQTgCibOMxq3pfsxnAcaq53+IjJNd7xCG44B7ai4k+AfVyHlNF7DWy+wI6GImwXszhWGaiehxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JE1tARRp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JE1tARRp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfnCJ6hXKz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 23:00:12 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIRnt1245517;
	Tue, 16 Jun 2026 13:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=o0OMGFCLWCHw+FRZ2MHpY20rhePg8t
	0ws3AIq6+7GZA=; b=JE1tARRpi3QXUdtr68hIO5rLIJ7ZEqnjHbYTN0Z/2iJFgb
	1RfRJ4Lxv4RYwLD04wrcSYsDYbTr90Q4C4lOQS4VWfHofzPMamBhBqobbHk6XEMB
	TKuraP8KdJ9nkVZCf7ByKR+Sc4XbH9DXxh88xNfzDLSx7etyj69DvtlUiwWdMv/c
	aSkSjSNvPUbqquTv47DE1bsd1UUqIBMXmsDqdB3e0XupMlJ+CZadcWQlyFqs3piK
	3+6ctJMJPHVgx3Pd2sSd/nwlPnKLPG1fBN+/b2qGBq6cr/iy2XbWeCawUmOmtgl8
	P6/27ApafysfkAKO2NJOfrLaZci6muqmsACHIIXw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nnp1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 13:00:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCna6T015445;
	Tue, 16 Jun 2026 13:00:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgb6je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 13:00:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCxxV961342028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:59:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5872E20040;
	Tue, 16 Jun 2026 12:59:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B0C520043;
	Tue, 16 Jun 2026 12:59:56 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 12:59:56 +0000 (GMT)
Date: Tue, 16 Jun 2026 18:29:56 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
 <cxxqerzk.ritesh.list@gmail.com>
 <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
 <a4suelh6.ritesh.list@gmail.com>
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
In-Reply-To: <a4suelh6.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a3148d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uf8v2oCiG3VMOCt4Q-kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX91vnwEwCtJy9
 4IDmOLTbE+y8DUPjvS36//3OY99p6DXjdNMpj71GkbEJSLhWpyfBZaqBzTFk6448A5YRj12ezWB
 R8yvr3Dg7VRm7IDBnV1rTJmt7D17ZSwnVN9oZVqalalgGnWmbwHBdabdX5L3h6zOIi34xhQndgm
 7R2LuqFmfLXWrrJay8AIY5eIOSzLbjrLebtTxSoKhkYeLicqQx5+hmiSyRTb2AFzWQgnZ7Ldi+n
 mEMXSL4w9vaNGHex7I/bv3fW4gHsURorq3xJDdWsx+FWnJn5WcsGqe5RO2C2zrqNMBtSfJz1SST
 Z8siC37jLCD9+JYFlDHU9/deo/9Gi80mvP8jPRkxo/ErTZVy0uSdxBbBnNXoj9qhRLy4LpraX08
 U/JzZRWY/PeD76SK2y5zSK/MB4vgBruQVitnI73vikp0rjlBl2qiCJXobgjg1Qj4JdX6g8b2Iqe
 53NCo8DqgnakOeNfDww==
X-Proofpoint-GUID: ML1oG-XSeM0TZNSTn72s47CE2A65pTRU
X-Proofpoint-ORIG-GUID: Dn8v-j0Ix4nd1NZLCwUYhSMQ33CJcsZf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfXzL3sb6EhLhtl
 NyeV+ZS55PCR5V300919uyvbwEaBO43taHIPEmcNfN+Kl6C5ooxFrXvseH2sT3kidUJ71qvmxsK
 3ixNM0siM3sUr6UKjiM50esUg5ICdhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160130

On 2026/06/16 05:38 PM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> >> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> >> > index 3449dd2b577d..7472b9522f71 100644
> >> > --- a/arch/powerpc/include/asm/reg.h
> >> > +++ b/arch/powerpc/include/asm/reg.h
> >> > @@ -1356,6 +1356,7 @@
> >> >  #define PVR_ARCH_300	0x0f000005
> >> >  #define PVR_ARCH_31	0x0f000006
> >> >  #define PVR_ARCH_31_P11	0x0f000007
> >> > +#define PVR_ARCH_INVALID	0xffffffff
> >> 
> >> Logical processor version is defined as part of the PAPR spec. We should
> >> ensure that this invalid PVR is also documented in the PAPR spec.
> >> 
> >> If you have already taken care of that, then please confirm and feel free to add:
> >
> > Regarding the PAPR specification documentation: The PAPR spec documents
> > the valid Processor Version Register (PVR) values for each processor
> > generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
> > PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
> > KVM implementation detail used internally to mark invalid compatibility
> > mode requests - it's not an architectural value that would be defined in
> > PAPR itself.
> >
> > The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
> > are documented in the kernel code and commit message.
> >
> 
> But that still worries me on what if PAPR wants to re-use this value for
> some other purpose in future. 

This is a valid concern about potential future conflicts with PAPR.
However, I'd like to point out that PAPR explicitly specifies:

  "The first byte of the logical processor version value shall be 0x0F."

Since PVR_ARCH_INVALID (0xffffffff) has a first byte of 0xFF, it's
explicitly outside the valid PAPR-defined range for logical PVR values.
This means there shouldn't be any risk of future conflict with PAPR
specifications.

Please let me know what you think about this?

Thanks,
Amit

> 
> BTW, thinking more about it, if we purely want this to be in kernel only,
> can we instead add, something like:
> 
>      bool kpvr_compat;   /* Does kernel supports this PVR */
> 
> rather than re-using & overloading arch_compat which has values that
> comes from PAPR spec?
> 
> Thoughts?
> 
> -ritesh

