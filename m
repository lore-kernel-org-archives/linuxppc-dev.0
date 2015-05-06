Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 242C31A0561
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 08:25:13 +1000 (AEST)
Date: Wed, 6 May 2015 15:25:08 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4] clk: qoriq: Add support for the FMan clock
Message-ID: <20150506222508.GA21794@codeaurora.org>
References: <1429185945-6949-1-git-send-email-igal.liberman@freescale.com>
 <20150506070247.GA27050@codeaurora.org>
 <1430897672.16357.279.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430897672.16357.279.camel@freescale.com>
Cc: "Igal.Liberman" <igal.liberman@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, mturquette@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06, Scott Wood wrote:
> On Wed, 2015-05-06 at 00:02 -0700, Stephen Boyd wrote:
> > On 04/16, Igal.Liberman wrote:
> > > +static int get_fm_clk_idx(int fm_id, int *fm_clk_idx)
> > > +{
> > > +	struct ccsr_guts __iomem *guts_regs = NULL;
> > 
> > Unnecessary initialization to NULL. Also, marking a structure as
> > __iomem is odd. Why do we need to use a struct to figure out
> > offsets for registers? Why not just use #defines? That would
> > probably also make it easy to avoid the asm include here.
> 
> Using a struct for registers is quite common:
> scott@snotra:~/fsl/git/linux/upstream$ git grep struct|grep __iomem|wc -l
> 3005

$ git grep -E 'struct \w+ __iomem' | wc -l
2212

That's slightly inflated, but ok.

Within drivers/clk there aren't any though, hence my apprehension

$ git grep -E 'struct \w+ __iomem' -- drivers/clk/ | wc -l
0

> 
> It provides type-safety, and makes accessing the registers more natural.

Sure, we can leave the struct as is, but to make this compile on
ARM we need to figure something out. Move the struct definition
into include/linux/platform_data/ perhaps?

> 
> > > +	struct device_node *guts;
> > > +	uint32_t reg = 0;
> > 
> > s/uint32_t/u32/
> 
> Why?

This matches the rest of the file except for one instance of
uint32_t. I googled it and found [1], perhaps that will help.

> 
> > Also unnecessary initialization.
> 
> Given the if/else if/else if/... nature of how reg is initialized, this
> seems like a useful and harmless way of making behavior predictable if
> there is a bug.
> 

If there's a possibility of a bug due to missed initialization
perhaps it's a sign the code is too complicated and should be
broken down into smaller functions. For example, this function
could be rewritten to have a match table with function pointers
that return the fm_clk_idx.

[1] http://lkml.iu.edu/hypermail/linux/kernel/1101.3/02176.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
