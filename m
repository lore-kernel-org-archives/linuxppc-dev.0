Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5442667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 06:24:28 +1100 (EST)
Date: Tue, 15 Mar 2005 11:24:24 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wade Farnsworth <wfarnsworth@mvista.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050315192424.GC18588@gate.ebshome.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110912458.24527.27.camel@rhino.az.mvista.com>
	<1110913134.24673.32.camel@rhino.az.mvista.com>
	<20050315192216.GB18588@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050315192216.GB18588@gate.ebshome.net>
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
> 

Or to phrase this differently, it's better to avoid any board specific 
code/defines in network driver.

--
Eugene
