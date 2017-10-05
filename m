Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7C4j4b72zDr6n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 23:39:00 +1100 (AEDT)
Date: Thu, 5 Oct 2017 14:38:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Black <daniel.black@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Drop lockdep_assert_cpus_held call from
 arch_update_cpu_topology
In-Reply-To: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1710051435530.2083@nanos>
References: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
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

On Wed, 4 Oct 2017, Thiago Jung Bauermann wrote:

> It turns out that not all paths calling arch_update_cpu_topology hold
> cpu_hotplug_lock, but that's ok because those paths aren't supposed to race
> with any concurrent hotplug events.
> 
> Callers of arch_update_cpu_topology are expected to know what they are
> doing when they call the function without holding the lock, so remove the
> lockdep warning.

"Expected to know what they are doing" is not really a good approach as
it's way too simple to screw things up.

You might consider to have two functions where one does the check and the
other does not, but I leave that to the PPC maintainers.

Thanks,

	tglx
