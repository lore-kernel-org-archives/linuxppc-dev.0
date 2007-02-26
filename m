Return-Path: <greg.lopp@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.230])
	by ozlabs.org (Postfix) with ESMTP id D5C21DDFA8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 03:43:16 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id i30so1446909wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 08:43:14 -0800 (PST)
Message-ID: <f20416350702260843p42a389aw4ea79fa5dfa7b4aa@mail.gmail.com>
Date: Mon, 26 Feb 2007 10:43:13 -0600
From: "Greg Lopp" <lopp@pobox.com>
Sender: greg.lopp@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: SPI controller hangs in 2.6 and not in 2.4
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264926@aquib01a>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_95270_24660034.1172508193706"
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264926@aquib01a>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_95270_24660034.1172508193706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I see that your code enables interrupts in the CPM and sets BD_SC_INTRPT,
but you do not claim the IRQ anywhere in this sample.

It doesn't explain the 2.4 vs 2.6 issues, but where is the request_irq() ?


On 2/25/07, DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
wrote:
>
>  Hi all,
>
> strange problem with SPI 8xx controller. I attach a litte code snippet
> that I use to produce the hang, just when giving the start command to the
> controller, the kernel hangs. START command is given in transmit_data called
> directly in init.
>
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/kernel.h>
>
> #include <linux/delay.h>               // for udelay()
> #include <linux/interrupt.h>
> #include <asm/io.h>
> #include <asm/semaphore.h>
>
> #include <asm/commproc.h>
> #include <linux/ioport.h>       // for request_mem_region
> #include <asm/irq.h>            // for SIU_IRQ1
>
> #define SPI_MAX_BUFFER_SIZE     8
> #define BD_SC_ME        ((ushort)0x0001)    /* Multi Master Error */
> #define SPCOM_STR             0x80    /* Start transmission command */
>
>
> volatile car8xx_t       *carp;
> volatile spi_t          *spi;
> volatile immap_t        *immap;
> volatile cpic8xx_t      *cpi;
> volatile cpm8xx_t       *cp;
> volatile iop8xx_t       *iop;
>
> static cbd_t *tbdf, *rbdf;
>
> static u8* txbuffer;
> static u8* rxbuffer;
> static u16 r_tbase, r_rbase;
> u8 txbuf[32];
> u8 rxbuf[32];
>
> static int transmit_data()
> {
>    int result = 0;  // default is no error
>
>    // BD status/control register
>    tbdf->cbd_sc = BD_SC_READY | BD_SC_WRAP | BD_SC_LAST;
>    rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;
>
>    cp->cp_spmode = 0x0778 | SPMODE_LOOP;                   // spi mode
> setting
>    cp->cp_spmode |= 0x0100;                // enable SPI
>    cp->cp_spie   = 0xff;                   // clear all spi events
>    cp->cp_spim   = 0x37;                   // mask all SPI events
>
>    udelay(5); // Wait 5 microsecs
>
>    cp->cp_spcom = SPCOM_STR;   // start the transfer
>
>    printk("after spcom\n");
>    udelay(100);
>    // go on and clear chip select befor looking at the result
>
>    // wait 2 character times before writing to SPI bus again !!! ?????
>
>    cp->cp_spmode = 0x00;   // reset spi mode
>
>
>    // test receive and transmit buffer descriptor for errors
>    if (rbdf->cbd_sc & (BD_SC_EMPTY | BD_SC_OV | BD_SC_ME))
>    {
>            result = -EIO;
>    }
>    if (tbdf->cbd_sc & (BD_SC_READY | BD_SC_UN | BD_SC_ME))
>    {
>            result = -EIO;
>    }
>
>         return result;
> } // int transmit_data
>
>
> static int hello_init(void)
> {
>         u32 dp_addr;
>         // get pointer to processors internal memory map
>         immap = (immap_t *)IMAP_ADDR;
>         //  printk("*** spi_read: immap = 0x%08x ***\n",(unsigned
> int)immap);
>
>         // get pointer to cpm interrupt controller
>         cpi = (cpic8xx_t*)&(((volatile immap_t*)IMAP_ADDR)->im_cpic);
>         //  printk("*** spi_read: cpi = 0x%08x ***\n",(unsigned int)cpi);
>
>         // get pointer to input/output port
>         iop = (iop8xx_t *)&(((volatile immap_t *)IMAP_ADDR)->im_ioport);
>         //  printk("*** spi_read: iop = 0x%08x ***\n",(unsigned int)iop);
>
>         // get pointer to communication processor
>         cp = (cpm8xx_t *)&(((volatile immap_t *)IMAP_ADDR)->im_cpm);
>         //  printk("*** spi_init: cp = 0x%08x ***\n",(unsigned int)cp);
>
>         // get pointer to Serial Peripheral Interface parameter RAM
>         spi = (spi_t *)&cp->cp_dparam[PROFF_SPI];
>         //  printk("*** spi_init: spi = 0x%08x ***\n",(unsigned int)spi);
>
>         // get pointer to clocks and reset
>         carp = (car8xx_t *)&((volatile immap_t *)IMAP_ADDR)->im_clkrst;
>         //  printk("*** spi_init: carp = 0x%08x ***\n",(unsigned
> int)carp);
>
>         // ------------------------------------------
>         //  SCCR[DFBRG] = 0  -->  BRGCLK = vcoout/1          ### verwenden
> nicht auch andere in ioDriver ????
>         // ------------------------------------------
>         carp->car_sccr &= 0xFFFFE7FF;
>
>         //  initialize the parameter ram
>         //  we need to make sure many things are initialized to zero
>         spi->spi_rstate = 0;
>         spi->spi_rdp = 0;
>         spi->spi_rbptr = 0;
>         spi->spi_rbc = 0;
>         spi->spi_rxtmp = 0;
>         spi->spi_tstate = 0;
>         spi->spi_tdp = 0;
>         spi->spi_tbptr = 0;
>         spi->spi_tbc = 0;
>         spi->spi_txtmp = 0;
>
>         // allocate space for one transmit and one receive buffer
> descriptor in the DP ram
>         dp_addr = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
>         // printk("*** spi_init: dp_addr = 0x%08x ***\n",(unsigned
> int)dp_addr);
>
>         // Set up the SPI parameters in the parameter ram
>         spi->spi_rbase = r_rbase = dp_addr;
>         spi->spi_tbase = r_tbase = dp_addr + sizeof(cbd_t);
>
>         // ***********IMPORTANT******************
>         // setting transmit and receive buffer descriptor
>         // pointers initially to rbase and tbase. Only the
>         // microcode patches documentation talks about initializing
>         // this pointer. This is missing from the sample I2C driver.
>         // If you dont initialize these pointers, the kernel hangs.
>         spi->spi_rbptr = spi->spi_rbase;
>         spi->spi_tbptr = spi->spi_tbase;
>
>         // Set to big endian
>         spi->spi_tfcr = SMC_EB;
>         spi->spi_rfcr = SMC_EB;
>
>         spi->spi_mrblr = SPI_MAX_BUFFER_SIZE;    // Set maximum receive
> size
>         //  printk("*** spi_init: spi->spi_mrblr = 0x%04x
> ***\n",spi->spi_mrblr);
>
>         cp->cp_cpcr |= 0x51;    // Setting CPCR
>
>         immap->im_siu_conf.sc_sdcr = 0x0001;    // sets SDMA configuration
> register
>         cpi->cpic_cicr |= 0x00000580;           // enable cpm interrupts,
> spi has highest priority
>         cpi->cpic_cimr |= 0x00000020;           // enable spi interrupts
>
>         cp->cp_spie = 0xff;     // clear all spi events
>
>         //  printk("*** spi_init: iop->iop_pcdat = 0x%04x ***\n",
> iop->iop_pcdat);
>
>         // ------------------------------------------------
>         // initialize Port B SPI pins -> page 34-8 MPC860UM
>         // (we are only in master mode !)
>         // ------------------------------------------------
>
>         // --------------------------------------------
>         // GPIO or per. function
>         // PBPAR[28] = 1  -> PERI: (SPIMISO)
>         // PBPAR[29] = 1  -> PERI: (SPIMOSI)
>         // PBPAR[30] = 1  -> PERI: (SPICLK)
>         // --------------------------------------------
>         cp->cp_pbpar |= 0x0000000E;  // set bits
>        //  printk("*** spi_init: cp->cp_pbpar\n
> ADR=0x%08x\n              VAL=0x%08x\n",(unsigned int)&cp->cp_pbpar,
> cp->cp_pbpar);
>
>         // ----------------------------------------------
>         // In/Out or per. function 0/1
>         // PBDIR[28] = 1  -> PERI1: SPIMISO
>         // PBDIR[29] = 1  -> PERI1: SPIMOSI
>         // PBDIR[30] = 1  -> PERI1: SPICLK
>         // ----------------------------------------------
>         cp->cp_pbdir |= 0x0000000E;
>         //printk("*** spi_init: cp->cp_pbdir\n
> ADR=0x%08x\n              VAL=0x%08x\n",(unsigned int)&cp->cp_pbdir,
> cp->cp_pbdir);
>
>         // -------------------------------------------------------------
>         // attention: PBODR is a 32-bit-register,
>         // but in the memory-map-struct it is handled as
>         // 16-bit-register because lower 16 bit are always 0
>         //
>         // open drain or active output
>         // PBODR[28] = 1  -> open drain: SPIMISO
>         // PBODR[29] = 0  -> active output SPIMOSI
>         // PBODR[30] = 0  -> active output: SPICLK
>         // -------------------------------------------------------------
>         //  printk("\n*** cp->cp_pbodr = 0x%08x ***\n",cp->cp_pbodr);
>         cp->cp_pbodr |= 0x0008;  // set bits
>         cp->cp_pbodr &= 0xFFF9;  // reset bits
>         //  printk("*** spi_init: cp->cp_pbodr\n
> ADR=0x%08x\n              VAL=0x%04x\n",(unsigned int)&cp->cp_pbodr,
> cp->cp_pbodr);
>
>         //  printk("*** spi_init: cp->cp_pbdat\n
> ADR=0x%08x\n              VAL=0x%08x\n",(unsigned int)&cp->cp_pbdat,
> cp->cp_pbdat);
>
>         // tx and rx buffer descriptors
>         tbdf = (cbd_t *)&cp->cp_dpmem[r_tbase];
>         rbdf = (cbd_t *)&cp->cp_dpmem[r_rbase];
>
>         // initialize tx and tx bd's
>         tbdf->cbd_sc &= ~BD_SC_READY;
>         rbdf->cbd_sc &= ~BD_SC_EMPTY;
>
>         // Allocate memory as required
>         rxbuffer = (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);  //
> Memory alloc for receive buffer
>         txbuffer = (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);  //
> Memory alloc for transmit buffer
>
>         // Set the bd's rx and tx buffer address pointers
>         rbdf->cbd_bufaddr = virt_to_bus((void
> *)rxbuffer);
>         tbdf->cbd_bufaddr = virt_to_bus((void *)txbuffer);
>
>
>         transmit_data();
>
>   return 0;
> }
>
>
> static void hello_exit(void)
> {
> }
>
> module_init(hello_init);
> module_exit(hello_exit);
>
> MODULE_LICENSE("Dual BSD/GPL");
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_95270_24660034.1172508193706
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I see that your code enables interrupts in the CPM and <font size="2">sets BD</font><font size="2">_SC_INTRPT, but you do not claim the IRQ anywhere in this sample. </font><br><br>It doesn&#39;t explain the 2.4 vs 2.6 issues, 
<font size="2"> but where is the request_irq() ?</font><br><br><br><div><span class="gmail_quote">On 2/25/07, <b class="gmail_sendername">DI BACCO ANTONIO - technolabs</b> &lt;<a href="mailto:Antonio.DiBacco@technolabs.it">
Antonio.DiBacco@technolabs.it</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">






<div>


<p><font size="2">Hi all,<br>
<br>
strange problem with SPI 8xx controller. I attach a litte code snippet that I use to produce the hang, just when giving the start command to the controller, the kernel hangs. START command is given in transmit_data called directly in init.
<br>
<br>
#include &lt;linux/init.h&gt;<br>
#include &lt;linux/module.h&gt;<br>
#include &lt;linux/kernel.h&gt;<br>
<br>
#include &lt;linux/delay.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // for udelay()<br>
#include &lt;linux/interrupt.h&gt;<br>
#include &lt;asm/io.h&gt;<br>
#include &lt;asm/semaphore.h&gt;<br>
<br>
#include &lt;asm/commproc.h&gt;<br>
#include &lt;linux/ioport.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // for request_mem_region<br>
#include &lt;asm/irq.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // for SIU_IRQ1<br>
<br>
#define SPI_MAX_BUFFER_SIZE&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
#define BD_SC_ME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((ushort)0x0001)&nbsp;&nbsp;&nbsp; /* Multi Master Error */<br>
#define SPCOM_STR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80&nbsp;&nbsp;&nbsp; /* Start transmission command */<br>
<br>
<br>
volatile car8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *carp;<br>
volatile spi_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *spi;&nbsp;<br>
volatile immap_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *immap;<br>
volatile cpic8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cpi;&nbsp;<br>
volatile cpm8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cp;&nbsp;&nbsp;<br>
volatile iop8xx_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *iop;&nbsp;<br>
<br>
static cbd_t *tbdf, *rbdf;<br>
<br>
static u8* txbuffer;<br>
static u8* rxbuffer;<br>
static u16 r_tbase, r_rbase;<br>
u8 txbuf[32];<br>
u8 rxbuf[32];<br>
<br>
static int transmit_data()<br>
{<br>
&nbsp;&nbsp; int result = 0;&nbsp; // default is no error<br>
<br>
&nbsp;&nbsp; // BD status/control register<br>
&nbsp;&nbsp; tbdf-&gt;cbd_sc = BD_SC_READY | BD_SC_WRAP | BD_SC_LAST;<br>
&nbsp;&nbsp; rbdf-&gt;cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;<br>
<br>
&nbsp;&nbsp; cp-&gt;cp_spmode = 0x0778 | SPMODE_LOOP;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; // spi mode setting<br>
&nbsp;&nbsp; cp-&gt;cp_spmode |= 0x0100;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // enable SPI<br>
&nbsp;&nbsp; cp-&gt;cp_spie&nbsp;&nbsp; = 0xff;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // clear all spi events<br>
&nbsp;&nbsp; cp-&gt;cp_spim&nbsp;&nbsp; = 0x37;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // mask all SPI events<br>
<br>
&nbsp;&nbsp; udelay(5); // Wait 5 microsecs<br>
<br>
&nbsp;&nbsp; cp-&gt;cp_spcom = SPCOM_STR;&nbsp;&nbsp; // start the transfer<br>
<br>
&nbsp;&nbsp; printk(&quot;after spcom\n&quot;);<br>
&nbsp;&nbsp; udelay(100);<br>
&nbsp;&nbsp; // go on and clear chip select befor looking at the result<br>
<br>
&nbsp;&nbsp; // wait 2 character times before writing to SPI bus again !!! ?????<br>
<br>
&nbsp;&nbsp; cp-&gt;cp_spmode = 0x00;&nbsp;&nbsp; // reset spi mode<br>
<br>
<br>
&nbsp;&nbsp; // test receive and transmit buffer descriptor for errors<br>
&nbsp;&nbsp; if (rbdf-&gt;cbd_sc &amp; (BD_SC_EMPTY | BD_SC_OV | BD_SC_ME))<br>
&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result = -EIO;<br>
&nbsp;&nbsp; }<br>
&nbsp;&nbsp; if (tbdf-&gt;cbd_sc &amp; (BD_SC_READY | BD_SC_UN | BD_SC_ME))<br>
&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result = -EIO;<br>
&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
} // int transmit_data<br>
<br>
<br>
static int hello_init(void)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dp_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to processors internal memory map<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; immap = (immap_t *)IMAP_ADDR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_read: immap = 0x%08x ***\n&quot;,(unsigned int)immap);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to cpm interrupt controller<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpi = (cpic8xx_t*)&amp;(((volatile immap_t*)IMAP_ADDR)-&gt;im_cpic);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_read: cpi = 0x%08x ***\n&quot;,(unsigned int)cpi);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to input/output port<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iop = (iop8xx_t *)&amp;(((volatile immap_t *)IMAP_ADDR)-&gt;im_ioport);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_read: iop = 0x%08x ***\n&quot;,(unsigned int)iop);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to communication processor<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp = (cpm8xx_t *)&amp;(((volatile immap_t *)IMAP_ADDR)-&gt;im_cpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: cp = 0x%08x ***\n&quot;,(unsigned int)cp);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to Serial Peripheral Interface parameter RAM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi = (spi_t *)&amp;cp-&gt;cp_dparam[PROFF_SPI];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: spi = 0x%08x ***\n&quot;,(unsigned int)spi);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get pointer to clocks and reset<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; carp = (car8xx_t *)&amp;((volatile immap_t *)IMAP_ADDR)-&gt;im_clkrst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: carp = 0x%08x ***\n&quot;,(unsigned int)carp);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; SCCR[DFBRG] = 0&nbsp; --&gt;&nbsp; BRGCLK = vcoout/1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ### verwenden nicht auch andere in ioDriver ????<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; carp-&gt;car_sccr &amp;= 0xFFFFE7FF;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; initialize the parameter ram<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; we need to make sure many things are initialized to zero<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rstate = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rdp = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbptr = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbc = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rxtmp = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tstate = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tdp = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbptr = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbc = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_txtmp = 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // allocate space for one transmit and one receive buffer descriptor in the DP ram<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp_addr = cpm_dpalloc(sizeof(cbd_t) * 2, 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // printk(&quot;*** spi_init: dp_addr = 0x%08x ***\n&quot;,(unsigned int)dp_addr);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set up the SPI parameters in the parameter ram<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbase = r_rbase = dp_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbase = r_tbase = dp_addr + sizeof(cbd_t);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ***********IMPORTANT******************<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // setting transmit and receive buffer descriptor<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // pointers initially to rbase and tbase. Only the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // microcode patches documentation talks about initializing<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // this pointer. This is missing from the sample I2C driver.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // If you dont initialize these pointers, the kernel hangs.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rbptr = spi-&gt;spi_rbase;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tbptr = spi-&gt;spi_tbase;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set to big endian<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_tfcr = SMC_EB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_rfcr = SMC_EB;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-&gt;spi_mrblr = SPI_MAX_BUFFER_SIZE;&nbsp;&nbsp;&nbsp; // Set maximum receive size<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: spi-&gt;spi_mrblr = 0x%04x ***\n&quot;,spi-&gt;spi_mrblr);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_cpcr |= 0x51;&nbsp;&nbsp;&nbsp; // Setting CPCR<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; immap-&gt;im_siu_conf.sc_sdcr = 0x0001;&nbsp;&nbsp;&nbsp; // sets SDMA configuration register<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpi-&gt;cpic_cicr |= 0x00000580;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // enable cpm interrupts, spi has highest priority<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpi-&gt;cpic_cimr |= 0x00000020;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // enable spi interrupts<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_spie = 0xff;&nbsp;&nbsp;&nbsp;&nbsp; // clear all spi events<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: iop-&gt;iop_pcdat = 0x%04x ***\n&quot;, iop-&gt;iop_pcdat);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ------------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // initialize Port B SPI pins -&gt; page 34-8 MPC860UM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // (we are only in master mode !)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ------------------------------------------------<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // --------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // GPIO or per. function<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBPAR[28] = 1&nbsp; -&gt; PERI: (SPIMISO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBPAR[29] = 1&nbsp; -&gt; PERI: (SPIMOSI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBPAR[30] = 1&nbsp; -&gt; PERI: (SPICLK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // --------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbpar |= 0x0000000E;&nbsp; // set bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: cp-&gt;cp_pbpar\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADR=0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VAL=0x%08x\n&quot;,(unsigned int)&amp;cp-&gt;cp_pbpar, cp-&gt;cp_pbpar);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ----------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // In/Out or per. function 0/1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBDIR[28] = 1&nbsp; -&gt; PERI1: SPIMISO<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBDIR[29] = 1&nbsp; -&gt; PERI1: SPIMOSI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBDIR[30] = 1&nbsp; -&gt; PERI1: SPICLK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ----------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbdir |= 0x0000000E;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //printk(&quot;*** spi_init: cp-&gt;cp_pbdir\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADR=0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VAL=0x%08x\n&quot;,(unsigned int)&amp;cp-&gt;cp_pbdir, cp-&gt;cp_pbdir);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // -------------------------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // attention: PBODR is a 32-bit-register,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // but in the memory-map-struct it is handled as<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 16-bit-register because lower 16 bit are always 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // open drain or active output<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBODR[28] = 1&nbsp; -&gt; open drain: SPIMISO<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBODR[29] = 0&nbsp; -&gt; active output SPIMOSI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PBODR[30] = 0&nbsp; -&gt; active output: SPICLK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // -------------------------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;\n*** cp-&gt;cp_pbodr = 0x%08x ***\n&quot;,cp-&gt;cp_pbodr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbodr |= 0x0008;&nbsp; // set bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp-&gt;cp_pbodr &amp;= 0xFFF9;&nbsp; // reset bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: cp-&gt;cp_pbodr\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADR=0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VAL=0x%04x\n&quot;,(unsigned int)&amp;cp-&gt;cp_pbodr, cp-&gt;cp_pbodr);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; printk(&quot;*** spi_init: cp-&gt;cp_pbdat\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADR=0x%08x\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VAL=0x%08x\n&quot;,(unsigned int)&amp;cp-&gt;cp_pbdat, cp-&gt;cp_pbdat);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // tx and rx buffer descriptors<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf = (cbd_t *)&amp;cp-&gt;cp_dpmem[r_tbase];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf = (cbd_t *)&amp;cp-&gt;cp_dpmem[r_rbase];<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // initialize tx and tx bd&#39;s<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf-&gt;cbd_sc &amp;= ~BD_SC_READY;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf-&gt;cbd_sc &amp;= ~BD_SC_EMPTY;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Allocate memory as required<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxbuffer = (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);&nbsp; // Memory alloc for receive buffer<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txbuffer = (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);&nbsp; // Memory alloc for transmit buffer<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set the bd&#39;s rx and tx buffer address pointers<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf-&gt;cbd_bufaddr = virt_to_bus((void *)rxbuffer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf-&gt;cbd_bufaddr = virt_to_bus((void *)txbuffer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; transmit_data();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp; return 0;<br>
}<br>
<br>
<br>
static void hello_exit(void)<br>
{<br>
}<br>
<br>
module_init(hello_init);<br>
module_exit(hello_exit);<br>
<br>
MODULE_LICENSE(&quot;Dual BSD/GPL&quot;);<br>
</font>
</p>

</div>
<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_95270_24660034.1172508193706--
