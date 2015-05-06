Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE6BF1A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 17:34:49 +1000 (AEST)
Message-ID: <1430897672.16357.279.camel@freescale.com>
Subject: Re: [v4] clk: qoriq: Add support for the FMan clock
From: Scott Wood <scottwood@freescale.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 6 May 2015 02:34:32 -0500
In-Reply-To: <20150506070247.GA27050@codeaurora.org>
References: <1429185945-6949-1-git-send-email-igal.liberman@freescale.com>
 <20150506070247.GA27050@codeaurora.org>
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

On Wed, 2015-05-06 at 00:02 -0700, Stephen Boyd wrote:
> On 04/16, Igal.Liberman wrote:
> > +static int get_fm_clk_idx(int fm_id, int *fm_clk_idx)
> > +{
> > +	struct ccsr_guts __iomem *guts_regs = NULL;
> 
> Unnecessary initialization to NULL. Also, marking a structure as
> __iomem is odd. Why do we need to use a struct to figure out
> offsets for registers? Why not just use #defines? That would
> probably also make it easy to avoid the asm include here.

Using a struct for registers is quite common:
scott@snotra:~/fsl/git/linux/upstream$ git grep struct|grep __iomem|wc -l
3005

It provides type-safety, and makes accessing the registers more natural.

> > +	struct device_node *guts;
> > +	uint32_t reg = 0;
> 
> s/uint32_t/u32/

Why?

> Also unnecessary initialization.

Given the if/else if/else if/... nature of how reg is initialized, this
seems like a useful and harmless way of making behavior predictable if
there is a bug.

-Scott
