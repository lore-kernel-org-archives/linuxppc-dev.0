Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A64C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 14:06:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88A061220
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88A061220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJrBh0SLhz3bmg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 00:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tg/J37Hz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=farosas@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Tg/J37Hz; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJrB96dMxz30BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2021 00:06:09 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13CE2wLG055751; Mon, 12 Apr 2021 10:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=imMop1+fNcGEidP7nMLbVS3Ggwi8E+o5W0jjoJmMAYA=;
 b=Tg/J37HzpIcjVUQ6qGsgTaLjeThJOoVvAQvXL3x1cnzwPmzTvrk1l/BhUzAO7pCiVXs7
 DL3MMy4EPirWMHs+Anwodzjvcl9mR0EwxieGY/VUk2g/Hs6TYuqEI9OegRZPUCVJjW0x
 bdaOU8gghIjQjDe8OYkEGJKBLYJQ33ldCC+GTgXVRPLc6hBduKHsHecWz7wleRo2RhO8
 74V2u6Kp+CHQayCJXjKngGIFnGVN4wfviYVw45hjXqp3uMNesoI2ZUTHi7JwLQ/qaMHS
 6om/XdGBJO82yyfClag7gfKEDUvRN5NYjB20keCVwl8giNF5IK5UY2mmWFGw8fSxbDhR /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37vn535vve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Apr 2021 10:06:06 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13CE4X69063390;
 Mon, 12 Apr 2021 10:06:05 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37vn535vux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Apr 2021 10:06:05 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CDvhFB022514;
 Mon, 12 Apr 2021 14:06:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 37u3n94pvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Apr 2021 14:06:05 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13CE63rK56427010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Apr 2021 14:06:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B605CBE056;
 Mon, 12 Apr 2021 14:06:03 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06C02BE053;
 Mon, 12 Apr 2021 14:06:02 +0000 (GMT)
Received: from localhost (unknown [9.211.82.34])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Apr 2021 14:06:02 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v1 01/12] KVM: PPC: Book3S HV P9: Restore host CTRL SPR
 after guest exit
In-Reply-To: <20210412014845.1517916-2-npiggin@gmail.com>
References: <20210412014845.1517916-1-npiggin@gmail.com>
 <20210412014845.1517916-2-npiggin@gmail.com>
Date: Mon, 12 Apr 2021 11:06:00 -0300
Message-ID: <877dl761iv.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BvqzYckQoTSCpfDpSvpAs70PjxRx4jMp
X-Proofpoint-GUID: QjqkTGjAIVpxQC3VDsMqqinVgAfYHYs1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-12_10:2021-04-12,
 2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120096
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:

> The host CTRL (runlatch) value is not restored after guest exit. The
> host CTRL should always be 1 except in CPU idle code, so this can result
> in the host running with runlatch clear, and potentially switching to
> a different vCPU which then runs with runlatch clear as well.
>
> This has little effect on P9 machines, CTRL is only responsible for some
> PMU counter logic in the host and so other than corner cases of software
> relying on that, or explicitly reading the runlatch value (Linux does
> not appear to be affected but it's possible non-Linux guests could be),
> there should be no execution correctness problem, though it could be
> used as a covert channel between guests.
>
> There may be microcontrollers, firmware or monitoring tools that sample
> the runlatch value out-of-band, however since the register is writable
> by guests, these values would (should) not be relied upon for correct
> operation of the host, so suboptimal performance or incorrect reporting
> should be the worst problem.
>
> Fixes: 95a6432ce9038 ("KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 13bad6bf4c95..208a053c9adf 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3728,7 +3728,10 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
>  	vcpu->arch.dec_expires = dec + tb;
>  	vcpu->cpu = -1;
>  	vcpu->arch.thread_cpu = -1;
> +	/* Save guest CTRL register, set runlatch to 1 */
>  	vcpu->arch.ctrl = mfspr(SPRN_CTRLF);
> +	if (!(vcpu->arch.ctrl & 1))
> +		mtspr(SPRN_CTRLT, vcpu->arch.ctrl | 1);

Maybe ditch the comment and use the already defined CTRL_RUNLATCH?

>
>  	vcpu->arch.iamr = mfspr(SPRN_IAMR);
>  	vcpu->arch.pspb = mfspr(SPRN_PSPB);
