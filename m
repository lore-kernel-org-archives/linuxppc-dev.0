Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5E062C0344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 04:12:12 +1100 (EST)
Received: from mail179-ch1 (localhost [127.0.0.1])	by
 mail179-ch1-R.bigfish.com (Postfix) with ESMTP id A96561000E3	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 17:12:06 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.252])	by mail179-ch1.bigfish.com (Postfix) with ESMTP id
 8BE30200C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 17:12:04 +0000 (UTC)
Message-ID: <1381770719.7979.604.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/qe_lib: Share the qe_lib for the others
 architecture
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Mon, 14 Oct 2013 12:11:59 -0500
In-Reply-To: <1381750622-1150-1-git-send-email-X.Xie@freescale.com>
References: <1381750622-1150-1-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-10-14 at 19:37 +0800, Xie Xiaobo wrote:
> The QUICC Engine (QE) is a communications coprocessors on Freescale
> embedded processors. The QE had been applied in PowerPC architecture
> previously, and it will be applied in ARM architecture too.
> So move the qe_lib from arch/powerpc to driver/ firstly.
> 
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
>  arch/powerpc/Kconfig                         |   2 -
>  arch/powerpc/include/asm/immap_qe.h          | 491 -----------------
>  arch/powerpc/include/asm/qe.h                | 740 -------------------------
>  arch/powerpc/include/asm/qe_ic.h             | 144 -----
>  arch/powerpc/include/asm/ucc.h               |  64 ---
>  arch/powerpc/include/asm/ucc_fast.h          | 244 --------
>  arch/powerpc/include/asm/ucc_slow.h          | 290 ----------
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   4 +-
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   4 +-
>  arch/powerpc/platforms/Kconfig               |  19 -
>  arch/powerpc/sysdev/Makefile                 |   1 -
>  arch/powerpc/sysdev/qe_lib/Kconfig           |  27 -
>  arch/powerpc/sysdev/qe_lib/Makefile          |  10 -
>  arch/powerpc/sysdev/qe_lib/gpio.c            | 317 -----------
>  arch/powerpc/sysdev/qe_lib/qe.c              | 708 ------------------------
>  arch/powerpc/sysdev/qe_lib/qe_ic.c           | 501 -----------------
>  arch/powerpc/sysdev/qe_lib/qe_ic.h           | 103 ----
>  arch/powerpc/sysdev/qe_lib/qe_io.c           | 218 --------
>  arch/powerpc/sysdev/qe_lib/ucc.c             | 213 -------
>  arch/powerpc/sysdev/qe_lib/ucc_fast.c        | 364 ------------
>  arch/powerpc/sysdev/qe_lib/ucc_slow.c        | 380 -------------
>  arch/powerpc/sysdev/qe_lib/usb.c             |  56 --
>  drivers/Kconfig                              |   2 +
>  drivers/Makefile                             |   3 +
>  drivers/net/ethernet/freescale/fsl_pq_mdio.c |   2 +-
>  drivers/net/ethernet/freescale/ucc_geth.c    |   8 +-
>  drivers/net/ethernet/freescale/ucc_geth.h    |   8 +-
>  drivers/qe/Kconfig                           |  51 ++
>  drivers/qe/Makefile                          |  10 +
>  drivers/qe/gpio.c                            | 317 +++++++++++
>  drivers/qe/qe.c                              | 708 ++++++++++++++++++++++++
>  drivers/qe/qe_common.c                       | 187 +++++++
>  drivers/qe/qe_ic.c                           | 501 +++++++++++++++++
>  drivers/qe/qe_ic.h                           | 103 ++++
>  drivers/qe/qe_io.c                           | 218 ++++++++
>  drivers/qe/ucc.c                             | 213 +++++++
>  drivers/qe/ucc_fast.c                        | 364 ++++++++++++
>  drivers/qe/ucc_slow.c                        | 380 +++++++++++++
>  drivers/qe/usb.c                             |  56 ++
>  drivers/spi/spi-fsl-cpm.c                    |   2 +-
>  drivers/tty/serial/ucc_uart.c                |   2 +-
>  include/qe/immap_qe.h                        | 491 +++++++++++++++++
>  include/qe/qe.h                              | 794 +++++++++++++++++++++++++++
>  include/qe/qe_ic.h                           | 144 +++++
>  include/qe/ucc.h                             |  64 +++
>  include/qe/ucc_fast.h                        | 244 ++++++++
>  include/qe/ucc_slow.h                        | 290 ++++++++++

Use -M -C with git format-patch.

-Scott
