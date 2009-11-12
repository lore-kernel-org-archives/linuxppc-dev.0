Return-Path: <John.Linn@xilinx.com>
Received: from mail163-va3-R.bigfish.com (mail-va3.bigfish.com
	[216.32.180.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 210C5B7B65
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 04:17:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v2 1/4] xilinx_spi: Split into of driver and generic part.
Date: Thu, 12 Nov 2009 10:17:01 -0700
In-Reply-To: <fa686aa40911120656x3b94b9c7tfabd6e7956ed41fb@mail.gmail.com>
References: <4AFC1B1E.60304@mocean-labs.com>
	<fa686aa40911120656x3b94b9c7tfabd6e7956ed41fb@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	=?iso-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Message-ID: <38eacaec-f0d3-436c-b461-40b5d795cdd9@VA3EHSMHS009.ehs.local>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Thursday, November 12, 2009 7:56 AM
> To: Richard R=F6jfors
> Cc: spi-devel-general@lists.sourceforge.net; linuxppc-dev@ozlabs.org; And=
rew Morton;
> dbrownell@users.sourceforge.net; John Linn
> Subject: Re: [PATCH v2 1/4] xilinx_spi: Split into of driver and generic =
part.
> =

> On Thu, Nov 12, 2009 at 7:26 AM, Richard R=F6jfors
> <richard.rojfors@mocean-labs.com> wrote:
> > This patch splits the xilinx_spi driver into a generic part and a
> > OF driver part.
> >
> > The reason for this is to later add in a platform driver as well.
> >
> > Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
> > ---

<snip>

> > +
> > + =A0 =A0 =A0 if (!ofdev->dev.platform_data) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ofdev->dev.platform_data =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct xsp=
i_platform_data), GFP_KERNEL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ofdev->dev.platform_data)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 =A0 }
> =

> Minor memory leak.  Anything alloced in the probe path should also be
> freed in the remove path.  It's not going to spiral out of control or
> anything, but it is important to be strict about such things.  Drop
> the outer if{} block here and kfree platform_data on remove.
> =

> > +
> > + =A0 =A0 =A0 /* number of slave select bits is required */
> > + =A0 =A0 =A0 prop =3D of_get_property(ofdev->node, "xlnx,num-ss-bits",=
 &len);
> > + =A0 =A0 =A0 if (!prop || len < sizeof(*prop)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bi=
ts' property\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 ofdev->dev.platform_data->num_chipselect =3D *prop;
> =

> Have you compile tested this?  platform_data is a void*, the
> dereference will not work.  I know you don't have hardware; but
> getting the needed cross compiler is easy.

Here's the fixes I did to make it compile. On to testing :)

Thanks,
John

diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
index 13e1591..2dea9f3 100644
--- a/drivers/spi/xilinx_spi_of.c
+++ b/drivers/spi/xilinx_spi_of.c
@@ -39,6 +39,7 @@
 static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 					const struct of_device_id *match)
 {
+	struct xspi_platform_data *pdata =3D ofdev->dev.platform_data;
 	struct resource r_irq_struct;
 	struct resource r_mem_struct;
 	struct spi_master *master;
@@ -74,8 +75,8 @@ static int __init xilinx_spi_of_probe(struct of_device *o=
fdev,
 		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
 		return -EINVAL;
 	}
-	ofdev->dev.platform_data->num_chipselect =3D *prop;
-	ofdev->dev.platform_data->bits_per_word =3D 8;
+	pdata->num_chipselect =3D *prop;
+	pdata->bits_per_word =3D 8;
 	master =3D xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1);
 	if (!master)
 		return -ENODEV;

> =

> > + =A0 =A0 =A0 master =3D xilinx_spi_init(&ofdev->dev, r_mem, r_irq->sta=
rt, -1);
> > + =A0 =A0 =A0 if (!master)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 dev_set_drvdata(&ofdev->dev, master);
> > +
> > + =A0 =A0 =A0 /* Add any subnodes on the SPI bus */
> > + =A0 =A0 =A0 of_register_spi_devices(master, ofdev->node);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
