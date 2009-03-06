Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f175.google.com (mail-gx0-f175.google.com
	[209.85.217.175]) by ozlabs.org (Postfix) with ESMTP id E23D5DE005
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 07:31:42 +1100 (EST)
Received: by gxk23 with SMTP id 23so627135gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 12:31:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090306203044.22371.75222.stgit@localhost.localdomain>
References: <20090306203044.22371.75222.stgit@localhost.localdomain>
Date: Fri, 6 Mar 2009 13:31:41 -0700
Message-ID: <fa686aa40903061231h5d9ef9f4i3d080bf00b6e99fb@mail.gmail.com>
Subject: Re: [PATCH] powerpc/5200: remove sysfs debug file from GPT driver
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram, you were right.  This was a bad idea.  I just took me a bit
longer to clue into it.

g.

On Fri, Mar 6, 2009 at 1:30 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Remove poorly designed debug sysfs attribute entry from the GPT driver.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0 39 -------------------=
----------
> =A01 files changed, 0 insertions(+), 39 deletions(-)
>
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_gpt.c
> index cb038dc..bfbcd41 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -335,44 +335,6 @@ static void
> =A0mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *p, struct device_node =
*np) { }
> =A0#endif /* defined(CONFIG_GPIOLIB) */
>
> -/***********************************************************************
> - * SYSFS attributes
> - */
> -#if defined(CONFIG_SYSFS)
> -static ssize_t mpc52xx_gpt_show_regs(struct device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device_attribute *attr, char *buf)
> -{
> - =A0 =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D dev_get_drvdata(dev);
> - =A0 =A0 =A0 int i, len =3D 0;
> - =A0 =A0 =A0 u32 __iomem *regs =3D (void __iomem *) gpt->regs;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < 4; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 len +=3D sprintf(buf + len, "%.8x ", in_be3=
2(regs + i));
> - =A0 =A0 =A0 len +=3D sprintf(buf + len, "\n");
> -
> - =A0 =A0 =A0 return len;
> -}
> -
> -static struct device_attribute mpc52xx_gpt_attrib[] =3D {
> - =A0 =A0 =A0 __ATTR(regs, S_IRUGO | S_IWUSR, mpc52xx_gpt_show_regs, NULL=
),
> -};
> -
> -static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt)
> -{
> - =A0 =A0 =A0 int i, err =3D 0;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(mpc52xx_gpt_attrib); i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D device_create_file(gpt->dev, &mpc52=
xx_gpt_attrib[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(gpt->dev, "error cr=
eating attribute %i\n", i);
> - =A0 =A0 =A0 }
> -
> -}
> -
> -#else /* defined(CONFIG_SYSFS) */
> -static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { retu=
rn 0; }
> -#endif /* defined(CONFIG_SYSFS) */
> -
> =A0/* -------------------------------------------------------------------=
--
> =A0* of_platform bus binding code
> =A0*/
> @@ -395,7 +357,6 @@ static int __devinit mpc52xx_gpt_probe(struct of_devi=
ce *ofdev,
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&ofdev->dev, gpt);
>
> - =A0 =A0 =A0 mpc52xx_gpt_create_attribs(gpt);
> =A0 =A0 =A0 =A0mpc52xx_gpt_gpio_setup(gpt, ofdev->node);
> =A0 =A0 =A0 =A0mpc52xx_gpt_irq_setup(gpt, ofdev->node);
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
