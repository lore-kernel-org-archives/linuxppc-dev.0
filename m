Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4CB962C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:37:57 +1100 (EST)
Date: Sat, 7 Dec 2013 10:37:49 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 04/17] clk: mpc512x: introduce COMMON_CLK for MPC512x
 (disabled)
Message-ID: <20131207103749.2fa8cb77@crub>
In-Reply-To: <1385851897-23475-5-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-5-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Turquette <mturquette@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:24 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> this change implements a clock driver for the MPC512x PowerPC platform
> which follows the COMMON_CLK approach and uses common clock drivers
> shared with other platforms
> 
> this driver implements the publicly announced set of clocks (those
> listed in the dt-bindings header file), as well as generates additional
> 'struct clk' items where the SoC hardware cannot easily get mapped to
> the common primitives (shared code) of the clock API, or requires
> "intermediate clock nodes" to represent clocks that have both gates and
> dividers
> 
> the previous PPC_CLOCK implementation is kept in place and remains
> active for the moment, the newly introduced CCF clock driver will
> receive additional support for backwards compatibility in a subsequent
> patch before it gets enabled and will replace the PPC_CLOCK approach
> 
> some of the clock items get pre-enabled in the clock driver to not have
> them automatically disabled by the underlying clock subsystem because of
> their being unused -- this approach is desirable because
> - some of the clocks are useful to have for diagnostics and information
>   despite their not getting claimed by any drivers (CPU, internal and
>   external RAM, internal busses, boot media)
> - some of the clocks aren't claimed by their peripheral drivers yet,
>   either because of missing driver support or because device tree specs
>   aren't available yet (but the workarounds will get removed as the
>   drivers get adjusted and the device tree provides the clock specs)
> 
> clkdev registration provides "alias names" for few clock items
> - to not break those peripheral drivers which encode their component
>   index into the name that is used for clock lookup (UART, SPI, USB)
> - to not break those drivers which use names for the clock lookup which
>   were encoded in the previous PPC_CLOCK implementation (NFC, VIU, CAN)
> this workaround will get removed as these drivers get adjusted after
> device tree based clock lookup has become available
> 
> the COMMON_CLK implementation copes with device trees which lack an
> oscillator node (backwards compat), the REF clock is then derived from
> the IPS bus frequency and multiplier values fetched from hardware
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/platforms/512x/Makefile          |    4 +-
>  arch/powerpc/platforms/512x/clock-commonclk.c |  798 +++++++++++++++++++++++++
>  include/linux/clk-provider.h                  |   16 +
>  3 files changed, 817 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c

applied to next. Thanks!

Anatolij
