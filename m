Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0148.outbound.protection.outlook.com [157.56.110.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D35821A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 09:01:19 +1000 (AEST)
Message-ID: <1430953265.16357.310.camel@freescale.com>
Subject: Re: [v4] clk: qoriq: Add support for the FMan clock
From: Scott Wood <scottwood@freescale.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 6 May 2015 18:01:05 -0500
In-Reply-To: <20150506222508.GA21794@codeaurora.org>
References: <1429185945-6949-1-git-send-email-igal.liberman@freescale.com>
 <20150506070247.GA27050@codeaurora.org>
 <1430897672.16357.279.camel@freescale.com>
 <20150506222508.GA21794@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Wed, 2015-05-06 at 15:25 -0700, Stephen Boyd wrote:
> On 05/06, Scott Wood wrote:
> > On Wed, 2015-05-06 at 00:02 -0700, Stephen Boyd wrote:
> > > On 04/16, Igal.Liberman wrote:
> > > > +static int get_fm_clk_idx(int fm_id, int *fm_clk_idx)
> > > > +{
> > > > +	struct ccsr_guts __iomem *guts_regs = NULL;
> > > 
> > > Unnecessary initialization to NULL. Also, marking a structure as
> > > __iomem is odd. Why do we need to use a struct to figure out
> > > offsets for registers? Why not just use #defines? That would
> > > probably also make it easy to avoid the asm include here.
> > 
> > Using a struct for registers is quite common:
> > scott@snotra:~/fsl/git/linux/upstream$ git grep struct|grep __iomem|wc -l
> > 3005
> 
> $ git grep -E 'struct \w+ __iomem' | wc -l
> 2212
> 
> That's slightly inflated, but ok.
> 
> Within drivers/clk there aren't any though, hence my apprehension
> 
> $ git grep -E 'struct \w+ __iomem' -- drivers/clk/ | wc -l
> 0

I'm not sure why clk should be special.  Plus, this is a struct that's
been used by other parts of the kernel since before git history began,
rather than something defined specifically for drivers/clk.

> > It provides type-safety, and makes accessing the registers more natural.
> 
> Sure, we can leave the struct as is, but to make this compile on
> ARM we need to figure something out. Move the struct definition
> into include/linux/platform_data/ perhaps?

It's register definition rather than platform data, but yes, it should
go somewhere in include/linux.  Or I suppose we could put #ifdef
CONFIG_PPC around the fman stuff.

> > > Also unnecessary initialization.
> > 
> > Given the if/else if/else if/... nature of how reg is initialized, this
> > seems like a useful and harmless way of making behavior predictable if
> > there is a bug.
> > 
> 
> If there's a possibility of a bug due to missed initialization
> perhaps it's a sign the code is too complicated and should be
> broken down into smaller functions.

Well, there's always a possibility. :-)

Though rereading this function, reg is only used in the locations where
it's set -- not after the if/else stuff -- so I no longer think this is
a particularly high risk situation.  Plus, GCC's gotten pretty
aggressive about warning about such possibilities.

>  For example, this function could be rewritten to have a match table
> with function pointers that return the fm_clk_idx.

Yes, that'd be nice.

-Scott
