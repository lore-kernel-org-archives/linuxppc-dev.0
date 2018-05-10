Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hKR10RFzzF2RN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 14:06:21 +1000 (AEST)
In-Reply-To: <20180509145818.17254-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mwb@linux.vnet.ibm.com
Subject: Re: powerpc/pseries: Fix CONFIG_NUMA=n build
Message-Id: <40hKR06KKqz9s4Z@ozlabs.org>
Date: Thu, 10 May 2018 14:06:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-09 at 14:58:18 UTC, Michael Ellerman wrote:
> The build is failing with CONFIG_NUMA=n and some compiler versions:
> 
>   arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
>   hotplug-cpu.c:(.text+0x12c): undefined reference to `timed_topology_update'
>   arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_cpu_remove':
>   hotplug-cpu.c:(.text+0x400): undefined reference to `timed_topology_update'
> 
> Fix it by moving the empty version of timed_topology_update() into the
> existing #ifdef block, which has the right guard of SPLPAR && NUMA.
> 
> Fixes: cee5405da402 ("powerpc/hotplug: Improve responsiveness of hotplug change")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/6c0a8f6b5a45ac892a763b6299bd3c

cheers
