Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B999767A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 03:52:39 +1000 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050315133710.B5861@cox.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110912458.24527.27.camel@rhino.az.mvista.com>
	<1110913134.24673.32.camel@rhino.az.mvista.com>
	<20050315192216.GB18588@gate.ebshome.net>
	<20050315133710.B5861@cox.net>
Content-Type: text/plain
Message-Id: <1112032352.24527.239.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 28 Mar 2005 10:52:32 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 3/3] PPC440EP IBM EMAC support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-15 at 13:37, Matt Porter wrote:
> On Tue, Mar 15, 2005 at 11:22:16AM -0800, Eugene Surovegin wrote:
> > On Tue, Mar 15, 2005 at 11:58:54AM -0700, Wade Farnsworth wrote:
> > > This patch adds support to the IBM EMAC ethernet driver for the 440EP.
> > > 
> > > Regards,
> > > Wade Farnsworth
> > > 
> > > Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
> > > 
> > 
> > > --- linux-2.6.11-bk7/drivers/net/ibm_emac/ibm_emac_phy.c	2005-03-02 00:38:13.000000000 -0700
> > > +++ linux-2.6.11-bk7-440ep/drivers/net/ibm_emac/ibm_emac_phy.c	2005-03-11 16:32:01.000000000 -0700
> > > @@ -27,6 +27,12 @@
> > >  
> > >  #include "ibm_emac_phy.h"
> > >  
> > > +#ifdef CONFIG_BAMBOO
> > > +#define BAMBOO_REV0 (mfspr(PVR) == PVR_440EP_RA)
> > > +#else
> > > +#define BAMBOO_REV0 0
> > > +#endif
> > > +
> > 
> > I really don't like it. Chip revision doesn't imply which board 
> > this code is running on. Please, think of some other way to do this or 
> > drop this completely.
> 
> Wade and I talked about this one before and there is no direct way
> to detect the board revision on this platform. Given that, I
> think that if the PVR of the 440EP in a Bamboo board does imply
> the board revision, then this is appropriate.

I emailed AMCC support about the 440EP eval board revision situation and
(finally) got a reply.

It seems there are no plans to replace the Rev 0 boards with Rev 1
boards.  It is, therefore, conceivable that some users will have Rev 0
boards, and will need the workaround in the patch.  Others will have Rev
1 boards, which work fine with the current version of the driver.

So it looks like there will have to be some sort of way to determine
which board the kernel is running on.  According to AMCC, all Rev 0's
have the 440EP Rev A processor and all Rev 1's have the 440EP Rev B
processor.  AMCC also says that the best way for software to determine
to determine which board rev it is running on is to either use the PVR
or the JTAG ID.  I agree this is not an ideal solution, but it seems to
be the best one.

I am, however, open to suggestions, if anyone knows of a better
solution.

Thanks,
-Wade Farnsworth
