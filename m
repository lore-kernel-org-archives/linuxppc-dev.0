Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 0A728B7D00
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 03:00:26 +1100 (EST)
Received: by yxe8 with SMTP id 8so9432738yxe.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 08:00:25 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 08:59:54 -0700
Message-ID: <fa686aa41002160759g6abb34a0t3bca718655822a88@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c/cpm: drop NO_IRQ
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
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
> Cc: Jochen Friedrich <jochen@scram.de>
> Cc: Ben Dooks <ben-linux@fluff.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/i2c/busses/i2c-cpm.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index 9c2e100..16948db 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -441,7 +441,7 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c *cp=
m)
> =A0 =A0 =A0 =A0init_waitqueue_head(&cpm->i2c_wait);
>
> =A0 =A0 =A0 =A0cpm->irq =3D of_irq_to_resource(ofdev->node, 0, NULL);
> - =A0 =A0 =A0 if (cpm->irq =3D=3D NO_IRQ)
> + =A0 =A0 =A0 if (!cpm->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0/* Install interrupt handler. */
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
