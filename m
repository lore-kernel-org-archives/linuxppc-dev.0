Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1b8219e7d7993d0e8204b94e959477e3007534ce.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<1b8219e7d7993d0e8204b94e959477e3007534ce.1276615626.git.richard.cochran@omicron.at>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 15 Jun 2010 10:43:08 -0600
Message-ID: <AANLkTikeae2t4KmnawOCo2LqfSI57BKjNnUayY09DfEC@mail.gmail.com>
Subject: Re: [PATCH 05/12] phylib: Allow reading and writing a mii bus from
	atomic context.
To: Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> In order to support hardware time stamping from a PHY, it is necessary to
> read from the PHY while running in_interrupt(). This patch allows a mii
> bus to operate in an atomic context. An mii_bus driver may declare itself
> capable for this mode. Drivers which do not do this will remain with the
> default that bus operations may sleep.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Last I checked, the MDIO bus is very slow.  Is this really a good
idea?  How much latency does MDIO access have on the hardware you are
working with?

I also don't like the idea of taking a spin lock during MDIO
operations, and the dual locking mode in the core code.

I'd rather see separate atomic context hooks that doesn't obtain the
mutex under the assumption that the caller has already done so.  If
the bus doesn't support atomic access, then it won't implement the
hooks and the core code should return an error.

I've cc'd Thomas Gleixner.  He might have a better idea about how to
implement what you're trying to do.

g.

> ---
> =A0drivers/net/phy/mdio_bus.c | =A0 35 ++++++++++++++++++++++++++++------=
-
> =A0include/linux/phy.h =A0 =A0 =A0 =A0| =A0 13 +++++++++++--
> =A02 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 6a6b819..441be7d 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -36,6 +36,22 @@
> =A0#include <asm/irq.h>
> =A0#include <asm/uaccess.h>
>
> +static inline void mdiobus_lock(struct mii_bus *bus)
> +{
> + =A0 =A0 =A0 if (MDIOBUS_SLEEPS_RW =3D=3D bus->locktype)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&bus->mdio_lock.m);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&bus->mdio_lock.s);
> +}
> +
> +static inline void mdiobus_unlock(struct mii_bus *bus)
> +{
> + =A0 =A0 =A0 if (MDIOBUS_SLEEPS_RW =3D=3D bus->locktype)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&bus->mdio_lock.m);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&bus->mdio_lock.s);
> +}
> +
> =A0/**
> =A0* mdiobus_alloc - allocate a mii_bus structure
> =A0*
> @@ -107,7 +123,10 @@ int mdiobus_register(struct mii_bus *bus)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mutex_init(&bus->mdio_lock);
> + =A0 =A0 =A0 if (MDIOBUS_SLEEPS_RW =3D=3D bus->locktype)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_init(&bus->mdio_lock.m);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&bus->mdio_lock.s);
>
> =A0 =A0 =A0 =A0if (bus->reset)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->reset(bus);
> @@ -212,11 +231,12 @@ int mdiobus_read(struct mii_bus *bus, int addr, u32=
 regnum)
> =A0{
> =A0 =A0 =A0 =A0int retval;
>
> - =A0 =A0 =A0 BUG_ON(in_interrupt());
> + =A0 =A0 =A0 if (MDIOBUS_SLEEPS_RW =3D=3D bus->locktype)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(in_interrupt());
>
> - =A0 =A0 =A0 mutex_lock(&bus->mdio_lock);
> + =A0 =A0 =A0 mdiobus_lock(bus);
> =A0 =A0 =A0 =A0retval =3D bus->read(bus, addr, regnum);
> - =A0 =A0 =A0 mutex_unlock(&bus->mdio_lock);
> + =A0 =A0 =A0 mdiobus_unlock(bus);
>
> =A0 =A0 =A0 =A0return retval;
> =A0}
> @@ -237,11 +257,12 @@ int mdiobus_write(struct mii_bus *bus, int addr, u3=
2 regnum, u16 val)
> =A0{
> =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 BUG_ON(in_interrupt());
> + =A0 =A0 =A0 if (MDIOBUS_SLEEPS_RW =3D=3D bus->locktype)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(in_interrupt());
>
> - =A0 =A0 =A0 mutex_lock(&bus->mdio_lock);
> + =A0 =A0 =A0 mdiobus_lock(bus);
> =A0 =A0 =A0 =A0err =3D bus->write(bus, addr, regnum, val);
> - =A0 =A0 =A0 mutex_unlock(&bus->mdio_lock);
> + =A0 =A0 =A0 mdiobus_unlock(bus);
>
> =A0 =A0 =A0 =A0return err;
> =A0}
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 7a8caac..352b030 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -98,11 +98,20 @@ struct mii_bus {
> =A0 =A0 =A0 =A0int (*write)(struct mii_bus *bus, int phy_id, int regnum, =
u16 val);
> =A0 =A0 =A0 =A0int (*reset)(struct mii_bus *bus);
>
> + =A0 =A0 =A0 /* Indicates whether bus may be used from an atomic context=
. */
> + =A0 =A0 =A0 enum {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MDIOBUS_SLEEPS_RW,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MDIOBUS_ATOMIC_RW
> + =A0 =A0 =A0 } locktype;
> +
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* A lock to ensure that only one thing can read/write
> + =A0 =A0 =A0 =A0* A lock or mutex to ensure that only one thing can read=
/write
> =A0 =A0 =A0 =A0 * the MDIO bus at a time
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 struct mutex mdio_lock;
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mutex m;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spinlock_t s;
> + =A0 =A0 =A0 } mdio_lock;
>
> =A0 =A0 =A0 =A0struct device *parent;
> =A0 =A0 =A0 =A0enum {
> --
> 1.6.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
