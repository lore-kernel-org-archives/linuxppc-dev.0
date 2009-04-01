Return-Path: <wg@grandegger.com>
Message-ID: <49D38D94.3010703@grandegger.com>
Date: Wed, 01 Apr 2009 17:51:48 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] powerpc: i2c-mpc: make I2C bus speed configurable
References: <49D36885.9070806@grandegger.com>	
	<fa686aa40904010644t1c111c05ka7349869eb155429@mail.gmail.com>
	<fa686aa40904010647o57b59845p54a9c1e1535e4453@mail.gmail.com>
In-Reply-To: <fa686aa40904010647o57b59845p54a9c1e1535e4453@mail.gmail.com>
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

Grant Likely wrote:
> On Wed, Apr 1, 2009 at 7:44 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Wed, Apr 1, 2009 at 7:13 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> This patch makes the I2C bus speed configurable by using the I2C node
>>> property "clock-frequency". If the property is not defined, the old
>>> fixed clock settings will be used for backward compatibility.
>> I mostly like this patch.  However, as I mentioned in my other reply,
>> I'm going to NAK it because the divisor tables are not common code and
>> do not belong in common code files.
>>
>> Other than that, I like this version of the patch and I think it is
>> almost finished.  More comments below.

Looks good now, indeed.

> Oh, and you should look in MAINTAINERS and cc this patch to Ben Dooks
> and the linux-i2c@vger.kernel.org mailing list.

Right, and I need to separate I2C and PowerPC related patches. And it
will require another round but some acked-by lines will help.

>>> -static void mpc_i2c_setclock(struct mpc_i2c *i2c)
>>> -{
>>> -       /* Set clock and filters */
>>> -       if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
>>> -               writeb(0x31, i2c->base + MPC_I2C_FDR);
>>> -               writeb(0x10, i2c->base + MPC_I2C_DFSRR);
>>> -       } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
>>> -               writeb(0x3f, i2c->base + MPC_I2C_FDR);
>>> -       else
>>> -               writel(0x1031, i2c->base + MPC_I2C_FDR);
>>> +static void mpc_i2c_setclock_52xx(struct device_node *node,
>>> +                                 struct mpc_i2c *i2c,
>>> +                                 u32 clock, u32 prescaler)
>>> +{
>>> +       int fdr = mpc52xx_i2c_get_fdr(node, clock, prescaler);
>>> +
>>> +       if (fdr < 0)
>>> +               fdr = 0x3f; /* backward compatibility */
>>> +       writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>>> +       dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
>>> +}
>>> +
>>> +static void mpc_i2c_setclock_8xxx(struct device_node *node,
>>> +                                 struct mpc_i2c *i2c,
>>> +                                 u32 clock, u32 prescaler)
>>> +{
>>> +       int fdr = fsl_i2c_get_fdr(node, clock, prescaler);
>>> +
>>> +       if (fdr < 0)
>>> +               fdr = 0x1031; /* backward compatibility */
>>> +       writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>>> +       writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
>>> +       dev_info(i2c->dev, "clock %d Hz (dfsrr=%d fdr=%d)\n",
>>> +                clock, fdr >> 8, fdr & 0xff);
>>>  }
>> Very neat and tidy indeed.  I like this.

Yep.

>>> Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c        2009-03-31 21:27:52.000000000 +0200
>>> +++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c     2009-04-01 12:09:18.796719327 +0200
>>> @@ -39,7 +39,7 @@
>>>  #include <sysdev/fsl_soc.h>
>>>  #include <mm/mmu_decl.h>
>>>  #include <asm/cpm2.h>
>>> -
>>> +#define DEBUG
>>  ^^^^^^^^^^^^^^^^^^^^^^^  oops?

Will fix.

Wolfgang.
