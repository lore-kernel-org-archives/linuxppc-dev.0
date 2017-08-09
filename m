Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS1Gc51wZzDqvc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 16:15:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: xive: ensure active irqd when setting affinity
In-Reply-To: <20170809000034.GB17162@us.ibm.com>
References: <20170803013822.GD28905@us.ibm.com>
 <87zibamjfi.fsf@concordia.ellerman.id.au> <20170809000034.GB17162@us.ibm.com>
Date: Wed, 09 Aug 2017 16:15:36 +1000
Message-ID: <87a839nu5z.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> Michael Ellerman [mpe@ellerman.id.au] wrote:
>> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> > From fd0abf5c61b6041fdb75296e8580b86dc91d08d6 Mon Sep 17 00:00:00 2001
>> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Date: Tue, 1 Aug 2017 20:54:41 -0500
>> > Subject: [PATCH] powerpc: xive: ensure active irqd when setting affinity
>> >
>> > Ensure irqd is active before attempting to set affinity. This should
>> > make the set affinity code more robust. For instance, this prevents
>> > these messages seen on a 4.12 based kernel when taking cpus offline:
>> >
>> >    [  123.053037264,3] XIVE[ IC 00  ] ISN 2 lead to invalid IVE !
>> >    [   77.885859] xive: Error -6 reconfiguring irq 17
>> >    [   77.885862] IRQ17: set affinity failed(-6).
>> >
>> > The underlying problem with taking cpus offline was fixed in 4.13-rc1 by:
>> >
>> >    commit 91f26cb4cd3c ("genirq/cpuhotplug: Do not migrated shutdown irqs")
>> 
>> So do we still need this? Or is the above only a partial fix?
>
> It would be good to have this fix.
>
> Commit 91f26cb4cd3c fixes the problem, so we wont see the errors with
> that commit applied. But if such a problem were to show up again, xive
> will handle them earlier before hitting those errors.

I'm not sure I'm convinced. We can't handle every possible case of the
higher level code calling us in situations we don't expect.

For example irq_data could be NULL, but we trust the higher level code
not to do that to us.

Also I don't see any other driver doing this check.

  $ git grep irqd_is_started
  include/linux/irq.h:static inline bool irqd_is_started(struct irq_data *d)
  kernel/irq/chip.c:      if (irqd_is_started(d)) {
  kernel/irq/chip.c:      if (irqd_is_started(&desc->irq_data)) {
  kernel/irq/cpuhotplug.c:        if (irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d)) {


cheers
