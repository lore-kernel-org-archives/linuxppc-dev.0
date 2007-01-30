Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E50B4DDF96
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:25:52 +1100 (EST)
Date: Tue, 30 Jan 2007 13:25:27 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] generic RTC support for PPC
Message-Id: <20070130132527.0ee3e9ea.kim.phillips@freescale.com>
In-Reply-To: <20070130160340.GA25443@lixom.net>
References: <20070125073754.GA10004@lixom.net>
	<20070130051736.GH28746@smtp.west.cox.net>
	<0747B3CD-F875-4A28-8199-1A7FF3666301@kernel.crashing.org>
	<20070130160340.GA25443@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	david-b@pacbell.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Jan 2007 10:03:40 -0600
olof@lixom.net (Olof Johansson) wrote:

> On Tue, Jan 30, 2007 at 12:37:12AM -0600, Kumar Gala wrote:
> > 
> > On Jan 29, 2007, at 11:17 PM, Tom Rini wrote:
> > 
> > >On Thu, Jan 25, 2007 at 01:37:54AM -0600, Olof Johansson wrote:
> > >
> > >>Make the PPC RTC functions use the generic RTC infrastructure if they
> > >>are not already defined (and an RTC is registered in the system).
> > >>
> > >>This should make it possible to remove the hideous direct access used
> > >>in some of the 83xx platforms.
> > >
> > >Now, I know I'm a bit late, and I've been quiet of late, but, um,  
> > >why is
> > >there anything other than the RTC class stuff being used?  I know
> > >drivers/char/genrtc.c isn't gone yet, but really, it should be in the
> > >process of being phased out.  IMHO, it should depend on !POWERPC (or
> > >whatever the magic is to allow arch/ppc && !arch/powerpc).
> > 
> > I think the problem was calling the RTC class code from the place's  
> > we use rtc in ppc had locking issues or something like that.
> 
> Yes, and it does a direct call into the driver instead of using the
> subsystem, exporting the symbol from the driver. Not a very pretty
> solution but it's possible that the genrtc stuff wasn't available when
> it was first implemented.
> 
that's probably true.

afaict, this powerpc platform <--> RTC class code glue is totally unnecessary; RTC class sets things up fine on 83xx based boards that have rtc chips supported in RTC class (e.g., the ITX).  I'm referring to the third bullet point here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2

For the MDS boards, which use the ds1374, I'd rather fix the problem properly and add a ds1374 driver to the RTC class.  While Scott Wood (cc'd) has already done the port, I believe his patches are pending some patches by David Brownell.

Kim
