Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGX3xJhzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:44 +1000 (AEST)
In-Reply-To: <1505801826-12396-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, paulus@samba.org,
 kan.liang@intel.com, tglx@linutronix.de, mingo@kernel.org
Subject: Re: powerpc/sysrq: Fix oops whem ppmu is not registered
Message-Id: <3xyKGX1f9lz9sRV@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-19 at 06:17:06 UTC, Ravi Bangoria wrote:
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
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4917fcb58cc73f6b81455e3c5f9601

cheers
