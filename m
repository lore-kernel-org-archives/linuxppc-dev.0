Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 2493B67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:29:05 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Thu, 10 Mar 2005 17:29:02 +0100
References: <200503101106.53345.g.jaeger@sysgo.com>
	<20050310160356.GD19275@gate.ebshome.net>
	<20050310091227.B27661@cox.net>
In-Reply-To: <20050310091227.B27661@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503101729.02348.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 440GX with NS DP83865 phy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 March 2005 17:12, Matt Porter wrote:
> On Thu, Mar 10, 2005 at 08:03:56AM -0800, Eugene Surovegin wrote:
> > On Thu, Mar 10, 2005 at 11:06:53AM +0100, Gerhard Jaeger wrote:
> > > the patch has been posted in October last year (wow, thought it was in
> > > december or so):
> > > http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015811.html
> > > 
> > > I think it needs some cleanup to apply correctly, but the issue is still
> > > the same -  the RGMII bridge needs to be setup again after the EMAC has 
> > > been reset. This problem occurs, when the speed is != 100Mbs, then
> > > the clocking for the phy is not correct. 
> > > I have attached an updated patch, which first checks the PHY speed, then
> > > according to that speed the RGMII and ZMII will be setup...
> > 
> > [snip]
> > 
> > OK, from quick look it seems that this is infamous problem with PHYs 
> > which don't generate Rx clock if there is no link.
> 
> Ok, good, I was just looking an wondering if it was the same issue. 
> 
> > Current driver works sometimes probably just by luck.
> > 
> > Gerhard, there is an experimental NAPI driver for 4xx at 
> > http://kernel.ebshome.net (for current 2.4 & 2.6 BK trees). I recently 
> > added full 440GX support. We (Matt and I) are thinking about 
> > scraping the current driver and using my new version sometimes in the 
> > future. It'd be great if you could find some time and try this new 
> > driver on your board. Enable "PHY Rx clock workaround" in driver 
> > config.
> 
> In the meantime, I'll see how this work-around works on some platforms
> I have here.
> 
> Gerhard: what's the list of 4xx systems (and phys) you have tested
> this against? I assume this patch is used on all 4xx platforms you
> support in your distro?

In the end this patch is used on our 2.4 kernel series (with backported
2.6 EMAC driver). Tested on Walnut, Ebony, Ocotoea and two custom 440gx
boards, one PHY there is the mentionend DP83865 phy and the other phy
is the AMD79C875 (same as on Ebony and Ocotea). I thought, that this 
problem is somewhat phy independant and more or less related to the
way, the phy is connected - here via GMII!

Ciao,
Gerhard
