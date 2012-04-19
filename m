Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EE41DB6FC3
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2012 06:15:16 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322669957-8259-1-git-send-email-timur@freescale.com>
Date: Thu, 19 Apr 2012 15:15:02 -0500
Message-Id: <E497D6ED-7447-493A-800D-F7CD5BEEFEAA@kernel.crashing.org>
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, dbaryshkov@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 30, 2011, at 10:19 AM, Timur Tabi wrote:

> Commit 46d026ac ("powerpc/85xx: consolidate of_platform_bus_probe calls")
> replaced platform-specific of_device_id tables with a single function
> that probes the most of the busses in 85xx device trees.  If a specific
> platform needed additional busses probed, then it could call
> of_platform_bus_probe() again.  Typically, the additional platform-specific
> busses are children of existing busses that have already been probed.
> of_platform_bus_probe() does not handle those child busses automatically.
> 
> Unfortunately, this doesn't actually work.  The second (platform-specific)
> call to of_platform_bus_probe() never finds any of the busses it's asked
> to find.
> 
> To remedy this, the platform-specific of_device_id tables are eliminated,
> and their entries are merged into mpc85xx_common_ids[], so that all busses
> are probed at once.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/common.c      |    6 ++++++
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   11 +----------
> arch/powerpc/platforms/85xx/p1022_ds.c    |   13 +------------
> 3 files changed, 8 insertions(+), 22 deletions(-)

applied to merge

- k
