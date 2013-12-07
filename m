Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D64432C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:42:40 +1100 (EST)
Date: Sat, 7 Dec 2013 10:42:37 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 07/17] clk: mpc5xxx: switch to COMMON_CLK, retire
 PPC_CLOCK
Message-ID: <20131207104237.0184de28@crub>
In-Reply-To: <1385851897-23475-8-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-8-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
 Mike Turquette <mturquette@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:27 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> the setup before the change was
> - arch/powerpc/Kconfig had the PPC_CLOCK option, off by default
> - depending on the PPC_CLOCK option the arch/powerpc/kernel/clock.c file
>   was built, which implements the clk.h API but always returns -ENOSYS
>   unless a platform registers specific callbacks
> - the MPC52xx platform selected PPC_CLOCK but did not register any
>   callbacks, thus all clk.h API calls keep resulting in -ENOSYS errors
>   (which is OK, all peripheral drivers deal with the situation)
> - the MPC512x platform selected PPC_CLOCK and registered specific
>   callbacks implemented in arch/powerpc/platforms/512x/clock.c, thus
>   provided real support for the clock API
> - no other powerpc platform did select PPC_CLOCK
> 
> the situation after the change is
> - the MPC512x platform implements the COMMON_CLK interface, and thus the
>   PPC_CLOCK approach in arch/powerpc/platforms/512x/clock.c has become
>   obsolete
> - the MPC52xx platform still lacks genuine support for the clk.h API
>   while this is not a change against the previous situation (the error
>   code returned from COMMON_CLK stubs differs but every call still
>   results in an error)
> - with all references gone, the arch/powerpc/kernel/clock.c wrapper and
>   the PPC_CLOCK option have become obsolete, as did the clk_interface.h
>   header file
> 
> the switch from PPC_CLOCK to COMMON_CLK is done for all platforms within
> the same commit such that multiplatform kernels (the combination of 512x
> and 52xx within one executable) keep working
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/Kconfig                     |    5 -
>  arch/powerpc/include/asm/clk_interface.h |   20 -
>  arch/powerpc/kernel/Makefile             |    1 -
>  arch/powerpc/kernel/clock.c              |   82 ----
>  arch/powerpc/platforms/512x/Kconfig      |    2 +-
>  arch/powerpc/platforms/512x/Makefile     |    1 -
>  arch/powerpc/platforms/512x/clock.c      |  754 ------------------------------
>  arch/powerpc/platforms/52xx/Kconfig      |    2 +-
>  8 files changed, 2 insertions(+), 865 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/clk_interface.h
>  delete mode 100644 arch/powerpc/kernel/clock.c
>  delete mode 100644 arch/powerpc/platforms/512x/clock.c

applied to next. Thanks!

Anatolij
