Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id EC7E9DDD07
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 00:41:08 +1100 (EST)
Subject: SPI controller hangs in 2.6 and not in 2.4
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C758E2.98A626B5"
Date: Sun, 25 Feb 2007 14:41:05 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264926@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C758E2.98A626B5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

strange problem with SPI 8xx controller. I attach a litte code snippet =
that I use to produce the hang, just when giving the start command to =
the controller, the kernel hangs. START command is given in =
transmit_data called directly in init.

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

#include <linux/delay.h>               // for udelay()
#include <linux/interrupt.h>
#include <asm/io.h>
#include <asm/semaphore.h>

#include <asm/commproc.h>
#include <linux/ioport.h>       // for request_mem_region
#include <asm/irq.h>            // for SIU_IRQ1

#define SPI_MAX_BUFFER_SIZE     8
#define BD_SC_ME        ((ushort)0x0001)    /* Multi Master Error */
#define SPCOM_STR             0x80    /* Start transmission command */


volatile car8xx_t       *carp;=20
volatile spi_t          *spi; =20
volatile immap_t        *immap;
volatile cpic8xx_t      *cpi; =20
volatile cpm8xx_t       *cp;  =20
volatile iop8xx_t       *iop; =20

static cbd_t *tbdf, *rbdf;

static u8* txbuffer;
static u8* rxbuffer;
static u16 r_tbase, r_rbase;
u8 txbuf[32];
u8 rxbuf[32];

static int transmit_data()
{
   int result =3D 0;  // default is no error

   // BD status/control register
   tbdf->cbd_sc =3D BD_SC_READY | BD_SC_WRAP | BD_SC_LAST;
   rbdf->cbd_sc =3D BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;

   cp->cp_spmode =3D 0x0778 | SPMODE_LOOP;   		   // spi mode setting
   cp->cp_spmode |=3D 0x0100;                // enable SPI
   cp->cp_spie   =3D 0xff;                   // clear all spi events
   cp->cp_spim   =3D 0x37;                   // mask all SPI events

   udelay(5); // Wait 5 microsecs

   cp->cp_spcom =3D SPCOM_STR;   // start the transfer

   printk("after spcom\n");
   udelay(100);
   // go on and clear chip select befor looking at the result

   // wait 2 character times before writing to SPI bus again !!! ?????

   cp->cp_spmode =3D 0x00;   // reset spi mode


   // test receive and transmit buffer descriptor for errors
   if (rbdf->cbd_sc & (BD_SC_EMPTY | BD_SC_OV | BD_SC_ME))
   {
           result =3D -EIO;
   }
   if (tbdf->cbd_sc & (BD_SC_READY | BD_SC_UN | BD_SC_ME))
   {
           result =3D -EIO;
   }

        return result;
} // int transmit_data


static int hello_init(void)
{
	u32 dp_addr;
        // get pointer to processors internal memory map
        immap =3D (immap_t *)IMAP_ADDR;
        //  printk("*** spi_read: immap =3D 0x%08x ***\n",(unsigned =
int)immap);

        // get pointer to cpm interrupt controller
        cpi =3D (cpic8xx_t*)&(((volatile immap_t*)IMAP_ADDR)->im_cpic);
        //  printk("*** spi_read: cpi =3D 0x%08x ***\n",(unsigned =
int)cpi);

        // get pointer to input/output port
        iop =3D (iop8xx_t *)&(((volatile immap_t =
*)IMAP_ADDR)->im_ioport);
        //  printk("*** spi_read: iop =3D 0x%08x ***\n",(unsigned =
int)iop);

        // get pointer to communication processor
        cp =3D (cpm8xx_t *)&(((volatile immap_t *)IMAP_ADDR)->im_cpm);
        //  printk("*** spi_init: cp =3D 0x%08x ***\n",(unsigned =
int)cp);

        // get pointer to Serial Peripheral Interface parameter RAM
        spi =3D (spi_t *)&cp->cp_dparam[PROFF_SPI];
        //  printk("*** spi_init: spi =3D 0x%08x ***\n",(unsigned =
int)spi);

        // get pointer to clocks and reset
        carp =3D (car8xx_t *)&((volatile immap_t =
*)IMAP_ADDR)->im_clkrst;
        //  printk("*** spi_init: carp =3D 0x%08x ***\n",(unsigned =
int)carp);

        // ------------------------------------------
        //  SCCR[DFBRG] =3D 0  -->  BRGCLK =3D vcoout/1          ### =
verwenden nicht auch andere in ioDriver ????
        // ------------------------------------------
        carp->car_sccr &=3D 0xFFFFE7FF;

        //  initialize the parameter ram
        //  we need to make sure many things are initialized to zero
        spi->spi_rstate =3D 0;
        spi->spi_rdp =3D 0;
        spi->spi_rbptr =3D 0;
        spi->spi_rbc =3D 0;
        spi->spi_rxtmp =3D 0;
        spi->spi_tstate =3D 0;
        spi->spi_tdp =3D 0;
        spi->spi_tbptr =3D 0;
        spi->spi_tbc =3D 0;
        spi->spi_txtmp =3D 0;

        // allocate space for one transmit and one receive buffer =
descriptor in the DP ram
        dp_addr =3D cpm_dpalloc(sizeof(cbd_t) * 2, 8);
        // printk("*** spi_init: dp_addr =3D 0x%08x ***\n",(unsigned =
int)dp_addr);

        // Set up the SPI parameters in the parameter ram
        spi->spi_rbase =3D r_rbase =3D dp_addr;
        spi->spi_tbase =3D r_tbase =3D dp_addr + sizeof(cbd_t);

        // ***********IMPORTANT******************
        // setting transmit and receive buffer descriptor
        // pointers initially to rbase and tbase. Only the
        // microcode patches documentation talks about initializing
        // this pointer. This is missing from the sample I2C driver.
        // If you dont initialize these pointers, the kernel hangs.
        spi->spi_rbptr =3D spi->spi_rbase;
        spi->spi_tbptr =3D spi->spi_tbase;

        // Set to big endian
        spi->spi_tfcr =3D SMC_EB;
        spi->spi_rfcr =3D SMC_EB;

        spi->spi_mrblr =3D SPI_MAX_BUFFER_SIZE;    // Set maximum =
receive size
        //  printk("*** spi_init: spi->spi_mrblr =3D 0x%04x =
***\n",spi->spi_mrblr);

        cp->cp_cpcr |=3D 0x51;    // Setting CPCR

        immap->im_siu_conf.sc_sdcr =3D 0x0001;    // sets SDMA =
configuration register
        cpi->cpic_cicr |=3D 0x00000580;           // enable cpm =
interrupts, spi has highest priority
        cpi->cpic_cimr |=3D 0x00000020;           // enable spi =
interrupts

        cp->cp_spie =3D 0xff;     // clear all spi events

        //  printk("*** spi_init: iop->iop_pcdat =3D 0x%04x ***\n", =
iop->iop_pcdat);

        // ------------------------------------------------
        // initialize Port B SPI pins -> page 34-8 MPC860UM
        // (we are only in master mode !)
        // ------------------------------------------------

        // --------------------------------------------
        // GPIO or per. function
        // PBPAR[28] =3D 1  -> PERI: (SPIMISO)
        // PBPAR[29] =3D 1  -> PERI: (SPIMOSI)
        // PBPAR[30] =3D 1  -> PERI: (SPICLK)
        // --------------------------------------------
        cp->cp_pbpar |=3D 0x0000000E;  // set bits
       //  printk("*** spi_init: cp->cp_pbpar\n              =
ADR=3D0x%08x\n              VAL=3D0x%08x\n",(unsigned int)&cp->cp_pbpar, =
cp->cp_pbpar);

        // ----------------------------------------------
        // In/Out or per. function 0/1
        // PBDIR[28] =3D 1  -> PERI1: SPIMISO
        // PBDIR[29] =3D 1  -> PERI1: SPIMOSI
        // PBDIR[30] =3D 1  -> PERI1: SPICLK
        // ----------------------------------------------
        cp->cp_pbdir |=3D 0x0000000E;
        //printk("*** spi_init: cp->cp_pbdir\n              =
ADR=3D0x%08x\n              VAL=3D0x%08x\n",(unsigned int)&cp->cp_pbdir, =
cp->cp_pbdir);

        // -------------------------------------------------------------
        // attention: PBODR is a 32-bit-register,
        // but in the memory-map-struct it is handled as
        // 16-bit-register because lower 16 bit are always 0
        //
        // open drain or active output
        // PBODR[28] =3D 1  -> open drain: SPIMISO
        // PBODR[29] =3D 0  -> active output SPIMOSI
        // PBODR[30] =3D 0  -> active output: SPICLK
        // -------------------------------------------------------------
        //  printk("\n*** cp->cp_pbodr =3D 0x%08x ***\n",cp->cp_pbodr);
        cp->cp_pbodr |=3D 0x0008;  // set bits
        cp->cp_pbodr &=3D 0xFFF9;  // reset bits
        //  printk("*** spi_init: cp->cp_pbodr\n              =
ADR=3D0x%08x\n              VAL=3D0x%04x\n",(unsigned int)&cp->cp_pbodr, =
cp->cp_pbodr);

        //  printk("*** spi_init: cp->cp_pbdat\n              =
ADR=3D0x%08x\n              VAL=3D0x%08x\n",(unsigned int)&cp->cp_pbdat, =
cp->cp_pbdat);

        // tx and rx buffer descriptors
        tbdf =3D (cbd_t *)&cp->cp_dpmem[r_tbase];
        rbdf =3D (cbd_t *)&cp->cp_dpmem[r_rbase];

        // initialize tx and tx bd's
        tbdf->cbd_sc &=3D ~BD_SC_READY;
        rbdf->cbd_sc &=3D ~BD_SC_EMPTY;

        // Allocate memory as required
        rxbuffer =3D (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);  // =
Memory alloc for receive buffer
        txbuffer =3D (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);  // =
Memory alloc for transmit buffer

        // Set the bd's rx and tx buffer address pointers
        rbdf->cbd_bufaddr =3D virt_to_bus((void *)rxbuffer);             =
                   =20
        tbdf->cbd_bufaddr =3D virt_to_bus((void *)txbuffer);             =
   =20
=09
=09
	transmit_data();
=09
  return 0;
}


static void hello_exit(void)
{
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("Dual BSD/GPL");

------_=_NextPart_001_01C758E2.98A626B5
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7234.20">
<TITLE>SPI controller hangs in 2.6 and not in 2.4</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi all,<BR>
<BR>
strange problem with SPI 8xx controller. I attach a litte code snippet =
that I use to produce the hang, just when giving the start command to =
the controller, the kernel hangs. START command is given in =
transmit_data called directly in init.<BR>
<BR>
#include &lt;linux/init.h&gt;<BR>
#include &lt;linux/module.h&gt;<BR>
#include &lt;linux/kernel.h&gt;<BR>
<BR>
#include =
&lt;linux/delay.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // for udelay()<BR>
#include &lt;linux/interrupt.h&gt;<BR>
#include &lt;asm/io.h&gt;<BR>
#include &lt;asm/semaphore.h&gt;<BR>
<BR>
#include &lt;asm/commproc.h&gt;<BR>
#include &lt;linux/ioport.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
for request_mem_region<BR>
#include =
&lt;asm/irq.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; // for SIU_IRQ1<BR>
<BR>
#define SPI_MAX_BUFFER_SIZE&nbsp;&nbsp;&nbsp;&nbsp; 8<BR>
#define BD_SC_ME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((ushort)0x0001)&nbsp;&nbsp;&nbsp; /* Multi Master Error */<BR>
#define =
SPCOM_STR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x80&nbsp;&nbsp;&nbsp; /* Start transmission command */<BR>
<BR>
<BR>
volatile car8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *carp;<BR>
volatile spi_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*spi;&nbsp;<BR>
volatile immap_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *immap;<BR>
volatile cpic8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cpi;&nbsp;<BR>
volatile cpm8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*cp;&nbsp;&nbsp;<BR>
volatile iop8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *iop;&nbsp;<BR>
<BR>
static cbd_t *tbdf, *rbdf;<BR>
<BR>
static u8* txbuffer;<BR>
static u8* rxbuffer;<BR>
static u16 r_tbase, r_rbase;<BR>
u8 txbuf[32];<BR>
u8 rxbuf[32];<BR>
<BR>
static int transmit_data()<BR>
{<BR>
&nbsp;&nbsp; int result =3D 0;&nbsp; // default is no error<BR>
<BR>
&nbsp;&nbsp; // BD status/control register<BR>
&nbsp;&nbsp; tbdf-&gt;cbd_sc =3D BD_SC_READY | BD_SC_WRAP | =
BD_SC_LAST;<BR>
&nbsp;&nbsp; rbdf-&gt;cbd_sc =3D BD_SC_EMPTY | BD_SC_WRAP | =
BD_SC_INTRPT;<BR>
<BR>
&nbsp;&nbsp; cp-&gt;cp_spmode =3D 0x0778 | SPMODE_LOOP;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; // spi mode setting<BR>
&nbsp;&nbsp; cp-&gt;cp_spmode |=3D =
0x0100;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; // enable SPI<BR>
&nbsp;&nbsp; cp-&gt;cp_spie&nbsp;&nbsp; =3D =
0xff;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // clear all spi events<BR>
&nbsp;&nbsp; cp-&gt;cp_spim&nbsp;&nbsp; =3D =
0x37;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // mask all SPI events<BR>
<BR>
&nbsp;&nbsp; udelay(5); // Wait 5 microsecs<BR>
<BR>
&nbsp;&nbsp; cp-&gt;cp_spcom =3D SPCOM_STR;&nbsp;&nbsp; // start the =
transfer<BR>
<BR>
&nbsp;&nbsp; printk(&quot;after spcom\n&quot;);<BR>
&nbsp;&nbsp; udelay(100);<BR>
&nbsp;&nbsp; // go on and clear chip select befor looking at the =
result<BR>
<BR>
&nbsp;&nbsp; // wait 2 character times before writing to SPI bus again =
!!! ?????<BR>
<BR>
&nbsp;&nbsp; cp-&gt;cp_spmode =3D 0x00;&nbsp;&nbsp; // reset spi =
mode<BR>
<BR>
<BR>
&nbsp;&nbsp; // test receive and transmit buffer descriptor for =
errors<BR>
&nbsp;&nbsp; if (rbdf-&gt;cbd_sc &amp; (BD_SC_EMPTY | BD_SC_OV | =
BD_SC_ME))<BR>
&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D =
-EIO;<BR>
&nbsp;&nbsp; }<BR>
&nbsp;&nbsp; if (tbdf-&gt;cbd_sc &amp; (BD_SC_READY | BD_SC_UN | =
BD_SC_ME))<BR>
&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D =
-EIO;<BR>
&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<BR>
} // int transmit_data<BR>
<BR>
<BR>
static int hello_init(void)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dp_addr;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to processors =
internal memory map<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; immap =3D (immap_t =
*)IMAP_ADDR;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_read: immap =3D 0x%08x ***\n&quot;,(unsigned int)immap);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to cpm =
interrupt controller<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpi =3D =
(cpic8xx_t*)&amp;(((volatile immap_t*)IMAP_ADDR)-&gt;im_cpic);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_read: cpi =3D 0x%08x ***\n&quot;,(unsigned int)cpi);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to =
input/output port<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iop =3D (iop8xx_t =
*)&amp;(((volatile immap_t *)IMAP_ADDR)-&gt;im_ioport);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_read: iop =3D 0x%08x ***\n&quot;,(unsigned int)iop);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to =
communication processor<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp =3D (cpm8xx_t =
*)&amp;(((volatile immap_t *)IMAP_ADDR)-&gt;im_cpm);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: cp =3D 0x%08x ***\n&quot;,(unsigned int)cp);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to Serial =
Peripheral Interface parameter RAM<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi =3D (spi_t =
*)&amp;cp-&gt;cp_dparam[PROFF_SPI];<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: spi =3D 0x%08x ***\n&quot;,(unsigned int)spi);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to clocks and =
reset<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; carp =3D (car8xx_t =
*)&amp;((volatile immap_t *)IMAP_ADDR)-&gt;im_clkrst;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: carp =3D 0x%08x ***\n&quot;,(unsigned int)carp);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; SCCR[DFBRG] =3D =
0&nbsp; --&gt;&nbsp; BRGCLK =3D =
vcoout/1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ### =
verwenden nicht auch andere in ioDriver ????<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; carp-&gt;car_sccr &amp;=3D =
0xFFFFE7FF;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; initialize the =
parameter ram<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; we need to make sure =
many things are initialized to zero<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rstate =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rdp =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbptr =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbc =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rxtmp =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tstate =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tdp =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbptr =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbc =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_txtmp =3D 0;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // allocate space for one =
transmit and one receive buffer descriptor in the DP ram<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp_addr =3D =
cpm_dpalloc(sizeof(cbd_t) * 2, 8);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // printk(&quot;*** spi_init: =
dp_addr =3D 0x%08x ***\n&quot;,(unsigned int)dp_addr);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set up the SPI parameters =
in the parameter ram<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbase =3D r_rbase =
=3D dp_addr;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbase =3D r_tbase =
=3D dp_addr + sizeof(cbd_t);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
***********IMPORTANT******************<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // setting transmit and =
receive buffer descriptor<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // pointers initially to =
rbase and tbase. Only the<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // microcode patches =
documentation talks about initializing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // this pointer. This is =
missing from the sample I2C driver.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // If you dont initialize =
these pointers, the kernel hangs.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbptr =3D =
spi-&gt;spi_rbase;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbptr =3D =
spi-&gt;spi_tbase;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set to big endian<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tfcr =3D =
SMC_EB;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rfcr =3D =
SMC_EB;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_mrblr =3D =
SPI_MAX_BUFFER_SIZE;&nbsp;&nbsp;&nbsp; // Set maximum receive size<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: spi-&gt;spi_mrblr =3D 0x%04x =
***\n&quot;,spi-&gt;spi_mrblr);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_cpcr |=3D =
0x51;&nbsp;&nbsp;&nbsp; // Setting CPCR<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; immap-&gt;im_siu_conf.sc_sdcr =
=3D 0x0001;&nbsp;&nbsp;&nbsp; // sets SDMA configuration register<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpi-&gt;cpic_cicr |=3D =
0x00000580;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
// enable cpm interrupts, spi has highest priority<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpi-&gt;cpic_cimr |=3D =
0x00000020;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
// enable spi interrupts<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_spie =3D =
0xff;&nbsp;&nbsp;&nbsp;&nbsp; // clear all spi events<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: iop-&gt;iop_pcdat =3D 0x%04x ***\n&quot;, =
iop-&gt;iop_pcdat);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
------------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // initialize Port B SPI pins =
-&gt; page 34-8 MPC860UM<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // (we are only in master =
mode !)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
------------------------------------------------<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
--------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // GPIO or per. function<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBPAR[28] =3D 1&nbsp; =
-&gt; PERI: (SPIMISO)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBPAR[29] =3D 1&nbsp; =
-&gt; PERI: (SPIMOSI)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBPAR[30] =3D 1&nbsp; =
-&gt; PERI: (SPICLK)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
--------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbpar |=3D =
0x0000000E;&nbsp; // set bits<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: =
cp-&gt;cp_pbpar\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
ADR=3D0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VAL=3D0x%08x\n&quot;,(unsigned =
int)&amp;cp-&gt;cp_pbpar, cp-&gt;cp_pbpar);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
----------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // In/Out or per. function =
0/1<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBDIR[28] =3D 1&nbsp; =
-&gt; PERI1: SPIMISO<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBDIR[29] =3D 1&nbsp; =
-&gt; PERI1: SPIMOSI<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBDIR[30] =3D 1&nbsp; =
-&gt; PERI1: SPICLK<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
----------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbdir |=3D =
0x0000000E;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //printk(&quot;*** spi_init: =
cp-&gt;cp_pbdir\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
ADR=3D0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VAL=3D0x%08x\n&quot;,(unsigned =
int)&amp;cp-&gt;cp_pbdir, cp-&gt;cp_pbdir);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
-------------------------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // attention: PBODR is a =
32-bit-register,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // but in the =
memory-map-struct it is handled as<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 16-bit-register because =
lower 16 bit are always 0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // open drain or active =
output<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBODR[28] =3D 1&nbsp; =
-&gt; open drain: SPIMISO<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBODR[29] =3D 0&nbsp; =
-&gt; active output SPIMOSI<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBODR[30] =3D 0&nbsp; =
-&gt; active output: SPICLK<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
-------------------------------------------------------------<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;\n*** =
cp-&gt;cp_pbodr =3D 0x%08x ***\n&quot;,cp-&gt;cp_pbodr);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbodr |=3D =
0x0008;&nbsp; // set bits<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbodr &amp;=3D =
0xFFF9;&nbsp; // reset bits<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: =
cp-&gt;cp_pbodr\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
ADR=3D0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VAL=3D0x%04x\n&quot;,(unsigned =
int)&amp;cp-&gt;cp_pbodr, cp-&gt;cp_pbodr);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** =
spi_init: =
cp-&gt;cp_pbdat\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
ADR=3D0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VAL=3D0x%08x\n&quot;,(unsigned =
int)&amp;cp-&gt;cp_pbdat, cp-&gt;cp_pbdat);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // tx and rx buffer =
descriptors<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf =3D (cbd_t =
*)&amp;cp-&gt;cp_dpmem[r_tbase];<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf =3D (cbd_t =
*)&amp;cp-&gt;cp_dpmem[r_rbase];<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // initialize tx and tx =
bd's<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf-&gt;cbd_sc &amp;=3D =
~BD_SC_READY;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf-&gt;cbd_sc &amp;=3D =
~BD_SC_EMPTY;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Allocate memory as =
required<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxbuffer =3D =
(u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);&nbsp; // Memory alloc for =
receive buffer<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txbuffer =3D =
(u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);&nbsp; // Memory alloc for =
transmit buffer<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set the bd's rx and tx =
buffer address pointers<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf-&gt;cbd_bufaddr =3D =
virt_to_bus((void =
*)rxbuffer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf-&gt;cbd_bufaddr =3D =
virt_to_bus((void =
*)txbuffer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; transmit_data();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp; return 0;<BR>
}<BR>
<BR>
<BR>
static void hello_exit(void)<BR>
{<BR>
}<BR>
<BR>
module_init(hello_init);<BR>
module_exit(hello_exit);<BR>
<BR>
MODULE_LICENSE(&quot;Dual BSD/GPL&quot;);<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C758E2.98A626B5--
