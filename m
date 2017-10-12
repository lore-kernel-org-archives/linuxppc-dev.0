Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCBLz67MzzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 11:20:11 +1100 (AEDT)
In-Reply-To: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Daniel Black <daniel.black@au1.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: powerpc: Drop lockdep_assert_cpus_held call from
 arch_update_cpu_topology
Message-Id: <3yCBLz4n8zz9t2Z@ozlabs.org>
Date: Thu, 12 Oct 2017 11:20:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-05 at 00:04:30 UTC, Thiago Jung Bauermann wrote:
> It turns out that not all paths calling arch_update_cpu_topology hold
> cpu_hotplug_lock, but that's ok because those paths aren't supposed to race
> with any concurrent hotplug events.
> 
> Callers of arch_update_cpu_topology are expected to know what they are
> doing when they call the function without holding the lock, so remove the
> lockdep warning.
...
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Fixes: 3e401f7a2e51 ("powerpc: Only obtain cpu_hotplug_lock if called by rtasd")
> Link: https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-September/163244.html
> Link: https://github.com/linuxppc/linux/issues/106

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6b2c08f989250c54f31b53dba9ace8

cheers
