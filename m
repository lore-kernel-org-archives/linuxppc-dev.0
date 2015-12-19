Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9676F1A1A1A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2015 21:58:20 +1100 (AEDT)
In-Reply-To: <1450419377-29847-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, stable@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc/opal-irqchip: Fix deadlock introduced by "Fix double
 endian conversion"
Message-Id: <20151219105820.56E9214076B@ozlabs.org>
Date: Sat, 19 Dec 2015 21:58:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-18-12 at 06:16:17 UTC, Alistair Popple wrote:
> Commit 25642e1459ac ("powerpc/opal-irqchip: Fix double endian
> conversion") fixed an endian bug by calling opal_handle_events() in
> opal_event_unmask(). However this introduces a deadlock when an event
> is active during unmasking as opal_handle_events() calls
> generic_handle_irq() which may call opal_event_unmask() with the irq
> descriptor lock held.
> 
> When generating multiple opal events in quick succession this would
> lead to the following stall warnings:
> 
> EEH: Fenced PHB#0 detected, location: U78C9.001.WZS09XA-P1-C32
> INFO: rcu_sched detected stalls on CPUs/tasks:
> 
>          12-...: (1 GPs behind) idle=68f/140000000000001/0 softirq=860/861 fqs=2065
>          15-...: (1 GPs behind) idle=be5/140000000000001/0 softirq=1142/1143 fqs=2065
>          (detected by 13, t=2102 jiffies, g=1325, c=1324, q=602)
> NMI watchdog: BUG: soft lockup - CPU#18 stuck for 22s! [irqbalance:2696]
> INFO: rcu_sched detected stalls on CPUs/tasks:
>          12-...: (1 GPs behind) idle=68f/140000000000001/0 softirq=860/861 fqs=8371
>          15-...: (1 GPs behind) idle=be5/140000000000001/0 softirq=1142/1143 fqs=8371
>          (detected by 20, t=8407 jiffies, g=1325, c=1324, q=1290)
> 
> This patch corrects the problem by queuing the work if an event is
> active during unmasking, which is similar to the pre-endian fix
> behaviour.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/036592fbbe753d236402a0ae68

cheers
