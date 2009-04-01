Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <fa686aa40904010644t1c111c05ka7349869eb155429@mail.gmail.com>
References: <49D36885.9070806@grandegger.com>
	<fa686aa40904010644t1c111c05ka7349869eb155429@mail.gmail.com>
Date: Wed, 1 Apr 2009 07:47:21 -0600
Message-ID: <fa686aa40904010647o57b59845p54a9c1e1535e4453@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: i2c-mpc: make I2C bus speed configurable
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 1, 2009 at 7:44 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Wed, Apr 1, 2009 at 7:13 AM, Wolfgang Grandegger <wg@grandegger.com> w=
rote:
>> This patch makes the I2C bus speed configurable by using the I2C node
>> property "clock-frequency". If the property is not defined, the old
>> fixed clock settings will be used for backward compatibility.
>
> I mostly like this patch. =A0However, as I mentioned in my other reply,
> I'm going to NAK it because the divisor tables are not common code and
> do not belong in common code files.
>
> Other than that, I like this version of the patch and I think it is
> almost finished. =A0More comments below.

Oh, and you should look in MAINTAINERS and cc this patch to Ben Dooks
and the linux-i2c@vger.kernel.org mailing list.

g.

>
>> -static void mpc_i2c_setclock(struct mpc_i2c *i2c)
>> -{
>> - =A0 =A0 =A0 /* Set clock and filters */
>> - =A0 =A0 =A0 if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x31, i2c->base + MPC_I2C_FDR);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x10, i2c->base + MPC_I2C_DFSRR);
>> - =A0 =A0 =A0 } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0x3f, i2c->base + MPC_I2C_FDR);
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(0x1031, i2c->base + MPC_I2C_FDR);
>> +static void mpc_i2c_setclock_52xx(struct device_node *node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mpc_i2c *i2c,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 cl=
ock, u32 prescaler)
>> +{
>> + =A0 =A0 =A0 int fdr =3D mpc52xx_i2c_get_fdr(node, clock, prescaler);
>> +
>> + =A0 =A0 =A0 if (fdr < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x3f; /* backward compatibility */
>> + =A0 =A0 =A0 writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>> + =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)\n", clock, fdr)=
;
>> +}
>> +
>> +static void mpc_i2c_setclock_8xxx(struct device_node *node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mpc_i2c *i2c,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 cl=
ock, u32 prescaler)
>> +{
>> + =A0 =A0 =A0 int fdr =3D fsl_i2c_get_fdr(node, clock, prescaler);
>> +
>> + =A0 =A0 =A0 if (fdr < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdr =3D 0x1031; /* backward compatibility =
*/
>> + =A0 =A0 =A0 writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>> + =A0 =A0 =A0 writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
>> + =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (dfsrr=3D%d fdr=3D%d)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock, fdr >> 8, fdr & 0xff);
>> =A0}
>
> Very neat and tidy indeed. =A0I like this.
>
>> Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A02009-03-=
31 21:27:52.000000000 +0200
>> +++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 2009-04-01 12:09:18.=
796719327 +0200
>> @@ -39,7 +39,7 @@
>> =A0#include <sysdev/fsl_soc.h>
>> =A0#include <mm/mmu_decl.h>
>> =A0#include <asm/cpm2.h>
>> -
>> +#define DEBUG
> =A0^^^^^^^^^^^^^^^^^^^^^^^ =A0oops?
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
