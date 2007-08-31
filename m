Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 14:25:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] bootwrapper: In cuImage,
	print message for ENET devices not found in tree
Message-ID: <20070831042536.GL19271@localhost.localdomain>
References: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
	<20070831024356.GA19271@localhost.localdomain>
	<fa686aa40708302114g77b916bftb01c14e1b3357506@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40708302114g77b916bftb01c14e1b3357506@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 10:14:41PM -0600, Grant Likely wrote:
> On 8/30/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Thu, Aug 30, 2007 at 02:26:18PM -0600, Grant Likely wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > CC: Scott Wood <scottwood@freescale.com>
> > > CC: Kumar Gala <galak@kernel.crashing.org>
> > > CC: David Gibson <david@gibson.dropbear.id.au>
> >
> > Hrm... I thought Scott had deliberately removed that message in his
> > patch set, to work with the way PlanetCore generates Ethernet
> > addresses.
> 
> I'm confused then.  The code either sets the property or it doesn't.
> >From what I can see, the message doesn't make any sense in the context
> of *not* calling setprop().  How does PlanetCore work?  Scott?

Sorry, I was misleading.  Scott moved the printf() into the if (devp)
as you do, but *didn't* add the alternative warning message in the
else.

The reason for this is that Planetcore only supplies the first MAC
address, and the bootwrapper must derive the addresses for all the
ENETs from that.  That in turn means it is much more convenient to
call fixup_mac_addresses() with more addresses than there are
ethernets, so we don't want a warning message when that happens.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
