Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D2E467A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:03:59 +1100 (EST)
Date: Thu, 10 Mar 2005 08:03:56 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Message-ID: <20050310160356.GD19275@gate.ebshome.net>
References: <200503101106.53345.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503101106.53345.g.jaeger@sysgo.com>
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

On Thu, Mar 10, 2005 at 11:06:53AM +0100, Gerhard Jaeger wrote:
> the patch has been posted in October last year (wow, thought it was in
> december or so):
> http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015811.html
> 
> I think it needs some cleanup to apply correctly, but the issue is still
> the same -  the RGMII bridge needs to be setup again after the EMAC has 
> been reset. This problem occurs, when the speed is != 100Mbs, then
> the clocking for the phy is not correct. 
> I have attached an updated patch, which first checks the PHY speed, then
> according to that speed the RGMII and ZMII will be setup...

[snip]

OK, from quick look it seems that this is infamous problem with PHYs 
which don't generate Rx clock if there is no link.

Current driver works sometimes probably just by luck.

Gerhard, there is an experimental NAPI driver for 4xx at 
http://kernel.ebshome.net (for current 2.4 & 2.6 BK trees). I recently 
added full 440GX support. We (Matt and I) are thinking about 
scraping the current driver and using my new version sometimes in the 
future. It'd be great if you could find some time and try this new 
driver on your board. Enable "PHY Rx clock workaround" in driver 
config.

Feel free to contact me directly if you have any problems with this 
driver (e.g. applying patch to an older kernel version, etc).

--
Eugene
