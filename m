Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG70KbRzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:15 +1100 (AEDT)
In-Reply-To: <20171107034301.35120-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jonas Pfefferle1 <JPF@zurich.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel,
 v2] powerpc/powernv/ioda: Remove explicit max window size check
Message-Id: <3yblG653bTz9sPr@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-07 at 03:43:01 UTC, Alexey Kardashevskiy wrote:
> DMA windows can only have a size of power of two on IODA2 hardware and
> using memory_hotplug_max() to determine the upper limit won't work
> correcly if it returns not power of two value.
> 
> This removes the check as the platform code does this check in
> pnv_pci_ioda2_setup_default_config() anyway; the other client is VFIO
> and that thing checks against locked_vm limit which prevents the userspace
> from locking too much memory.
> 
> It is expected to impact DPDK on machines with non-power-of-two RAM size,
> mostly. KVM guests are less likely to be affected as usually guests get
> less than half of hosts RAM.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9003a249815a15704f415954039d1c

cheers
