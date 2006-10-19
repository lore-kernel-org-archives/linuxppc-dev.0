Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Support for MPIC on native cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200610191638.50652.arnd.bergmann@de.ibm.com>
References: <1160984707.22522.64.camel@localhost.localdomain>
	<200610191638.50652.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 09:40:44 +1000
Message-Id: <1161301244.10524.66.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-19 at 16:38 +0200, Arnd Bergmann wrote:
> On Monday 16 October 2006 09:45, Benjamin Herrenschmidt wrote:
> > +               /* The MPIC driver will get everything it needs from the
> > +                * device-tree, just pass 0 to all arguments
> > +                */
> > +               mpic = mpic_alloc(dn, 0, 0, 0, 0, " MPIC     ");
> 
> Do you expect future users to do the same and just pass zeroes?
> If so, maybe we should add a small wrapper like
> 
> static inline struct mpic *mpic_probe(struct device_node *dn)
> {
> 	return mpic_alloc(dn, 0, 0, 0, 0, " MPIC     ");
> }

Possibly... there are still flags that it can't figure out by itself,
like segher never put "big-endian" in the SLOF DT of the blades etc...

But yes, I might move in that direction.

Ben.
