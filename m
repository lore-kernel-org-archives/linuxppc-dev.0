Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090331124035.594457231@denx.de>
References: <20090331123727.853787299@denx.de>
	<20090331124035.594457231@denx.de>
Date: Tue, 31 Mar 2009 09:57:41 -0600
Message-ID: <fa686aa40903310857w57b9d020i71d56f33ede4e875@mail.gmail.com>
Subject: Re: [PATCH 3/8] powerpc/85xx: Add support for the "socrates" board
	(MPC8544).
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sergei Poselenov <sposelenov@emcraft.com>, devicetree-discuss@ozlabs.org,
	Ilya Yanok <yanok@emcraft.com>,
	Dmitry Rakhchev <rda@emcraft.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
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
> Supported are Ethernet, serial console, I2C, I2C-based RTC and
> temperature sensors, NOR and NAND flash, PCI, USB, CAN and Lime
> display controller.
>
> The multiplexing of FPGA interrupts onto PowerPC interrupt lines is
> supported through our own fpga_pic interrupt controller driver.
>
> For example the SJA1000 controller is level low sensitive connected to
> fpga_pic line 2 and is routed to the second (of three) irq lines to
> the CPU:
>
> =A0 =A0can@3,100 {
> =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "philips,sja1000";
> =A0 =A0 =A0 =A0 =A0 =A0reg =3D <3 0x100 0x80>;
> =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 2>;
> =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 8 1>; =A0 // number, type, routi=
ng
> =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&fpga_pic>;
> =A0 =A0};
>
> Signed-off-by: Sergei Poselenov <sposelenov@emcraft.com>
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Signed-off-by: Dmitry Rakhchev <rda@emcraft.com>
> ---
> =A0arch/powerpc/boot/dts/socrates.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0338=
 +++++
> =A0arch/powerpc/configs/85xx/socrates_defconfig =A0 =A0| 1410 +++++++++++=
+++++++++++++

I always ask this question: Do you really need a board specific
defconfig file?  We are multiplatform now.

> =A0arch/powerpc/platforms/85xx/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06
> =A0arch/powerpc/platforms/85xx/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01
> =A0arch/powerpc/platforms/85xx/socrates.c =A0 =A0 =A0 =A0 =A0| =A0133 ++
> =A0arch/powerpc/platforms/85xx/socrates_fpga_pic.c | =A0327 +++++
> =A0arch/powerpc/platforms/85xx/socrates_fpga_pic.h | =A0 16

socrates_fpga_pic is only ever going to be used by socrates.c.  I'd
roll the two socrates.c files into one and eliminate the header file.

> Index: linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
[...]
> +struct socrates_fpga_irq_info {
> + =A0 =A0 =A0 unsigned int irq_line;
> + =A0 =A0 =A0 int type;
> +};
> +
> +/*
> + * Interrupt routing and type table
> + *
> + * IRQ_TYPE_NONE means the interrupt type is configurable,
> + * otherwise it's fixed to the specified value.
> + */
> +static struct socrates_fpga_irq_info fpga_irqs[SOCRATES_FPGA_NUM_IRQS] =
=3D {
> + =A0 =A0 =A0 [0] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [1] =3D {0, IRQ_TYPE_LEVEL_HIGH},
> + =A0 =A0 =A0 [2] =3D {0, IRQ_TYPE_LEVEL_LOW},
> + =A0 =A0 =A0 [3] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [4] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [5] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [6] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [7] =3D {0, IRQ_TYPE_NONE},
> + =A0 =A0 =A0 [8] =3D {0, IRQ_TYPE_LEVEL_HIGH},
> +};

It is good practice to use named elements in initializers: {.type =3D
IRQ_TYPE_LEVEL_HIGH},

Static variables are initialized to zero.  Everything that is 0 can be
dropped from this initializer (lines 0 and 3-7, and the irq_line
field).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
