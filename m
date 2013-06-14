Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 612DB2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 08:53:47 +1000 (EST)
Message-ID: <1371250417.21896.17.camel@pasglop>
Subject: Re: [PATCH] powerpc/sysfs: disable hotplug for the boot cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Date: Sat, 15 Jun 2013 08:53:37 +1000
In-Reply-To: <20130613112552.GC7536@localhost.localdomain>
References: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
 <1369727984-21505-2-git-send-email-chenhui.zhao@freescale.com>
 <1370036984.3928.144.camel@pasglop>
 <20130603104315.GA1365@localhost.localdomain>
 <1371007522.8250.169.camel@pasglop>
 <20130613112552.GC7536@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-13 at 19:25 +0800, Zhao Chenhui wrote:
> Some multicore SoCs firstly boot up the cpu0 after warm reset.
> In some suspend/resume cases, SoC will do a warm reset when resuming.
> In order to ensure that the suspending and resuming is running
> on a same cpu, cpu0 should be the last cpu to suspend. Here, cpu0 is
> the boot_cpuid.

Well, so:

  - In any case, your patch will break pseries, so it's not acceptable.

  - Why does it have to absolutely resume from the same CPU it suspended
from ? Can't you have a little bit of code on the resuming CPU that
checks if it's not online, poke an online one and goes back to sleep ?

Cheers,
Ben.
