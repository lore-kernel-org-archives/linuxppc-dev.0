Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EBE667C25
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 05:04:04 +1100 (EST)
In-Reply-To: <20061212113653.2da563a7.kim.phillips@freescale.com>
References: <20061212113653.2da563a7.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E4A6C67-E44F-40DF-B540-064876B91623@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Tue, 12 Dec 2006 12:03:56 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 11:36 AM, Kim Phillips wrote:

> Eliminate code redundancy.  mpc83[246]x_{mds,itx,sys,pb} files merged
> into a single setup.c.  machine definitions moved to machdefs.c with
> corresponding probe fns.  This patch also utilizes  
> of_platform_bus_probe()
> in lieu of manually calling of_platform_device_create for each  
> ucc_geth device.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>
>  arch/powerpc/kernel/of_platform.c         |    1 +
>  arch/powerpc/platforms/83xx/Makefile      |    6 +-
>  arch/powerpc/platforms/83xx/machdefs.c    |  126 +++++++++++++++
>  arch/powerpc/platforms/83xx/mpc832x_mds.c |  232  
> ----------------------------
>  arch/powerpc/platforms/83xx/mpc832x_mds.h |   19 ---
>  arch/powerpc/platforms/83xx/mpc834x_itx.c |  121 ---------------
>  arch/powerpc/platforms/83xx/mpc834x_itx.h |   23 ---
>  arch/powerpc/platforms/83xx/mpc834x_sys.c |  140 -----------------
>  arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 ---
>  arch/powerpc/platforms/83xx/mpc8360e_pb.c |  236  
> -----------------------------
>  arch/powerpc/platforms/83xx/mpc83xx.h     |    2 +
>  arch/powerpc/platforms/83xx/setup.c       |  188 ++++++++++++++++++ 
> +++++
>  12 files changed, 318 insertions(+), 799 deletions(-)

We should split machdefs into <BOARD>.c and then fixup the Kconfig to  
you can build all of them together?  I think this would be more clear  
and makes for good examples on how a custom board port should go.

- k
