Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id A117067A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:12:30 +1100 (EST)
Date: Thu, 10 Mar 2005 09:12:28 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Gerhard Jaeger <g.jaeger@sysgo.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050310091227.B27661@cox.net>
References: <200503101106.53345.g.jaeger@sysgo.com>
	<20050310160356.GD19275@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050310160356.GD19275@gate.ebshome.net>;
	from ebs@ebshome.net on Thu, Mar 10, 2005 at 08:03:56AM -0800
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

On Thu, Mar 10, 2005 at 08:03:56AM -0800, Eugene Surovegin wrote:
> On Thu, Mar 10, 2005 at 11:06:53AM +0100, Gerhard Jaeger wrote:
> > the patch has been posted in October last year (wow, thought it was in
> > december or so):
> > http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015811.html
> > 
> > I think it needs some cleanup to apply correctly, but the issue is still
> > the same -  the RGMII bridge needs to be setup again after the EMAC has 
> > been reset. This problem occurs, when the speed is != 100Mbs, then
> > the clocking for the phy is not correct. 
> > I have attached an updated patch, which first checks the PHY speed, then
> > according to that speed the RGMII and ZMII will be setup...
> 
> [snip]
> 
> OK, from quick look it seems that this is infamous problem with PHYs 
> which don't generate Rx clock if there is no link.

Ok, good, I was just looking an wondering if it was the same issue. 

> Current driver works sometimes probably just by luck.
> 
> Gerhard, there is an experimental NAPI driver for 4xx at 
> http://kernel.ebshome.net (for current 2.4 & 2.6 BK trees). I recently 
> added full 440GX support. We (Matt and I) are thinking about 
> scraping the current driver and using my new version sometimes in the 
> future. It'd be great if you could find some time and try this new 
> driver on your board. Enable "PHY Rx clock workaround" in driver 
> config.

In the meantime, I'll see how this work-around works on some platforms
I have here.

Gerhard: what's the list of 4xx systems (and phys) you have tested
this against? I assume this patch is used on all 4xx platforms you
support in your distro?
