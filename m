Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id BF8EE67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:22:39 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Thu, 10 Mar 2005 17:22:33 +0100
References: <200503101106.53345.g.jaeger@sysgo.com>
	<20050310160356.GD19275@gate.ebshome.net>
In-Reply-To: <20050310160356.GD19275@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503101722.33597.g.jaeger@sysgo.com>
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

On Thursday 10 March 2005 17:03, Eugene Surovegin wrote:
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
> 
> Current driver works sometimes probably just by luck.
> 
> Gerhard, there is an experimental NAPI driver for 4xx at 
> http://kernel.ebshome.net (for current 2.4 & 2.6 BK trees). I recently 
> added full 440GX support. We (Matt and I) are thinking about 
> scraping the current driver and using my new version sometimes in the 
> future. It'd be great if you could find some time and try this new 
> driver on your board. Enable "PHY Rx clock workaround" in driver 
> config.
> 
> Feel free to contact me directly if you have any problems with this 
> driver (e.g. applying patch to an older kernel version, etc).
> 
Eugene, I will give it a try ASAP. As we are using a heavily patched 2.4 
kernel on the customers board, where came up, it might took some time 
for making it work - but I'll keep you informed.

Thanx
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
