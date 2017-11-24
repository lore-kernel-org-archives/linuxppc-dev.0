Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtg5KsczDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:35 +1100 (AEDT)
In-Reply-To: <1508093022-11496-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/perf/imc: use cpu_to_node instead
 topology_physical_package_id
Message-Id: <3yjrtg3ZtMz9s71@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-10-15 at 18:43:41 UTC, Madhavan Srinivasan wrote:
> ...
> [1069001518.000000] [c000003f95b3f770] [c0000000000b2574] init_imc_pmu+0x1f4/0xc40
> [1069005374.000000] [c000003f95b3f850] [c00000000008fec8] opal_imc_counters_probe+0x2e8/0x3e0
> [1069009426.000000] [c000003f95b3f950] [c0000000006153a4] platform_drv_probe+0x44/0x90
> [1069012818.000000] [c000003f95b3f9c0] [c0000000006124c0] really_probe+0x290/0x370
> [1069016302.000000] [c000003f95b3fa50] [c0000000006126c8] __driver_attach+0x128/0x130
> [1069019564.000000] [c000003f95b3fa90] [c00000000060f38c] bus_for_each_dev+0x9c/0x110
> [1069022838.000000] [c000003f95b3fae0] [c000000000611dfc] driver_attach+0x3c/0x60
> [1069026104.000000] [c000003f95b3fb10] [c0000000006118d8] bus_add_driver+0x298/0x320
> [1069029428.000000] [c000003f95b3fb90] [c0000000006135b8] driver_register+0xb8/0x1a0
> [1069033016.000000] [c000003f95b3fc00] [c00000000061533c] __platform_driver_register+0x8c/0xb0
> [1069036362.000000] [c000003f95b3fc30] [c000000000cbb0fc] opal_imc_driver_init+0x24/0x38
> [1069039756.000000] [c000003f95b3fc50] [c00000000000cc70] do_one_initcall+0xd0/0x250
> [1069043094.000000] [c000003f95b3fd20] [c000000000ca44d0] kernel_init_freeable+0x244/0x324
> [1069046490.000000] [c000003f95b3fdc0] [c00000000000d600] kernel_init+0x30/0x1b0
> [1069050348.000000] [c000003f95b3fe30] [c00000000000b268] ret_from_kernel_thread+0x5c/0x74
> 
> init_imc_pmu() use topology_physical_package_id() to detect the phy_id
> of the processor it is on to get local memory. But this cause crashes
> when node_id are not same as physicaly id. As a fix use cpu_to_node().
> 
> Reported-By: Rob Lippert <rlippert@google.com>
> Tested-By: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f3f1dfd600ff82b18b7ea73d80eb27

cheers
