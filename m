Return-Path: <hch@lst.de>
Date: Sat, 7 Oct 2006 10:55:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Cell interrupt rework (final)
Message-ID: <20061007085524.GA3421@lst.de>
References: <1159506029.15792.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1159506029.15792.18.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2006 at 03:00:29PM +1000, Benjamin Herrenschmidt wrote:
> This patch reworks the cell iic interrupt handling so that:
> 
>  - Node ID is back in the interrupt number (only one IRQ host is created
> for all nodes). This allows interrupts from sources on another node to
> be routed non-locally. This will allow possibly one day to fix maxcpus=1
> or 2 and still get interrupts from devices on BE 1. (A bit more fixing
> is needed for that) and it will allow us to implement actual affinity
> control of external interrupts.
> 
>  - Added handling of the IO exceptions interrupts (badly named, but I
> re-used the name initially used by STI). Those are the interrupts
> exposed by IIC_ISR and IIC_IRR, such as the IOC translation exception,
> performance monitor, etc... Those get their special numbers in the IRQ
> number space and are internally implemented as a cascade on unit 0xe,
> class 1 of each node.

Looks good to me.
