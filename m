Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJQH47XPzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:04:55 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8JA4QMc073194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:04:52 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d30nv9mw9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:04:52 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 19 Sep 2017 20:04:48 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8JA4kVM35782666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:04:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8JA4blU006722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:04:38 +1000
Subject: Re: [PATCH] powerpc/sysrq: Fix oops whem ppmu is not registered
To: Michael Ellerman <mpe@ellerman.id.au>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, tglx@linutronix.de,
 mingo@kernel.org, kan.liang@intel.com, linux-kernel@vger.kernel.org
References: <1505801826-12396-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <87wp4vknxq.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 15:34:40 +0530
MIME-Version: 1.0
In-Reply-To: <87wp4vknxq.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6d061729-f2a2-ed05-2008-46c78ef4bd6f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 19 September 2017 03:30 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> Kernel crashes if power pmu is not registered and user tries to dump
>> regs with 'echo p > /proc/sysrq-trigger'. Sample log:
>>
>>    Unable to handle kernel paging request for data at address 0x00000008
>>    Faulting instruction address: 0xc0000000000d52f0
>>
>>    NIP [c0000000000d52f0] perf_event_print_debug+0x10/0x230
>>    LR [c00000000058a938] sysrq_handle_showregs+0x38/0x50
>>    Call Trace:
>>     printk+0x38/0x4c (unreliable)
>>     __handle_sysrq+0xe4/0x270
>>     write_sysrq_trigger+0x64/0x80
>>     proc_reg_write+0x80/0xd0
>>     __vfs_write+0x40/0x200
>>     vfs_write+0xc8/0x240
>>     SyS_write+0x60/0x110
>>     system_call+0x58/0x6c
> Thanks.
>
> I added:
>
>    Fixes: 5f6d0380c640 ("powerpc/perf: Define perf_event_print_debug() to print PMU register values")
>
> But I don't think I'll Cc stable, I can't think why we'd ever *not* have
> a ppmu registered. How did you hit it?
mpe,

We hit this in a compact mode setup where the distro kernel did not have 
the
pmu support for the base pvr.

Maddy


> cheers
>
