Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB62F1A04DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 09:40:10 +1100 (AEDT)
Message-ID: <1445639975.701.257.camel@freescale.com>
Subject: Re: [PATCH v3 0/5] clk: qoriq: Move chip-specific knowledge into
 driver
From: Scott Wood <scottwood@freescale.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@codeaurora.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar
 <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>,
 <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>, Tang
 Yuantian <Yuantian.Tang@freescale.com>, <javier@osg.samsung.com>, Bhupesh
 Sharma <bhupesh.sharma@freescale.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Oct 2015 17:39:35 -0500
In-Reply-To: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-09-19 at 23:29 -0500, Scott Wood wrote:
> The existing device tree bindings are error-prone and inflexible. 
> Correct the mistake by moving the knowledge into the driver, which has
> more flexibility in describing the quirks of each chip.  This leaves the
> device tree to its proper role of identifying a programming interface
> rather than describing its individual registers.
> 
> For more detail, see the commit message of patch 2.
> 
> As there are both ARM and PPC patches that depend on this patchset, I'm
> requesting ACKs from clk and cpufreq in order to put this into a topic
> branch that both ARM and PPC can pull.
> 
> Scott Wood (5):
>   powerpc/fsl: Move fsl_guts.h out of arch/powerpc
>   clk: qoriq: Move chip-specific knowledge into driver
>   clk: qoriq: Add ls2080a support.
>   clk: Add consumer APIs for discovering possible parent clocks
>   cpufreq: qoriq: Don't look at clock implementation details

I've applied the first three patches plus 
http://patchwork.ozlabs.org/patch/534739/ to the clock branch of 
scottwood/linux.git to be used as a basis for PPC and ARM device tree patches.

Note that there is a trivial merge conflict with commit 
4a7748c3d6419bb8178748 ("clk: Allow drivers to build if COMPILE_TEST is 
enabled").  Another option is for these patches to go via the clk tree, and 
the device tree patches will ust go separately.  This would result in 
intermediate commits where the device tree contains clock information that 
the clock driver can't handle, but it would be resolved by -rc1 -- and it 
seems that one of the ARM device tree patches ("dts/ls2080a: Update DTSI to 
add support of various peripherals") was already merged without waiting for 
the clock driver patch.  I could still wait until next merge window to rip 
out the legacy stuff from existing device trees, so it would only affect new 
functionality.

Patch 4 is still waiting for an ack from Russell King, but it appears that 
patch 5 (which depends on patch 4) can probably wait until the next merge 
window.  Without those patches, qoriq-cpufreq should still mostly work, as 
long as the old device trees are used.  Patches 4 and 5 will be needed to 
make qoriq-cpufreq continue to work with device trees using the new binding.

-Scott
