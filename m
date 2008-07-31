Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
Date: Thu, 31 Jul 2008 11:49:32 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <4891A744.6060005@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
Cc: Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Grant Likely wrote:
>
> > On Fri, Jul 25, 2008 at 11:19:41AM -0500, Timur Tabi wrote:
> >
> > > Wolfgang Grandegger wrote:
> > >
> > >
> > > > I know but we still need an algorithm for MPC52xx and MPC82xx as well.
> > > >
> > > That's true, but I still think hard-coding values of DFSR and FDR in the
> device
> > > tree is not a good way to do this.
> > >
> >
> > I agree, it should encode real frequencies, not raw register values.
> >
>
>  Digging deeper I'm frightened by plenty of platform specific code. We would
> need:
>
>  - one table of divider,fdr,dfsr values for the MPC82/3/5/6xx processors
>   (already available from Timur's U-Boot implementation)
>
>  - one table of divider,fdr values for the MPC5200 rev A.
>
>  - one table of divider,fdr values for the MPC5200 rev B.
>   (the Rev. B has two more pre-scaler bits).

Aren't the tables in the manual there just to make it easy for a human
to pick out the line they want? For a computer you'd program the
formula that was used to create the tables.

I agree that it took me half an hour to figure out the formula that
was needed to compute the i2s clocks, but once you figure out the
formula it solves all of the cases and no one needs to read the manual
any more. The i2c formula may even need a small loop which compares
different solutions looking for the smallest error term. But it's a
small space to search.

These device tree flags should be removed, the driver can ask the
platform code what CPU it is running on.

        if (of_get_property(op->node, "dfsrr", NULL))
                i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;

        if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
                        of_device_is_compatible(op->node, "mpc5200-i2c"))
                i2c->flags |= FSL_I2C_DEV_CLOCK_5200;

static void mpc_i2c_setclock(struct mpc_i2c *i2c)
{
        /* Set clock and filters */
        if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
                writeb(0x31, i2c->base + MPC_I2C_FDR);
                writeb(0x10, i2c->base + MPC_I2C_DFSRR);
        } else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
                writeb(0x3f, i2c->base + MPC_I2C_FDR);
        else
                writel(0x1031, i2c->base + MPC_I2C_FDR);
}

These defines shouldn't be here, they should get the offset from the
right header file for the CPU. But it appears that structures for the
i2c memory map haven't been done for the various CPUs.

#define MPC_I2C_FDR     0x04
#define MPC_I2C_CR      0x08
#define MPC_I2C_SR      0x0c
#define MPC_I2C_DR      0x10
#define MPC_I2C_DFSRR 0x14

There appears to be one for i2x8xxx but not the other CPUs.

/* I2C
*/
typedef struct i2c {
        u_char  i2c_i2mod;
        char    res1[3];
        u_char  i2c_i2add;
        char    res2[3];
        u_char  i2c_i2brg;
        char    res3[3];
        u_char  i2c_i2com;
        char    res4[3];
        u_char  i2c_i2cer;
        char    res5[3];
        u_char  i2c_i2cmr;
        char    res6[0x8b];
} i2c8xx_t;




>  - furthermore, there are various mpc-specific I2C clock sources:
>
>   MPC82xx                     : fsl_get_sys_freq()
>   MPC5200                     : IPB
>   MPC83xx                     : fsl_get_sys_freq()
>   MPC8540/41/60/55,MPC8610    : fsl_get_sys_freq()
>   MPC8543/45/47/48/68, MPC8641: fsl_get_sys_freq()/2
>   MPC8544                     : fsl_get_sys_freq()/2 or /3
>
>   It would make sense to hand-over the I2C frequency from U-Boot to
>   Linux.
>
>  Wolfgang.
>
>
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
