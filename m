Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Cell interrupt rework (final)
Date: Fri, 29 Sep 2006 09:51:06 +0200
References: <1159506029.15792.18.camel@localhost.localdomain>
In-Reply-To: <1159506029.15792.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609290951.07215.arnd@arndb.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 September 2006 07:00, Benjamin Herrenschmidt wrote:
> This patch reworks the cell iic interrupt handling so that:
>=20
> =A0- Node ID is back in the interrupt number (only one IRQ host is created
> for all nodes). This allows interrupts from sources on another node to
> be routed non-locally. This will allow possibly one day to fix maxcpus=3D1
> or 2 and still get interrupts from devices on BE 1. (A bit more fixing
> is needed for that) and it will allow us to implement actual affinity
> control of external interrupts.
>=20
> =A0- Added handling of the IO exceptions interrupts (badly named, but I
> re-used the name initially used by STI). Those are the interrupts
> exposed by IIC_ISR and IIC_IRR, such as the IOC translation exception,
> performance monitor, etc... Those get their special numbers in the IRQ
> number space and are internally implemented as a cascade on unit 0xe,
> class 1 of each node.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
