Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 4E4D5DDE00
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 01:46:05 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so598720pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Apr 2008 07:46:04 -0700 (PDT)
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart 16550.
From: Josh Boyer <jwboyer@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200804030616.09825.arnd@arndb.de>
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
	<200804030134.11437.arnd@arndb.de>
	<fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
	<200804030616.09825.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 05 Apr 2008 09:45:56 -0500
Message-Id: <1207406756.6809.2.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, John Linn <john.linn@xilinx.com>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-03 at 06:16 +0200, Arnd Bergmann wrote:
> On Thursday 03 April 2008, Grant Likely wrote:
> > >
> > >  Since it is not really compatible with ns16550, shouldn't you at least specify
> > >  a different "compatible" property? That way, the driver won't do incorrect
> > >  accesses when you try to use an old driver with a device tree that specifies
> > >  one of these.
> > 
> > Heh; we've gone back and forth on this issue.  The problem is that we
> > have a common case of ns16550 like devices that require a little bit
> > of register address tweaking that spans a whole range of vendors (so
> > adding a compatible match with each of those vendor's prefixes is
> > probably non-scalable).  So, if "ns16550" is not a good idea, then
> > what should be used?  "sparse16550" has been suggested more than once.
> 
> After another IRC discussion between Grant, Segher and myself, we concluded
> that we don't need to invent a new "compatible" value, as only new device
> trees with old kernels will have a problem with this, and they don't work
> in the first place.
> 
> The devices will still have their specific "compatible" value, e.g.
> "xlnx,plb-uart16550-1.00.c", followed by "ns16550", and possibly
> "ns16450" and "i8250", although the last two do not have an effect
> on Linux.
> 
> Josh, can you please forward all three patches in their latest version?
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

So is the discussion on reg-offset settled then?  It seemed Paul and
David had some issues with that, and I'd like to make sure everyone is
agreed on that before I bring in patches 2 and 3.

josh
