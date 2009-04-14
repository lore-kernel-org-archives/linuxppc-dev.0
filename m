Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090414222753.GA26006@oksana.dev.rtsoft.ru>
References: <1239733836.5344.83.camel@subratamodak.linux.ibm.com>
	<fa686aa40904141142s3717812ep293973fefce8853d@mail.gmail.com>
	<20090414212724.GA12371@oksana.dev.rtsoft.ru>
	<fa686aa40904141431q2f7575a1sd4ada4ee611b6426@mail.gmail.com>
	<20090414215124.GA20534@oksana.dev.rtsoft.ru>
	<fa686aa40904141454s6bc4d226x8bfb66de5d2d8887@mail.gmail.com>
	<20090414220237.GA21581@oksana.dev.rtsoft.ru>
	<fa686aa40904141519w73f3f724m1393e9ae7e437021@mail.gmail.com>
	<20090414222753.GA26006@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 14 Apr 2009 17:03:52 -0600
Message-ID: <fa686aa40904141603u6b533fcfs401e09b718d35ed3@mail.gmail.com>
Subject: Re: [BUILD FAILURE 11/12] Next April 14 : PPC64 randconfig
	[drivers/spi/mpc52xx_psc_spi.c]
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	David Brownell <dbrownell@users.sourceforge.net>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Damn.  I didn't "reply to all" earlier in the thread.  Adding back the
mailing list.

On Tue, Apr 14, 2009 at 4:27 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Tue, Apr 14, 2009 at 04:19:56PM -0600, Grant Likely wrote:
>> On Tue, Apr 14, 2009 at 4:02 PM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > On Tue, Apr 14, 2009 at 03:54:16PM -0600, Grant Likely wrote:
>> >> On Tue, Apr 14, 2009 at 3:51 PM, Anton Vorontsov
>> >> <avorontsov@ru.mvista.com> wrote:
>> >> > On Tue, Apr 14, 2009 at 03:31:39PM -0600, Grant Likely wrote:
>> >> >> On Tue, Apr 14, 2009 at 3:27 PM, Anton Vorontsov
>> >> >> <avorontsov@ru.mvista.com> wrote:
>> >> >> > On Tue, Apr 14, 2009 at 12:42:47PM -0600, Grant Likely wrote:
>> >> >> >> Thanks Subrata. =A0I'll look into this.
>> >> >> >
>> >> >> > Whoops. That's my fault, I didn't expect that anyone other
>> >> >> > than spi_mpc83xx is using fsl_spi_platform_data. :-/
>> >> >>
>> >> >> /me hands Anton a paper bag.
>> >> >
>> >> > Yeah... :-(
>> >> >
>> >> > This should fix the issue:
>> >>
>> >> Are there any users of this in tree?
>> >
>> > Nope. Sure, we should switch the driver to the gpios =3D <>,
>> > but I believe it's too late for 2.6.30, and FWIW, I can't test
>> > the result on the hardware (don't have any MPC52xx machines).
>> >
>> > So there are two options:
>> >
>> > 1. Remove the cs stuff completely (then the driver would only
>> > =A0 handle SPI devices w/o chipselects, and thus we should state it
>> > =A0 in the Kconfig).
>> > 2. Just fix the build (could also help non-mainline users, if any).
>>
>> Either way will break out of tree users. =A0I don't want to be forced
>> into such a decision during the stablization period. =A0The removal of
>> struct fsl_spi_platform_data needs to be reverted.
>
> Hm. struct fsl_spi_platform_data is still there. It's just there
> is no two functions (activate_cs and deactivate_cs) any longer,
> there's just one: cs_ontrol that takes "spi_device" and "on"
> arguments).
>
> And the build fix (down below) is trivial.

Regardless of how trivial the build fix is for in-tree, I'm not
thrilled with breaking out of tree users.  I don't bend over backwards
for out-of-tree, but the decision should be intentional and not forced
into, especially during the stabilization period.  Please add the
hooks back for 2.6.30.  You can send another patch targeted at 2.6.31
-next to remove them again so that it can be discussed properly on the
list.

g.

>
>> g.
>>
>> >
>> >>
>> >> >
>> >> > ---
>> >> >
>> >> > diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_ps=
c_spi.c
>> >> > index 68c77a9..e1901fd 100644
>> >> > --- a/drivers/spi/mpc52xx_psc_spi.c
>> >> > +++ b/drivers/spi/mpc52xx_psc_spi.c
>> >> > @@ -13,6 +13,7 @@
>> >> >
>> >> > =A0#include <linux/module.h>
>> >> > =A0#include <linux/init.h>
>> >> > +#include <linux/types.h>
>> >> > =A0#include <linux/errno.h>
>> >> > =A0#include <linux/interrupt.h>
>> >> > =A0#include <linux/of_platform.h>
>> >> > @@ -30,8 +31,7 @@
>> >> >
>> >> > =A0struct mpc52xx_psc_spi {
>> >> > =A0 =A0 =A0 =A0/* fsl_spi_platform data */
>> >> > - =A0 =A0 =A0 void (*activate_cs)(u8, u8);
>> >> > - =A0 =A0 =A0 void (*deactivate_cs)(u8, u8);
>> >> > + =A0 =A0 =A0 void (*cs_control)(struct spi_device *spi, bool on);
>> >> > =A0 =A0 =A0 =A0u32 sysclk;
>> >> >
>> >> > =A0 =A0 =A0 =A0/* driver internal data */
>> >> > @@ -111,18 +111,16 @@ static void mpc52xx_psc_spi_activate_cs(struc=
t spi_device *spi)
>> >> > =A0 =A0 =A0 =A0out_be16((u16 __iomem *)&psc->ccr, ccr);
>> >> > =A0 =A0 =A0 =A0mps->bits_per_word =3D cs->bits_per_word;
>> >> >
>> >> > - =A0 =A0 =A0 if (mps->activate_cs)
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->activate_cs(spi->chip_select,
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (spi-=
>mode & SPI_CS_HIGH) ? 1 : 0);
>> >> > + =A0 =A0 =A0 if (mps->cs_control)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control(spi, (spi->mode & SPI=
_CS_HIGH) ? 1 : 0);
>> >> > =A0}
>> >> >
>> >> > =A0static void mpc52xx_psc_spi_deactivate_cs(struct spi_device *spi=
)
>> >> > =A0{
>> >> > =A0 =A0 =A0 =A0struct mpc52xx_psc_spi *mps =3D spi_master_get_devda=
ta(spi->master);
>> >> >
>> >> > - =A0 =A0 =A0 if (mps->deactivate_cs)
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->deactivate_cs(spi->chip_select,
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (spi-=
>mode & SPI_CS_HIGH) ? 1 : 0);
>> >> > + =A0 =A0 =A0 if (mps->cs_control)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control(spi, (spi->mode & SPI=
_CS_HIGH) ? 0 : 1);
>> >> > =A0}
>> >> >
>> >> > =A0#define MPC52xx_PSC_BUFSIZE (MPC52xx_PSC_RFNUM_MASK + 1)
>> >> > @@ -388,15 +386,13 @@ static int __init mpc52xx_psc_spi_do_probe(st=
ruct device *dev, u32 regaddr,
>> >> > =A0 =A0 =A0 =A0mps->irq =3D irq;
>> >> > =A0 =A0 =A0 =A0if (pdata =3D=3D NULL) {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(dev, "probe called without =
platform data, no "
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(de)=
activate_cs function will be called\n");
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->activate_cs =3D NULL;
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->deactivate_cs =3D NULL;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cs_c=
ontrol function will be called\n");
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control =3D NULL;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->sysclk =3D 0;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->bus_num =3D bus_num;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->num_chipselect =3D 255;
>> >> > =A0 =A0 =A0 =A0} else {
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->activate_cs =3D pdata->activate_=
cs;
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->deactivate_cs =3D pdata->deactiv=
ate_cs;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control =3D pdata->cs_control=
;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->sysclk =3D pdata->sysclk;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->bus_num =3D pdata->bus_num;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->num_chipselect =3D pdata->ma=
x_chipselect;
>> >> >
>> >>
>> >>
>> >>
>> >> --
>> >> Grant Likely, B.Sc., P.Eng.
>> >> Secret Lab Technologies Ltd.
>> >
>> > --
>> > Anton Vorontsov
>> > email: cbouatmailru@gmail.com
>> > irc://irc.freenode.net/bd2
>> >
>>
>>
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
