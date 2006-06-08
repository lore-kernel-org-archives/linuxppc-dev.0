Return-Path: <jcrigby@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.206])
	by ozlabs.org (Postfix) with ESMTP id 2AFA567BF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 02:11:25 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id h31so323785wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Jun 2006 09:11:24 -0700 (PDT)
Message-ID: <4b73d43f0606080911x5607f1fakbeee6a9b6e2cd6f1@mail.gmail.com>
Date: Thu, 8 Jun 2006 10:11:24 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: Trueskew <trueskew@gmail.com>
Subject: Re: MPC5200B SPI PSC3 Problem
In-Reply-To: <4b73d43f0606080904v52e3cbe1kf9585bc1b0ba26a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_32491_3409545.1149783084098"
References: <44875165.40800d0c.36a8.3e2e@mx.gmail.com>
	<4b73d43f0606080904v52e3cbe1kf9585bc1b0ba26a5@mail.gmail.com>
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

------=_Part_32491_3409545.1149783084098
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's an include file that goes with file in the last email.

On 6/8/06, John Rigby <jcrigby@gmail.com> wrote:
> There seems to be a conflict between two sections of the 5200 User manual.
> In section 7.3 where port_config is documented the PSC3 configuration
> bits (20:23)
> defined as:
>
> 0000 = All PSC3 pins are GPIOs
> 0001 = USB2 on PSC3, no GPIOs available, see Note 3
> 001X = Reserved
> 0100 = UART functionality without CD
> 0101 = UARTe functionality with CD
> 0110 = CODEC3 functionality
> 0111 = CODEC3 functionality (with MCLK)
> 100X = SPI
> 101X = Reserved
> 1100 = SPI with UART3
> 1101 = SPI with UART3e
> 111X = SPI with CODEC3
>
> but in the psc chapter in table 15-85 it says to set port config to
> 0x00000600 but
> the description says "Select the Pin-Muxing for PSC3 Codec mode"
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
> > We have an AIC26 codec connected to our Lite5200B platform via J21.  I've
> > used MPC5200BUG to configure PSC3 as an SPI master, along with some samples
> > I've found online (including here) and some I received from Freescale.
> > Although the transfers seem to be working as expected (please see the output
> > file at the end of this message), I get only 0xffff back.  This occurs
> > whether or not the device is attached to J21.  A scope shows that PSC3_8
> > (SPI_SS) and PSC3_9 (SPI_CLK) are low at all times, and I'm concerned I'm
> > still doing something wrong with respect to enabling SPI over PSC3.
> >
> > I'm including my driver initialization code, my write code, and output
> > showing the write behavior.  If someone could comment on it, I would greatly
> > appreciate it... or if someone flat out has code to do this, I'd be happy to
> > take it from you.  I've seen a few variations, but whether I use them
> > directly or modify them as I need to, I can't seem to get past this.  Of
> > course, any other suggestions are welcome.
> >
> > Thanks.
> > Sal
> >
> > ---------------------------------------------------------------------------
> > Initialization Code
> > ---------------------------------------------------------------------------
> > #define GPIO_PSC3_PORT_CONFIG_MASK 0x00000f00
> > #ifdef SPI_USE_MCLK
> >    #define      GPIO_PSC3_PORT_CONFIG 0x00000700  /* PSC3 mode with mclk */
> > #else  /* SPI_USE_MCLK */
> >    #define      GPIO_PSC3_PORT_CONFIG 0x00000600  /* PSC3 mode */
> > #endif /* SPI_USE_MCLK */
> >
> > #define       CDM_PSC3_MCLK_ENABLE 0x00000080
> > #define       CDM_PSC3_MCLK_CONFIG 0x8020      /* Divide Fvco ftom 528 to
> >                                                   16Mhz */
> >
> > #define        PSC3_SICR_REG_VALUE 0x0280f000  /* 16-bit select Codec SPI
> >                                                   master
> > mode, msb first,
> >                                                   UseEOF=1.
> > GenClk=1, SIM,
> >                                                   CPOL and
> > CPHA are
> >                                                   function
> > input */
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
> >    g_pCDM->mclken_div_psc3 = CDM_PSC3_MCLK_CONFIG;
> > #endif /* SPI_USE_MCLK */
> >
> >    /* Disable rx and tx */
> >    g_pPSC->command = MPC52xx_PSC_RST_RX;
> >    g_pPSC->command = MPC52xx_PSC_RST_TX;
> >    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
> >    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
> >    g_pPSC->command = MPC52xx_PSC_RX_DISABLE | MPC52xx_PSC_TX_DISABLE;
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
> >    g_pPSC->rfalarm=100;      /* Alarm values taken from SPI example sample
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
> > ---------------------------------------------------------------------------
> > Write code
> > ---------------------------------------------------------------------------
> > static int mpc52xx_spi_transfer(u16 *p_usBuffer, u16 p_usCount)
> > {
> >    u16 usIndex, usTemp;
> >
> >
> > printk("------------------------------------------------------\n");
> >    printk("Entry:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >    g_pPSC->command = MPC52xx_PSC_RST_RX;
> >    g_pPSC->command = MPC52xx_PSC_RST_TX;
> >    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
> >    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
> >    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
> >    printk("TX-RX Enable:  psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >
> >    /* Clean out the read FIFO */
> >    usIndex = 0;
> >    while(g_pPSC->mpc52xx_psc_status & MPC52xx_PSC_SR_RXRDY)
> >    {
> >       usTemp = g_pPSC->mpc52xx_psc_buffer_16;
> >       printk("Flushing Rx FIFO: psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
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
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >       g_pPSC->mpc52xx_psc_buffer_16 = p_usBuffer[usIndex];
> >       printk("Sent:          psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >    }
> >    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
> >    usTemp = 0;
> >    while(g_pPSC->tfnum)
> >    {
> >       printk("TFNUM Wait:   psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
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
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >    for(usIndex=0; usIndex<p_usCount; usIndex++)
> >    {
> >       usTemp = 0;
> >       while(!(g_pPSC->mpc52xx_psc_status &
> > MPC52xx_PSC_SR_RXRDY))
> >       {
> >          printk("RxRDY Wait:    psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
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
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >         g_pPSC->tfnum, g_pPSC->rfnum);
> >       p_usBuffer[usIndex] = g_pPSC->mpc52xx_psc_buffer_16;
> >       printk("  Received %04x\n", p_usBuffer[usIndex]);
> >    }
> >
> >    printk("EXIT:          psc=%x status=%04x tfstat=%04x rfstat=%04x
> > mode=%02x\n   tfnum %3d  rfnum %3d\n",
> >
> > (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
> >      g_pPSC->tfnum, g_pPSC->rfnum);
> >    return(usIndex);
> > }
> >
> >
> > ---------------------------------------------------------------------------
> > Output
> > ---------------------------------------------------------------------------
> > The lines below are a capture of register settings from my driver,
> > along with output lines when trying to write 16 bit words to our
> > device.  This output is consistent whether the device is connected
> > or not (via J21).  Basic operation, delimited by "------...---":
> >
> >   - Disable TX, Enable RX (despite the "TX-RX Enable" heading)
> >   - Send word 1
> >   - Send word 2
> >   - Enable TX, Enable RX
> >   - Wait for tfnum == 0
> >   - Receive data
> >
> > port_config=91051624 sicr=0280f000 clk_enables=00ffffff div_psc3=800f
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

------=_Part_32491_3409545.1149783084098
Content-Type: text/plain; name="mpc5200_ts_spi.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mpc5200_ts_spi.h"
X-Attachment-Id: f_eo7b5nwp

LyoKICogTWVkaWE1MjAwIHRvdWNoc2NyZWVuIGRyaXZlcgogKgogKiBDb3B5cmlnaHQgKGMpIDIw
MDYgRnJlZXNjYWxlCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CiAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZCBieQog
KiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgogKi8KCi8qCglGaWxlIDogIm1wYzUyMDBf
dHNfc3BpLmgiCglTdW1tYXJ5OiBzcGkgaGVhZGVyIGZpbGUKCgoqLwoKI2lmbmRlZiBfX01QQzUy
MDBfVFNfU1BJX0gKI2RlZmluZSBfX01QQzUyMDBfVFNfU1BJX0gKCi8qIGhlYWRlcnMgKi8KI2lu
Y2x1ZGUgIm1wYzUyMDBfdHNfY29tbW9uLmgiCiNpbmNsdWRlICJtcGM1MjAwX3RzX3NwaV9kZm4u
aCIKCnR5cGVkZWYgc3RydWN0IFNQSV9Db25maWdfVHlwZQp7CiAgICB1OCAgU1BJX01hc3Rlcjsg
ICAgICAvKiAxID0gIFNQSSBkZXZpY2UgaXMgTWFzdGVyOyAqLwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIDAgPSBTUEkgZGV2aWNlIGlzIFNsYXZlICovCiAgICB1OCAgQ2xvY2tQb2xh
cml0eTsgICAvKiAxID0gQWN0aXZlLWxvdyBjbG9ja3Mgc2VsZWN0ZWQ7Ki8gCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLyogMCA9IEFjdGl2ZS1oaWdoIGNsb2NrcyBzZWxlY3RlZCAqLwog
ICAgdTggIENsb2NrUGhhc2U7ICAgICAgLyogQ2xvY2sgUGhhc2UgKi8KICAgIHU4ICBXaXJlZE9S
OyAgICAgICAgIC8qIDEgPSBXaXJlZC1PUiBtb2RlICovCiAgICB1OCAgU1BJX0VuYWJsZTsgICAg
ICAvKiAxID0gU1BJIHN5c3RlbSBlbmFibGUgKi8KICAgIHU4ICBTU291dHB1dDsgICAgICAgIC8q
IDEgPSBTUyBhcyBnZW5lcmFsLXB1cnBvc2Ugb3V0cHV0Ki8KICAgIHUzMiBCYXVkUmF0ZTsgICAg
ICAgIC8qIEJhdWQgUmF0ZSAsdGhlIHVuaXQgaXMgS0h6ICovIAp9IFNQSV9Db25maWdfVDsKCgp0
eXBlZGVmIHN0cnVjdCBDbG9ja0Rpdmlzb3JfVHlwZQp7CiAgICB1OCAgICByZWdfdmFsdWU7ICAg
IC8qIFRoZSBjb3JyZXNwb25kaW5nIHJlZ2lzdGVyIHZhbHVlICovCiAgICB1MTYgICAgY2xvY2tk
aXZpc29yOyAvKiBDbG9jayBEaXZpc29yICovCn0gQ2xvY2tEaXZpc29yX1Q7CgoKLyogVGhlIGZv
bGxvd2luZyBhcmUgZGVmYXVsdCB2YWx1ZXMgb2YgU1BJIGNvbmZpZ3VyYXRpb24gOiBjb2RlIHJl
dmlldyAqLwojZGVmaW5lIFNQSV9NQVNURVJfREVGQVVMVCAgICAgICAgICAgICAgICAgIDEKI2Rl
ZmluZSBTUElfQ1BPTF9ERUZBVUxUICAgICAgICAgICAgICAgICAgICAxCiNkZWZpbmUgU1BJX0NQ
SEFfREVGQVVMVCAgICAgICAgICAgICAgICAgICAgMQojZGVmaW5lIFNQSV9XT1JfREVGQVVMVCAg
ICAgICAgICAgICAgICAgICAgIDEKI2RlZmluZSBTUElfU1BFX0RFRkFVTFQgICAgICAgICAgICAg
ICAgICAgICAxCiNkZWZpbmUgU1BJX1NTT0VfREVGQVVMVCAgICAgICAgICAgICAgICAgICAgMSAg
IC8qV2VpV2VpIGFkZCBpdCBmb3IgU1NPRSBiaXQgKi8KLy8jZGVmaW5lIFNQSV9CQVVEX0RFRkFV
TFQgICAgICAgICAgICAgICAgICAyMDYyNTAgLy8gd2l0aCA2Nk1IWiBjbG9jaywgc2hvdWxkIHlp
ZWxkIDMyMCBkaXZpc29yIC4uIHRoaXMgbWF5IHNvbHZlIGVycmF0YSBzaGVldCB3aGVyZSBTUElG
IHNldCBiZWZvcmUgZGF0YSByZWFkeSBiZWxvdyAyMDBLSFogNTAwMDAKI2RlZmluZSBTUElfQkFV
RF9ERUZBVUxUICAgICAgICAgICAgICAgICAgMTI4OTAwIC8vIHdpdGggMTMyTUh6IGJ1cywgMTAy
NAovLyNkZWZpbmUgU1BJX0JBVURfREVGQVVMVCAgICAgICAgICAgICAgICAgIDUwMDAwCiNkZWZp
bmUgUkNWQlVGX1NJWkVfREVGQVVMVCAgICAgICAgICAgICAgIDUxMgojZGVmaW5lIFJDVkJVRl9N
SU5fU0laRSAgICAgICAgICAgICAgICAgICA0CiNkZWZpbmUgUkNWQlVGX01BWF9TSVpFICAgICAg
ICAgICAgICAgICAgIDQwOTYKI2RlZmluZSBNU0dfTUFYX1NJWkUgICAgICAgICAgICAgICAgICAg
ICAgMjA0OAojZGVmaW5lIEJVRlNJWkUgICAgICAgICAgICAgICAgICAgICAgICAgICA1MTIKCi8q
IHNldHRpbmcgZm9yIG1vZHVsZSBjbG9jayBpcyBub3cgMTMyTUhaIGZvciBNZWRpYTUyMDAgKi8K
I2RlZmluZSBTUElfTU9EVUxFX0NMT0NLICAgICAgICAgICAgICAgICAgMTMyMDAwMDAwCgojZGVm
aW5lIFNQSV9ESVZJU09SX05VTSAgICAgICAgICAgICAgICAgICAzNgojZGVmaW5lIE5BTk9TRUNT
X1BFUl9XUklURSAgICAgICAgICAgICAgICAxMDAwMDAwCiNkZWZpbmUgTkFOT1NFQ1NfRk9SX1dD
T0wgICAgICAgICAgICAgICAgIDEwMDAwMDAKI2RlZmluZSBMT09QUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMTAKCgovKiBDbG9jayBEaXZpc29yIFNlbGVjdGlvbnMgQXJyYXkuIEFsbCBj
bG9jayBkaXZpc29yIHNlbGVjdGlvbnMgdGhlIHNwaSBkcml2ZXIgCiAqIGNhbiBzdXBwb3J0IGFy
ZSBhcnJhbmdlZCBiZXR3ZWVuIDY0MCB0byAyMDQ4IGluIGFzY2VuZGluZyBvcmRlci4gVGhlIHN1
cHBvcnRlZCAKICogYmF1ZHJhdGUgcmFuZ2Ugd2lsbCByZWx5IG9uIHRoZSBTUEkgbW9kdWxlIGNs
b2NrKCBzeXN0ZW0gY2xvY2spLiAgCiAqIEdpdmVuIDY2TUh6IHN5c3RlbSBjbG9jaywgdGhlIGJh
dWRyYXRlIHJhbmdlZCBiZXR3ZWVuIDMzMDAwSHogdG8gMTAwMDAwSHouCiAqLwovKiBGb3IgbWVt
b3J5IGxlYWsgOiB1cCB0aGUgYmF1ZCByYXRlIHRvIDEwMEtIeiAqLwpDbG9ja0Rpdmlzb3JfVCBD
bG9ja19EaXZpc29yW1NQSV9ESVZJU09SX05VTV0gPQp7IHsgMHg0NSwgMzIwfSx7IDB4NDYsIDY0
MCB9LCB7IDB4NTYsIDc2OCB9LCB7IDB4NjYsIDg5NiB9LCB7IDB4NzYsIDEwMjQgfSwgeyAweDQ3
LCAxMjgwIH0sIHsgMHg1NywgMTUzNiB9LHsgMHg2NywgMTc5Mn0sIHsgMHg3NywgMjA0OCB9IH07
CgoKCgoKU1BJX1JlZ3NfVAkJKlNQSV9SZWdzOyAvKiBzcGkgcmVnaXN0ZXIgc3RydWN0ICovCgoK
Ci8qIHB1YmxpYyBmdW5jdGlvbiBwcm90b3R5cGluZyAqLwppbnQgc3BpX2luaXQgKHZvaWQpOwpp
bnQgd3JpdGVfc3BpKHU4ICpidWZmZXIsIHUzMiBuYnl0ZXMpOwppbnQgcmVhZF9zcGkodTggKmJ1
ZmZlciwgdTMyIG5ieXRlcyk7CgovKiBwcml2YXRlIGZ1bmN0aW9ucyBwcm90b3R5cGluZyAqLwpz
dGF0aWMgaW50IFNQSV9TZXRDb25maWcoU1BJX0NvbmZpZ19UICogQ29uZmlnX1B0ciApOwpzdGF0
aWMgaW50IFNQSV9TZXRCYXVkcmF0ZSggdTMyIEJhdWRSYXRlKTsKCiNlbmRpZgo=
------=_Part_32491_3409545.1149783084098--
