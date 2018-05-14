Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l3TS3D1CzF3cv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 00:47:56 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4EEiJIT099914
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 10:47:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hyc9mgrnf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 10:47:53 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 14 May 2018 15:47:50 +0100
Subject: Re: [PATCH v10 02/25] x86/mm: define
 ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
To: Punit Agrawal <punit.agrawal@arm.com>, akpm@linux-foundation.org
Cc: mhocko@kernel.org, peterz@infradead.org, kirill@shutemov.name,
 ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, Daniel Jordan
 <daniel.m.jordan@oracle.com>, David Rientjes <rientjes@google.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523975611-15978-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <87sh72jtmn.fsf@e105922-lin.cambridge.arm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 16:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <87sh72jtmn.fsf@e105922-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c289a58f-8afa-34c7-2624-c7bd2f6fcf48@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2018 13:04, Punit Agrawal wrote:
> Hi Laurent,
> 
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> 
>> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT which turns on the
>> Speculative Page Fault handler when building for 64bit.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/x86/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index d8983df5a2bc..ebdeb48e4a4a 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -30,6 +30,7 @@ config X86_64
>>  	select MODULES_USE_ELF_RELA
>>  	select X86_DEV_DMA_OPS
>>  	select ARCH_HAS_SYSCALL_WRAPPER
>> +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
> 
> I'd suggest merging this patch with the one making changes to the
> architectural fault handler towards the end of the series.
> 
> The Kconfig change is closely tied to the architectural support for SPF
> and makes sense to be in a single patch.
> 
> If there's a good reason to keep them as separate patches, please move
> the architecture Kconfig changes after the patch adding fault handler
> changes.
> 
> It's better to enable the feature once the core infrastructure is merged
> rather than at the beginning of the series to avoid potential bad
> fallout from incomplete functionality during bisection.

Indeed bisection was the reason why Andrew asked me to push the configuration
enablement on top of the series (https://lkml.org/lkml/2017/10/10/1229).

I also think it would be better to have the architecture enablement in on patch
but that would mean that the code will not be build when bisecting without the
latest patch adding the per architecture code.

I'm fine with the both options.

Andrew, what do you think would be the best here ?

Thanks,
Laurent.

> 
> All the comments here definitely hold for the arm64 patches that you
> plan to include with the next update.
> 
> Thanks,
> Punit
> 
>>  
>>  #
>>  # Arch settings
> 
