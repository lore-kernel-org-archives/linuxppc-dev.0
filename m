Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJKZ5Bn1zDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:00:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, maddy@linux.vnet.ibm.com,
 tglx@linutronix.de, mingo@kernel.org, kan.liang@intel.com,
 linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/sysrq: Fix oops whem ppmu is not registered
In-Reply-To: <1505801826-12396-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1505801826-12396-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 20:00:49 +1000
Message-ID: <87wp4vknxq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> Kernel crashes if power pmu is not registered and user tries to dump
> regs with 'echo p > /proc/sysrq-trigger'. Sample log:
>
>   Unable to handle kernel paging request for data at address 0x00000008
>   Faulting instruction address: 0xc0000000000d52f0
>
>   NIP [c0000000000d52f0] perf_event_print_debug+0x10/0x230
>   LR [c00000000058a938] sysrq_handle_showregs+0x38/0x50
>   Call Trace:
>    printk+0x38/0x4c (unreliable)
>    __handle_sysrq+0xe4/0x270
>    write_sysrq_trigger+0x64/0x80
>    proc_reg_write+0x80/0xd0
>    __vfs_write+0x40/0x200
>    vfs_write+0xc8/0x240
>    SyS_write+0x60/0x110
>    system_call+0x58/0x6c

Thanks.

I added:

  Fixes: 5f6d0380c640 ("powerpc/perf: Define perf_event_print_debug() to print PMU register values")

But I don't think I'll Cc stable, I can't think why we'd ever *not* have
a ppmu registered. How did you hit it?

cheers
