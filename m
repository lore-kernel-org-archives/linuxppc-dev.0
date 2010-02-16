Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 8714EB7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 03:01:48 +1100 (EST)
Received: by ywh39 with SMTP id 39so5286380ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 08:01:46 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1256245888-25210-4-git-send-email-w.sang@pengutronix.de>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-4-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 09:01:20 -0700
Message-ID: <fa686aa41002160801k7a277567r50d71fb9d827203b@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c/ibm-iic: drop NO_IRQ
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 22, 2009 at 2:11 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driver=
 is
> only used on powerpc, where NO_IRQ is 0 anyhow.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sean MacLennan <smaclennan@pikatech.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Ben, will you pick up this series of 3, or would you like me to merge
them through the powerpc tree?

Thanks,
g.

> ---
> =A0drivers/i2c/busses/i2c-ibm_iic.c | =A0 14 +++++++-------
> =A01 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ib=
m_iic.c
> index b1bc6e2..2bef534 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -668,12 +668,12 @@ static int __devinit iic_request_irq(struct of_devi=
ce *ofdev,
> =A0 =A0 =A0 =A0int irq;
>
> =A0 =A0 =A0 =A0if (iic_force_poll)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> =A0 =A0 =A0 =A0irq =3D irq_of_parse_and_map(np, 0);
> - =A0 =A0 =A0 if (irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 if (!irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "irq_of_parse_and_map=
 failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Disable interrupts until we finish initialization, assu=
mes
> @@ -683,7 +683,7 @@ static int __devinit iic_request_irq(struct of_device=
 *ofdev,
> =A0 =A0 =A0 =A0if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "request_irq %d faile=
d\n", irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fallback to the polling mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return irq;
> @@ -719,7 +719,7 @@ static int __devinit iic_probe(struct of_device *ofde=
v,
> =A0 =A0 =A0 =A0init_waitqueue_head(&dev->wq);
>
> =A0 =A0 =A0 =A0dev->irq =3D iic_request_irq(ofdev, dev);
> - =A0 =A0 =A0 if (dev->irq =3D=3D NO_IRQ)
> + =A0 =A0 =A0 if (!dev->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&ofdev->dev, "using polling mode\=
n");
>
> =A0 =A0 =A0 =A0/* Board specific settings */
> @@ -766,7 +766,7 @@ static int __devinit iic_probe(struct of_device *ofde=
v,
> =A0 =A0 =A0 =A0return 0;
>
> =A0error_cleanup:
> - =A0 =A0 =A0 if (dev->irq !=3D NO_IRQ) {
> + =A0 =A0 =A0 if (dev->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iic_interrupt_mode(dev, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dev->irq, dev);
> =A0 =A0 =A0 =A0}
> @@ -790,7 +790,7 @@ static int __devexit iic_remove(struct of_device *ofd=
ev)
>
> =A0 =A0 =A0 =A0i2c_del_adapter(&dev->adap);
>
> - =A0 =A0 =A0 if (dev->irq !=3D NO_IRQ) {
> + =A0 =A0 =A0 if (dev->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iic_interrupt_mode(dev, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dev->irq, dev);
> =A0 =A0 =A0 =A0}
> --
> 1.6.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
