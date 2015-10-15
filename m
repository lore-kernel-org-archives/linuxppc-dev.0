Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFF161A02BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 06:59:34 +1100 (AEDT)
Date: Thu, 15 Oct 2015 12:53:13 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH v3 2/5] clk: qoriq: Move chip-specific knowledge into
 driver
Message-ID: <20151015195313.GR4558@codeaurora.org>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-3-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442723397-26329-3-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19, Scott Wood wrote:
> The device tree should describe the chips (or chip-like subblocks) in
> the system, but it generally does not describe individual registers --
> it should identify, rather than describe, a programming interface.
> 
> This has not been the case with the QorIQ clockgen nodes.  The
> knowledge of what each bit setting of CLKCnCSR means is encoded in
> three places (binding, pll node, and mux node), and the last also needs
> to know which options are valid on a particular chip.  All three of
> these locations are considered stable ABI, making it difficult to fix
> mistakes (of which I have found several), much less refactor the
> abstraction to be able to address problems, limitations, or new chips.
> 
> Under the current binding, a pll clock specifier of 2 means that the
> PLL is divided by 4 -- and the driver implements this, unless there
> happen to be four clock-output-names rather than 3, in which case it
> interprets it as PLL divided by 3.  This does not appear in the binding
> documentation at all.  That hack is now considered stable ABI.
> 
> The current device tree nodes contain errors, such as saying that
> T1040 can set a core clock to PLL/4 when only PLL and PLL/2 are options.
> The current binding also ignores some restrictions on clock selection,
> such as p5020's requirement that if a core uses the "wrong" PLL, that
> PLL must be clocked lower than the "correct" PLL and be at most 80% of
> the rated CPU frequency.
> 
> Possibly because of the lack of the ability to express such nuance in
> the binding, some valid options are omitted from the device trees, such
> as the ability on p4080 to run cores 0-3 from PLL3 and cores 4-7 from
> PLL1 (again, only if they are at most 80% of rated CPU frequency).
> This omission, combined with excessive caution in the cpufreq driver
> (addressed in a subsequent patch), means that currently on a 1500 MHz
> p4080 with typical PLL configuration, cpufreq can lower the frequency
> to 1200 MHz on half the CPUs and do nothing on the others.  With this
> patchset, all CPUs can be lowered to 1200 MHz on a rev2 p4080, and on a
> rev3 p4080 half can be lowered to 750 MHz and the other half to 600
> MHz.
> 
> The current binding only deals with CPU clocks.  To describe FMan in
> the device tree, we need to describe its clock.  Some chips have
> additional muxes that work like the CPU muxes, but are not described in
> the device tree.  Others require inspecting the Reset Control Word to
> determine which PLL is used.  Rather than continue to extend this mess,
> replace it.  Have the driver bind to the chip-specific clockgen
> compatible, and keep the detailed description of quirky chip variations
> in the driver, where it can be easily fixed, refactored, and extended.
> 
> Older device trees will continue to work (including a workaround for
> old ls1021a device trees that are missing compatible and reg in the
> clockgen node, which even the old binding required).  The pll/mux
> details in old device trees will be ignored, but "clocks" properties
> pointing at the old nodes will still work, and be directed at the
> corresponding new clock.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
