Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 59AAF67A65
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 07:37:12 +1100 (EST)
Date: Tue, 15 Mar 2005 13:37:10 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050315133710.B5861@cox.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110912458.24527.27.camel@rhino.az.mvista.com>
	<1110913134.24673.32.camel@rhino.az.mvista.com>
	<20050315192216.GB18588@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050315192216.GB18588@gate.ebshome.net>;
	from ebs@ebshome.net on Tue, Mar 15, 2005 at 11:22:16AM -0800
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

On Tue, Mar 15, 2005 at 11:22:16AM -0800, Eugene Surovegin wrote:
> On Tue, Mar 15, 2005 at 11:58:54AM -0700, Wade Farnsworth wrote:
> > This patch adds support to the IBM EMAC ethernet driver for the 440EP.
> > 
> > Regards,
> > Wade Farnsworth
> > 
> > Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
> > 
> 
> > --- linux-2.6.11-bk7/drivers/net/ibm_emac/ibm_emac_phy.c	2005-03-02 00:38:13.000000000 -0700
> > +++ linux-2.6.11-bk7-440ep/drivers/net/ibm_emac/ibm_emac_phy.c	2005-03-11 16:32:01.000000000 -0700
> > @@ -27,6 +27,12 @@
> >  
> >  #include "ibm_emac_phy.h"
> >  
> > +#ifdef CONFIG_BAMBOO
> > +#define BAMBOO_REV0 (mfspr(PVR) == PVR_440EP_RA)
> > +#else
> > +#define BAMBOO_REV0 0
> > +#endif
> > +
> 
> I really don't like it. Chip revision doesn't imply which board 
> this code is running on. Please, think of some other way to do this or 
> drop this completely.

Wade and I talked about this one before and there is no direct way
to detect the board revision on this platform. Given that, I
think that if the PVR of the 440EP in a Bamboo board does imply
the board revision, then this is appropriate.

-Matt
