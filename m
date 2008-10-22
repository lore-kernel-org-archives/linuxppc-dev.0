Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE006.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 5FA02DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 10:38:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: virtex 4 linux driver bus error
Date: Wed, 22 Oct 2008 17:38:07 -0600
In-Reply-To: <1695261910@web.de>
References: <1695261910@web.de>
From: John Linn <John.Linn@xilinx.com>
To: "Mirsad Vejseli" <Vejseli@web.de>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081022233812.BCC92145805C@mail39-va3.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

See the inline comments.

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto=
:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Mirsad Vejseli
> Sent: Wednesday, October 22, 2008 6:10 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: virtex 4 linux driver bus error
> =

> hello at all,
> =

> at the moment I use development board ML410 with montavistalinux.
> =

> I have a problem, please help me!
> =

> I try to write a linux-driver for writing or reading registers.
> I have a ace-file, which contents Linux and EDK-project with a component =
(IP-wizard) which is added
> on a PLB-bus.
> I also have a driver-construct which I can register (insmod driver.ko) in=
to the linux-Kernel only if
> i do not use functions to write or read the bus (XIO_out32() or XIO_in32 =
()  ). If I use this

I don't know MontaVista Linux, but in general these are functions provided =
by Xilinx for standalone (no RTOS) operation unless MontaVista has changed =
them.  I would recommend that you go look at other Linux drivers to see the=
 pattern for I/O such as the uartlite serial driver or the xilinx_ps2.c dri=
ver.  I realize each driver already in the mainline can be different but th=
ey are working.

I would also add some debug to print out the virtual address after the iore=
map. You aren't checking the result of the ioremap to make sure it didn't f=
ail. =


Is the ioremap bad or the I/O operation is the question.

> function after registering the driver I got an error.
> If I try to insert the modul with Insmod driver.ko I get a bus error!
> =

> my driver is similar to http://ozlabs.org/pipermail/linuxppc-embedded/200=
6-January/021578.html
> =

> =

> her the two importent functions  of the driver:
> =

> #define REG_BASE 	(u32) XPAR_komponente_0_BASEADDR // defined in xparamet=
ers_ml41x.h
> #define REG_HIGH 	(u32) XPAR_komponente_0_HIGHADDR // defined in xparamet=
ers_ml41x.h
> =

> =

> #define reg0_upper	(u32) komponente_SLV_REG0_OFFSET // 32-bit register / =
defined in komponente.h
> #define reg1_upper	(u32) komponente_SLV_REG1_OFFSET // 32-bit register / =
defined in komponente.h
> #define reg2_upper	(u32) komponente_SLV_REG2_OFFSET // 32-bit register / =
defined in komponente.h
> =

> const static long remap_size =3D REG_HIGH - REG_BASE + 1;
> =

> static void read_register_values(void)
> {
> 	static u32 upper;
> =

> =

> 	printk("%s:\n",DRIVERNAME);
> 	printk("%s:                      |     upper         |\n",DRIVERNAME);
> 	printk("%s:----------------------|-------------------|\n",DRIVERNAME);
> =

> 	upper =3D XIo_In32(reg_remapped_address + reg1_upper);
> =

>     printk("%s: Daten im Register 35 |%15X |\n", DRIVERNAME, upper );
> =

> }
> =

> =

> static int __init meintreiber_init(void)
> reg_remapped_address =3D (u32) ioremap(REG_BASE, remap_size);
> =

>     rtn =3D misc_register(&miscdev);
>     if (rtn)
>     {
> 		printk("%s: %s error driver not reg. \n",DRIVERNAME, miscdev.name);
>         return rtn;
>     }
> =

> 	read2_register_values();
> =

> in the messeges log file i got the 3 printk lins and this line
> "upper =3D XIo_In32(reg_remapped_address + reg1_upper);"
> creates a error
> =

> =

> =

> =

> Thank you very much for your kind help!
> ________________________________________________________________________
> Schon geh=F6rt? Bei WEB.DE gibt' s viele kostenlose Spiele:
> http://games.entertainment.web.de/de/entertainment/games/free/index.html
> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
