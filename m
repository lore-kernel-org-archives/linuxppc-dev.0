Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id CE53F67F79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 13:17:47 +1000 (EST)
Date: Tue, 16 Aug 2005 20:17:45 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Otto Solares <solca@guug.org>
Message-ID: <20050816201745.C2246@cox.net>
References: <20050812032819.GA4763@guug.org> <20050815222510.C28706@cox.net>
	<20050816211259.GB28419@guug.org> <20050816141908.A1053@cox.net>
	<20050817024745.GA30824@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050817024745.GA30824@guug.org>;
	from solca@guug.org on Tue, Aug 16, 2005 at 08:47:45PM -0600
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Redwood-6 and 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 16, 2005 at 08:47:45PM -0600, Otto Solares wrote:
> On Tue, Aug 16, 2005 at 02:19:08PM -0700, Matt Porter wrote:
> > On Tue, Aug 16, 2005 at 03:12:59PM -0600, Otto Solares wrote:
> > > Now, when 'make znetboot' in 2.4 there was a zImage.embedded, is the
> > > same thing as zImage.treebot that appears now in 2.6?
> > 
> > Yes, this is the image that boots on the stock OpenBIOS firmware.
> > It has the standard "tree" header on it.
> 
> Thank you, just one more thing, do you know if the smc91x driver
> works for PPC?  In 2.4 I had to set:

It should work.
 
> CONFIG_SMC91111=y
> CONFIG_SMC91111_ADVANCED=y
> CONFIG_SMC91111_BYTE_SWAP=y
> 
> Looking in the driver itself I think it was developed for ARM.

Well, the ARM folks were the earliest users of smc9xxxx glued
onto their parts. There have been multiple drivers over the years
and then Nico recently unified them into smc91x.  PPC has always
had PCI Ethernets or on-chips Ethernet (like the other 4xx parts)
so having a nasty little smc part glued onto a bus isn't that
popular. :) 

It should still work.  Dale Farnsworth took the time to add the
proper redwood specific bits to smc91x.h for accessing the regs
and add the bits to instantiate an smc91x platform device in the
redwood kernel ports.

> I am unable to netboot, I don't have serial console so my only access
> to this little box (MediaMVP) is the net.  Thank you.
 
What kernel port are you using?  You're trying boot a Redwood 6
kernel on the MediaMVP?

-Matt
