Return-Path: <groeck7@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxly434pbzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:45:31 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e69so689927pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:45:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Traceback due to 'powerpc/mm: Fix kernel RAM protection...' when
 running ppc image in qemu
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
References: <20170919182459.GA7933@roeck-us.net>
 <8760ce9iib.fsf@concordia.ellerman.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <daaad0c4-75af-4b02-20d0-b0b8e327f94a@roeck-us.net>
Date: Tue, 19 Sep 2017 20:45:27 -0700
MIME-Version: 1.0
In-Reply-To: <8760ce9iib.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19/2017 08:05 PM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> Hi,
>>
>> I see a the following traceback when running an SMP image based on
>> 85xx/mpc85xx_cds_defconfig in qemu.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at kernel/smp.c:416 smp_call_function_many+0xcc/0x2fc
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc1-00009-g0666f56 #1
>> task: cf830000 task.stack: cf82e000
>> NIP:  c00a93c8 LR: c00a9634 CTR: 00000001
>> REGS: cf82fde0 TRAP: 0700   Not tainted  (4.14.0-rc1-00009-g0666f56)
>> MSR:  00021000 <CE,ME>  CR: 24000082  XER: 00000000
>>
>> GPR00: c00a9634 cf82fe90 cf830000 c050ad3c c0015a54 00000000 00000001 00000001
>> GPR08: 00000001 00000000 00000000 cf82e000 24000084 00000000 c0003150 00000000
>> GPR16: 00000000 00000000 00000000 00000000 00000000 00000001 00000000 c0510000
>> GPR24: 00000000 c0015a54 00000000 c050ad3c c051823c c050ad3c 00000025 00000000
>> NIP [c00a93c8] smp_call_function_many+0xcc/0x2fc
>> LR [c00a9634] smp_call_function+0x3c/0x50
>> Call Trace:
>> [cf82fe90] [00000010] 0x10 (unreliable)
>> [cf82fed0] [c00a9634] smp_call_function+0x3c/0x50
>> [cf82fee0] [c0015d2c] flush_tlb_kernel_range+0x20/0x38
>> [cf82fef0] [c001524c] mark_initmem_nx+0x154/0x16c
>> [cf82ff20] [c001484c] free_initmem+0x20/0x4c
>> [cf82ff30] [c000316c] kernel_init+0x1c/0x108
>> [cf82ff40] [c000f3a8] ret_from_kernel_thread+0x5c/0x64
>> Instruction dump:
>> 7c0803a6 7d808120 38210040 4e800020 3d20c052 812981a0 2f890000 40beffac
>> 3d20c051 8929ac64 2f890000 40beff9c <0fe00000> 4bffff94 7fc3f378 7f64db78
>> ---[ end trace 7da7bdcf8b15ddb3 ]---
> 
> Thanks.
> 
> I guess the system still runs OK otherwise, you're just seeing the warning?
> 
Yes, though I am not sure if that is because there is only one active CPU (there is
still only one if I say "-smp 4" on the qemu command line).

>> A complete log is available at:
>> http://kerneltests.org/builders/qemu-ppc-master/builds/814/steps/qemubuildcommand/logs/stdio
>>
>> Bisect points to commit 3184cc4b6f6a1dc0 ("powerpc/mm: Fix kernel RAM protection
>> after freeing unused memory on PPC32"). Bisect log is attached. A quick look
>> suggests that mark_initmem_nx() is called with interrupts disabled, which
>> triggers the traceback.
> 
> Hmm. Yes the MSR says you have interrupts disabled (EE missing).
> 
> But I don't see why. start_kernel() did local_irq_enable(), so I don't
> understand why we got to mark_initmem_nx() with them disabled. I'll hope
> that Christophe has some idea.
> 
Good question. I only see this with one of 9 ppc emulations, with 85xx/mpc85xx_cds_defconfig
+CONFIG_DEVTMPFS=y +CONFIG_SMP=y. Maybe there is a platform specific init function
which leaves interrupts disabled. Question is which one that might be.

Guenter
