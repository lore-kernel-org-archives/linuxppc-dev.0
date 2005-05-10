Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id D8740679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 May 2005 23:45:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 10 May 2005 15:45:42 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B26@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Serial console settings nightmare...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
I'm trying to get a montavista hardhat pro 3.1 (kernel 2.4.20) running =
on our hardware. This one uses a ppc 405 EP.
In order to do that, we use a vxWorks bootloader to download via ftp the =
linux image (zImage.treeboot) in  memory.=20
We had to modify some parts of linux code to achieve that. Indeed, linux =
bootstrap (which relocate & decompress) waits a board info structure =
from the bootloader;
in our case the vxWorks bootloader was not able to do that so we had =
this in a static way :

/**********************/
/*   ppc4xx_setup.c   */
/**********************/
void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
	      unsigned long r6, unsigned long r7)
{
  parse_bootinfo(find_bootinfo());

/* We use VxWorks bootrom, so we have to create ourselves the boot info =
structure */
  bd_t my_bd_t;
 =20
  strcpy(my_bd_t.bi_s_version,"v1");                  /*  Version of =
this structure   */
  strcpy(my_bd_t.bi_r_version,"bootrom linux 1.0") ;  /*  Version of the =
IBM ROM      */
  my_bd_t.bi_memsize        =3D 16*1024*1024 ;          /* DRAM =
installed, in bytes     */
  my_bd_t.bi_intfreq      =3D 200000000 ;     /* Processor speed, in Hz  =
     */
  my_bd_t.bi_busfreq      =3D 100000000 ;     /* PLB Bus speed, in Hz    =
     */
  my_bd_t.bi_pllouta_freq =3D 400000000 ;     /* PLL OUTA speed, in Hz   =
     */
  my_bd_t.bi_opb_busfreq  =3D 50000000 ;      /* OPB Bus speed, in Hz    =
     */
  my_bd_t.bi_iic_fast[0]  =3D 0 ;             /* Use fast i2c mode       =
     */       =20
 =20
  memcpy((void *) __res, (void *) &my_bd_t,sizeof (bd_t));

...

/**********************/
/*   embed_config.c   */
/**********************/
bd_t * get_board_info(void)
{
  my_strcpy(my_bd_t.bi_s_version,"v1");                   /*  Version of =
this structure   */
  my_strcpy(my_bd_t.bi_r_version,"bootrom linux 1.0") ;   /*  Version of =
the IBM ROM      */
  my_bd_t.bi_memsize =3D 16*1024*1024 ;                     /* DRAM =
installed, in bytes     */
  my_bd_t.bi_intfreq      =3D 200000000 ;     /* Processor speed, in Hz  =
     */
  my_bd_t.bi_busfreq      =3D 100000000 ;     /* PLB Bus speed, in Hz    =
     */
  my_bd_t.bi_pllouta_freq =3D 400000000 ;     /* PLL OUTA speed, in Hz   =
     */
  /*my_bd_t.bi_opb_busfreq  =3D 50000000 ;    /* OPB Bus speed, in Hz    =
     */
  /*my_bd_t.bi_iic_fast[0]  =3D 0 ;           /* Use fast i2c mode       =
     */

  /* We return the address of our global structure */                 =20
  return &my_bd_t;
} =20


After that modifications the kernel boot process seemed to begin =
properly. But I can't see it properly on my serial console after
the linux bootstrap give the control to the kernel execution entry point =
(head_4xx.S).=20
Here is what I see on it:

loaded at:     00C7B250 00D374C4
relocated to:  00400000 004BC274
board data at: 004B913C 004B9190
relocated to:  0040547C 004054D0
zimage at:     00405AFF 004B8B22
avail ram:     004BD000 01000000

Linux/PPC load: console=3DttyS0,38400 root=3D/dev/nfs rw ip=3Don
Uncompressing Linux...done.
Now booting the kernel
.?w..tg?..*/)1j..-b?./?...V..?..-..W..E..?..4.)-W.?.-CV....i\Q!n.?v.-....=
;rs5k.5%.?i-.?-.-..V.....?!.-.?.Cn..?-.Fh-..g-.?wH.k...                  =
        .[1;156H.[1;156H.

As you can see, I'd like my linux to have a serial setting of 38400 8n1. =
To achieve that, I modified the following things:

- in "ns16550.c":  #define SERIAL_BAUD 38400       //(instead of 9600)
- in "tty_io.c" (console_init() function ): =20
        tty_std_termios.c_iflag =3D ICRNL | IXON;
	tty_std_termios.c_oflag =3D OPOST | ONLCR;
        tty_std_termios.c_cflag =3D B38400 | CS8 | CREAD | HUPCL;   =
//(instead of 9600)
	tty_std_termios.c_lflag =3D ISIG | ICANON | ECHO | ECHOE | ECHOK =
|ECHOCTL | ECHOKE | IEXTEN;
- in "arch/ppc/platforms/myplatform.h" :  #define BASE_BAUD xxxxxx

As you can see I haven't given a value for the BASE_BAUD value. Indeed, =
I can not find the right method to calculate it.
Could someone give me the formula please given the following infos:
  - UART_DIV =3D 0x15  (so 21 in decimal)
  - all other clocking info are given above in the "get_board_info"


Do you see sometrhing wrong there cause without any "readable" console =
I'm totally blind and I can't debug anything.
Please help me cause I've read so many forums,docs, and others that I'm =
really desperate... HELP!!!

J=E9r=E9mie
