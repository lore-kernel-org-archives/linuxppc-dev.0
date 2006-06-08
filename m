Return-Path: <trueskew@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id A6D1E67BD9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 05:57:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so700631pye
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Jun 2006 12:57:22 -0700 (PDT)
From: "Trueskew" <trueskew@gmail.com>
To: "'John Rigby'" <jcrigby@gmail.com>
Subject: RE: MPC5200B SPI PSC3 Problem
Date: Thu, 8 Jun 2006 12:50:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4b73d43f0606080911x5607f1fakbeee6a9b6e2cd6f1@mail.gmail.com>
Message-ID: <44887f97.7f880061.2e4f.5d3e@mx.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks John.  I actually decided not to sleep last night and figured all of
that out, including the documentation conflict, and now I'm working.  I
wasn't even sure my post work, I didn't receive it, but maybe the sender is
left out.  I should've slept and waited for your reply.

I'm still a little confused though.  I re-checked code from Freescale and
references and patches listed or mentioned here, and they all use either
0x06 or 0x07 for the GPIO port config, depending on whether they want MCLK
or not.  The included SPI transfer routines use the PSC3 FIFO mechanism to
send and receive data.  The biggest light bulb shot for how I figured out
what was going on was because I decided to hang a scope off the codec lines
of the PSC3, and that's where I found the data I was sending out.  The
MPC5200B vs. MPC5200 doc from Freescale doesn't mention this area as
changed, so how do so many 5200 SPI solutions go this route?  I wondered if
they worked on reference platforms that were using the codec lines to drive
SPI, which looks like it's doable, but some solutions advertise themselves
as MPC5200 SPI drivers.  Another possibility is that they weren't tested.
And yet another, the one I'm concerned with, is that I'm still
misunderstanding something... hence the paragraph.

But in any case, thanks again, I appreciate the help.


-----Original Message-----
From: John Rigby [mailto:jcrigby@gmail.com] 
Sent: Thursday, June 08, 2006 9:11 AM
To: Trueskew
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200B SPI PSC3 Problem

Here's an include file that goes with file in the last email.

On 6/8/06, John Rigby <jcrigby@gmail.com> wrote:
> There seems to be a conflict between two sections of the 5200 User manual.
> In section 7.3 where port_config is documented the PSC3 configuration 
> bits (20:23) defined as:
>
> 0000 = All PSC3 pins are GPIOs
> 0001 = USB2 on PSC3, no GPIOs available, see Note 3 001X = Reserved 
> 0100 = UART functionality without CD
> 0101 = UARTe functionality with CD
> 0110 = CODEC3 functionality
> 0111 = CODEC3 functionality (with MCLK) 100X = SPI 101X = Reserved 
> 1100 = SPI with UART3
> 1101 = SPI with UART3e
> 111X = SPI with CODEC3
>
> but in the psc chapter in table 15-85 it says to set port config to 
> 0x00000600 but the description says "Select the Pin-Muxing for PSC3 
> Codec mode"
>
> It appears that table 15-85 is wrong.
>
> I have attached some spi code that is embedded in a touchscreen 
> driver.  It might be helpful.
>
>
>
>
>
> On 6/7/06, Trueskew <trueskew@gmail.com> wrote:
> >
> >
> > We have an AIC26 codec connected to our Lite5200B platform via J21.  
> > I've used MPC5200BUG to configure PSC3 as an SPI master, along with 
> > some samples I've found online (including here) and some I received from
Freescale.
> > Although the transfers seem to be working as expected (please see 
> > the output file at the end of this message), I get only 0xffff back.  
> > This occurs whether or not the device is attached to J21.  A scope 
> > shows that PSC3_8
> > (SPI_SS) and PSC3_9 (SPI_CLK) are low at all times, and I'm 
> > concerned I'm still doing something wrong with respect to enabling SPI
over PSC3.
> >
> > I'm including my driver initialization code, my write code, and 
> > output showing the write behavior.  If someone could comment on it, 
> > I would greatly appreciate it... or if someone flat out has code to 
> > do this, I'd be happy to take it from you.  I've seen a few 
> > variations, but whether I use them directly or modify them as I need 
> > to, I can't seem to get past this.  Of course, any other suggestions are
welcome.
> >
> > Thanks.
> > Sal
> >
> > --------------------------------------------------------------------
> > -------
> > Initialization Code
> > --------------------------------------------------------------------
> > ------- #define GPIO_PSC3_PORT_CONFIG_MASK 0x00000f00 #ifdef 
> > SPI_USE_MCLK
> >    #define      GPIO_PSC3_PORT_CONFIG 0x00000700  /* PSC3 mode with mclk
*/
> > #else  /* SPI_USE_MCLK */
> >    #define      GPIO_PSC3_PORT_CONFIG 0x00000600  /* PSC3 mode */
> > #endif /* SPI_USE_MCLK */
> >
> > #define       CDM_PSC3_MCLK_ENABLE 0x00000080
> > #define       CDM_PSC3_MCLK_CONFIG 0x8020      /* Divide Fvco ftom 528
to
> >                                                   16Mhz */
> >
> > #define        PSC3_SICR_REG_VALUE 0x0280f000  /* 16-bit select Codec
SPI
> >                                                   master mode, msb 
> > first,
> >                                                   UseEOF=1.
> > GenClk=1, SIM,
> >                                                   CPOL and CPHA are
> >                                                   function input */ 
> > ...
> >    /* Select the Pin-Muxing for PSC3 Codec mode */
> >    gpio = (struct mpc52xx_gpio *) ioremap(MPC52xx_GPIO,
> >      sizeof(struct mpc52xx_gpio));
> >    if(gpio)
> >    {
> >       port_config = gpio->port_config;
> >       port_config &= ~GPIO_PSC3_PORT_CONFIG_MASK;
> >       port_config |= GPIO_PSC3_PORT_CONFIG;
> >       gpio->port_config = port_config;
> >       iounmap(gpio);
> >    }
> >    else
> >    {
> >       return(-1);
> >    }
> >
> > #ifdef SPI_USE_MCLK
> >    /* PSC clock enable */
> >    g_pCDM->clk_enables |= CDM_PSC3_MCLK_ENABLE;
> >    g_pCDM->mclken_div_psc3 = CDM_PSC3_MCLK_CONFIG; #endif /* 
> > SPI_USE_MCLK */
> >
> >    /* Disable rx and tx */
> >    g_pPSC->command = MPC52xx_PSC_RST_RX;
> >    g_pPSC->command = MPC52xx_PSC_RST_TX;
> >    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
> >    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
> >    g_pPSC->command = MPC52xx_PSC_RX_DISABLE | 
> > MPC52xx_PSC_TX_DISABLE;
> >
> >    g_pPSC->mode = 0;
> >    g_pPSC->sicr = PSC3_SICR_REG_VALUE;
> >
> >    #ifdef SPI_USE_MCLK
> >    g_pPSC->ccr=0x0703;       /* set SCK and DSCKL delay */
> >    #else  /* SPI_USE_MCLK */
> >    g_pPSC->ccr=0x0003;       /* set SCK and DSCKL delay must be > 2 */
> >    #endif /* SPI_USE_MCLK */
> >
> >    g_pPSC->ctur=0x00;        /* Set DTL delay 2us */
> >    g_pPSC->ctlr=0x84;
> >
> >    g_pPSC->rfalarm=100;      /* Alarm values taken from SPI example
sample
> > */
> >    g_pPSC->tfalarm=1;
> >
> >    g_pPSC->rfcntl &= 0xf8;       /* 0 byte granularity */
> >    g_pPSC->tfcntl = 1;
> >
> >    /* Enable rx & tx */
> >    g_pPSC->command = MPC52xx_PSC_RST_RX;
> >    g_pPSC->command = MPC52xx_PSC_RST_TX;
> >    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
> >    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
> >    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
> >
> > --------------------------------------------------------------------
> > -------
> > Write code
> > --------------------------------------------------------------------
> > ------- static int mpc52xx_spi_transfer(u16 *p_usBuffer, u16 
> > p_usCount) {
> >    u16 usIndex, usTemp;
> >
> >
> > printk("------------------------------------------------------\n");
> >    printk("Entry:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >    g_pPSC->command = MPC52xx_PSC_RST_RX;
> >    g_pPSC->command = MPC52xx_PSC_RST_TX;
> >    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
> >    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
> >    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
> >    printk("TX-RX Enable:  psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >
> >    /* Clean out the read FIFO */
> >    usIndex = 0;
> >    while(g_pPSC->mpc52xx_psc_status & MPC52xx_PSC_SR_RXRDY)
> >    {
> >       usTemp = g_pPSC->mpc52xx_psc_buffer_16;
> >       printk("Flushing Rx FIFO: psc=%x status=%04x tfstat=%04x
rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >       udelay(100000);
> >       udelay(100000);
> >       udelay(100000);
> >       udelay(100000);
> >       udelay(100000);
> >       usIndex++;
> >       if(usIndex == 10) return(-1);
> >    }
> >
> >    /* Send out the buffer */
> >    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_DISABLE;
> >    for(usIndex=0; usIndex<p_usCount; usIndex++)
> >    {
> >       printk("Sending %04x:  psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >         p_usBuffer[usIndex],
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >       g_pPSC->mpc52xx_psc_buffer_16 = p_usBuffer[usIndex];
> >       printk("Sent:          psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >    }
> >    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
> >    usTemp = 0;
> >    while(g_pPSC->tfnum)
> >    {
> >       printk("TFNUM Wait:   psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >       udelay(100000);
> >       udelay(100000);
> >       udelay(100000);
> >       udelay(100000);
> >       udelay(100000);
> >       usTemp++;
> >       if(usTemp == 10) return(-1);
> >    };
> >    printk("TxRDY:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >    for(usIndex=0; usIndex<p_usCount; usIndex++)
> >    {
> >       usTemp = 0;
> >       while(!(g_pPSC->mpc52xx_psc_status &
> > MPC52xx_PSC_SR_RXRDY))
> >       {
> >          printk("RxRDY Wait:    psc=%x status=%04x tfstat=%04x
rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >            g_pPSC->tfnum, g_pPSC->rfnum);
> >          udelay(100000);
> >          udelay(100000);
> >          udelay(100000);
> >          udelay(100000);
> >          udelay(100000);
> >          usTemp++;
> >          if(usTemp == 10) return(-1);
> >       };
> >       printk("RxRDY:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >       p_usBuffer[usIndex] = g_pPSC->mpc52xx_psc_buffer_16;
> >       printk("  Received %04x\n", p_usBuffer[usIndex]);
> >    }
> >
> >    printk("EXIT:          psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> >
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >    return(usIndex);
> > }
> >
> >
> > --------------------------------------------------------------------
> > -------
> > Output
> > --------------------------------------------------------------------
> > ------- The lines below are a capture of register settings from my 
> > driver, along with output lines when trying to write 16 bit words to 
> > our device.  This output is consistent whether the device is 
> > connected or not (via J21).  Basic operation, delimited by 
> > "------...---":
> >
> >   - Disable TX, Enable RX (despite the "TX-RX Enable" heading)
> >   - Send word 1
> >   - Send word 2
> >   - Enable TX, Enable RX
> >   - Wait for tfnum == 0
> >   - Receive data
> >
> > port_config=91051624 sicr=0280f000 clk_enables=00ffffff 
> > div_psc3=800f
> > ------------------------------------------------------
> > Entry:         psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
> >    tfnum   0  rfnum   0
> > TX-RX Enable:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
> >    tfnum   0  rfnum   0
> > Sending 0880:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   0
> > Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   2  rfnum   0
> > Sending bb00:  psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   2  rfnum   0
> > Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   4  rfnum   0
> > TFNUM Wait:   psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   2  rfnum   0
> > TxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   4
> > RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   4
> >   Received ffff
> > RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   2
> >   Received ffff
> > EXIT:          psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   0
> > ------------------------------------------------------
> > Entry:         psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   0
> > TX-RX Enable:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
> >    tfnum   0  rfnum   0
> > Sending 8820:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   0
> > Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   2  rfnum   0
> > Sending 0000:  psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   2  rfnum   0
> > Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   4  rfnum   0
> > TFNUM Wait:   psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
> >    tfnum   2  rfnum   0
> > TxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   4
> > RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   4
> >   Received ffff
> > RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   2
> >   Received ffff
> > EXIT:          psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
> >    tfnum   0  rfnum   0
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>
>
>
