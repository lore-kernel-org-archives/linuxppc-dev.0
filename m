Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVQS117NzDr1f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:26:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4PDOBFT121146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 09:25:59 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2anyb8k5qw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 09:25:59 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Thu, 25 May 2017 07:25:58 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH] powerpc/lib: Split xor_vmx file to guarantee instruction
 ordering
References: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
 <0a79517a-c9eb-6eca-4048-de20d4543114@us.ibm.com>
 <CAPoR37YQ-9Q=HacFVrWDg_aS=rPhWhB_SuuevdZDCA2Vu=AVyg@mail.gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
From: Paul Clarke <pc@us.ibm.com>
Date: Thu, 25 May 2017 08:25:50 -0500
MIME-Version: 1.0
In-Reply-To: <CAPoR37YQ-9Q=HacFVrWDg_aS=rPhWhB_SuuevdZDCA2Vu=AVyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f6497cbe-5251-79d1-f221-c1911b55d4db@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2017 11:56 PM, Matt Brown wrote:
> On Wed, May 24, 2017 at 11:36 PM, Paul Clarke <pc@us.ibm.com> wrote:
>> On 05/23/2017 06:45 PM, Matt Brown wrote:
>>> The xor_vmx.c file is used for the RAID5 xor operations. In these functions
>>> altivec is enabled to run the operation and then disabled. However due to
>>> compiler instruction reordering, altivec instructions are being run before
>>> enable_altivec() and after disable_altivec().
>>
>> If altivec instructions can be reordered after disable_altivec(), then disable_altivec() is broken, I'd think.
>>
>> Could it be because the isync in mtmsr_isync() is after the mtmsr?
>>
>> disable_kernel_altivec
>> - msr_check_and_clear
>>   - __msr_check_and_clear
>>     - mtmsr_isync
> 
> So it turns out the enable / disable functions don't actually enable
> or disable the use of vector instructions.
> If we have marked the file to be compiled with altivec the compiler
> has free reign to reorder the vector instructions wherever it likes.
> Including reordering it before or after the enable/disable_altivec
> commands.
> 
> The enable_kernel_altivec and disable_kernel_altivec functions are
> mainly there to empty and restore the vector registers which could
> have been used in user-space. So those functions work as intended,
> although not particularly intuitive.
> 
> Splitting the files and only compiling the xor_vmx.c file with altivec
> will guarantee that there are no vector instructions in the
> xor_vmx_glue.c file, and that no vector instructions are outside of
> the enable/disable block.

Thanks for the explanation!  That makes sense.

PC
