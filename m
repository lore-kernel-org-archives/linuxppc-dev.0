Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311006t49372fa7m37bee031130cb4ac@mail.gmail.com>
Date: Thu, 31 Jul 2008 13:06:41 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <fa686aa40807310951l48e2af8ep11ef83480397669a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<fa686aa40807310951l48e2af8ep11ef83480397669a@mail.gmail.com>
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
>  If you're careful, the table doesn't need to be huge.  It can be
>  marked as initdata and conditionally compiled depending on which
>  architectures are compiled in.  You should use .data in the driver's
>  of_device_id table to provide machine specific ops for setting
>  clocking to avoid a maze of if/else statements.

Does this look ok for the mpc5200 i2c struct?

/* I2C Registers */
struct mpc52xx_i2c {
	u8 madr; 			/* I2C + 0x00 */
	u8 reserved1[3];		/* I2C + 0x01 */
	u8 mfdr; 			/* I2C + 0x04 */
	u8 reserved2[3];		/* I2C + 0x05 */
	u8 mcr; 			/* I2C + 0x08 */
	u8 reserved3[3];		/* I2C + 0x09 */
	u8 msr;			/* I2C + 0x0c */
	u8 reserved4[3];		/* I2C + 0x0d */
	u8 mdr;			/* I2C + 0x10 */
	u8 reserved5[15];	/* I2C + 0x11 */
	u8 interrupt; 		/* I2C + 0x20 */
	u8 reserved6[3];		/* I2C + 0x21 */
	u8 mifr; 			/* I2C + 0x24 */
};



-- 
Jon Smirl
jonsmirl@gmail.com
