Return-Path: <linuxppc-dev+bounces-20565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F171CD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 13:26:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBCh7088Xz2xQC;
	Thu, 07 May 2026 23:26:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778160390;
	cv=none; b=l+NTM50S3tPSc+JFANMyVVM8wGmwO90QZKHQL15SwoynysK74parSWSaZPutc7ZjCMTAHCzWLe/083PrtIW3cF/1wfjiKR8j8fumShNJdeUVN0laz9C12iumobBMb0NLUyKKlqF7rBEx4Uar3FQWYQFy52CBaOeGdXrOSrBJFosxf13yDeDQDlZDoxFoFjPyxCZ1Cl7CRaol6BP4wVKzK0WkuJPqvnXqct5fTfBAkn3hFCm3g0ooEkR7Qd2p0BU6ujaQov2DT3vl5txlsiYDWAdOowmNm+jdB11SunFTxhj7JA/AWxJZPxDjHWkXIVxdFFnCIQW1YAX/s82mbS9Z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778160390; c=relaxed/relaxed;
	bh=YrsIwPGSozTs0qDshooUyVAFjIFileoxrrcdpsFu3jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRNJ0rO9mMepfOfG/2vy8kxU8oHrsfLQGKiORI50gmclbt1sddOMDz4Z9RzHSL/PpzzFJrMkfJCO795m6qzJj1ltF4YYu7ITj9MmGvAXV5og7F8+vfAtI1ZPgiLNmKnKWAmL6eHqn2wbxkXZ2t81n8SmI6b1BwcRwWjtoFI13YoE/JldxOnJF6ONmUlt1jlCyp+s+2t8FQE3yofkfh44ZWxgDWPUavt803/QNN4PWdtlp159RQe1nWdBJavTE2pHf1FsSyLqzBOrYB788Ahsr4bK9QN9Oc1M56lXNpRFGpbdXiutroMQSex2tOEJut8YI5tD5gSl8nQgS65lkiD6eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBwb6lWN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBwb6lWN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBCh55wfnz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 23:26:29 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6476kcNs852737;
	Thu, 7 May 2026 13:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YrsIwPGSozTs0qDshooUyVAFjIFile
	oxrrcdpsFu3jc=; b=tBwb6lWNHxphDlwMTWlgeaUQu4sHyY4S6H4UzwixlRBIZj
	xO5ktEVUEyNN62cfad0G1Voufh3Fcw1q7LfpRJ7P/mfxyL7+bD/rRWDqWJrHOMJr
	KKJ2dXQZBeKKiYf+1T/DyX6GyChMZMeVaqjhx1a2STeN6Mf/FA0fUWR1kaBp1TRt
	tv2yjSHMBHPWflBnVb+WGDvg1BG0ujTul8KYksJlAtI/3hs3vN6VN6iNJBaNUusW
	Ot8+kCm6HlI/F1l/rf6TME6QTctwC0EhikrDLKPeY8nBD9E6jNpx5P230iewqY/u
	IAUNqWlDbgZ1qhq+AILCr4rpTMpV5NkX+GPenjPw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4wrfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:26:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647DOTSf001358;
	Thu, 7 May 2026 13:26:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk3qsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:26:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647DQ6tt36176154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 13:26:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6460D20040;
	Thu,  7 May 2026 13:26:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D120E20043;
	Thu,  7 May 2026 13:26:02 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.124.211.112])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 13:26:02 +0000 (GMT)
Date: Thu, 7 May 2026 18:55:57 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260507184929.5197d7b4-e4-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-2-amachhiw@linux.ibm.com>
 <0ca0e84a-ec56-428f-ac6a-22dd52ad4a1a@linux.ibm.com>
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
In-Reply-To: <0ca0e84a-ec56-428f-ac6a-22dd52ad4a1a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMSBTYWx0ZWRfX+4Xn5psHPomF
 AkqCrCChDRAqafxYCtJhTM6z7hEaEj3to3pXYLU0blvBA0VXbW7OCrFUZoJdkZuwmJQMgwO2t4W
 /9uK6tO0dhIFGtVK7KFf8Stg2gLii6dSWwpRU82Nx5r4PNxLOwqqreaym3XgD0zUnD5ep3bXka5
 nDJnzRxg3AT1oxc03oHRSp+3+7CHcVuyKNQWg2WbKkk1hENJJsWXFfUkYe9RGUOmA4kfklfVKvx
 X/tBtsTas6wpGRWci6ZL+j3dU2vjjjyrYUpAwpsTt51As75unWvqeeCA4f2cm7/uMDPOg9Zg8gh
 9cV1yd7HY+29YPMYJ3t7HHHYEWCe6xhbNQm/oYQecDTLx0aF9YA3aGQwOcH4bcoFtda9QXPtIAL
 NXDfcGu4BwenU0VSEe+Vwk8myNr6PB+jM7KBWrG9z33AyevmajM+JoZ3gWTwRRi1ydrtDo0Malo
 nk/cRzDMBgv5Tk5g5Nw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fc92f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=uYXa65u6JyZUx7HkiKsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: KhMse8iPlJ02IZRrliSN-BLN7lHmdG32
X-Proofpoint-ORIG-GUID: 1NDTBBT_KRpDT5t7eUaO75GnK_7H4tL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070131

Hi Harsh,

Thanks for looking at the series and your review. Please find my comments
inline.

On 2026/05/05 12:14 PM, Harsh Prateek Bora wrote:
> 
> 
> On 30/04/26 11:19 am, Amit Machhiwal wrote:
> > On IBM POWER systems, newer processor generations can operate in
> > compatibility modes corresponding to earlier generations. This becomes
> > relevant for nested virtualization, where nested KVM guests may need to
> > run with a specific processor compatibility level.
> > 
> > Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> > logical partition (L1) booted in Power10 compatibility mode, the guest
> > fails to boot while setting 'arch_compat'. This happens because the CPU
> > class is derived from the hardware PVR (via mfspr()), which reflects the
> > physical processor generation (Power11), rather than the effective
> > compatibility mode (Power10).
> > 
> > As a result, userspace may request a Power11 arch_compat for the L2
> > guest. However, the L1 partition, running in Power10 compatibility, has
> > only negotiated support up to Power10 with the Power Hypervisor (L0).
> > When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor
> > rejects the request, leading to a late guest boot failure:
> > 
> >    KVM-NESTEDv2: couldn't set guest wide elements
> >    [..KVM reg dump..]
> > 
> > This situation should be detected earlier. Rejecting unsupported
> > 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> > invalid H_SET_STATE hcall and provides a clearer failure mode.
> > 
> > Add a check to reject Power11 'arch_compat' requests when the host is
> > running in Power10 compatibility mode, returning -EINVAL early instead
> > of deferring the failure to the hypervisor.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3..948c6b099a29 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -446,7 +446,13 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >   			guest_pcr_bit = PCR_ARCH_300;
> >   			break;
> >   		case PVR_ARCH_31:
> > +			guest_pcr_bit = PCR_ARCH_31;
> > +			break;
> >   		case PVR_ARCH_31_P11:
> > +			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
> > +				cur_cpu_spec->pvr_value) {
> > +				return -EINVAL;
> > +			}
> 
> Is it possible to keep the check generic for applicable ISA versions (ISA
> 3.1 onwards?) instead of keeping it specific for P11 ?
> Also need to add a comment, why it's not applicable for older ISAs.

I believe the check is only required for ISA 3.1, the reason being that Power10
and Power11 share the same PCR value. For newer ISA versions, that might not
necessarily be the case. For any subsequent ISA versions, this check would
already be taken care of by the below check in kvmppc_set_arch_compat():

	if (guest_pcr_bit > host_pcr_bit)
		return -EINVAL;

Its mostly implicit but I'm okay to include a comment mentioning the same.

Thanks,
Amit

> 
> >   			guest_pcr_bit = PCR_ARCH_31;
> >   			break;
> >   		default:
> 

