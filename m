Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id 5116667A6E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2005 23:27:12 +1100 (EST)
Date: Tue, 8 Mar 2005 13:15:01 +0100
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050308121501.GC4556@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston> <20050308122048.GA22866@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050308122048.GA22866@xyzzy>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Nicolas DET <det.nicolas@free.fr>
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 05:20:48AM -0700, Dale Farnsworth wrote:
> On Tue, Mar 08, 2005 at 06:27:12PM +1100, Benjamin Herrenschmidt wrote:
> > > Notice that benh is telling me that you should use SA_SHIRQ always and that
> > > SA_INTERRUPT should go away, and that you should contact him online if you
> > > have trouble with that.
> > > 
> > > > For the pegasos 2, you'll need the second patch which applies after
> > > > the one I previously sent for chrp_setup.c.
> > > 
> > > Ok, will test this anyway, and tell you how it works.
> > 
> > GHeh, ok, just picked up the discussion. Yes, there is really no reason
> > to use SA_INTERRUPT here, this is a thing of the past.
> 
> Excellent.  Thanks.
> 
> Here's a new patch to try.  :-)

Hehe, i did that myself :)

Anyway, i have another problem though, namely that even though i do
arch_initcall(mv643xx_eth_add_pds), mv643xx_eth_add_pds is never called, and
in the mv643xx_eth driver itself, altough the module init is done, _probe
never gets called. I will now do a build without any #ifdefs around the
chrp_setup.c stuff (And Christophe Hellwig proposed moving the stuff into
arch/ppc/platform/pegasos_mv643xx_eth.c), and see if that will solve it.

Also going to add the explicit detection of the marvell bridge in the OF tree,
but need to decide what to check for there.

Friendly,

Sven Luther
