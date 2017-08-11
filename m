Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG40c7rzDr5C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:56 +1000 (AEST)
In-Reply-To: <20170803013822.GD28905@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc: xive: ensure active irqd when setting affinity
Message-Id: <3xTPG360xZz9t32@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 01:38:22 UTC, Sukadev Bhattiprolu wrote:
> >From fd0abf5c61b6041fdb75296e8580b86dc91d08d6 Mon Sep 17 00:00:00 2001
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
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cffb717ceb8e2ca0316e89d908db54

cheers
