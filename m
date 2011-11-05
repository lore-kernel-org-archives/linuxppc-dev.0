Return-Path: <dgibson@ozlabs.org>
Date: Sat, 5 Nov 2011 11:40:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Robert Sciuk <robert.sciuk@exfo.com>
Subject: Re: fpga driver on custom PPC target platform (P4080) ...
Message-ID: <20111105004050.GA1384@truffala.fritz.box>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 04, 2011 at 02:19:36PM -0400, Robert Sciuk wrote:
> > >
> > > I *believe* you are not supposed to create separate nodes for reading
> > > and writing.  I know that's how I2C works, but I think the I2C layer
> > > takes care of that for you.
> > >
> > > If you look at other device trees, you'll see they only have one node
> > > for any particular I2C device.
> > >
> > 
> > 
> > Thanks, Timur ... I've fixed the tree, and I'm tracking down the
> > problems with addressing the nodes ...
> 
> Ah,  my compatible attribute was wrong:
> 
> 	Compatible = "nxp,pca9539";
> 
> 	Should have been:
> 
> 	Compatible = "nxp,pca953x";
> 
> The tree now seems to bind the i2c gpio drivers properly ... on to
> the localbus mappings!

Ah.  In that case the drivers should probably be extended to recognize
the first compatible.  "wildcard" compatible strings are a bad idea,
unfortunately there are some already in the wild, as you've seen.  We
should try to phase them out though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
