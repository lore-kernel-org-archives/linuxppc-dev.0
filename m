Return-Path: <jcrigby@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.197])
	by ozlabs.org (Postfix) with ESMTP id 0C94867BF4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 02:04:55 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id h31so322531wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Jun 2006 09:04:53 -0700 (PDT)
Message-ID: <4b73d43f0606080904v52e3cbe1kf9585bc1b0ba26a5@mail.gmail.com>
Date: Thu, 8 Jun 2006 10:04:52 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: Trueskew <trueskew@gmail.com>
Subject: Re: MPC5200B SPI PSC3 Problem
In-Reply-To: <44875165.40800d0c.36a8.3e2e@mx.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_32382_15031283.1149782692554"
References: <44875165.40800d0c.36a8.3e2e@mx.gmail.com>
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

------=_Part_32382_15031283.1149782692554
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There seems to be a conflict between two sections of the 5200 User manual.
In section 7.3 where port_config is documented the PSC3 configuration
bits (20:23)
defined as:

0000 = All PSC3 pins are GPIOs
0001 = USB2 on PSC3, no GPIOs available, see Note 3
001X = Reserved
0100 = UART functionality without CD
0101 = UARTe functionality with CD
0110 = CODEC3 functionality
0111 = CODEC3 functionality (with MCLK)
100X = SPI
101X = Reserved
1100 = SPI with UART3
1101 = SPI with UART3e
111X = SPI with CODEC3

but in the psc chapter in table 15-85 it says to set port config to
0x00000600 but
the description says "Select the Pin-Muxing for PSC3 Codec mode"

It appears that table 15-85 is wrong.

I have attached some spi code that is embedded in a touchscreen
driver.  It might be helpful.





On 6/7/06, Trueskew <trueskew@gmail.com> wrote:
>
>
> We have an AIC26 codec connected to our Lite5200B platform via J21.  I've
> used MPC5200BUG to configure PSC3 as an SPI master, along with some samples
> I've found online (including here) and some I received from Freescale.
> Although the transfers seem to be working as expected (please see the output
> file at the end of this message), I get only 0xffff back.  This occurs
> whether or not the device is attached to J21.  A scope shows that PSC3_8
> (SPI_SS) and PSC3_9 (SPI_CLK) are low at all times, and I'm concerned I'm
> still doing something wrong with respect to enabling SPI over PSC3.
>
> I'm including my driver initialization code, my write code, and output
> showing the write behavior.  If someone could comment on it, I would greatly
> appreciate it... or if someone flat out has code to do this, I'd be happy to
> take it from you.  I've seen a few variations, but whether I use them
> directly or modify them as I need to, I can't seem to get past this.  Of
> course, any other suggestions are welcome.
>
> Thanks.
> Sal
>
> ---------------------------------------------------------------------------
> Initialization Code
> ---------------------------------------------------------------------------
> #define GPIO_PSC3_PORT_CONFIG_MASK 0x00000f00
> #ifdef SPI_USE_MCLK
>    #define      GPIO_PSC3_PORT_CONFIG 0x00000700  /* PSC3 mode with mclk */
> #else  /* SPI_USE_MCLK */
>    #define      GPIO_PSC3_PORT_CONFIG 0x00000600  /* PSC3 mode */
> #endif /* SPI_USE_MCLK */
>
> #define       CDM_PSC3_MCLK_ENABLE 0x00000080
> #define       CDM_PSC3_MCLK_CONFIG 0x8020      /* Divide Fvco ftom 528 to
>                                                   16Mhz */
>
> #define        PSC3_SICR_REG_VALUE 0x0280f000  /* 16-bit select Codec SPI
>                                                   master
> mode, msb first,
>                                                   UseEOF=1.
> GenClk=1, SIM,
>                                                   CPOL and
> CPHA are
>                                                   function
> input */
> ...
>    /* Select the Pin-Muxing for PSC3 Codec mode */
>    gpio = (struct mpc52xx_gpio *) ioremap(MPC52xx_GPIO,
>      sizeof(struct mpc52xx_gpio));
>    if(gpio)
>    {
>       port_config = gpio->port_config;
>       port_config &= ~GPIO_PSC3_PORT_CONFIG_MASK;
>       port_config |= GPIO_PSC3_PORT_CONFIG;
>       gpio->port_config = port_config;
>       iounmap(gpio);
>    }
>    else
>    {
>       return(-1);
>    }
>
> #ifdef SPI_USE_MCLK
>    /* PSC clock enable */
>    g_pCDM->clk_enables |= CDM_PSC3_MCLK_ENABLE;
>    g_pCDM->mclken_div_psc3 = CDM_PSC3_MCLK_CONFIG;
> #endif /* SPI_USE_MCLK */
>
>    /* Disable rx and tx */
>    g_pPSC->command = MPC52xx_PSC_RST_RX;
>    g_pPSC->command = MPC52xx_PSC_RST_TX;
>    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
>    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
>    g_pPSC->command = MPC52xx_PSC_RX_DISABLE | MPC52xx_PSC_TX_DISABLE;
>
>    g_pPSC->mode = 0;
>    g_pPSC->sicr = PSC3_SICR_REG_VALUE;
>
>    #ifdef SPI_USE_MCLK
>    g_pPSC->ccr=0x0703;       /* set SCK and DSCKL delay */
>    #else  /* SPI_USE_MCLK */
>    g_pPSC->ccr=0x0003;       /* set SCK and DSCKL delay must be > 2 */
>    #endif /* SPI_USE_MCLK */
>
>    g_pPSC->ctur=0x00;        /* Set DTL delay 2us */
>    g_pPSC->ctlr=0x84;
>
>    g_pPSC->rfalarm=100;      /* Alarm values taken from SPI example sample
> */
>    g_pPSC->tfalarm=1;
>
>    g_pPSC->rfcntl &= 0xf8;       /* 0 byte granularity */
>    g_pPSC->tfcntl = 1;
>
>    /* Enable rx & tx */
>    g_pPSC->command = MPC52xx_PSC_RST_RX;
>    g_pPSC->command = MPC52xx_PSC_RST_TX;
>    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
>    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
>    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
>
> ---------------------------------------------------------------------------
> Write code
> ---------------------------------------------------------------------------
> static int mpc52xx_spi_transfer(u16 *p_usBuffer, u16 p_usCount)
> {
>    u16 usIndex, usTemp;
>
>
> printk("------------------------------------------------------\n");
>    printk("Entry:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>      g_pPSC->tfnum, g_pPSC->rfnum);
>    g_pPSC->command = MPC52xx_PSC_RST_RX;
>    g_pPSC->command = MPC52xx_PSC_RST_TX;
>    g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
>    g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
>    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
>    printk("TX-RX Enable:  psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>      g_pPSC->tfnum, g_pPSC->rfnum);
>
>    /* Clean out the read FIFO */
>    usIndex = 0;
>    while(g_pPSC->mpc52xx_psc_status & MPC52xx_PSC_SR_RXRDY)
>    {
>       usTemp = g_pPSC->mpc52xx_psc_buffer_16;
>       printk("Flushing Rx FIFO: psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>         g_pPSC->tfnum, g_pPSC->rfnum);
>       udelay(100000);
>       udelay(100000);
>       udelay(100000);
>       udelay(100000);
>       udelay(100000);
>       usIndex++;
>       if(usIndex == 10) return(-1);
>    }
>
>    /* Send out the buffer */
>    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_DISABLE;
>    for(usIndex=0; usIndex<p_usCount; usIndex++)
>    {
>       printk("Sending %04x:  psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>         p_usBuffer[usIndex],
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>         g_pPSC->tfnum, g_pPSC->rfnum);
>       g_pPSC->mpc52xx_psc_buffer_16 = p_usBuffer[usIndex];
>       printk("Sent:          psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>         g_pPSC->tfnum, g_pPSC->rfnum);
>    }
>    g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
>    usTemp = 0;
>    while(g_pPSC->tfnum)
>    {
>       printk("TFNUM Wait:   psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>         g_pPSC->tfnum, g_pPSC->rfnum);
>       udelay(100000);
>       udelay(100000);
>       udelay(100000);
>       udelay(100000);
>       udelay(100000);
>       usTemp++;
>       if(usTemp == 10) return(-1);
>    };
>    printk("TxRDY:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>      g_pPSC->tfnum, g_pPSC->rfnum);
>    for(usIndex=0; usIndex<p_usCount; usIndex++)
>    {
>       usTemp = 0;
>       while(!(g_pPSC->mpc52xx_psc_status &
> MPC52xx_PSC_SR_RXRDY))
>       {
>          printk("RxRDY Wait:    psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>            g_pPSC->tfnum, g_pPSC->rfnum);
>          udelay(100000);
>          udelay(100000);
>          udelay(100000);
>          udelay(100000);
>          udelay(100000);
>          usTemp++;
>          if(usTemp == 10) return(-1);
>       };
>       printk("RxRDY:         psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>         g_pPSC->tfnum, g_pPSC->rfnum);
>       p_usBuffer[usIndex] = g_pPSC->mpc52xx_psc_buffer_16;
>       printk("  Received %04x\n", p_usBuffer[usIndex]);
>    }
>
>    printk("EXIT:          psc=%x status=%04x tfstat=%04x rfstat=%04x
> mode=%02x\n   tfnum %3d  rfnum %3d\n",
>
> (int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC->mode,
>      g_pPSC->tfnum, g_pPSC->rfnum);
>    return(usIndex);
> }
>
>
> ---------------------------------------------------------------------------
> Output
> ---------------------------------------------------------------------------
> The lines below are a capture of register settings from my driver,
> along with output lines when trying to write 16 bit words to our
> device.  This output is consistent whether the device is connected
> or not (via J21).  Basic operation, delimited by "------...---":
>
>   - Disable TX, Enable RX (despite the "TX-RX Enable" heading)
>   - Send word 1
>   - Send word 2
>   - Enable TX, Enable RX
>   - Wait for tfnum == 0
>   - Receive data
>
> port_config=91051624 sicr=0280f000 clk_enables=00ffffff div_psc3=800f
> ------------------------------------------------------
> Entry:         psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
>    tfnum   0  rfnum   0
> TX-RX Enable:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
>    tfnum   0  rfnum   0
> Sending 0880:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   0
> Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   2  rfnum   0
> Sending bb00:  psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   2  rfnum   0
> Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   4  rfnum   0
> TFNUM Wait:   psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   2  rfnum   0
> TxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   4
> RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   4
>   Received ffff
> RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   2
>   Received ffff
> EXIT:          psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   0
> ------------------------------------------------------
> Entry:         psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   0
> TX-RX Enable:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
>    tfnum   0  rfnum   0
> Sending 8820:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   0
> Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   2  rfnum   0
> Sending 0000:  psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   2  rfnum   0
> Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   4  rfnum   0
> TFNUM Wait:   psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
>    tfnum   2  rfnum   0
> TxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   4
> RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   4
>   Received ffff
> RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   2
>   Received ffff
> EXIT:          psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
>    tfnum   0  rfnum   0
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>

------=_Part_32382_15031283.1149782692554
Content-Type: text/plain; name=mpc5200_ts_spi.c; charset=ISO-8859-1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo7axb6f
Content-Disposition: attachment; filename="mpc5200_ts_spi.c"

LyoKICogTWVkaWE1MjAwIHRvdWNoc2NyZWVuIGRyaXZlcgogKgogKiBDb3B5cmlnaHQgKGMpIDIw
MDYgRnJlZXNjYWxlCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CiAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZCBieQog
KiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgogKi8KCi8qCglGaWxlIDogbXBjNTIwMF90
c19zcGkuYwoJU3VtbWFyeSA6IHRvdWNoc2NyZWVuIHNwaSBkcml2ZXIKKi8KCiNpbmNsdWRlICJt
cGM1MjAwX3RzX3NwaS5oIgojaW5jbHVkZSAiYXNtL2lvLmgiCgoKLyoqKioqKioqKioqKioqKiog
UHVibGljIGZ1bmN0aW9ucyAqKioqKioqKioqKioqKioqLwoKLyogCglJbml0aWFsaXplIGFuZCBj
b25maWd1cmUgc3BpIAoJLSBjb25maWd1cmUgbXV4IHBvcnQgb24gcHNjMwoJLSBjb25maWd1cmUg
c3BpIG1vZGUKCS0gY29uZmlndXJlIHNwaSBiYXVkIHJhdGUKCQoqLwppbnQgc3BpX2luaXQgKHZv
aWQpIAp7CglzdHJ1Y3QgbXBjNTJ4eF9ncGlvIF9faW9tZW0gKmdwaW87CglzdHJ1Y3QgbXBjNTJ4
eF9pbnRyIF9faW9tZW0gKmludHI7CgoJLyogTWFwIHpvbmVzICovCglncGlvID0gaW9yZW1hcChN
UEM1Mnh4X1BBKE1QQzUyeHhfR1BJT19PRkZTRVQpLCBNUEM1Mnh4X0dQSU9fU0laRSk7CglpbnRy
ID0gaW9yZW1hcChNUEM1Mnh4X1BBKE1QQzUyeHhfSU5UUl9PRkZTRVQpLCBNUEM1Mnh4X0lOVFJf
U0laRSk7CgoJaWYgKCFncGlvIHx8ICFpbnRyKSB7CgkJcHJpbnRrKEtFUk5fRVJSIF9fRklMRV9f
ICI6ICIKCQkJCSJFcnJvciB3aGlsZSBtYXBwaW5nIEdQSU8vSU5UUiBkdXJpbmcgIgoJCQkJInNw
aV9pbml0XG4iKTsKCQlnb3RvIHVubWFwX3JlZ3M7Cgl9CgoJU1BJX0NvbmZpZ19UIAlzcGlfY29u
ZmlnOyAvKiBzcGkgY29uZmlndXJhdGlvbiAqLwoKCVBERUJVRzMoInNwaW5faW5pdDogaW5pdGlh
bGl6aW5nIFNQSSBpbiBzcGlfaW5pdCgpXG4iKTsKCgkvKiBlbmFibGUgaW50ZXJydXB0ICovCglp
bnRyLT5wZXJfbWFzayAmPSBJTlRSX1BFUl9NQVNLX1NQSV9PRkY7CgoKCS8qIGluaXRpYWxpemUg
bXV4IHBvcnQgUFNDMyB0byBTUEkgKi8KCWdwaW8tPnBvcnRfY29uZmlnIHw9IEdQSU9fQ09ORklH
X1BPUlRfU1BJX01BU0s7CgoJLyogaW5pdGlhbHplIGRhdGEgc3RydWN0dXJlICovCQoJU1BJX1Jl
Z3MgPSAoU1BJX1JlZ3NfVCAqKShTUElfQkFTRV9BRERSRVNTKTsKCW1lbXNldCgmc3BpX2NvbmZp
ZywgMCwgc2l6ZW9mKFNQSV9Db25maWdfVCkpOyAKCgkvKiBzZXQgc3BpIGNvbmZpZyBhdHRyaWJ1
dGVzICovCglzcGlfY29uZmlnLlNQSV9NYXN0ZXIgPSBTUElfTUFTVEVSX0RFRkFVTFQ7CglzcGlf
Y29uZmlnLkNsb2NrUG9sYXJpdHkgPSBTUElfQ1BPTF9ERUZBVUxUOwoJc3BpX2NvbmZpZy5DbG9j
a1BoYXNlID0gU1BJX0NQSEFfREVGQVVMVDsKCXNwaV9jb25maWcuV2lyZWRPUiA9IFNQSV9XT1Jf
REVGQVVMVDsKCXNwaV9jb25maWcuU1NvdXRwdXQgPSBTUElfU1NPRV9ERUZBVUxUOwoKCXNwaV9j
b25maWcuU1BJX0VuYWJsZSA9IFNQSV9TUEVfREVGQVVMVDsKCXNwaV9jb25maWcuQmF1ZFJhdGUg
PSBTUElfQkFVRF9ERUZBVUxUOyAgICAKCgkvKiBtb2RpZnkgYWNjb3JkaW5nIHRvIHRvdWNoc2Ny
ZWVuIGRyaXZlciBzcGkgY29uZmlnICovICAgCglzcGlfY29uZmlnLkNsb2NrUG9sYXJpdHkgPSAw
OwoJc3BpX2NvbmZpZy5DbG9ja1BoYXNlID0gMCA7CglzcGlfY29uZmlnLldpcmVkT1IgPSAwOwoK
CgkvKlNldCB0aGUgU1MgcGluIHRvIGxvdyBieSBzZXQgU1BJUE9SVCByZWdpc3RlciovIAoJU1BJ
X1JlZ3MtPlNQSVBPUlQgPSAweDAwOwoKCS8qIG5vdyBpbml0aWFsaXplIHRoZSBzcGkgaGFyZHdh
cmUgKi8KCVNQSV9TZXRDb25maWcoJnNwaV9jb25maWcpOwoKCS8qIFVubWFwIHJlZyB6b25lICov
CnVubWFwX3JlZ3M6CglpZiAoZ3BpbykgaW91bm1hcChncGlvKTsKCWlmIChpbnRyKSBpb3VubWFw
KGludHIpOwoKCXJldHVybiAoVFNfT0spOwp9CgoKCgoKCgovKiBhc3N1bWUgKmJ1ZmZlciBhbHJl
YWR5IGFsb2NhdGVkIHRvIGJlIGF0IGxlYXN0IG5ieXRlcyBsb25nICovCmludCByZWFkX3NwaSh1
OCAqYnVmZmVyLCB1MzIgbmJ5dGVzKQp7CiAgICBpbnQgaTsKCglmb3IgKGkgPSAwOyBpIDwgbmJ5
dGVzOyBpKyspIHsKCSAgICBidWZmZXJbaV0gPSBSZWFkUmVnaXN0ZXIoU1BJX1JlZ3MtPlNQSURS
KTsKICAgIH0gLyogZm9yICovCgoJcmV0dXJuIChuYnl0ZXMpOwp9IC8qIHJlYWRfc3BpICovCgoK
CgoKCgoKCgoKCmludCB3cml0ZV9zcGkoIHU4ICpidWZmZXIsIHUzMiBuYnl0ZXMpCnsKICAgIHUz
MiBsZW47CiAgICB1OCByZWdfdmFsdWU7CiAgICAKCiAgICAvLyBNb3ZlIHRoaXMgdG8gb25lIGRl
dmN0bCBjb21tYW5kIAogICAgLy8gU1BJX1JlZ3MtPlNQSVBPUlQgPSAweDAwOyAgIAogICAgIAog
ICAgZm9yICggbGVuID0gMDsgbGVuIDwgbmJ5dGVzOyBsZW4rKyApCiAgICB7CiAgICAgCgoJICAg
IFBERUJVRzkoImluIHdyaXRlX3NwaTogYnVmZmVyID0gJXhcbiIsICpidWZmZXIpOwoKICAgICAg
ICBXcml0ZVJlZ2lzdGVyKFNQSV9SZWdzLT5TUElEUiwqYnVmZmVyKTsKCiAgICAgICAgLyogV2Fp
dCBzZXZlcmFsIG5hbm9zZWNvbmRzIGFuZCB0aGVuIGNoZWNrIHRoZSBXQ09MIGZsYWcgaW4gc3Rh
dHVzIAogICAgICAgICAqIHJlZ2lzdGVyLiAgV2VpV2VpIHN5c3Rlc3QgcmVwbGFjZSBpdCB3aXRo
IHRoZSBmb3ItbG9vcCBkaXJlY3RseQogICAgICAgICAqLwogICAgICAgIC8vICBXQUlUKE5BTk9T
RUNTX1BFUl9XUklURSk7CiAgICAgICAgd2hpbGUoMSkKICAgICAgICB7CiAgICAgICAgICAgICBy
ZWdfdmFsdWUgPSBSZWFkUmVnaXN0ZXIoU1BJX1JlZ3MtPlNQSVNSKTsgCiAgICAgICAgICAgICBp
ZiAocmVnX3ZhbHVlICYgU1BJX1dDT0wpIAogICAgICAgICAgICAgewogICAgICAgICAgICAgICAg
V3JpdGVSZWdpc3RlcihTUElfUmVncy0+U1BJRFIsKmJ1ZmZlcik7CiAgICAgICAgICAgICAgICBj
b250aW51ZTsKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIGlmICggcmVnX3ZhbHVlICYgU1BJ
X1NQSUYgKSAgICAgICAKICAgICAgICAgICAgICAgICBicmVhazsKCSAgICB9CgogICAgICAgIC8v
U1BJX0lzcigpOwogICAgICAgIGJ1ZmZlcisrOwogICAgfQogICAgLyogV2VpV2VpIGFkZCA6IGhh
cmR3YXJlIHRlYW0gc3VnZ2VzdGlvbiwgYnV0IGl0IGlzIG9wdGlvbmFsICAqLwogICAgLy8gU1BJ
X1JlZ3MtPlNQSVBPUlQgPSAweDA4OyAgIAogICAgcmV0dXJuIGxlbjsKfQoKCgoKCi8qKioqKioq
KioqKioqKiogUHJpdmF0ZSBmdW5jdGlvbnMgKioqKioqKioqKioqKioqKioqKiovCnN0YXRpYyBp
bnQgU1BJX1NldENvbmZpZyhTUElfQ29uZmlnX1QgKiBDb25maWdfUHRyICkKewogICAgdTggY29u
dHJvbF9yZWcgPSAweDAwOwoKICAgICAgIAoJLyogaW5pdGlhbGl6ZSBkaXJlY3Rpb24gcmVnaXN0
ZXIgZm9yIFNQSSAqLwogICAgV3JpdGVSZWdpc3RlciAoIFNQSV9SZWdzLT5TUElERFIsIDB4MGUg
KTsgICAKICAgICAgCiAgICAvKiBTZXQgQmF1ZCBSYXRlICovCiAgICBpZihTUElfU2V0QmF1ZHJh
dGUoIENvbmZpZ19QdHIgLT4gQmF1ZFJhdGUpID09IFRTX0VSUk9SICkKICAgIHsKICAgICAgICBQ
REVCVUczKCJTUElfU2V0Q29uZmlnOiBFcnJvciBpbiBTZXQgYmF1ZHJhdGUgXG4iKTsKICAgICAg
ICAKICAgICAgICBXcml0ZVJlZ2lzdGVyKFNQSV9SZWdzLT5TUElDUjEsIGNvbnRyb2xfcmVnIHwg
U1BJX1NQRSk7CiAgICAgICAgcmV0dXJuIFRTX0VSUk9SOwogICAgfSAgIAoKCS8qIGF3YXlzIG1h
c3RlciAqLyAgICAgCgljb250cm9sX3JlZyB8PSBTUElfTUFTVEVSX01PREU7CgkvKiBUaGUgU1NP
RSBmb3IgbWFzdGVyIG1vZGUgKi8gICAgICAgICAgCgljb250cm9sX3JlZyAmPSB+U1BJX1NTT0U7
ICAgICAKICAgICAgIAoJaWYoQ29uZmlnX1B0ciAtPiBDbG9ja1BvbGFyaXR5KQoJICAgIGNvbnRy
b2xfcmVnIHw9IFNQSV9DUE9MOwoJZWxzZSAKCSAgICBjb250cm9sX3JlZyAmPSB+U1BJX0NQT0w7
CgkgICAgCglpZihDb25maWdfUHRyIC0+IENsb2NrUGhhc2UpCgkgICAgY29udHJvbF9yZWcgfD0g
U1BJX0NQSEE7CgllbHNlIAoJICAgIGNvbnRyb2xfcmVnICY9IH5TUElfQ1BIQTsKCSAgICAKCWlm
KENvbmZpZ19QdHIgLT4gV2lyZWRPUikKCSAgICBjb250cm9sX3JlZyB8PSBTUElfU1BXT007Cgll
bHNlIAoJICAgIGNvbnRyb2xfcmVnICY9IH5TUElfU1BXT007CiAgICAgICAgCiAgICAvKiBhbHdh
eXMgZW5hYmxlIFNQSSAqLyAgICAKICAgIGNvbnRyb2xfcmVnIHw9IFNQSV9TUEU7ICAgICAgICAK
ICAgICAgCgogICAgLyogRW5hYmxlIHRoZSBpbnRlcnJ1cHQgYW5kIHNldCB0aGUgcmVnaXN0ZXIg
OiBXZWlXZWkgc3lzdGVzdCAqLwogICAgV3JpdGVSZWdpc3RlcihTUElfUmVncy0+U1BJQ1IxLCBj
b250cm9sX3JlZyB8IFNQSV9TUElFICk7CiAgCiAgICBQREVCVUczKCJTUElfU2V0Q2NvbmZpZyA6
IFNQSUNSMSA9JXggXG4iLFNQSV9SZWdzLT5TUElDUjEpOwoKCiAgICByZXR1cm4gVFNfT0sgOwoK
fQoKCgpzdGF0aWMgaW50IFNQSV9TZXRCYXVkcmF0ZSh1MzIgQmF1ZFJhdGUpCnsKICAgIGludCBp
OwogICAgdTE2IGNsb2NrZGl2aXNvcjsKCiAgICAvKiBDb21wdXRlIHRoZSBDbG9jayBEaXZpc29y
IGZyb20gbW9kdWxlIGNsb2NrIGRpdmlkZWQgYnkgQmF1ZFJhdGUgKi8gCiAgICBjbG9ja2Rpdmlz
b3IgPSBTUElfTU9EVUxFX0NMT0NLL0JhdWRSYXRlOwogCiAgICAvKiBGaW5kIHRoZSB2YWx1ZSBv
ZiB0aGUgQmF1ZCBSYXRlIFJlZ2lzdGVyIGZyb20gdGhlIGFycmF5LiAKICAgICAqIElmIG5vIGFj
Y3VyYXRlIHZhbHVlIGNhbiBiZSBmb3VuZCwgc2VsZWN0IHRoZSBjbG9zZXN0IG9uZSAKICAgICAq
LyAgCiAgICBmb3IgKGkgPSAwOyBpIDwgU1BJX0RJVklTT1JfTlVNLTE7IGkrKykKICAgIHsKICAg
ICAgICBpZigoIGNsb2NrZGl2aXNvciA+PSBDbG9ja19EaXZpc29yW2ldLmNsb2NrZGl2aXNvciAp
ICYmIFwKICAgICAgICAgICAoIGNsb2NrZGl2aXNvciA8IENsb2NrX0Rpdmlzb3JbaSsxXS5jbG9j
a2Rpdmlzb3IpKQogICAgICAgIHsgICAgICAKICAgICAgICAgICAgdTE2IG1pZGRsZTsKICAgICAg
ICAgICAgbWlkZGxlID0gKENsb2NrX0Rpdmlzb3JbaV0uY2xvY2tkaXZpc29yICsgXAogICAgICAg
ICAgICAgICAgICAgQ2xvY2tfRGl2aXNvcltpKzFdLmNsb2NrZGl2aXNvcikvMjsKICAgICAgICAg
ICAgaWYgKCBjbG9ja2Rpdmlzb3IgPD0gbWlkZGxlICkgewogICAgICAgICAgICAgICAgV3JpdGVS
ZWdpc3RlcihTUElfUmVncy0+U1BJQlIsICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgQ2xv
Y2tfRGl2aXNvcltpXS5yZWdfdmFsdWUpOwogICAgICAgICAgICAgICAgUERFQlVHMygiU1BJX1Nl
dEJhdWRyYXRlOiBCYXVkcmF0ZSAlZFxuIiwgU1BJX01PRFVMRV9DTE9DSy9DbG9ja19EaXZpc29y
W2ldLmNsb2NrZGl2aXNvcik7IAogICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgICAg
V3JpdGVSZWdpc3RlcihTUElfUmVncy0+U1BJQlIsIFwKICAgICAgICAgICAgICAgICAgICAgICAg
ICBDbG9ja19EaXZpc29yW2krMV0ucmVnX3ZhbHVlKTsKCQkJCVBERUJVRzMoIlNQSV9TZXRCYXVk
cmF0ZTogQmF1ZHJhdGUgJWRcbiIsIFNQSV9NT0RVTEVfQ0xPQ0svQ2xvY2tfRGl2aXNvcltpKzFd
LmNsb2NrZGl2aXNvcik7ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgfQog
ICAgCiAgICAgICAgICAgIHJldHVybiBUU19PSzsKICAgICAgICB9CiAgICB9CiAgICBpZiAoIGNs
b2NrZGl2aXNvciA9PSBDbG9ja19EaXZpc29yW2ldLmNsb2NrZGl2aXNvciApCiAgICB7ICAgICAK
ICAgICAgIAogICAgICAgIFdyaXRlUmVnaXN0ZXIoU1BJX1JlZ3MtPlNQSUJSLCBDbG9ja19EaXZp
c29yW2ldLnJlZ192YWx1ZSk7ICAgCiAgICAgICAgUERFQlVHMygiU1BJX1NldEJhdWRyYXRlOiBF
eGFjdCBCYXVkcmF0ZSAlZFxuIiwgU1BJX01PRFVMRV9DTE9DSy9jbG9ja2Rpdmlzb3IpOwogICAg
ICAgICAKICAgICAgICByZXR1cm4gVFNfT0s7CiAgICB9CiAgICBlbHNlIAogICAgICAgIHJldHVy
biBUU19FUlJPUjsKfQoKCg==
------=_Part_32382_15031283.1149782692554--
