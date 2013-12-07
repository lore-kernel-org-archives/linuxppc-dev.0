Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 35DC22C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 21:05:19 +1100 (EST)
Date: Sat, 7 Dec 2013 11:05:15 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 17/17] clk: mpc512x: remove migration support
 workarounds
Message-ID: <20131207110515.7e534e3b@crub>
In-Reply-To: <1385851897-23475-18-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-18-git-send-email-gsi@denx.de>
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

On Sat, 30 Nov 2013 23:51:37 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> this change removes workarounds which have become obsolete after
> migration to common clock support has completed
> - remove clkdev registration calls (compatibility clock item aliases)
>   after all peripheral drivers were adjusted for device tree based
>   clock lookup
> - remove pre-enable workarounds after all peripheral drivers were
>   adjusted to acquire their respective clock items
> 
> workarounds for these clock items get removed:  FEC (ethernet), I2C,
> PSC (UART, SPI), PSC FIFO, USB, NFC (NAND flash), VIU (video capture),
> BDLC (CAN), CAN MCLK, DIU (video output)
> 
> these clkdev registered names won't be provided any longer by the
> MPC512x platform's clock driver:  "psc%d_mclk", "mscan%d_mclk",
> "usb%d_clk", "nfc_clk", "viu_clk", "sys_clk", "ref_clk"
> 
> the pre-enable workaround for PCI remains, but depends on the presence
> of PCI related device tree nodes (disables the PCI clock in the absence
> of PCI nodes, keeps the PCI clock enabled in the presence of nodes) --
> moving clock acquisition into the peripheral driver isn't possible for
> PCI because its initialization takes place before the platform clock
> driver gets initialized, thus the clock provider isn't available then
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/platforms/512x/clock-commonclk.c |   50 ++++++++-----------------
>  1 file changed, 16 insertions(+), 34 deletions(-)

applied to next. Thanks!

Anatolij
