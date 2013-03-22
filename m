Return-Path: <jason@lakedaemon.net>
Date: Fri, 22 Mar 2013 10:29:24 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
Message-ID: <20130322142924.GK13280@titan.lakedaemon.net>
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363959568-16976-1-git-send-email-florian@openwrt.org>
 <20130322141423.GJ13280@titan.lakedaemon.net>
 <514C69B7.8090106@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <514C69B7.8090106@openwrt.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 22, 2013 at 03:24:55PM +0100, Florian Fainelli wrote:
> Le 03/22/13 15:14, Jason Cooper a =E9crit :
> >On Fri, Mar 22, 2013 at 02:39:24PM +0100, Florian Fainelli wrote:
> >>Hi all,
> >>
> >>This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus=
 driver
> >>instead of rolling its own implementation. As a result, all users of =
this
> >>mv643xx_eth driver are converted to register an "orion-mdio" platform=
_device.
> >>The mvmdio driver is also updated to support an interrupt line which =
reports
> >>SMI error/completion, and to allow traditionnal platform device regis=
tration
> >>instead of just device tree.
> >>
> >>David, I think it makes sense for you to merge all of this, since we =
do
> >>not want the architecture files to be desynchronized from the mv643xx=
_eth to
> >>avoid runtime breakage. The potential for merge conflicts should be v=
ery small.
> >>
> >>Florian Fainelli (4):
> >>   net: mvmdio: allow platform device style registration
> >>   net: mvmdio: rename base register cookie from smireg to regs
> >>   net: mvmdio: enhance driver to support SMI error/done interrupts
> >>   mv643xx_eth: convert to use the Marvell Orion MDIO driver
> >>
> >>  .../devicetree/bindings/net/marvell-orion-mdio.txt |    3 +
> >>  arch/arm/plat-orion/common.c                       |   54 +++---
> >>  arch/powerpc/platforms/chrp/pegasos_eth.c          |   20 ++
> >>  arch/powerpc/sysdev/mv64x60_dev.c                  |   16 +-
> >>  drivers/net/ethernet/marvell/Kconfig               |    5 +-
> >>  drivers/net/ethernet/marvell/Makefile              |    2 +-
> >>  drivers/net/ethernet/marvell/mv643xx_eth.c         |  195 ++-------=
-----------
> >>  drivers/net/ethernet/marvell/mvmdio.c              |  130 +++++++++=
+---
> >>  include/linux/mv643xx_eth.h                        |    1 -
> >>  9 files changed, 187 insertions(+), 239 deletions(-)
> >
> >Whole series applied on top of v3.9-rc3 and tested on dreamplug
> >(kirkwood DT boot with legacy mv643xx_eth init)
>=20
> Ok, thanks! Does that mean that you want these changes to go via
> your tree? David initially applied my v2 of this patchset, and since
> it thouches mostly ethernet driver stuff, I would rather make it go
> via his tree if both of you agree.

Yeah, I thought I should have reworded that after I hit send :)  I
simply meant it applied cleanly against v3.9-rc3, booted, and worked.  I
Acked it so David could take the whole series through his tree.  Sorry
for the confusion.

Now that I can build mv643xx_eth DT on top of this, I'll structure it so
those changes go on top of yours (in David's tree) and try to avoid the
external dependency for the DT bits going though arm-soc.

thx,

Jason.
