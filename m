Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4341C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:43:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F972064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F972064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YdQW4ZtPzDsQB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:43:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YdLQ0tVGzF3LM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:39:41 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9FCdPuC067958
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 08:39:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n4ss33m2j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 08:39:38 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 15 Oct 2018 13:39:36 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Oct 2018 13:39:33 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9FCdWwx5767652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Oct 2018 12:39:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 621784C040;
 Mon, 15 Oct 2018 15:39:06 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E16744C046;
 Mon, 15 Oct 2018 15:39:05 +0100 (BST)
Received: from [9.126.30.56] (unknown [9.126.30.56])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 15 Oct 2018 15:39:05 +0100 (BST)
Subject: Re: [PATCH 1/3] powerpc: Split user/kernel definitions of struct
 pt_regs
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20181013105646.5147-1-mpe@ellerman.id.au>
 <458fb5e1-3654-e8db-dfa7-074195decb11@linux.vnet.ibm.com>
 <87sh17zcur.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 15 Oct 2018 18:09:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sh17zcur.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101512-4275-0000-0000-000002CC42EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101512-4276-0000-0000-000037D745B0
Message-Id: <14b76e3e-2497-4ac2-c0b5-ce801275ac64@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-15_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150117
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



On Monday 15 October 2018 04:38 PM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>
>> On Saturday 13 October 2018 04:26 PM, Michael Ellerman wrote:
>>> We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
>>> That means the layout of the structure is ABI, ie. we can't change it.
>>>
>>> That would be fine if it was only used to describe the user-visible
>>> register state of a process, but it's also the struct we use in the
>>> kernel to describe the registers saved in an interrupt frame.
>>>
>>> We'd like more flexibility in the content (and possibly layout) of the
>>> kernel version of the struct, but currently that's not possible.
>>>
>>> So split the definition into a user-visible definition which remains
>>> unchanged, and a kernel internal one.
>>>
>>> At the moment they're still identical, and we check that at build
>>> time. That's because we have code (in ptrace etc.) that assumes that
>>> they are the same. We will fix that code in future patches, and then
>>> we can break the strict symmetry between the two structs.
>> Nice and awesome. But just trying to understand. What will
>> *regs will point to in the "struct sigcontext".
> Yeah that's a bit fishy.
>
> It should always point to a user_pt_regs.
>
> So in the kernel we want:
>
>    struct sigcontext {
>    	...
>    	struct user_pt_regs	__user *regs;
>
> And in userspace we want:
>
>    struct sigcontext {
>    	...
>    	struct pt_regs	__user *regs;
>
>
> I think it's not actually broken at the moment, because it's just a
> pointer, and we don't do anything based on the sizeof() the type.

yes. This clarifies. But still perf/perf_regs.c needs changes.
Because perf support dumping user_space regs and interrupt regs.
Once again, we dont use any sizeof(), but need to handle the
user_pt_regs changes.

I will have a look at that in the morning.

Thanks for clarification.
Maddy

>
> But still we should fix it.
>
> I guess I'll do this:
>
> diff --git a/arch/powerpc/include/uapi/asm/sigcontext.h b/arch/powerpc/include/uapi/asm/sigcontext.h
> index 2fbe485acdb4..630aeda56d59 100644
> --- a/arch/powerpc/include/uapi/asm/sigcontext.h
> +++ b/arch/powerpc/include/uapi/asm/sigcontext.h
> @@ -22,7 +22,11 @@ struct sigcontext {
>   #endif
>   	unsigned long	handler;
>   	unsigned long	oldmask;
> -	struct pt_regs	__user *regs;
> +#ifdef __KERNEL__
> +	struct user_pt_regs __user *regs;
> +#else
> +	struct pt_regs	*regs;
> +#endif
>   #ifdef __powerpc64__
>   	elf_gregset_t	gp_regs;
>   	elf_fpregset_t	fp_regs;
>
>
> Thanks for the review.
>
> cheers
>

