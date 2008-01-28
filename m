Return-Path: <olof@lixom.net>
Date: Mon, 28 Jan 2008 10:23:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] Cell IOMMU static mapping support
Message-ID: <20080128162343.GA19859@lixom.net>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
	<20080126025117.GA28066@lixom.net>
	<200801281241.49059.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200801281241.49059.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 28, 2008 at 12:41:48PM +0100, Arnd Bergmann wrote:
> On Saturday 26 January 2008, Olof Johansson wrote:
> > > 
> > > So instead of having an IOMMU window that we use to temporarily map things
> > > in and out of DMA'able space, at boot we create a 1:1 mapping for all of
> > > memory. This obviously only works for devices that can do 64-bit DMA.
> > 
> > I don't get it. Why not disable the iommu instead?
> > 
> 
> When you disable the iommu, the 32-bit devices stop working because
> they can no longer access all of main memory.
> 
> The 1:1 mapping is in addition to the DMA window used for those devices,
> not in place of it.

Ok, makes sense.

I was going to protest the hack for >32GB configs, with the motivation
that just using the htab-backed window is way too small for such a
config. However, with 32GB memory and 4K pages, that window is 512MB, so
we should be fine.

Having that described in the patch (or at least in the patch description)
to make it more clear could be good. That, and the fact that the mapping
is offset on <32GB memory machines, and thus not really a 1:1 mapping.

Does the cell I/O bridge reflect out accesses to 2-4GB on the bus
again? If not, that could be another place to stick the dynamic range
for large config machines.


-Olof
