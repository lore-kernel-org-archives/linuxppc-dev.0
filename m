Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] Cell IOMMU static mapping support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080128162343.GA19859@lixom.net>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
	<20080126025117.GA28066@lixom.net> <200801281241.49059.arnd@arndb.de>
	<20080128162343.GA19859@lixom.net>
Content-Type: text/plain
Date: Tue, 29 Jan 2008 08:16:17 +1100
Message-Id: <1201554977.6815.189.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-28 at 10:23 -0600, Olof Johansson wrote:
> Ok, makes sense.
> 
> I was going to protest the hack for >32GB configs, with the motivation
> that just using the htab-backed window is way too small for such a
> config. However, with 32GB memory and 4K pages, that window is 512MB, so
> we should be fine.

Might be a problem with 64K pages tho... Or do we use the same
calculation ?

In addition, on those blades, really the only device that is limited to
32 bits (and thus is forced to use the iommu remapped region) is USB.

> Having that described in the patch (or at least in the patch description)
> to make it more clear could be good. That, and the fact that the mapping
> is offset on <32GB memory machines, and thus not really a 1:1 mapping.

Should be called a "linear" mapping.

> Does the cell I/O bridge reflect out accesses to 2-4GB on the bus
> again? If not, that could be another place to stick the dynamic range
> for large config machines.

On the PCI bus itself, 2-4GB is where MMIO sits.

Ben.
