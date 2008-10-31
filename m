Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BE80DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 21:36:54 +1100 (EST)
Date: Fri, 31 Oct 2008 10:36:46 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.28-rc1: NVRAM being corrupted on ppc64 preventing boot
	(bisected)
Message-ID: <20081031103646.GA24395@csn.ul.ie>
References: <alpine.LFD.2.00.0810232028500.3287@nehalem.linux-foundation.org>
	<20081030142632.GA15645@csn.ul.ie>
	<18698.7794.500191.189515@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <18698.7794.500191.189515@cargo.ozlabs.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 07:52:02AM +1100, Paul Mackerras wrote:
> Mel Gorman writes:
> 
> > On some ppc64 machines, NVRAM is being corrupted very early in boot (before
> > console is initialised). The machine reboots and then fails to find yaboot
> > printing the error "PReP-BOOT: Unable to load PRep image".  It's nowhere near
> > as serious as the ftrace+e1000 problem as the machine is not bricked but it's
> > fairly scary looking, the machine cannot boot and the fix is non-obvious. To
> > "fix" the machine;
> > 
> > 1. Go to OpenFirmware prompt
> > 2. type dev nvram
> > 3. type wipe-nvram
> > 
> > The machine will reboot, reconstruct the NVRAM using some magic and yaboot
> > work again allowing an older kernel to be used. I bisected the problem down
> > to this commit.
> 
> Eek!
> 
> Which ppc64 machines has this been seen on, and how were they being
> booted (netboot, yaboot, etc.)?
> 

Yaboot in my case and I've heard it affected a DVD installation. I don't
know for sure if it affects netboot but as I think it's something the
kernel is doing, it probably doesn't matter how it gets loaded?

> Is it just the Powerstations with their SLOF-based firmware, or is it
> IBM pSeries machines as well?
> 

To be honest, I haven't been brave enough to try this on a Powerstation yet
as I only have the one and I don't know if it's a) affected or b) fixable
with the same workaround. It was an IBM pSeries that was affected in my case
and a few people have hit the problem on pSeries AFARIK.

It's been pointed out that it can be "fixed" by upgrading the firmware but
surely we can avoid breaking the machine in the first place?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
