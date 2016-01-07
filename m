Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72D51A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 07:45:24 +1100 (AEDT)
Received: by mail-pa0-x22e.google.com with SMTP id cy9so267280621pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 12:45:24 -0800 (PST)
Date: Thu, 7 Jan 2016 12:45:20 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: add FSL_SOC dependency to drivers using FSL_LBC
Message-ID: <20160107204520.GK109450@google.com>
References: <1452194501-115280-1-git-send-email-computersforpeace@gmail.com>
 <1452196053.19133.23.camel@freescale.com>
 <20160107203418.GJ109450@google.com>
 <1452199237.19133.26.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452199237.19133.26.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On Thu, Jan 07, 2016 at 02:40:37PM -0600, Scott Wood wrote:
> On Thu, 2016-01-07 at 12:34 -0800, Brian Norris wrote:
> > On Thu, Jan 07, 2016 at 01:47:33PM -0600, Scott Wood wrote:
> > > On Thu, 2016-01-07 at 11:21 -0800, Brian Norris wrote:
> > > > I've managed to construct .config files (for ppc64) that come across
> > > > this Kconfig warning:
> > > > 
> > > >   warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM)
> > > > selects
> > > > FSL_LBC which has unmet direct dependencies (FSL_SOC)
> > > > 
> > > > Let's add the FSL_SOC dependency to the NAND drivers. AFAICT, they are
> > > > only supported on PPC32 FSL SoCs anyway.
> > > 
> > > There are other problems, if you can enable an 83xx board on ppc64. 
> > >  PPC_83xx
> > > does select FSL_SOC so I don't know why it's unmet.
> > 
> > I don't have an 83xx board enabled. I just have MTD_NAND_FSL_ELBC
> > enabled; it only depends on PPC right now. Attaching the current test
> > .config, for clarity.
> 
> Where did MPC836x_RDK come from above?

I believe that Kconfig warning is misleading. Seems like it should be
saying '||' instead of '&&'. I did not have MPC836x_RDK or
MTD_NAND_FSL_UPM in my .config; only MTD_NAND_FSL_ELBC=y. (Check the
attachment from my previous mail to be sure.)

Regards,
Brian
