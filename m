Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EF13B6EF3
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 07:46:22 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322669957-8259-1-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 15:46:07 -0500
Message-Id: <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 30, 2011, at 10:19 AM, Timur Tabi wrote:

> Commit 46d026ac ("powerpc/85xx: consolidate of_platform_bus_probe =
calls")
> replaced platform-specific of_device_id tables with a single function
> that probes the most of the busses in 85xx device trees.  If a =
specific
> platform needed additional busses probed, then it could call
> of_platform_bus_probe() again.  Typically, the additional =
platform-specific
> busses are children of existing busses that have already been probed.
> of_platform_bus_probe() does not handle those child busses =
automatically.
>=20
> Unfortunately, this doesn't actually work.  The second =
(platform-specific)
> call to of_platform_bus_probe() never finds any of the busses it's =
asked
> to find.
>=20
> To remedy this, the platform-specific of_device_id tables are =
eliminated,
> and their entries are merged into mpc85xx_common_ids[], so that all =
busses
> are probed at once.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/common.c      |    6 ++++++
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   11 +----------
> arch/powerpc/platforms/85xx/p1022_ds.c    |   13 +------------
> 3 files changed, 8 insertions(+), 22 deletions(-)

This seems like paper taping over the real issue.  We should be able to =
call of_platform_bus_probe() multiple times.

- k=
