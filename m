Return-Path: <dgibson@ozlabs.org>
Date: Tue, 1 Apr 2008 13:22:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 6/9] [POWERPC] prpmc2800: clean up dts properties
Message-ID: <20080401022222.GC32615@localhost.localdomain>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234900.GF30214@farnsworth.org>
	<20080329215942.GB27226@lixom.net>
	<20080330101128.GA20077@localhost.localdomain>
	<20080331164302.GC13750@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080331164302.GC13750@farnsworth.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2008 at 09:43:02AM -0700, Dale Farnsworth wrote:
> On Sun, Mar 30, 2008 at 09:11:28PM +1100, David Gibson wrote:
> > On Sat, Mar 29, 2008 at 04:59:42PM -0500, Olof Johansson wrote:
> > > On Fri, Mar 28, 2008 at 04:49:00PM -0700, Dale Farnsworth wrote:
> > > > From: Mark A. Greer <mgreer@mvista.com>
> > > > 
> > > > Remove several unused (or software config only) properties.
> > > > Rename marvel node to "soc".  Technically, it's not an SOC,
> > > > but its organization is the same as an SOC.  Also, rename the
> > > > "block-index" property to "cell-index" to conform to current
> > > > practice.
> > > 
> > > I see this rename as purely misleading. It isn't an soc, so it shouldn't
> > > be named as such. Call it system-controller or something. Pretty much
> > > any other name is better. :-)
> > 
> > I agree.  system-controller, host-bridge, north-bridge, maybe, but not
> > soc.  With current conventions, the node name is primarily for the
> > benefit of human readers, so if it misleads it has failed entirely in
> > its purpose.
> 
> I'm convinced.  I'll change it to system-controller.
> 
> However, I can't resist pointing out that in the existing devtrees
> with a "soc" node, the name is also misleading.  That node doesn't
> refer to the SOC itself, but to the part of the SOC containing the
> peripherals.  Whether the system is implemented on one or two chips
> is an implementation detail irrelevant to the drivers or device
> tree.

Well, quite so.  It's not even all of the peripherals on the SOC, just
the ones on Freescale SoCs that are relocatable by the IMMR register.
Which is why 4xx SoCs don't use /soc and instead have separate nodes
for the on-chip busses.

However, /soc is established now, but let's not accrete it with any
more badly named examples.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
