Return-Path: <Torsten.Demke@fci.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 8B3A62BE83
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Dec 2004 03:05:00 +1100 (EST)
Message-ID: <9CFB9DA5261CD611A29B00508B7890480EFE0ADB@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	linuxppc-embedded@ozlabs.org, etux@embeddedtux.org
Date: Thu, 16 Dec 2004 17:05:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hello Alexander,

(snip)
> 
> Make zImage
> 
>   CHK     include/linux/version.h
> make[1]: `arch/ppc/kernel/asm-offsets.asm' is up to date.
>   CHK     include/linux/compile.h
>   CC      arch/ppc/8xx_io/uart.o
> arch/ppc/8xx_io/uart.c:82: warning: type defaults to `int' in 
> declaration of
> `DECLARE_TASK_QUEUE'
> arch/ppc/8xx_io/uart.c:82: warning: parameter names (without types) in
> function declaration
> arch/ppc/8xx_io/uart.c: In function `serial_console_device':
> arch/ppc/8xx_io/uart.c:145: error: storage class specified 
> for parameter
> `rs_table'
> arch/ppc/8xx_io/uart.c:145: error: parameter `rs_table' is initialized
Its also recommended to use the "new" serial driver for 8xx 
(CONFIG_SERIAL_CPM_xxx) from the ../drivers/serial/cpm_uart/*.* directory.

Regards,
Torsten

> 
> Thanks,
> Best Regards,
> Alex
> 
> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Wednesday, December 15, 2004 11:54 AM
> To: Povolotsky, Alexander
> Cc: 'linuxppc-embedded@ozlabs.org'
> Subject: Re: I2C + Linux 2.6 on MPC880/MPC885 based board(s)
> 
> 
> On Dec 15, 2004, at 11:04 AM, Povolotsky, Alexander wrote:
> 
> > On a software (Linux 2.6) side ...
> > Did you deal with Linux 2.6 + MPC880/MPC885 (or at least 
> any MPC8xx) ?
> >  If yes, what I2C settings in .config were used for 
> successful 2.6 kernel
> 
> >  build ?
> >  I am having a problem building it (see below attached) ... 
> - that is  
> >  why I am trying to understand from the hardware point of 
> view - hence my
> h/w related questions  
> >  ... - the importance of I2C.
> 
> It looks like someone that has an interest in
> using the CPM I2C (which isn't me) will need to port it first to 2.6,
> then provide the board specific functions for set up and control.
> 
> On top of this, if you want to run the SMBus protocols, you will
> need a much more complex CPM I2C functions.
> 
> 
> 	-- Dan
> ******************
> -----Original Message-----
> From: Povolotsky, Alexander 
> Sent: Tuesday, December 14, 2004 6:13 PM
> To: 'Greg KH'; Jean Delvare
> Subject: RE: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
> 
> 
> Hi,
> 
> >Alexander, what arch are you building for?
> 
> PPC ->8xx ->MPC880 (Motorola -> FreeScale Semiconductor)
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code
> =MPC885&nodeId
> =018rH3bTdG4204
> 
> Thanks,
> Best Regards,
> Alex
> 
> PPS I have attached my original e-mail in its entirety (at the end ).
> 
> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, December 14, 2004 4:50 PM
> To: Jean Delvare
> Cc: Alexander.Povolotsky@marconi.com
> Subject: Re: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
> 
> 
> On Tue, Dec 14, 2004 at 10:38:00AM +0100, Jean Delvare wrote:
> > 
> > On 2004-12-14, Alexander Povolotsky wrote:
> > 
> > > Hi,
> > >
> > > I have the following .config setup:
> > > (...)
> > > CONFIG_I2C_RPXLITE=y
> > > (...)
> > > 
> > > Originally I was getting error:
> > >  CC      drivers/i2c/busses/i2c-rpx.o
> > > drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h: 
> No such file
> or
> > > directory - why I am missing it - any hint ?
> > 
> > Hm, looks like the 8xx i2c algorithm was never ported to 
> Linux 2.6. Greg,
> > how come that the RPX adapter driver is present in the tree and the
> > algorithm it depends on isn't?
> 
> Because no one ever sent me the patch with those files in it?  :)
> 
> I have no idea, I've not cross built this driver before.
> 
> > Greg, could it be that an arch-specific (m68k? don't know what this
> > rpx/8xx thing is) variant of the Linux tree already has the 
> i2c-algo-8xx
> > driver ported to 2.6? We probably want to import it into 
> the main tree
> > if this is the case (having adapter drivers that won't 
> compile doesn't
> > sound good...)
> 
> It might, I've seen i2c drivers in different arch specific trees (like
> sh for example I know has a few.)
> 
> Alexander, what arch are you building for?
> 
> thanks,
> 
> greg k-h
> *************
> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, December 14, 2004 4:38 AM
> To: Alexander.Povolotsky@marconi.com; greg@kroah.com
> Subject: Re: 8xx i2c drivers (cross)compilation errors on Linux 2.6.8
> 
> 
> 
> On 2004-12-14, Alexander Povolotsky wrote:
> 
> > Hi,
> >
> > I have the following .config setup:
> > (...)
> > CONFIG_I2C_RPXLITE=y
> > (...)
> > 
> > Originally I was getting error:
> >  CC      drivers/i2c/busses/i2c-rpx.o
> > drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h: 
> No such file or
> > directory - why I am missing it - any hint ?
> 
> Hm, looks like the 8xx i2c algorithm was never ported to 
> Linux 2.6. Greg,
> how come that the RPX adapter driver is present in the tree and the
> algorithm it depends on isn't?
> 
> > So I copied the i2c-algo-8xx.h file from Linux 2.4.26 
> distribution ...
> > could I use it ?
> > (if not - could you send me the correct i2c-algo-8xx.h file 
> ? - TIA !)
> 
> I don't think it'll work. The header file is one thing, the algorithm
> driver is another and you would need to port both (they proabbly won't
> work out of the box due to important changes in the i2c subsystem
> between 2.4 and 2.6 kernels). Also, obviously the RPX adapter driver
> couldn't be used so far so it was possibly never tested. There will
> probably be much porting and debugging work if you want to get it to
> work.
> 
> Greg, could it be that an arch-specific (m68k? don't know what this
> rpx/8xx thing is) variant of the Linux tree already has the 
> i2c-algo-8xx
> driver ported to 2.6? We probably want to import it into the main tree
> if this is the case (having adapter drivers that won't compile doesn't
> sound good...)
> 
> Alexander, at any rate, there's not much I can do myself, as I don't
> have compatible hardware to port/test/debug the i2c-algo-8xx 
> and i2c-rpx
> drivers. Sorry.
> 
> Thanks,
> --
> Jean Delvare
> -----Original Message-----
> From: 	Povolotsky, Alexander  
> Sent:	Monday, December 13, 2004 10:22 PM
> To:	'khali@linux-fr.org'
> Subject:	8xx i2c drivers (cross)compilation errors on Linux 2.6.8
> 
> Hi,
> 
> I have the following .config setup:
> .....
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_ISA is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> CONFIG_I2C_RPXLITE=y
> # CONFIG_SCx200_ACB is not set
> 
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
> 
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
> 
> Originally I was getting error:
>  CC      drivers/i2c/busses/i2c-rpx.o
> drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h: No 
> such file or
> directory - why I am missing it - any hint ?
> 
> So I copied the i2c-algo-8xx.h file from Linux 2.4.26 
> distribution ... could
> I use it ?
> (if not - could you send me the correct i2c-algo-8xx.h file ? - TIA !)
> 
> Then I started to get another error:
> 
>   CC      drivers/i2c/busses/i2c-rpx.o
> In file included from drivers/i2c/busses/i2c-rpx.c:20:
> include/linux/i2c-algo-8xx.h:15: warning: type defaults to `int' in
> declaration of `i2c8xx_t'
> include/linux/i2c-algo-8xx.h:15: warning: no semicolon at end 
> of struct or
> union
> include/linux/i2c-algo-8xx.h:15: error: parse error before '*' token
> include/linux/i2c-algo-8xx.h:16: error: parse error before '*' token
> include/linux/i2c-algo-8xx.h:16: warning: type defaults to `int' in
> declaration of `iip'
> include/linux/i2c-algo-8xx.h:16: warning: data definition has 
> no type or
> storage class
> include/linux/i2c-algo-8xx.h:17: error: parse error before '*' token
> include/linux/i2c-algo-8xx.h:17: warning: type defaults to `int' in
> declaration of `cp'
> include/linux/i2c-algo-8xx.h:17: warning: data definition has 
> no type or
> storage  class
> include/linux/i2c-algo-8xx.h:25: error: parse error before '}' token
> drivers/i2c/busses/i2c-rpx.c: In function `rpx_iic_init':
> drivers/i2c/busses/i2c-rpx.c:34: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:38: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:38: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:39: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:39: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:41: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:42: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:53: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c:56: error: dereferencing pointer 
> to incomplete
> type
> drivers/i2c/busses/i2c-rpx.c: At top level:
> drivers/i2c/busses/i2c-rpx.c:67: error: variable `rpx_data' 
> has initializer
> but incomplete type
> drivers/i2c/busses/i2c-rpx.c:68: error: unknown field 
> `setisr' specified in
> initializer
> drivers/i2c/busses/i2c-rpx.c:69: warning: excess elements in struct
> initializer
> drivers/i2c/busses/i2c-rpx.c:69: warning: (near initialization for
> `rpx_data')
> drivers/i2c/busses/i2c-rpx.c:67: error: storage size of 
> `rpx_data' isn't
> known
> make[3]: *** [drivers/i2c/busses/i2c-rpx.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> 
> Here is the listing of i2c-algo-8xx.h I have (from Linux 
> 2.4.26 distribution
> )
> /* 
> --------------------------------------------------------------
> ----------
> /* i2c-algo-8xx.h i2c driver algorithms for MPX8XX CPM
> /* 
> --------------------------------------------------------------
> ----------
> 
> /* $Id$ */
> 
> #ifndef I2C_ALGO_8XX_H
> #define I2C_ALGO_8XX_H 1
> 
> #include <linux/i2c.h>
> 
> struct i2c_algo_8xx_data {
>         uint dp_addr;
>         int reloc;
>         volatile i2c8xx_t *i2c;
>         volatile iic_t  *iip;
>         volatile cpm8xx_t *cp;
> 
>         int     (*setisr) (int irq,
>                            void (*func)(int, void *, struct 
> pt_regs *),
>                            const char *name,
>                            void *data);
> 
>         u_char  temp[513];
> };
> 
> int i2c_8xx_add_bus(struct i2c_adapter *);
> int i2c_8xx_del_bus(struct i2c_adapter *);
> 
> #endif /* I2C_ALGO_8XX_H */
> 
> 
> Thanks,
> Best Regards,
> I will highly Appreciate your response/help !
> Alex Povolotsky
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
