Return-Path: <olof@lixom.net>
Date: Mon, 28 Jan 2008 15:48:13 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] Cell IOMMU static mapping support
Message-ID: <20080128214813.GA24416@lixom.net>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
	<20080126025117.GA28066@lixom.net>
	<200801281241.49059.arnd@arndb.de>
	<20080128162343.GA19859@lixom.net>
	<1201554977.6815.189.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201554977.6815.189.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 29, 2008 at 08:16:17AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2008-01-28 at 10:23 -0600, Olof Johansson wrote:
> > Ok, makes sense.
> > 
> > I was going to protest the hack for >32GB configs, with the motivation
> > that just using the htab-backed window is way too small for such a
> > config. However, with 32GB memory and 4K pages, that window is 512MB, so
> > we should be fine.
> 
> Might be a problem with 64K pages tho... Or do we use the same
> calculation ?

The current code is hardcoded at page shift 12. That's probably the
safest thing to do, since even though PAGE_SHIFT might be 16, if we're
doing the software-based 64K approach we can't use a smaller table.

See htab_get_table_size() in arch/powerpc/mm/hash_utils_64.c.

> In addition, on those blades, really the only device that is limited to
> 32 bits (and thus is forced to use the iommu remapped region) is USB.
>
> > Having that described in the patch (or at least in the patch description)
> > to make it more clear could be good. That, and the fact that the mapping
> > is offset on <32GB memory machines, and thus not really a 1:1 mapping.
> 
> Should be called a "linear" mapping.

Yep. Linear with a fixed offset.

> > Does the cell I/O bridge reflect out accesses to 2-4GB on the bus
> > again? If not, that could be another place to stick the dynamic range
> > for large config machines.
> 
> On the PCI bus itself, 2-4GB is where MMIO sits.

Depending on the implementation, 2-4GB accesses _from_ PCI could mean
something else. But for most machines it doesn't, and I'm guessing cell
is one of those.


-Olof
