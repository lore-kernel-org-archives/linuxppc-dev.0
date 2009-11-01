Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 4818AB7C1B
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 12:22:50 +1100 (EST)
Received: by gxk28 with SMTP id 28so515751gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 18:22:49 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1256297157-28246-1-git-send-email-w.sang@pengutronix.de>
References: <1256297157-28246-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 31 Oct 2009 19:22:29 -0600
Message-ID: <fa686aa40910311822i4ba27b2bs350c5684cd57187b@mail.gmail.com>
Subject: Re: [PATCH] spi/mpc52xx: check for invalid PSC usage
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 23, 2009 at 5:25 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Add checks to allow only PSCs capable of SPI.
> Also turn printk to dev_err while we are here.

Hi Wolfram,

I wouldn't even bother.  It's not actively dangerous to try and use
PSC{4,5} in SPI mode.  It just not going to work.  Besides, the
MPC5200 common code already checks for an invalid PSC number when
setting the clock divisor.

Have you seen cases of users trying to do the wrong thing with the
crippled PSCs?

g.

>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> ---
>
> Grant, if the patch is OK, maybe it can also go via your tree?
>
> =A0drivers/spi/mpc52xx_psc_spi.c | =A0 =A09 ++++-----
> =A01 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.=
c
> index 1b74d5c..1d11a6d 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -467,19 +467,18 @@ static int __init mpc52xx_psc_spi_of_probe(struct o=
f_device *op,
>
> =A0 =A0 =A0 =A0regaddr_p =3D of_get_address(op->node, 0, &size64, NULL);
> =A0 =A0 =A0 =A0if (!regaddr_p) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid PSC address\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Invalid PSC address\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0regaddr64 =3D of_translate_address(op->node, regaddr_p);
>
> - =A0 =A0 =A0 /* get PSC id (1..6, used by port_config) */
> + =A0 =A0 =A0 /* get PSC id (only 1,2,3,6 can do SPI) */
> =A0 =A0 =A0 =A0if (op->dev.platform_data =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const u32 *psc_nump;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psc_nump =3D of_get_property(op->node, "ce=
ll-index", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_nump || *psc_nump > 5) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "mpc52xx_ps=
c_spi: Device node %s has invalid "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "cell-index property\n", op->node->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_nump || (*psc_nump > 2 && *psc_num=
p !=3D 5)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "PSC can'=
t do SPI\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0id =3D *psc_nump + 1;
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
