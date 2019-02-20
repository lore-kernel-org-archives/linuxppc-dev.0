Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A9FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:00:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46E6208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46E6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444BQS6S4lzDq6y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:00:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=akshay.adiga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444BNb2vbBzDq6M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 19:58:55 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K8n41R042445
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 03:58:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qs3a5hjgj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 03:58:52 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 20 Feb 2019 08:58:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 08:58:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K8wmbK60358768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 08:58:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA49F4C044;
 Wed, 20 Feb 2019 08:58:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 081354C064;
 Wed, 20 Feb 2019 08:58:47 +0000 (GMT)
Received: from aks.ibm (unknown [9.85.70.128])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Feb 2019 08:58:46 +0000 (GMT)
Date: Wed, 20 Feb 2019 14:28:41 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
References: <20190206062837.26917-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206062837.26917-1-ruscur@russell.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19022008-0016-0000-0000-000002589CF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022008-0017-0000-0000-000032B2E550
Message-Id: <20190220085841.GA11633@aks.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200065
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 06, 2019 at 05:28:37PM +1100, Russell Currey wrote:
> Without restoring the IAMR after idle, execution prevention on POWER9
> with Radix MMU is overwritten and the kernel can freely execute userspace without
> faulting.
> 
> This is necessary when returning from any stop state that modifies user
> state, as well as hypervisor state.
> 
> To test how this fails without this patch, load the lkdtm driver and
> do the following:
> 
>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
> 
> which won't fault, then boot the kernel with powersave=off, where it
> will fault.  Applying this patch will fix this.
> 
> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
> space")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/include/asm/cpuidle.h |  1 +
>  arch/powerpc/kernel/asm-offsets.c  |  1 +
>  arch/powerpc/kernel/idle_book3s.S  | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 43e5f31fe64d..ad67dbe59498 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -77,6 +77,7 @@ struct stop_sprs {
>  	u64 mmcr1;
>  	u64 mmcr2;
>  	u64 mmcra;
> +	u64 iamr;
>  };
> 
>  #define PNV_IDLE_NAME_LEN    16
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 9ffc72ded73a..10e0314c2b0d 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -774,6 +774,7 @@ int main(void)
>  	STOP_SPR(STOP_MMCR1, mmcr1);
>  	STOP_SPR(STOP_MMCR2, mmcr2);
>  	STOP_SPR(STOP_MMCRA, mmcra);
> +	STOP_SPR(STOP_IAMR, iamr);
>  #endif
> 
>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 7f5ac2e8581b..bb4f552f6c7e 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -200,6 +200,12 @@ pnv_powersave_common:
>  	/* Continue saving state */
>  	SAVE_GPR(2, r1)
>  	SAVE_NVGPRS(r1)
> +
> +BEGIN_FTR_SECTION
> +	mfspr	r5, SPRN_IAMR
> +	std	r5, STOP_IAMR(r13)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +
>  	mfcr	r5
>  	std	r5,_CCR(r1)
>  	std	r1,PACAR1(r13)
> @@ -924,6 +930,13 @@ BEGIN_FTR_SECTION
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
>  	REST_NVGPRS(r1)
>  	REST_GPR(2, r1)
> +
> +BEGIN_FTR_SECTION
> +	ld	r4, STOP_IAMR(r13)
> +	mtspr	SPRN_IAMR, r4
> +	isync
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +
>  	ld	r4,PACAKMSR(r13)
>  	ld	r5,_LINK(r1)
>  	ld	r6,_CCR(r1)
> @@ -946,6 +959,13 @@ pnv_wakeup_noloss:
>  BEGIN_FTR_SECTION
>  	CHECK_HMI_INTERRUPT
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> +
> +BEGIN_FTR_SECTION
> +	ld	r4, STOP_IAMR(r13)
> +	mtspr	SPRN_IAMR, r4
> +	isync
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +

pnv_wakeup_noloss gets called from two paths:
1) cpu wakes up at 0x100  (ESL=EC=1)
2) cpu wakes up at next instruction  (ESL=EC=0)

We know for the fact that its not lost with ESL=EC=0 , so we
should put it somewhere else.

I would like to put the restore code in pnv_restore_hyp_resource_arch300
it already has some work arounds we can add another.

By this time we cr3 has comparison of SRR1[46:47] with 2

  542 pnv_restore_hyp_resource_arch300:
  543         /*
  544          * Workaround for POWER9, if we lost resources, the ERAT
  545          * might have been mixed up and needs flushing. We also need
  546          * to reload MMCR0 (see comment above). We also need to set
  547          * then clear bit 60 in MMCRA to ensure the PMU starts running.
  548          */
  549         blt     cr3,1f
  550 BEGIN_FTR_SECTION
  551         PPC_INVALIDATE_ERAT
  552         ld      r1,PACAR1(r13)
  553         ld      r4,_MMCR0(r1)
  554         mtspr   SPRN_MMCR0,r4
  555 END_FTR_SECTION_IFCLR(CPU_FTR_POWER9_DD2_1)
  556         mfspr   r4,SPRN_MMCRA
  557         ori     r4,r4,(1 << (63-60))
  558         mtspr   SPRN_MMCRA,r4
  559         xori    r4,r4,(1 << (63-60))
  560         mtspr   SPRN_MMCRA,r4
+ 561 BEGIN_FTR_SECTION
+ 562         ld      r4,STOP_IAMR(r13)
+ 563         mtspr   SPRN_IAMR,r4
+ 564 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
  565 1:
  566         /* 

I have a patchset to handle both AMOR and IAMR,
need to test it on power8 before posting.


>  	ld	r4,PACAKMSR(r13)
>  	ld	r5,_NIP(r1)
>  	ld	r6,_CCR(r1)
> -- 
> 2.20.1
> 

