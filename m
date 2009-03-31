Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090331124035.908249543@denx.de>
References: <20090331123727.853787299@denx.de>
	<20090331124035.908249543@denx.de>
Date: Tue, 31 Mar 2009 09:41:48 -0600
Message-ID: <fa686aa40903310841x42876819rafe3e8bf24b8646e@mail.gmail.com>
Subject: Re: [PATCH 5/8] powerpc: i2c-mpc: make I2C bus speed configurable
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 6:37 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> This patch makes the I2C bus speed configurable by using the I2C node
> property "clock-frequency". If the property is not defined, the old
> fixed clock settings will be used for backward comptibility.
>
> The generic I2C clock properties, especially the CPU-specific source
> clock pre-scaler are defined via the OF match table:
>
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc5200b-i2c",
> =A0 =A0 =A0 =A0 .data =3D (void *)FSL_I2C_DEV_CLOCK_5200, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc5200-i2c",
> =A0 =A0 =A0 =A0 .data =3D (void *)FSL_I2C_DEV_CLOCK_5200, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8313-i2c",
> =A0 =A0 =A0 =A0 .data =3D (void *)FSL_I2C_DEV_SEPARATE_DFSRR, },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8543-i2c",
> =A0 =A0 =A0 =A0 .data =3D (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FSL_I2C_DEV_CLOCK_DIV2=
), },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl,mpc8544-i2c",
> =A0 =A0 =A0 =A0 .data =3D (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FSL_I2C_DEV_CLOCK_DIV2=
3), },
> =A0 =A0 =A0 =A0/* Backward compatibility */
> =A0 =A0 =A0 =A0{.compatible =3D "fsl-i2c", },
> =A0 =A0 =A0 =A0{},
> =A0};


Instead passing in a flag (and using an ugly cast to do it) which is
then checked inside the mpc_i2c_setclock(), you should do this
instead:

struct fsl_i2c_match_data {
        int static void *(setclock)(struct device_node *node, struct
mpc_i2c *i2c, u32 clock);
        int flags;
        /* Other stuff can go here */
};

static const struct of_device_id mpc_i2c_of_match[] =3D {
        {.compatible =3D "fsl,mpc5200b-i2c",
         .data =3D (struct fsl_i2c_match_data[]) { .setclock =3D
mpc_i2c_setclock_mpc5200, },
        },
        {.compatible =3D "fsl,mpc5200-i2c",
         .data =3D (struct fsl_i2c_match_data[]) { .setclock =3D
mpc_i2c_setclock_mpc5200, },
        },
        {.compatible =3D "fsl,mpc8313-i2c",
         .data =3D (struct fsl_i2c_match_data[]) { .setclock =3D
mpc_i2c_setclock_separate_dfsrr, },
        },
        {.compatible =3D "fsl,mpc8543-i2c",
         .data =3D (struct fsl_i2c_match_data[]) { .setclock =3D
mpc_i2c_setclock_separate_dfsrr, },
         .flags =3D FSL_I2C_DEV_CLOCK_DIV2,
        },
        {.compatible =3D "fsl,mpc8544-i2c",
         .data =3D (struct fsl_i2c_match_data[]) { .setclock =3D
mpc_i2c_setclock_separate_dfsrr, },
         .flags =3D FSL_I2C_DEV_CLOCK_DIV23,
        },
        /* Backward compatibility */
        {.compatible =3D "fsl-i2c",
         .data =3D (struct fsl_i2c_match_data[]) { .setclock =3D
mpc_i2c_setclock, },
        },
        {},
  };

The table definition is more verbose this way, but I think it results
in more understandable and easier to extend code.  It also adds lets
the compiler do more type checking for you.


Also, this ...

> --- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A02009-03-3=
1 13:25:08.000000000 +0200
> +++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 2009-03-31 13:34:40.5=
31721011 +0200
> +int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_fla=
gs)
> +{
> [...]
> +}
> +EXPORT_SYMBOL(fsl_i2c_get_fdr);

... and this ...

> --- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c 2009-03-3=
1 13:25:08.000000000 +0200
> +++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c =A0 =A0 =A0200=
9-03-31 13:28:54.309718526 +0200
> +int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_fla=
gs)
> +{
> [...]
> +}
> +EXPORT_SYMBOL(fsl_i2c_get_fdr);

does not work on a multiplatform kernel.  Both 8xxx and 52xx support
can be selected at the same time.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
