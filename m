Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40806282157y65835a73y6391e22cdf55b571@mail.gmail.com>
Date: Sat, 28 Jun 2008 22:57:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Convert i2c-mpc from a platform driver to an of_platform
	one
In-Reply-To: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2008 at 8:40 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Convert i2c-mpc from a platform driver into an of_platform driver.
> This patch is much smaller since Jochen already added
> of_find_i2c_driver(). Versions of this have been posted before.
>
> Signed-ff-by: Jon Smirl <jonsmirl@gmail.com>
>
> --
> +       if (of_device_is_compatible(op->node, "mpc5200-i2c"))
> +               i2c->flags |= FSL_I2C_DEV_CLOCK_5200;

This needs to also test for "fsl,mpc5200-i2c".  "mpc5200-i2c" isn't
used on current device trees, but there may be some deployed boards
which still have this string.

> +static const struct of_device_id mpc_i2c_of_match[] = {
> +       {
> +               .compatible     = "fsl-i2c",
> +       },

You can probably shorten this by 2 lines if you change it to:
+       { .compatible = "fsl-i2c", },

Doing so makes it more readable when you need to add additional
compatible values.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
