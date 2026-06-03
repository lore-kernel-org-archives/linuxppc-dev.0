Return-Path: <linuxppc-dev+bounces-21980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A48BCD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 14:26:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVqkl69Qqz2ySJ;
	Thu, 04 Jun 2026 00:26:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780496783;
	cv=none; b=KwXmdvRIUUxUizHx1R9QlwlYbf2zaE9Bfkcq+ebVpRhctnE2weJTtePlq8QPpreUKnST7Ell/u3pOVfV9eKzPgawPBGC3hhoqE+vivmb98TADL5LflBxk52JU2L/Cg9JirCacviSKrF3GA8UysSRM2IzT6GS3BFeDvei64Acvlcexbj44fGcV5NCSZk6sIpgOdTdohvEDvcJk+dL8zGm0YADvUT50ei+QXdJyMGL/GGXU+Xpj3Hu/kR807g2KuKBAWPP+whuLs3us7JLRbUWVe0xoBCK+1WUuIqkMmPxx5jAZi3M1Qa3Q3U50dEaJN26bqoSGjmjRDiPOPhZWpsjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780496783; c=relaxed/relaxed;
	bh=D3c3qVzMqoLf/cC8c1yv2aX8V7QliPT1+YNIojfmBbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up4OFSkpSMEcGb96+W1WIvKeVjjftLE6Ebi3eeA8Z/vkLtAZiHgi2O/G1HxK03e3YANcm3KjUJTmREIkWwkFYn/aX4fSRIiNW7iIcYtyydSt5lQdIvmP33OKXCAvL/V92h0ICFFjg15ZImg4sj8t3y3zHcGOko0LY/hFYHsqrtxguPLVbOgzhIEcvjRy4O5pEigxY5yaAEsf+wKEcSIzzUVYwuk6KwQhn8rBV3juSiBqb55tqT8aJ3wCWCvZHnWHbncDZOsANbCUu9ifihDJxQKtzOXtrH1ABfp6OHIOjdUs/UJYgp30Ce2qEAQW0EOORB4gTwtv+QLy4L2OQm13ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ouwwIeFA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ouwwIeFA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVqkl0B29z2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 00:26:22 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6538OBOc1640981;
	Wed, 3 Jun 2026 14:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D3c3qVzMqoLf/cC8c1yv2aX8V7QliP
	T1+YNIojfmBbU=; b=ouwwIeFAXd+ijIDnWrcJNMyYcdSVa4q/v5UPwwfVzOcmmA
	V/pj5lB9Z1EyTAUe6LSNdvrgE7Kpfqovjj31KHmiTPk+wpD5zmwsZOda5KxTF9xa
	J+dF/KNx5FYzilBnFoUyQtMjr2VyiTDLgT4uDKQchcbY3QVH476VzpYlXkDKyWtO
	XrnJeXW3Cgtn6zTd6p5Rmg/33ANs1ZspQ8nB4IEeOgO5SF9ERA+XO45fN0qxOBMJ
	oyXGLBKENWA2EFElZMvfIdP1yytgFk4K7sQuvhqPMEWJmVIOZx5x84MPTCtdspFL
	nst6KRrVNhrJCNPvESqz90cBHTiGCY1ffygFcRtg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahtyrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 14:26:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653EPECu010968;
	Wed, 3 Jun 2026 14:26:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qgr1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 14:26:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653EQ5Lj51511648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 14:26:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A7B2004B;
	Wed,  3 Jun 2026 14:26:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3644F20040;
	Wed,  3 Jun 2026 14:26:02 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jun 2026 14:26:02 +0000 (GMT)
Date: Wed, 3 Jun 2026 19:56:00 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260603194919.ca2d31c0-17-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-2-amachhiw@linux.ibm.com>
 <pl2g6xbz.ritesh.list@gmail.com>
 <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
 <cxyewhx8.ritesh.list@gmail.com>
 <87se74z4a6.fsf@vajain21.in.ibm.com>
 <72ef4cdb-8d9e-4319-9c94-b9a46a6f6194@linux.ibm.com>
 <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
 <bjdsw43g.ritesh.list@gmail.com>
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
In-Reply-To: <bjdsw43g.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNiBTYWx0ZWRfX/QwTJz03YvEm
 tnycR05KaAFcuOcNHpoejZ6IIh+UigfTilSwx5QMy4TR/fb3T3nnsdjCkScPevJC7iq8kg7o/Ib
 BZOdVVIAQSEWsTLbm5JkibeEbyY76YvNycOZ1AbXrDCcXWoLRmyyNVeESjK1hwxv8iicqccho6q
 bw0M2elmleS2YzLqa+ooJEStZ1HERkg7kWJn9VQFC5xfpnmIxXKLA+zay9XlzSz4/1E7vSzr3uy
 rX4jTxMpp/ouvk2B4lAc6WYNDnjslQK+K8fvacktm78OV1NnZ97PzPE6lyEQPS/ynzJ6TSYuHZX
 UxU3oScsqwa/3xR1Gp3Sxy8dEjZq3M/Vd6eppK/2QAHRYkaoNkZNn7aLf2YtDK2Fi26PhIHAj0x
 cSKIE/Seck6pW5M+8det4XBtpkAumePRM6utxRT0J8Gw2uA4Y0kZEpWrK1txc42FAATyH2M7Zua
 iCAt4hj+s+3OIeGb8rw==
X-Proofpoint-ORIG-GUID: tLYlDXtEPf68UXX27itDkXR-54AXc34Z
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a203982 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tBi8NAT1RsUeDLHYQY8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: GLiYH9xarfqBmBAlgsiXZLR5YM2sYABO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030136

Hi Maddy, Ritesh,

I have made the suggested changes and posted the separate patch here:

 https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/

<..snip..>

> > Hence IMHO, this patch can be marked for stable tree and potential
> > candidate for 7.2 merge window. But dont see applicability of a 'fixes'
> > tag to this patch
> 
> I agree, we need not use a fixes tag then. So, we shall mark this
> with v6.10 tag then.
> 
> Cc: stable@vger.kernel.org # v6.10+

Please note that I have marked the patch for stable v6.13+ as the KVM
support for Power11 was added via 96e266e3bcd6 ("KVM: PPC: Book3S HV:
Add Power11 capability support for Nested PAPR guests"). Also, this
commit had introduced CPU_FTR_P11_PVR on which the compat PVR check in
the patch is based on.

Thanks,
Amit

