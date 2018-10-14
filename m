Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A6C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 06:38:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91A820835
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 06:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91A820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XsMd3xtMzF368
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 17:38:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XsKc5Yz7zDrTQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:36:20 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9E6SsYu088841
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 02:36:17 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n3x5ruvk0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 02:36:17 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 14 Oct 2018 07:36:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 14 Oct 2018 07:36:14 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9E6aDLA3080502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 06:36:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A9F442045
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 09:35:47 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 351E14203F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 09:35:47 +0100 (BST)
Received: from [9.126.30.56] (unknown [9.126.30.56])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 09:35:47 +0100 (BST)
Subject: Re: [PATCH 1/3] powerpc: Split user/kernel definitions of struct
 pt_regs
To: linuxppc-dev@lists.ozlabs.org
References: <20181013105646.5147-1-mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Sun, 14 Oct 2018 12:06:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013105646.5147-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101406-0020-0000-0000-000002D3C946
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101406-0021-0000-0000-000021225362
Message-Id: <458fb5e1-3654-e8db-dfa7-074195decb11@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-14_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810140063
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Saturday 13 October 2018 04:26 PM, Michael Ellerman wrote:
> We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
> That means the layout of the structure is ABI, ie. we can't change it.
>
> That would be fine if it was only used to describe the user-visible
> register state of a process, but it's also the struct we use in the
> kernel to describe the registers saved in an interrupt frame.
>
> We'd like more flexibility in the content (and possibly layout) of the
> kernel version of the struct, but currently that's not possible.
>
> So split the definition into a user-visible definition which remains
> unchanged, and a kernel internal one.
>
> At the moment they're still identical, and we check that at build
> time. That's because we have code (in ptrace etc.) that assumes that
> they are the same. We will fix that code in future patches, and then
> we can break the strict symmetry between the two structs.

Nice and awesome. But just trying to understand. What will
*regs will point to in the "struct sigcontext".


>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/include/asm/ptrace.h      | 27 ++++++++++++++++++
>   arch/powerpc/include/uapi/asm/ptrace.h |  7 ++++-
>   arch/powerpc/kernel/ptrace.c           | 39 ++++++++++++++++++++++++++
>   3 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 447cbd1bee99..3dd15024db93 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -26,6 +26,33 @@
>   #include <uapi/asm/ptrace.h>
>   #include <asm/asm-const.h>
>
> +#ifndef __ASSEMBLY__
> +struct pt_regs
> +{
> +	union {
> +		struct user_pt_regs user_regs;
> +		struct {
> +			unsigned long gpr[32];
> +			unsigned long nip;
> +			unsigned long msr;
> +			unsigned long orig_gpr3;
> +			unsigned long ctr;
> +			unsigned long link;
> +			unsigned long xer;
> +			unsigned long ccr;
> +#ifdef CONFIG_PPC64
> +			unsigned long softe;
> +#else
> +			unsigned long mq;
> +#endif
> +			unsigned long trap;
> +			unsigned long dar;
> +			unsigned long dsisr;
> +			unsigned long result;
> +		};
> +	};
> +};
> +#endif
>
>   #ifdef __powerpc64__
>
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 55c7a131d2ab..f5f1ccc740fc 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -29,7 +29,12 @@
>
>   #ifndef __ASSEMBLY__
>
> -struct pt_regs {
> +#ifdef __KERNEL__
> +struct user_pt_regs
> +#else
> +struct pt_regs
> +#endif
> +{
>   	unsigned long gpr[32];
>   	unsigned long nip;
>   	unsigned long msr;
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 4e372f54088f..939d7f81bbbe 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3335,3 +3335,42 @@ void do_syscall_trace_leave(struct pt_regs *regs)
>
>   	user_enter();
>   }
> +
> +void __init pt_regs_check(void)
> +{
> +	BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
> +		     offsetof(struct user_pt_regs, gpr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, nip) !=
> +		     offsetof(struct user_pt_regs, nip));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, msr) !=
> +		     offsetof(struct user_pt_regs, msr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, msr) !=
> +		     offsetof(struct user_pt_regs, msr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
> +		     offsetof(struct user_pt_regs, orig_gpr3));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, ctr) !=
> +		     offsetof(struct user_pt_regs, ctr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, link) !=
> +		     offsetof(struct user_pt_regs, link));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, xer) !=
> +		     offsetof(struct user_pt_regs, xer));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, ccr) !=
> +		     offsetof(struct user_pt_regs, ccr));
> +#ifdef __powerpc64__
> +	BUILD_BUG_ON(offsetof(struct pt_regs, softe) !=
> +		     offsetof(struct user_pt_regs, softe));
> +#else
> +	BUILD_BUG_ON(offsetof(struct pt_regs, mq) !=
> +		     offsetof(struct user_pt_regs, mq));
> +#endif
> +	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
> +		     offsetof(struct user_pt_regs, trap));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=
> +		     offsetof(struct user_pt_regs, dar));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
> +		     offsetof(struct user_pt_regs, dsisr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
> +		     offsetof(struct user_pt_regs, result));
> +
> +	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
> +}

