Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id C55AE2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Dec 2004 02:54:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 16 Dec 2004 10:41:57 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB90F1997@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	<linuxppc-embedded@ozlabs.org>, <etux@embeddedtux.org>
Subject: RE: Error cross-building  Linux 2.6 for 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

arch/ppc/8xx_io/uart.c is the problem.  For the 2.6 kernel that compiles
for 8xx that file does not exist.  You need a newer version of the 2.6
kernel.  The version that compiles correctly and sort of runs is Linux
2.6.10-rc3.  I know for a fact that Linux 2.6.9 and lower does not
compile correctly on 8xx.=20

Also, nfs root does not work, use a ramdisk.

My email client sucks, so I probably broke the thread, sorry.




> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Povolotsky, Alexander
> Sent: Thursday, December 16, 2004 10:31 AM
> To: 'linuxppc-embedded@ozlabs.org'; 'etux@embeddedtux.org'
> Subject: Error cross-building Linux 2.6 for 8xx
>=20
> Hi - I am double posting this on both:=20
> linuxppc-embedded@ozlabs.org and etux@embeddedtux.org, hoping=20
> to increase the audience and, hence, to maximize the number=20
> of responses (if only the same people read both mail lists,=20
> why such duplicate redundant mail lists exist ?)
>=20
> I recognize and highly appreciate what Wolfgang Denk=20
> <wd@denx.de> wrote (to
> me) on etux@embeddedtux.org:
>=20
> >Forget the combination of a 2.6 kernel and  a  MPC8xx =20
> processor  for=20
> >now. There are still serious problems in 2.6 on these processors.
>=20
> But at least (I thought) I should be able to build the 2.6=20
> kernel for 8xx.
> So firstly I ran into I2C "no-current-support-for-8xx" (see=20
> details in the listed below e-mail chain) ...
>=20
> Then I took the I2C configuration out and tried to build the=20
> kernel again - but I am still getting errors (not sure though=20
> whether cross-compiler "contributes" to those recent errors=20
> or not ... - I would, as always,  appreciate any opinion/input ! ):
>=20
> Make zImage
>=20
>   CHK     include/linux/version.h
> make[1]: `arch/ppc/kernel/asm-offsets.asm' is up to date.
>   CHK     include/linux/compile.h
>   CC      arch/ppc/8xx_io/uart.o
> arch/ppc/8xx_io/uart.c:82: warning: type defaults to `int' in=20
> declaration of `DECLARE_TASK_QUEUE'
> arch/ppc/8xx_io/uart.c:82: warning: parameter names (without=20
> types) in function declaration
> arch/ppc/8xx_io/uart.c: In function `serial_console_device':
> arch/ppc/8xx_io/uart.c:145: error: storage class specified=20
> for parameter `rs_table'
> arch/ppc/8xx_io/uart.c:145: error: parameter `rs_table' is initialized
>=20
> Thanks,
> Best Regards,
> Alex
>=20
> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Wednesday, December 15, 2004 11:54 AM
> To: Povolotsky, Alexander
> Cc: 'linuxppc-embedded@ozlabs.org'
> Subject: Re: I2C + Linux 2.6 on MPC880/MPC885 based board(s)
>=20
>=20
> On Dec 15, 2004, at 11:04 AM, Povolotsky, Alexander wrote:
>=20
> > On a software (Linux 2.6) side ...
> > Did you deal with Linux 2.6 + MPC880/MPC885 (or at least=20
> any MPC8xx) ?
> >  If yes, what I2C settings in .config were used for successful 2.6=20
> > kernel
>=20
> >  build ?
> >  I am having a problem building it (see below attached) ...=20
> - that is =20
> > why I am trying to understand from the hardware point of=20
> view - hence=20
> > my
> h/w related questions =20
> >  ... - the importance of I2C.
>=20
> It looks like someone that has an interest in using the CPM=20
> I2C (which isn't me) will need to port it first to 2.6, then=20
> provide the board specific functions for set up and control.
>=20
> On top of this, if you want to run the SMBus protocols, you=20
> will need a much more complex CPM I2C functions.
>=20
>=20
> 	-- Dan
> ******************
> -----Original Message-----
> From: Povolotsky, Alexander
> Sent: Tuesday, December 14, 2004 6:13 PM
> To: 'Greg KH'; Jean Delvare
> Subject: RE: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
>=20
>=20
> Hi,
>=20
> >Alexander, what arch are you building for?
>=20
> PPC ->8xx ->MPC880 (Motorola -> FreeScale Semiconductor)
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code
=3DMPC885&nodeId
> =3D018rH3bTdG4204
>=20
> Thanks,
> Best Regards,
> Alex
>=20
> PPS I have attached my original e-mail in its entirety (at the end ).
>=20
> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, December 14, 2004 4:50 PM
> To: Jean Delvare
> Cc: Alexander.Povolotsky@marconi.com
> Subject: Re: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
>=20
>=20
> On Tue, Dec 14, 2004 at 10:38:00AM +0100, Jean Delvare wrote:
> >=20
> > On 2004-12-14, Alexander Povolotsky wrote:
> >=20
> > > Hi,
> > >
> > > I have the following .config setup:
> > > (...)
> > > CONFIG_I2C_RPXLITE=3Dy
> > > (...)
> > >=20
> > > Originally I was getting error:
> > >  CC      drivers/i2c/busses/i2c-rpx.o
> > > drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h:=20
> No such file
> or
> > > directory - why I am missing it - any hint ?
> >=20
> > Hm, looks like the 8xx i2c algorithm was never ported to=20
> Linux 2.6. Greg,
> > how come that the RPX adapter driver is present in the tree and the
> > algorithm it depends on isn't?
>=20
> Because no one ever sent me the patch with those files in it?  :)
>=20
> I have no idea, I've not cross built this driver before.
>=20
> > Greg, could it be that an arch-specific (m68k? don't know what this
> > rpx/8xx thing is) variant of the Linux tree already has the=20
> i2c-algo-8xx
> > driver ported to 2.6? We probably want to import it into=20
> the main tree
> > if this is the case (having adapter drivers that won't=20
> compile doesn't
> > sound good...)
>=20
> It might, I've seen i2c drivers in different arch specific trees (like
> sh for example I know has a few.)
>=20
> Alexander, what arch are you building for?
>=20
> thanks,
>=20
> greg k-h
> *************
> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, December 14, 2004 4:38 AM
> To: Alexander.Povolotsky@marconi.com; greg@kroah.com
> Subject: Re: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
>=20
>=20
>=20
> On 2004-12-14, Alexander Povolotsky wrote:
>=20
> > Hi,
> >
> > I have the following .config setup:
> > (...)
> > CONFIG_I2C_RPXLITE=3Dy
> > (...)
> >=20
> > Originally I was getting error:
> >  CC      drivers/i2c/busses/i2c-rpx.o
> > drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h:=20
> No such file or
> > directory - why I am missing it - any hint ?
>=20
> Hm, looks like the 8xx i2c algorithm was never ported to=20
> Linux 2.6. Greg,
> how come that the RPX adapter driver is present in the tree and the
> algorithm it depends on isn't?
>=20
> > So I copied the i2c-algo-8xx.h file from Linux 2.4.26=20
> distribution ...
> > could I use it ?
> > (if not - could you send me the correct i2c-algo-8xx.h file=20
> ? - TIA !)
>=20
> I don't think it'll work. The header file is one thing, the algorithm
> driver is another and you would need to port both (they proabbly won't
> work out of the box due to important changes in the i2c subsystem
> between 2.4 and 2.6 kernels). Also, obviously the RPX adapter driver
> couldn't be used so far so it was possibly never tested. There will
> probably be much porting and debugging work if you want to get it to
> work.
>=20
> Greg, could it be that an arch-specific (m68k? don't know what this
> rpx/8xx thing is) variant of the Linux tree already has the=20
> i2c-algo-8xx
> driver ported to 2.6? We probably want to import it into the main tree
> if this is the case (having adapter drivers that won't compile doesn't
> sound good...)
>=20
> Alexander, at any rate, there's not much I can do myself, as I don't
> have compatible hardware to port/test/debug the i2c-algo-8xx=20
> and i2c-rpx
> drivers. Sorry.
>=20
> Thanks,
> --
> Jean Delvare
> -----Original Message-----
> From: 	Povolotsky, Alexander =20
> Sent:	Monday, December 13, 2004 10:22 PM
> To:	'khali@linux-fr.org'
> Subject:	8xx i2c drivers (cross)compilation errors on Linux 2.6.8
>=20
> Hi,
>=20
> I have the following .config setup:
> .....
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_ISA is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> CONFIG_I2C_RPXLITE=3Dy
> # CONFIG_SCx200_ACB is not set
>=20
> #
> # Hardware Sensors Chip support
> #
> # CONFIG_I2C_SENSOR is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83627HF is not set
>=20
> #
> # Other I2C Chip support
> #
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_RTC8564 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> ...............
>=20
> Originally I was getting error:
>  CC      drivers/i2c/busses/i2c-rpx.o
> drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h: No=20
> such file or
> directory - why I am missing it - any hint ?
>=20
> So I copied the i2c-algo-8xx.h file from Linux 2.4.26=20
> distribution ... could
> I use it ?
> (if not - could you send me the correct i2c-algo-8xx.h file ? - TIA !)
>=20
> Then I started to get another error:
>=20
>   CC      drivers/i2c/busses/i2c-rpx.o
> In file included from drivers/i2c/busses/i2c-rpx.c:20:
> include/linux/i2c-algo-8xx.h:15: warning: type defaults to `int' in
> declaration of `i2c8xx_t'
> include/linux/i2c-algo-8xx.h:15: warning: no semicolon at end=20
> of struct or
> union
> include/linux/i2c-algo-8xx.h:15: error: parse error before '*' token
> include/linux/i2c-algo-8xx.h:16: error: parse error before '*' token
> include/linux/i2c-algo-8xx.h:16: warning: type defaults to `int' in
> declaration of `iip'
> include/linux/i2c-algo-8xx.h:16: warning: data definition has=20
> no type or
> storage class
> include/linux/i2c-algo-8xx.h:17: error: parse error before '*' token
> include/linux/i2c-algo-8xx.h:17: warning: type defaults to `int' in
> declaration of `cp'
> include/linux/i2c-algo-8xx.h:17: warning: data definition has=20
> no type or
> storage  class
> include/linux/i2c-algo-8xx.h:25: error: parse error before '}' token
> drivers/i2c/busses/i2c-rpx.c: In function `rpx_iic_init':
> drivers/i2c/busses/i2c-rpx.c:34: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:38: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:38: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:39: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:39: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:41: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:42: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:53: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:56: error: dereferencing pointer=20
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c: At top level:
> drivers/i2c/busses/i2c-rpx.c:67: error: variable `rpx_data'=20
> has initializer
> but incomplete type
> drivers/i2c/busses/i2c-rpx.c:68: error: unknown field=20
> `setisr' specified in
> initializer
> drivers/i2c/busses/i2c-rpx.c:69: warning: excess elements in struct
> initializer
> drivers/i2c/busses/i2c-rpx.c:69: warning: (near initialization for
> `rpx_data')
> drivers/i2c/busses/i2c-rpx.c:67: error: storage size of=20
> `rpx_data' isn't
> known
> make[3]: *** [drivers/i2c/busses/i2c-rpx.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
>=20
> Here is the listing of i2c-algo-8xx.h I have (from Linux=20
> 2.4.26 distribution
> )
> /*=20
> --------------------------------------------------------------
> ----------
> /* i2c-algo-8xx.h i2c driver algorithms for MPX8XX CPM
> /*=20
> --------------------------------------------------------------
> ----------
>=20
> /* $Id$ */
>=20
> #ifndef I2C_ALGO_8XX_H
> #define I2C_ALGO_8XX_H 1
>=20
> #include <linux/i2c.h>
>=20
> struct i2c_algo_8xx_data {
>         uint dp_addr;
>         int reloc;
>         volatile i2c8xx_t *i2c;
>         volatile iic_t  *iip;
>         volatile cpm8xx_t *cp;
>=20
>         int     (*setisr) (int irq,
>                            void (*func)(int, void *, struct=20
> pt_regs *),
>                            const char *name,
>                            void *data);
>=20
>         u_char  temp[513];
> };
>=20
> int i2c_8xx_add_bus(struct i2c_adapter *);
> int i2c_8xx_del_bus(struct i2c_adapter *);
>=20
> #endif /* I2C_ALGO_8XX_H */
>=20
>=20
> Thanks,
> Best Regards,
> I will highly Appreciate your response/help !
> Alex Povolotsky
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
