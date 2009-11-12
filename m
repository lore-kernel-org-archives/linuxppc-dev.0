Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 1C5FAB7B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 05:39:30 +1100 (EST)
Date: Thu, 12 Nov 2009 19:39:26 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCHv2 0/3] mpc52xx/wdt: re-enable the MPC5200 WDT
To: "Likely, Grant" <grant.likely@secretlab.ca>, Linux PPC Development
	<linuxppc-dev@ozlabs.org>, Devicetree Discussions
	<devicetree-discuss@lists.ozlabs.org>, Wim Van Sebroeck <wim@iguana.be>
Message-Id: <1258051166.2280.0@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches merges the MPC5200 WDT into the GPT code, making it
functional again - currently, the MPC5200 GPT code blocks using the WDT.

Additionally, it defines a new OF property as to reserve and/or enable the
WDT during the boot process which may be a requirement for safety-related
(e.g. ISO/EN 61508) applications.

Note that all patches are against Grant Likely's "next" tree.

Compared to the first version of the patch, the basic change is a full merg=
e
of the WDT code into the GPT implementation in arch/powerpc/platforms/52xx.
It makes the old WDT implementation file obsolete.  As a side effect, it is
not possible any more to build the 52xx WDT support as module which shouldn=
't
be a big issue, though.

Cheers, Albrecht.

---

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |   17 +-
 arch/powerpc/include/asm/mpc52xx.h                 |    5 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  328 ++++++++++++++++=
++--
 drivers/watchdog/Kconfig                           |    4 +-
 drivers/watchdog/Makefile                          |    1 -
 5 files changed, 331 insertions(+), 24 deletions(-)
