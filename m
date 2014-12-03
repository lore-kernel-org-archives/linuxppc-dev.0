Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A55641A0568
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 11:39:13 +1100 (AEDT)
Message-ID: <1417567137.15957.229.camel@freescale.com>
Subject: Re: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
Date: Tue, 2 Dec 2014 18:38:57 -0600
In-Reply-To: <DM2PR03MB574DB4A270F85EB73EB76CDFA710@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
 <1415333263.23458.417.camel@snotra.buserror.net>
 <DM2PR03MB574DB4A270F85EB73EB76CDFA710@DM2PR03MB574.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Kevin Hao <haokexin@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Gerhard Sittig <gsi@denx.de>, Mike Turquette <mturquette@linaro.org>, Lu
 Jingchang-B35083 <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the current code panics as of commit da788acb2838, then the revert
(but not the other patches) should go to stable as well.

-Scott

On Wed, 2014-11-26 at 21:30 -0600, Tang Yuantian-B29983 wrote:
> Hello Mike,
> 
> Could you please apply this patch?
> This patch has been acked for a while.
> 
> Thanks,
> Yuantian
> 
> > -----Original Message-----
> > From: Linuxppc-dev
> > [mailto:linuxppc-dev-bounces+b29983=freescale.com@lists.ozlabs.org] On
> > Behalf Of Scott Wood
> > Sent: Friday, November 07, 2014 12:08 PM
> > To: Kevin Hao
> > Cc: Mike Turquette; Gerhard Sittig; Lu Jingchang-B35083;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
> > CONFIG_CLK_PPC_CORENET is enabled
> > 
> > On Sun, 2014-10-19 at 14:11 +0800, Kevin Hao wrote:
> > > Hi,
> > >
> > > I have done a boot test on p2014rdb and t4240qds boards. I don't have
> > > an access to mpc512x board, so only build test for that.
> > >
> > > v2:
> > >  - Revert the commit da788acb2838 first.
> > >  - Invoke of_clk_init() from a common place.
> > >
> > > v1
> > > This tries to fix a kernel panic introduced by commit da788acb2838
> > > ("clk: ppc-corenet: Fix Section mismatch warning").
> > >
> > > Kevin Hao (3):
> > >   Revert "clk: ppc-corenet: Fix Section mismatch warning"
> > >   powerpc: call of_clk_init() from time_init()
> > >   clk: ppc-corenet: fix section mismatch warning
> > >
> > >  arch/powerpc/kernel/time.c                    |  5 ++++
> > >  arch/powerpc/platforms/512x/clock-commonclk.c | 11 ++++---
> > >  drivers/clk/clk-ppc-corenet.c                 | 43 ++++-----------------------
> > >  3 files changed, 16 insertions(+), 43 deletions(-)
> > >
> > 
> > Acked-by: Scott Wood <scottwood@freescale.com>
> > 
> > Whose tree should this go through?
> > 
> > -Scott
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
