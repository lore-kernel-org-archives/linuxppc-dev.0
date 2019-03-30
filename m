Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1000C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 06:04:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F9D2173C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 06:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F9D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WSjT6XMNzDqVj
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 17:04:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WSgT2TRNzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 17:02:28 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2U62Ksn130125
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:02:26 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rj23b10mk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:02:25 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sat, 30 Mar 2019 05:58:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 30 Mar 2019 05:58:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2U5waRq44368058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 30 Mar 2019 05:58:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2960211C04A;
 Sat, 30 Mar 2019 05:58:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19B8711C04C;
 Sat, 30 Mar 2019 05:58:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.85.132])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat, 30 Mar 2019 05:58:34 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s/radix: Fix radix segment exception handling
In-Reply-To: <20190329074257.14428-1-npiggin@gmail.com>
References: <20190329074257.14428-1-npiggin@gmail.com>
Date: Sat, 30 Mar 2019 11:28:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19033005-0028-0000-0000-0000035A4567
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19033005-0029-0000-0000-000024190C9C
Message-Id: <871s2oq4xi.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-30_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300042
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:

> Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> broke the radix-mode segment exception handler. In radix mode, this is
> exception is not an SLB miss, rather it signals that the EA is outside
> the range translated by any page table.
>
> The commit lost the radix feature alternate code patch, which can
> cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!
>
> The original radix code would send faults to slb_miss_large_addr,
> which would end up faulting due to slb_addr_limit being 0. This patch
> sends radix directly to do_bad_slb_fault, which is a bit clearer.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index a5b8fbae56a0..9481a117e242 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -656,11 +656,17 @@ EXC_COMMON_BEGIN(data_access_slb_common)
>  	ld	r4,PACA_EXSLB+EX_DAR(r13)
>  	std	r4,_DAR(r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> +BEGIN_MMU_FTR_SECTION
> +	/* HPT case, do SLB fault */
>  	bl	do_slb_fault
>  	cmpdi	r3,0
>  	bne-	1f
>  	b	fast_exception_return
>  1:	/* Error case */
> +MMU_FTR_SECTION_ELSE
> +	/* Radix case, access is outside page table range */
> +	li	r3,-EFAULT
> +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
>  	std	r3,RESULT(r1)
>  	bl	save_nvgprs
>  	RECONCILE_IRQ_STATE(r10, r11)
> @@ -705,11 +711,17 @@ EXC_COMMON_BEGIN(instruction_access_slb_common)
>  	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
>  	ld	r4,_NIP(r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> +BEGIN_MMU_FTR_SECTION
> +	/* HPT case, do SLB fault */
>  	bl	do_slb_fault
>  	cmpdi	r3,0
>  	bne-	1f
>  	b	fast_exception_return
>  1:	/* Error case */
> +MMU_FTR_SECTION_ELSE
> +	/* Radix case, access is outside page table range */
> +	li	r3,-EFAULT
> +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
>  	std	r3,RESULT(r1)
>  	bl	save_nvgprs
>  	RECONCILE_IRQ_STATE(r10, r11)
> -- 
> 2.20.1

