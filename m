Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWBq2D9wzDr14
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:40:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: xive: ensure active irqd when setting affinity
In-Reply-To: <20170803013822.GD28905@us.ibm.com>
References: <20170803013822.GD28905@us.ibm.com>
Date: Tue, 08 Aug 2017 20:40:33 +1000
Message-ID: <87zibamjfi.fsf@concordia.ellerman.id.au>
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

> From fd0abf5c61b6041fdb75296e8580b86dc91d08d6 Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 1 Aug 2017 20:54:41 -0500
> Subject: [PATCH] powerpc: xive: ensure active irqd when setting affinity
>
> Ensure irqd is active before attempting to set affinity. This should
> make the set affinity code more robust. For instance, this prevents
> these messages seen on a 4.12 based kernel when taking cpus offline:
>
>    [  123.053037264,3] XIVE[ IC 00  ] ISN 2 lead to invalid IVE !
>    [   77.885859] xive: Error -6 reconfiguring irq 17
>    [   77.885862] IRQ17: set affinity failed(-6).
>
> The underlying problem with taking cpus offline was fixed in 4.13-rc1 by:
>
>    commit 91f26cb4cd3c ("genirq/cpuhotplug: Do not migrated shutdown irqs")

So do we still need this? Or is the above only a partial fix?

I'm a bit confused.

cheers
