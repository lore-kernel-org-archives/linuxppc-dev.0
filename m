Return-Path: <linuxppc-dev+bounces-27489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECA2C982C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlMcf1SFyz2xlY;
	Thu, 17 Sep 2026 01:04:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789571090;
	cv=none; b=RJay9t8U4ZUmAySW6Q7wdmArID8BkJaWxXPCFWn1EBctrehFEWmxIU18KNBjLkUJJKRzTo2NpkUcH/Rwih5eHwZM+aInoTJwct9jU5h/VHWFhrdzYEA2i5hDB7j6kn30pMko7vH+bbjnHXobyicsA1Ek56nVwberVtjbNfSI2BYTDQVa9DSTC6sQ30G4KjnLjGaYcbqORdyVtbTfOyVUPpuFy61r3Sm0+uvRQgQHtobRO9wuRzRTY7d6Al4HguVKp7L3PB/zDIbPkiIQnha0O/065VcvqqC7d148St4GM+245OHbhC256asD2OZ9bwycqPTw5/KgkDFECEV40h6pTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789571090; c=relaxed/relaxed;
	bh=N0tUu17lG62G5Z5DbG3BitLoWJBNZ0QhlSPYp+Pbogc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1u1Zx3LSwg23Xkl2reO1Y9BPFsOlYQS+F6aw+9XPA8s31n/aUR/dByezOtAzCDtNAFSkMwJZl2eiYfoZt3DaLbxqLJ9yOLEgA+ztnM+QShipLOG2861CKARgaeKRkBYHLL03uZaWLG8aDcm1MUT1KrVVq05ZG0U5yu74V3/osXznyQOwR4PvPOaWFo1LduW1AJ893y9JgXFayAQWufRJy3p9MgET21H/QekDbszUvqNRvdqg5NdJ23boPCRVlGzfH8sLWBXNvX0EYLTxNtdI45fdBb1fyin3EW2goGD+kybuV8GD0aacjAuPpoaACM9707xL9M+2UjbBLb3nRe9TQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TwVeJyLi; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TwVeJyLi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlMcc4VdZz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 01:04:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEW1JV2848668;
	Wed, 16 Sep 2026 15:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N0tUu17lG62G5Z5DbG3BitLoWJBNZ0
	QhlSPYp+Pbogc=; b=TwVeJyLiXJkao/qBh2KNYtRcJD3e9mzgfNjWFz2SEUw8z/
	z/rhOdsdWZ/OpexRGgBqCGQZ0HaUDtZSnnVpjRNGmJXav7iLt1EzlXHR3eDu4vco
	stdCf/9J5bQ0FwvfPtdLpXFepFh529Us/M0ZI483l8vlbR0he2e4SmgidTqq2MHY
	EAomGOhqbTkUpnmrahJ54hFLArt/xSQxUxZp0PtCnBSfjEE/Ek3g4cELZqWr45o9
	VU0ymSrlqhpbcQRLkOWrLDlFfG1C2rS9NZ25cj+sNm+qM+d0PXXm8XmT6iOtdtJ8
	+PgW/JZ3O7rhl5umpht3pV+ChrWbmWEVQz41hBkA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e50ha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:04:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEa9tU2520715;
	Wed, 16 Sep 2026 15:04:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d7ed0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:04:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GF4VJ653215664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:04:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A51520040;
	Wed, 16 Sep 2026 15:04:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7097B20043;
	Wed, 16 Sep 2026 15:04:29 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 15:04:29 +0000 (GMT)
Date: Wed, 16 Sep 2026 20:42:15 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Free the queue pages in error path
Message-ID: <20260916203756.b91f68b1-db-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	ritesh.list@gmail.com, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916111210.1982-1-gautam@linux.ibm.com>
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
In-Reply-To: <20260916111210.1982-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfXyKA8Du4JSENa
 SXz+rd1Uwuw7tUewkfc+dQNxfSk0naBu6GwB2YcPHxSdG6+HyTjOydbimC02siOb+n36avWDLZ7
 MMluVx+vn8ud83MtAW1d8P+gJzITYRtYzSPHESgrT4GawzlTSoWvd0NmnFTek6d0gqtJkxsJ5Wj
 9HpuXxLK1OT7trCHpAjeLHbh7eV9QqTmOoBbc02a5BEUs0BbXWh2jhTnFp81KMM1jhIBD7uvMCX
 p09DMgMZusJVYtcycj8tzXx1q9D32n2zYqYJ57l/bJ/8whNITQBXtLwaXex+cIn3yTMSoNg/WL1
 HDKGeRj6d7KN35fQGKnKAWjeOYuaha6Pz32vwh7c/Im0mUbRvFlCpTg8/qbJPvyq3q+NrRDrpYo
 7tQq/qyqSSL8i/U3S3nHiXJUC7T7lhjffX80MwHX5njzzn/wXWhNkYhR6NFwfjGP5dguFSxEe8P
 uzR2GKQEos41B7FBj2g==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaab004 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=nNpDWInLOLAhFrY20doA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Feya2zTqiceHodv0SiCkVJAt_hIjLdSA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfXxFEMHiwRyfzM
 H4AxHUtz6mGXDRGX8UxBCYcQJx5c4FX20g9fUt/S08Vp0IobaE+Gj+3db1gKaDKh+S4ATt72750
 QYNr8whFowHbRPjt5kuhDJyWYdPnvXA=
X-Proofpoint-GUID: tnW4Yiw5t04BE3UFSWRqQYBvJoDvgjUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160204

On 2026/09/16 04:42 PM, Gautam Menghani wrote:
> If the xive_native_configure_queue() call fails, the qpage allocated is
> not freed, which results in wasted memory. Fix this by freeing the qpage
> in the error path.
> 
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_xive.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> index 1d67237783b7..6f8648d9302b 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -961,9 +961,11 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
>  	 */
>  	rc = xive_native_configure_queue(xc->vp_id, q, prio, qpage,
>  					 xive->q_order, true);
> -	if (rc)
> +	if (rc) {
> +		free_pages((unsigned long)qpage, xive->q_page_order);
>  		pr_err("Failed to configure queue %d for VCPU %d\n",
>  		       prio, xc->server_num);

Fix looks correct.  xive_native_configure_queue() only sets q->qpage on success,
so without this fix the cleanup path in kvmppc_xive_cleanup_vcpu() would never
reclaim the pages.  The use of q_page_order for freeing is consistent with the
rest of the file.

One nit: I would prefer emitting the error log first and then perform cleanup
which I think looks more consistent:

	if (rc) {
		pr_err("Failed to configure queue %d for VCPU %d\n",
		       prio, xc->server_num);
		free_pages((unsigned long)qpage, xive->q_page_order);
	}

Not a blocker though.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

