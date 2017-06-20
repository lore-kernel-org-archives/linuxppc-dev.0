Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsQxF3kDbzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 21:44:33 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id s66so22299979pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:44:33 -0700 (PDT)
Date: Tue, 20 Jun 2017 21:44:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>,
 stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id>,
 akpm@linux-foundation.org, sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [BUG][next-20170619][347de24] PowerPC boot fails with Oops
Message-ID: <20170620214416.1d3b6373@roar.ozlabs.ibm.com>
In-Reply-To: <1497943165.6789.10.camel@abdul.in.ibm.com>
References: <1497943165.6789.10.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Jun 2017 12:49:25 +0530
Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:

> Hi,
> 
> commit: 347de24 (powerpc/64s: implement arch-specific hardlockup
> watchdog)
> 
> linux-next fails to boot on PowerPC Bare-metal box.
> 
> Test: boot
> Machine type: Power 8 Bare-metal
> Kernel: 4.12.0-rc5-next-20170619
> gcc: version 4.8.5
> 
> 
> In file arch/powerpc/kernel/watchdog.c
> 
> void soft_nmi_interrupt(struct pt_regs *regs)
> {
>     unsigned long flags;
>     int cpu = raw_smp_processor_id();
>     u64 tb;
> 
>     if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
>         return;
> 
> >>> nmi_enter();  

Thanks for the report.

This is due to emergency stacks not zeroing preempt_count, so they get
garbage here, and it just trips the BUG_ON(in_nmi()) check.

Don't think it's a bug in the proposed new powerpc watchdog. (at least
I was able to reproduce your bug and fix it by fixing the stack init).

Thanks,
Nick
