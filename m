Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EFE202C030D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 10:51:58 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
Date: Tue, 10 Dec 2013 14:11:33 +0100
Message-Id: <1386681097-14126-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this series improves the previously introduced common clock support for
MPC512x such that SoC variants 5123 and 5125 get addressed appropriately
(MPC5125 turned out to be rather different from MPC5121 than I perceived
before -- there is much more than "just two FECs and no MBX")

thus this series depends on "add COMMON_CLK support for PowerPC MPC512x"
(v6 sent in <1385851897-23475-1-git-send-email-gsi@denx.de>, applicable
on top of v3.13-rc1 or later, currently applied to mpc5xxx -next,
available at git://git.denx.de/linux-2.6-agust.git next)

this series does not address the issue of outdated or missing device
tree binding documentation for MPC512x peripherals -- that's the scope
of a pending separate series

v1 initial submission (2013-12-10)
- enforce an even divider value for SDHC (on all MPC512x variants)
- tell 5121/5123/5125 SoC variants apart and only register the
  appropriate set of clock items (i.e. refuse to access unused and
  reserved bits, and support those components which are only found on
  MPC5125)
- update the MPC5125 "tower" board DTS (although the code still works in
  the absence of device tree clock specs)

the series passes 'checkpatch.pl --strict' except for two warnings which
cannot get fixed because <linux/clk-provider.h> dictates the data type
and "fixing" the warning would break the build

  WARNING: static const char * array should probably be static const char * const
  #256: FILE: arch/powerpc/platforms/512x/clock-commonclk.c:500:
  +static const char *parent_names_mux0_spdif[] = {

  WARNING: static const char * array should probably be static const char * const
  #260: FILE: arch/powerpc/platforms/512x/clock-commonclk.c:504:
  +static const char *parent_names_mux0_canin[] = {

  total: 0 errors, 2 warnings, 0 checks, 495 lines checked

the series was build-tested, and was run-tested on the MPC5121 ADS board

Matteo, can you verify the crystal frequency in the DTS update, please?
And that v3.13-rc kernels with v6 of the COMMON_CLK introduction for
MPC512x plus this series for MPC5125 operate your peripherals, both with
an updated device tree as well as with a former device tree that lacks
clock specs?  Thank you!  Setting CONFIG_COMMON_CLK_DEBUG=y in your
.config and eyeballing /sys/kernel/debug/clk/clk_summary will help you.

Gerhard Sittig (4):
  powerpc/512x: clk: minor comment updates
  powerpc/512x: clk: enforce even SDHC divider values
  powerpc/512x: clk: support MPC5121/5123/5125 SoC variants
  powerpc/512x: dts: add MPC5125 clock specs

 arch/powerpc/boot/dts/mpc5125twr.dts          |   53 +++-
 arch/powerpc/include/asm/mpc5121.h            |    7 +-
 arch/powerpc/platforms/512x/clock-commonclk.c |  369 +++++++++++++++++++++----
 include/dt-bindings/clock/mpc512x-clock.h     |    9 +-
 4 files changed, 386 insertions(+), 52 deletions(-)

-- 
1.7.10.4
