Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311047s40330eb7gb6a7a2b0a1d5d57c@mail.gmail.com>
Date: Thu, 31 Jul 2008 13:47:44 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <fa686aa40807311036l1f081780g667129bbd4df3d9c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<fa686aa40807310951l48e2af8ep11ef83480397669a@mail.gmail.com>
	<9e4733910807311006t49372fa7m37bee031130cb4ac@mail.gmail.com>
	<fa686aa40807311036l1f081780g667129bbd4df3d9c@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Jul 31, 2008 at 11:06 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > On 7/31/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >>  If you're careful, the table doesn't need to be huge.  It can be
>  >>  marked as initdata and conditionally compiled depending on which
>  >>  architectures are compiled in.  You should use .data in the driver's
>  >>  of_device_id table to provide machine specific ops for setting
>  >>  clocking to avoid a maze of if/else statements.
>  >
>  > Does this look ok for the mpc5200 i2c struct?
>  >
>  > /* I2C Registers */
>  > struct mpc52xx_i2c {
>  >        u8 madr;                        /* I2C + 0x00 */
>  >        u8 reserved1[3];                /* I2C + 0x01 */
>  >        u8 mfdr;                        /* I2C + 0x04 */
>  >        u8 reserved2[3];                /* I2C + 0x05 */
>  >        u8 mcr;                         /* I2C + 0x08 */
>  >        u8 reserved3[3];                /* I2C + 0x09 */
>  >        u8 msr;                 /* I2C + 0x0c */
>  >        u8 reserved4[3];                /* I2C + 0x0d */
>  >        u8 mdr;                 /* I2C + 0x10 */
>  >        u8 reserved5[15];       /* I2C + 0x11 */
>  >        u8 interrupt;           /* I2C + 0x20 */
>  >        u8 reserved6[3];                /* I2C + 0x21 */
>  >        u8 mifr;                        /* I2C + 0x24 */
>  > };
>
>
> Ugh.  I hate all the registers defined in structures thing done for
>  5200, but I guess it is better to stick with established convention
>  than do it differently.

Isn't it better than adding random numbers to a pointer and having to
worry about what the pointer is pointing at so that it will multiply
by the right word size? That's a mess when the registers are different
lengths.

A common i2c struct might be a better idea that adds in the dfsrr
register might be better.

You can set the flags for dfsrr use in these set_freq routines too
since they select on CPU type.
       {.compatible = "fsl,mpc5200b-i2c", .data = fsl_i2c_mpc5200b_set_freq, },
       {.compatible = "fsl,mpc5200-i2c", .data = fsl_i2c_mpc5200_set_freq, },
       {.compatible = "fsl,mpc8260-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
       {.compatible = "fsl,mpc8349-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
       {.compatible = "fsl,mpc8540-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
       {.compatible = "fsl,mpc8543-i2c", .data =
fsl_i2c_mpc8xxx_div2_set_freq, },
       {.compatible = "fsl,mpc8544-i2c", .data =
fsl_i2c_mpc8xxx_div3_set_freq, },



>
>  Yes, I think this is okay (but I haven't double checked the values; I
>  trust you).
>
>
>  g.
>
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl@gmail.com
