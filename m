Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11771C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 06:13:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79411217F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 06:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79411217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K1jn3KtPzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 17:13:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K1gz298HzDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 17:11:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44K1gz0cBNz8wP9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 17:11:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44K1gz08Xgz9s47; Wed, 13 Mar 2019 17:11:43 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=akshay.adiga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44K1gy22vvz9s55
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2019 17:11:41 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2D64LEr088271
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2019 02:11:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r6un8stvb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2019 02:11:38 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 13 Mar 2019 06:11:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 06:11:33 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2D6BWgc60489902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Mar 2019 06:11:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ECE211C04C;
 Wed, 13 Mar 2019 06:11:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 809AE11C050;
 Wed, 13 Mar 2019 06:11:31 +0000 (GMT)
Received: from aks.ibm (unknown [9.124.35.29])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 13 Mar 2019 06:11:31 +0000 (GMT)
Date: Wed, 13 Mar 2019 11:41:29 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/9] powerpc/powernv/idle: Restore AMR/UAMOR/AMOR
 after idle
References: <20190228144917.16876-1-mpe@ellerman.id.au>
 <20190228144917.16876-2-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228144917.16876-2-mpe@ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19031306-4275-0000-0000-0000031A5347
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031306-4276-0000-0000-00003828C056
Message-Id: <20190313061129.GA4047@aks.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-13_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=642 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130044
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 01, 2019 at 01:49:10AM +1100, Michael Ellerman wrote:
> In order to implement KUAP (Kernel Userspace Access Protection) on
> Power9 we will be using the AMR, and therefore indirectly the
> UAMOR/AMOR.
> 
> So save/restore these regs in the idle code.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> v4: New.
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 36178000a2f2..4a860d3b9229 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -170,8 +170,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  	bne-	core_idle_lock_held
>  	blr
> 
> -/* Reuse an unused pt_regs slot for IAMR */
> +/* Reuse some unused pt_regs slots for AMR/IAMR/UAMOR/UAMOR */
> +#define PNV_POWERSAVE_AMR	_TRAP
>  #define PNV_POWERSAVE_IAMR	_DAR
> +#define PNV_POWERSAVE_UAMOR	_DSISR
> +#define PNV_POWERSAVE_AMOR	RESULT
> 
>  /*
>   * Pass requested state in r3:
> @@ -205,8 +208,16 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  	SAVE_NVGPRS(r1)
> 
>  BEGIN_FTR_SECTION
> +	mfspr	r4, SPRN_AMR
>  	mfspr	r5, SPRN_IAMR
> +	mfspr	r6, SPRN_UAMOR
> +	std	r4, PNV_POWERSAVE_AMR(r1)
>  	std	r5, PNV_POWERSAVE_IAMR(r1)
> +	std	r6, PNV_POWERSAVE_UAMOR(r1)
> +BEGIN_FTR_SECTION_NESTED(42)
> +	mfspr	r7, SPRN_AMOR
> +	std	r7, PNV_POWERSAVE_AMOR(r1)
> +END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)

Can we save/restore for ARCH_300S only ?

I checked the user manual "POWER8 Processor User’s Manual for the
Single-Chip Module" v1.3 dated 16 March 2016. In section 9.7.2.2,
It mentions that AMOR and UAMOR will be preserved by hardware.

Excrept : 
" When an SMT thread switch is enabled, the napping thread’s
 resources can be given to other threads to improve core
 performance. Software must restore the architected state
 of the dormant thread upon exiting nap mode except for
 the following architected facilities, which are preserved
 by the hardware:
 - SLB State
 - All Hypervisor Special Registers (includes PURR, SPURR, AMOR,
 UAMOR, AMR, ACOP)
"

Keeping 207S has no harm, its just that we may spend a few
more cycles saving and restoring the sprs.

> 
>  	mfcr	r5
> @@ -935,12 +946,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
>  	REST_GPR(2, r1)
> 
>  BEGIN_FTR_SECTION
> -	/* IAMR was saved in pnv_powersave_common() */
> +	/* These regs were saved in pnv_powersave_common() */
> +	ld	r4, PNV_POWERSAVE_AMR(r1)
>  	ld	r5, PNV_POWERSAVE_IAMR(r1)
> +	ld	r6, PNV_POWERSAVE_UAMOR(r1)
> +	mtspr	SPRN_AMR, r4
>  	mtspr	SPRN_IAMR, r5
> +	mtspr	SPRN_UAMOR, r6
> +BEGIN_FTR_SECTION_NESTED(42)
> +	ld	r7, PNV_POWERSAVE_AMOR(r1)
> +	mtspr	SPRN_AMOR, r7
> +END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE, 42)
>  	/*
> -	 * We don't need an isync here because the upcoming mtmsrd is
> -	 * execution synchronizing.
> +	 * We don't need an isync here after restoring IAMR because the upcoming
> +	 * mtmsrd is execution synchronizing.
>  	 */
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> 
> -- 
> 2.20.1
> 

