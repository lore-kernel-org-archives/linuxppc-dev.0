Message-ID: <8D7C5F56B409554D9D46AC22195807F3061D6B@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'Lokesh Kumar'" <kumar.lokesh@wrx-us.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
Date: Mon, 6 Oct 2003 08:04:18 +1300 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lokesh,

There are quite a few things you need to change to get this to work for your
board.  Firstly there is a define called SERIAL_DEV_OFFSET in
drivers/char/serial.c you need to set this to a value for your board so
TTY's for this driver are greater than your MPC855 UARTs.  We do not use
this as a loadable module so I can't comment on operation in that way.
Secondly in the file <kernel root>/include/asm/serial.h you are going to
need to define the operation mode and the address' of the serial device here
is our one:
#define STD_SERIAL_PORT_DEFNS			\
	{ 0, BASE_BAUD, 0, 14, ASYNC_BOOT_AUTOCONF, 0, 0, 0, 0, 0, 0, 0, \
	  (void*)0xf3000000, 0, 0, 0, {},{},{},SERIAL_IO_MEM },  \
	{ 0, BASE_BAUD, 0, 15, ASYNC_BOOT_AUTOCONF, 0, 0, 0, 0, 0, 0, 0, \
	  (void*)0xf4000000, 0, 0, 0, {},{},{},SERIAL_IO_MEM },
The important fields are the interrupt field, the base address field, and
the operation mode.  The interrupt on the first line is 14 and the second
line is 15.  The base address is the 0xF3000000 and 0xF4000000.  The
operation mode is the last entry in this structure note this structure has
more fields but we are not interested in these.
Next the interrupt field is very important.  Linux has the notion of virtual
hardware interrupts and physical hardware interrupts.  You have to choose a
physical interrupt for your board that is not used by anything else in your
hardware and hook that up to an unused virtual hardware interrupt.  This is
code you are going to have to write yourself it is very simple and just a
matter of unpeeling the layers.  I will list the files I changed to hook
this up for our hardware. (NOTE there may be an easier way to do this but
this works for us)
         <kernel root>/include/asm/irq.h
         <kernel root>/arch/ppc/kernel/irq.c
         <kernel root>/arch/ppc/kernel/ppx8xx_pic.c
         <kernel root>/arch/ppc/8xx_io/commproc.c
         <kernel root>/drivers/char/serial.c
         <kernel root>/include/asm/serial.h
         <kernel root>/include/asm/[board specific defines file].h


Hope this helps as I have said above I do not use this driver as a module so
I have no idea how that is going to impact your work.  This is what I did
and it took me about 1 1/2 days to figure it out and make it work.  We have
a DUART on our hardware.

Good luck,
Rod Boyce

> -----Original Message-----
> From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
> Sent: Saturday, 4 October 2003 5:46 a.m.
> To: 'Steven Blakeslee'; Lokesh Kumar; 'linuxppc-
> embedded@lists.linuxppc.org'
> Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
>
>
> HI Steven,
> Let me tell few more details of the board I have. I am using SMC1 and 2 as
> serial and SCC1 as serial as well. Then there is the fourth serial  which
> is
> 16550 memory mapped. I want to load the driver for the 16550 as module,
> and
> do all the mapping and chip select setup in the module itself.
>
> Now, if I use serial.c as the module for 16550, are there any things I
> need
> to do i.e. tty names, minor and major numbers etc?
>
> Lokesh
>
> -----Original Message-----
> From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com]
> Sent: Friday, October 03, 2003 9:49 AM
> To: 'Lokesh Kumar'; 'linuxppc-embedded@lists.linuxppc.org'
> Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
>
>
> You can do the mapping anywhere you want, anywhere you do specific board
> initialization is a good spot.  Check out
> arch/ppc/platforms/sandpoint_setup.c
> arch/ppc/platforms/sandpoint_serial.h
> for an example on setting up the serial device.
>
>
> -----Original Message-----
> From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
> Sent: Friday, October 03, 2003 9:26 AM
> To: 'Steven Blakeslee'; Lokesh Kumar;
> 'linuxppc-embedded@lists.linuxppc.org'
> Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
>
>
> Hi Steven,
> Thanks for the quick reply. I did look at serial.c, however, i did not
> find
> where do we map the device to the memory i.e. where are we doing chip
> select
> setting and stuff. I saw that being done for CONFIG_SERIAL_TTTECH. Is that
> what you are referring to or I am missing the point completely?
>
> Lokesh
>
> -----Original Message-----
> From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com]
> Sent: Friday, October 03, 2003 9:16 AM
> To: 'Lokesh Kumar'; 'linuxppc-embedded@lists.linuxppc.org'
> Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
>
>
> It's already in there.  drivers/char/serial.c
>
> -----Original Message-----
> From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
> Sent: Friday, October 03, 2003 9:02 AM
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: mpc8xx memory mapped 16550 extrenal uart driver
>
>
>
> Hi gurus,
>
> Does anybody know of a driver for an external 16550 memory mapped uart
> driver for an mpc855 based board? Any help is appreciated?
>
>
> Lokesh Kumar
> Wireless Matrix USA Inc.
> 703-262-4032
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
