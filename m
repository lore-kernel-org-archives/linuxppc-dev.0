Return-Path: <trueskew@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id 434ED67B7F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Jun 2006 08:27:31 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 55so509985wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Jun 2006 15:27:30 -0700 (PDT)
From: "Trueskew" <trueskew@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200B SPI PSC3 Problem
Date: Wed, 7 Jun 2006 15:21:22 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00EE_01C68A46.09E05B40"
Message-ID: <44875165.40800d0c.36a8.3e2e@mx.gmail.com>
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

------=_NextPart_000_00EE_01C68A46.09E05B40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

We have an AIC26 codec connected to our Lite5200B platform via J21.  I've
used MPC5200BUG to configure PSC3 as an SPI master, along with some samples
I've found online (including here) and some I received from Freescale.
Although the transfers seem to be working as expected (please see the output
file at the end of this message), I get only 0xffff back.  This occurs
whether or not the device is attached to J21.  A scope shows that PSC3_8
(SPI_SS) and PSC3_9 (SPI_CLK) are low at all times, and I'm concerned I'm
still doing something wrong with respect to enabling SPI over PSC3.  
 
I'm including my driver initialization code, my write code, and output
showing the write behavior.  If someone could comment on it, I would greatly
appreciate it... or if someone flat out has code to do this, I'd be happy to
take it from you.  I've seen a few variations, but whether I use them
directly or modify them as I need to, I can't seem to get past this.  Of
course, any other suggestions are welcome.
 
Thanks.
Sal
 
---------------------------------------------------------------------------
Initialization Code
---------------------------------------------------------------------------
#define GPIO_PSC3_PORT_CONFIG_MASK 0x00000f00
#ifdef SPI_USE_MCLK
   #define      GPIO_PSC3_PORT_CONFIG 0x00000700  /* PSC3 mode with mclk */
#else  /* SPI_USE_MCLK */
   #define      GPIO_PSC3_PORT_CONFIG 0x00000600  /* PSC3 mode */
#endif /* SPI_USE_MCLK */
 
#define       CDM_PSC3_MCLK_ENABLE 0x00000080
#define       CDM_PSC3_MCLK_CONFIG 0x8020      /* Divide Fvco ftom 528 to 
                                                  16Mhz */
 
#define        PSC3_SICR_REG_VALUE 0x0280f000  /* 16-bit select Codec SPI 
                                                  master mode, msb first, 
                                                  UseEOF=1. GenClk=1, SIM, 
                                                  CPOL and CPHA are 
                                                  function input */  
...                                               
   /* Select the Pin-Muxing for PSC3 Codec mode */
   gpio = (struct mpc52xx_gpio *) ioremap(MPC52xx_GPIO,
     sizeof(struct mpc52xx_gpio));
   if(gpio)
   {
      port_config = gpio->port_config;
      port_config &= ~GPIO_PSC3_PORT_CONFIG_MASK;
      port_config |= GPIO_PSC3_PORT_CONFIG;
      gpio->port_config = port_config;
      iounmap(gpio);
   }
   else
   {
      return(-1);
   }
 
#ifdef SPI_USE_MCLK
   /* PSC clock enable */
   g_pCDM->clk_enables |= CDM_PSC3_MCLK_ENABLE;
   g_pCDM->mclken_div_psc3 = CDM_PSC3_MCLK_CONFIG;
#endif /* SPI_USE_MCLK */
 
   /* Disable rx and tx */
   g_pPSC->command = MPC52xx_PSC_RST_RX;
   g_pPSC->command = MPC52xx_PSC_RST_TX;
   g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
   g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
   g_pPSC->command = MPC52xx_PSC_RX_DISABLE | MPC52xx_PSC_TX_DISABLE;  
 
   g_pPSC->mode = 0;
   g_pPSC->sicr = PSC3_SICR_REG_VALUE;
 
   #ifdef SPI_USE_MCLK
   g_pPSC->ccr=0x0703;       /* set SCK and DSCKL delay */
   #else  /* SPI_USE_MCLK */
   g_pPSC->ccr=0x0003;       /* set SCK and DSCKL delay must be > 2 */
   #endif /* SPI_USE_MCLK */
 
   g_pPSC->ctur=0x00;        /* Set DTL delay 2us */
   g_pPSC->ctlr=0x84;
 
   g_pPSC->rfalarm=100;      /* Alarm values taken from SPI example sample
*/
   g_pPSC->tfalarm=1;
 
   g_pPSC->rfcntl &= 0xf8;       /* 0 byte granularity */
   g_pPSC->tfcntl = 1;
 
   /* Enable rx & tx */
   g_pPSC->command = MPC52xx_PSC_RST_RX;
   g_pPSC->command = MPC52xx_PSC_RST_TX;
   g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
   g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
   g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;  
 
---------------------------------------------------------------------------
Write code
---------------------------------------------------------------------------
static int mpc52xx_spi_transfer(u16 *p_usBuffer, u16 p_usCount)
{
   u16 usIndex, usTemp;
 
   printk("------------------------------------------------------\n");
   printk("Entry:         psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
     g_pPSC->tfnum, g_pPSC->rfnum);
   g_pPSC->command = MPC52xx_PSC_RST_RX;
   g_pPSC->command = MPC52xx_PSC_RST_TX;
   g_pPSC->command = MPC52xx_PSC_SEL_MODE_REG_1;
   g_pPSC->command = MPC52xx_PSC_RST_ERR_STAT;
   g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
   printk("TX-RX Enable:  psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
     g_pPSC->tfnum, g_pPSC->rfnum);
 
   /* Clean out the read FIFO */
   usIndex = 0;
   while(g_pPSC->mpc52xx_psc_status & MPC52xx_PSC_SR_RXRDY)
   {
      usTemp = g_pPSC->mpc52xx_psc_buffer_16;
      printk("Flushing Rx FIFO: psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
        g_pPSC->tfnum, g_pPSC->rfnum);
      udelay(100000);
      udelay(100000);
      udelay(100000);
      udelay(100000);
      udelay(100000);
      usIndex++;
      if(usIndex == 10) return(-1);
   }
 
   /* Send out the buffer */
   g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_DISABLE;
   for(usIndex=0; usIndex<p_usCount; usIndex++)
   {
      printk("Sending %04x:  psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
        p_usBuffer[usIndex],
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
        g_pPSC->tfnum, g_pPSC->rfnum);
      g_pPSC->mpc52xx_psc_buffer_16 = p_usBuffer[usIndex];
      printk("Sent:          psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
        g_pPSC->tfnum, g_pPSC->rfnum);
   }
   g_pPSC->command = MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;
   usTemp = 0;
   while(g_pPSC->tfnum)
   {
      printk("TFNUM Wait:   psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
        g_pPSC->tfnum, g_pPSC->rfnum);
      udelay(100000);
      udelay(100000);
      udelay(100000);
      udelay(100000);
      udelay(100000);
      usTemp++;
      if(usTemp == 10) return(-1);
   };
   printk("TxRDY:         psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
     g_pPSC->tfnum, g_pPSC->rfnum);
   for(usIndex=0; usIndex<p_usCount; usIndex++)
   {
      usTemp = 0;
      while(!(g_pPSC->mpc52xx_psc_status & MPC52xx_PSC_SR_RXRDY))
      {
         printk("RxRDY Wait:    psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
           g_pPSC->tfnum, g_pPSC->rfnum);
         udelay(100000);
         udelay(100000);
         udelay(100000);
         udelay(100000);
         udelay(100000);
         usTemp++;
         if(usTemp == 10) return(-1);
      };
      printk("RxRDY:         psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
        g_pPSC->tfnum, g_pPSC->rfnum);
      p_usBuffer[usIndex] = g_pPSC->mpc52xx_psc_buffer_16;
      printk("  Received %04x\n", p_usBuffer[usIndex]);
   }
 
   printk("EXIT:          psc=%x status=%04x tfstat=%04x rfstat=%04x
mode=%02x\n   tfnum %3d  rfnum %3d\n",
 
(int)g_pPSC,g_pPSC->mpc52xx_psc_status,g_pPSC->tfstat,g_pPSC->tfstat,g_pPSC-
>mode,
     g_pPSC->tfnum, g_pPSC->rfnum);
   return(usIndex);
}
 

---------------------------------------------------------------------------
Output
---------------------------------------------------------------------------
The lines below are a capture of register settings from my driver,
along with output lines when trying to write 16 bit words to our
device.  This output is consistent whether the device is connected
or not (via J21).  Basic operation, delimited by "------...---":
 
  - Disable TX, Enable RX (despite the "TX-RX Enable" heading)
  - Send word 1
  - Send word 2
  - Enable TX, Enable RX
  - Wait for tfnum == 0
  - Receive data
 
port_config=91051624 sicr=0280f000 clk_enables=00ffffff div_psc3=800f
------------------------------------------------------
Entry:         psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
   tfnum   0  rfnum   0
TX-RX Enable:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
   tfnum   0  rfnum   0
Sending 0880:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   0
Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   2  rfnum   0
Sending bb00:  psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   2  rfnum   0
Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   4  rfnum   0
TFNUM Wait:   psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   2  rfnum   0
TxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   4
RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   4
  Received ffff
RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   2
  Received ffff
EXIT:          psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   0
------------------------------------------------------
Entry:         psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   0
TX-RX Enable:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=33
   tfnum   0  rfnum   0
Sending 8820:  psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   0
Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   2  rfnum   0
Sending 0000:  psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   2  rfnum   0
Sent:          psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   4  rfnum   0
TFNUM Wait:   psc=f0002400 status=0000 tfstat=0002 rfstat=0002 mode=07
   tfnum   2  rfnum   0
TxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   4
RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   4
  Received ffff
RxRDY:         psc=f0002400 status=0500 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   2
  Received ffff
EXIT:          psc=f0002400 status=0400 tfstat=0003 rfstat=0003 mode=07
   tfnum   0  rfnum   0

------=_NextPart_000_00EE_01C68A46.09E05B40
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>We have an AIC26&nbsp;<SPAN=20
class=3D780381522-07062006>codec </SPAN>connected to our Lite5200B =
platform via=20
J21.&nbsp; I've used MPC5200BUG to configure PSC3 as an SPI master, =
along with=20
some samples I've found online&nbsp;<SPAN =
class=3D780381522-07062006>(including=20
here) </SPAN>and&nbsp;<SPAN class=3D780381522-07062006>some I =
</SPAN>received from=20
Freescale.&nbsp; Although the transfers seem to be working as expected =
(please=20
see the&nbsp;<SPAN class=3D780381522-07062006>output file at the end of =
this=20
message</SPAN>), I get only 0xffff back.&nbsp; This occurs whether or =
not the=20
device is attached to J21.&nbsp; A scope shows that PSC3_8 (SPI_SS) and =
PSC3_9=20
(SPI_CLK) are low at all times, and I'm concerned I'm still doing =
something=20
wrong with respect to enabling SPI over PSC3.&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm&nbsp;<SPAN =
class=3D780381522-07062006>including=20
</SPAN>my driver initialization code, my write code, and output showing =
the=20
write behavior.&nbsp; If someone could comment on it, I would greatly =
appreciate=20
it.<SPAN class=3D780381522-07062006>.. or&nbsp;if someone flat out has =
code to do=20
this, I'd be happy to take it from you.&nbsp; I've seen a few =
variations, but=20
whether I use them directly or modify them as I&nbsp;need to, I can't =
seem to=20
get past this.&nbsp; Of course, any other suggestions are=20
welcome.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks.<BR>Sal</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>----------------------------------------------------------------=
-----------<BR>Initialization=20
Code<BR>-----------------------------------------------------------------=
----------<BR>#define=20
GPIO_PSC3_PORT_CONFIG_MASK 0x00000f00<BR>#ifdef =
SPI_USE_MCLK<BR>&nbsp;&nbsp;=20
#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GPIO_PSC3_PORT_CONFIG =
0x00000700&nbsp; /*=20
PSC3 mode with mclk */<BR>#else&nbsp; /* SPI_USE_MCLK */<BR>&nbsp;&nbsp; =

#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GPIO_PSC3_PORT_CONFIG =
0x00000600&nbsp; /*=20
PSC3 mode */<BR>#endif /* SPI_USE_MCLK */</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
CDM_PSC3_MCLK_ENABLE =
0x00000080<BR>#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
CDM_PSC3_MCLK_CONFIG 0x8020&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Divide Fvco =
ftom=20
528 to=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
16Mhz */</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
PSC3_SICR_REG_VALUE 0x0280f000&nbsp; /* 16-bit select Codec SPI=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
master mode, msb first,=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
UseEOF=3D1. GenClk=3D1, SIM,=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
CPOL and CPHA are=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
function input */&nbsp;=20
<BR>...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp; /* Select the Pin-Muxing for PSC3 Codec mode =
*/<BR>&nbsp;&nbsp;=20
gpio =3D (struct mpc52xx_gpio *) =
ioremap(MPC52xx_GPIO,<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
sizeof(struct mpc52xx_gpio));<BR>&nbsp;&nbsp; if(gpio)<BR>&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config =3D=20
gpio-&gt;port_config;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config =
&amp;=3D=20
~GPIO_PSC3_PORT_CONFIG_MASK;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
port_config |=3D=20
GPIO_PSC3_PORT_CONFIG;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
gpio-&gt;port_config =3D=20
port_config;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(gpio);<BR>&nbsp;&nbsp;=20
}<BR>&nbsp;&nbsp; else<BR>&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
return(-1);<BR>&nbsp;&nbsp; }</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>#ifdef SPI_USE_MCLK<BR>&nbsp;&nbsp; /* =
PSC clock=20
enable */<BR>&nbsp;&nbsp; g_pCDM-&gt;clk_enables |=3D=20
CDM_PSC3_MCLK_ENABLE;<BR>&nbsp;&nbsp; g_pCDM-&gt;mclken_div_psc3 =3D=20
CDM_PSC3_MCLK_CONFIG;<BR>#endif /* SPI_USE_MCLK */</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; /* Disable rx and tx=20
*/<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D =
MPC52xx_PSC_RST_RX;<BR>&nbsp;&nbsp;=20
g_pPSC-&gt;command =3D MPC52xx_PSC_RST_TX;<BR>&nbsp;&nbsp; =
g_pPSC-&gt;command =3D=20
MPC52xx_PSC_SEL_MODE_REG_1;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RST_ERR_STAT;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RX_DISABLE | MPC52xx_PSC_TX_DISABLE;&nbsp; </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; g_pPSC-&gt;mode =3D =
0;<BR>&nbsp;&nbsp;=20
g_pPSC-&gt;sicr =3D PSC3_SICR_REG_VALUE;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; #ifdef =
SPI_USE_MCLK<BR>&nbsp;&nbsp;=20
g_pPSC-&gt;ccr=3D0x0703;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set SCK =
and DSCKL=20
delay */<BR>&nbsp;&nbsp; #else&nbsp; /* SPI_USE_MCLK */<BR>&nbsp;&nbsp;=20
g_pPSC-&gt;ccr=3D0x0003;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set SCK =
and DSCKL=20
delay must be &gt; 2 */<BR>&nbsp;&nbsp; #endif /* SPI_USE_MCLK =
*/</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;=20
g_pPSC-&gt;ctur=3D0x00;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set =
DTL delay=20
2us */<BR>&nbsp;&nbsp; g_pPSC-&gt;ctlr=3D0x84;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;=20
g_pPSC-&gt;rfalarm=3D100;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Alarm values =
taken from=20
SPI example sample */<BR>&nbsp;&nbsp; =
g_pPSC-&gt;tfalarm=3D1;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; g_pPSC-&gt;rfcntl &amp;=3D =

0xf8;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 0 byte granularity=20
*/<BR>&nbsp;&nbsp; g_pPSC-&gt;tfcntl =3D 1;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; /* Enable rx &amp; tx=20
*/<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D =
MPC52xx_PSC_RST_RX;<BR>&nbsp;&nbsp;=20
g_pPSC-&gt;command =3D MPC52xx_PSC_RST_TX;<BR>&nbsp;&nbsp; =
g_pPSC-&gt;command =3D=20
MPC52xx_PSC_SEL_MODE_REG_1;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RST_ERR_STAT;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>----------------------------------------------------------------=
-----------<BR>Write=20
code<BR>-----------------------------------------------------------------=
----------<BR>static=20
int mpc52xx_spi_transfer(u16 *p_usBuffer, u16 =
p_usCount)<BR>{<BR>&nbsp;&nbsp;=20
u16 usIndex, usTemp;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;=20
printk("------------------------------------------------------\n");<BR>&n=
bsp;&nbsp;=20
printk("Entry:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psc=3D%x=20
status=3D%04x tfstat=3D%04x rfstat=3D%04x mode=3D%02x\n&nbsp;&nbsp; =
tfnum %3d&nbsp;=20
rfnum %3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp; g_pPSC-&gt;command =
=3D=20
MPC52xx_PSC_RST_RX;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RST_TX;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_SEL_MODE_REG_1;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RST_ERR_STAT;<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D=20
MPC52xx_PSC_RX_ENABLE | MPC52xx_PSC_TX_ENABLE;<BR>&nbsp;&nbsp; =
printk("TX-RX=20
Enable:&nbsp; psc=3D%x status=3D%04x tfstat=3D%04x rfstat=3D%04x =
mode=3D%02x\n&nbsp;&nbsp;=20
tfnum %3d&nbsp; rfnum %3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; /* Clean out the read FIFO =

*/<BR>&nbsp;&nbsp; usIndex =3D 0;<BR>&nbsp;&nbsp;=20
while(g_pPSC-&gt;mpc52xx_psc_status &amp; =
MPC52xx_PSC_SR_RXRDY)<BR>&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usTemp =3D=20
g_pPSC-&gt;mpc52xx_psc_buffer_16;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("Flushing Rx FIFO: psc=3D%x status=3D%04x tfstat=3D%04x =
rfstat=3D%04x=20
mode=3D%02x\n&nbsp;&nbsp; tfnum %3d&nbsp; rfnum=20
%3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
usIndex++;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(usIndex =3D=3D 10)=20
return(-1);<BR>&nbsp;&nbsp; }</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; /* Send out the buffer=20
*/<BR>&nbsp;&nbsp; g_pPSC-&gt;command =3D MPC52xx_PSC_RX_ENABLE |=20
MPC52xx_PSC_TX_DISABLE;<BR>&nbsp;&nbsp; for(usIndex=3D0; =
usIndex&lt;p_usCount;=20
usIndex++)<BR>&nbsp;&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printk("Sending=20
%04x:&nbsp; psc=3D%x status=3D%04x tfstat=3D%04x rfstat=3D%04x =
mode=3D%02x\n&nbsp;&nbsp;=20
tfnum %3d&nbsp; rfnum =
%3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
p_usBuffer[usIndex],=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;mpc52xx_psc_buffer_16 =3D=20
p_usBuffer[usIndex];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("Sent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3D%x=20
status=3D%04x tfstat=3D%04x rfstat=3D%04x mode=3D%02x\n&nbsp;&nbsp; =
tfnum %3d&nbsp;=20
rfnum %3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp; }<BR>&nbsp;&nbsp;=20
g_pPSC-&gt;command =3D MPC52xx_PSC_RX_ENABLE |=20
MPC52xx_PSC_TX_ENABLE;<BR>&nbsp;&nbsp; usTemp =3D 0;<BR>&nbsp;&nbsp;=20
while(g_pPSC-&gt;tfnum)<BR>&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("TFNUM Wait:&nbsp;&nbsp; psc=3D%x status=3D%04x tfstat=3D%04x =
rfstat=3D%04x=20
mode=3D%02x\n&nbsp;&nbsp; tfnum %3d&nbsp; rfnum=20
%3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
usTemp++;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(usTemp =3D=3D 10)=20
return(-1);<BR>&nbsp;&nbsp; };<BR>&nbsp;&nbsp;=20
printk("TxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psc=3D%x=20
status=3D%04x tfstat=3D%04x rfstat=3D%04x mode=3D%02x\n&nbsp;&nbsp; =
tfnum %3d&nbsp;=20
rfnum %3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp; for(usIndex=3D0;=20
usIndex&lt;p_usCount; usIndex++)<BR>&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usTemp =3D=20
0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
while(!(g_pPSC-&gt;mpc52xx_psc_status &amp;=20
MPC52xx_PSC_SR_RXRDY))<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("RxRDY=20
Wait:&nbsp;&nbsp;&nbsp; psc=3D%x status=3D%04x tfstat=3D%04x =
rfstat=3D%04x=20
mode=3D%02x\n&nbsp;&nbsp; tfnum %3d&nbsp; rfnum=20
%3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum,=20
g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
udelay(100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
usTemp++;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(usTemp =
=3D=3D 10)=20
return(-1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("RxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psc=3D%x=20
status=3D%04x tfstat=3D%04x rfstat=3D%04x mode=3D%02x\n&nbsp;&nbsp; =
tfnum %3d&nbsp;=20
rfnum %3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
p_usBuffer[usIndex] =3D=20
g_pPSC-&gt;mpc52xx_psc_buffer_16;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
printk("&nbsp; Received %04x\n", p_usBuffer[usIndex]);<BR>&nbsp;&nbsp;=20
}</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;=20
printk("EXIT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3D%x=20
status=3D%04x tfstat=3D%04x rfstat=3D%04x mode=3D%02x\n&nbsp;&nbsp; =
tfnum %3d&nbsp;=20
rfnum %3d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
(int)g_pPSC,g_pPSC-&gt;mpc52xx_psc_status,g_pPSC-&gt;tfstat,g_pPSC-&gt;tf=
stat,g_pPSC-&gt;mode,<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
g_pPSC-&gt;tfnum, g_pPSC-&gt;rfnum);<BR>&nbsp;&nbsp;=20
return(usIndex);<BR>}</FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
<DIV><BR>----------------------------------------------------------------=
-----------<BR>Output<BR>------------------------------------------------=
---------------------------<BR>The=20
lines below are a capture of register settings from my driver,<BR>along =
with=20
output lines when trying to write 16 bit words to our<BR>device.&nbsp; =
This=20
output is consistent whether the device is connected<BR>or not (via =
J21).&nbsp;=20
Basic operation, delimited by "------...---":</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; - Disable TX, Enable RX (despite the "TX-RX Enable"=20
heading)<BR>&nbsp; - Send word 1<BR>&nbsp; - Send word 2<BR>&nbsp; - =
Enable TX,=20
Enable RX<BR>&nbsp; - Wait for tfnum =3D=3D 0<BR>&nbsp; - Receive=20
data<BR>&nbsp;<BR>port_config=3D91051624 sicr=3D0280f000 =
clk_enables=3D00ffffff=20
div_psc3=3D800f<BR>------------------------------------------------------=
<BR>Entry:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
psc=3Df0002400 status=3D0400 tfstat=3D0003 rfstat=3D0003 =
mode=3D33<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp; 0<BR>TX-RX Enable:&nbsp;=20
psc=3Df0002400 status=3D0400 tfstat=3D0003 rfstat=3D0003 =
mode=3D33<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp; 0<BR>Sending 0880:&nbsp;=20
psc=3Df0002400 status=3D0400 tfstat=3D0003 rfstat=3D0003 =
mode=3D07<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp;=20
0<BR>Sent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0000 tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
2&nbsp; rfnum&nbsp;&nbsp; 0<BR>Sending bb00:&nbsp; psc=3Df0002400 =
status=3D0000=20
tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; tfnum&nbsp;&nbsp; =
2&nbsp;=20
rfnum&nbsp;&nbsp;=20
0<BR>Sent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0000 tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
4&nbsp; rfnum&nbsp;&nbsp; 0<BR>TFNUM Wait:&nbsp;&nbsp; psc=3Df0002400 =
status=3D0000=20
tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; tfnum&nbsp;&nbsp; =
2&nbsp;=20
rfnum&nbsp;&nbsp; =
0<BR>TxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
psc=3Df0002400 status=3D0500 tfstat=3D0003 rfstat=3D0003 =
mode=3D07<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp;=20
4<BR>RxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0500 tfstat=3D0003 rfstat=3D0003 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
0&nbsp; rfnum&nbsp;&nbsp; 4<BR>&nbsp; Received=20
ffff<BR>RxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0500 tfstat=3D0003 rfstat=3D0003 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
0&nbsp; rfnum&nbsp;&nbsp; 2<BR>&nbsp; Received=20
ffff<BR>EXIT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0400 tfstat=3D0003 rfstat=3D0003 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
0&nbsp; rfnum&nbsp;&nbsp;=20
0<BR>------------------------------------------------------<BR>Entry:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
psc=3Df0002400 status=3D0400 tfstat=3D0003 rfstat=3D0003 =
mode=3D07<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp; 0<BR>TX-RX Enable:&nbsp;=20
psc=3Df0002400 status=3D0400 tfstat=3D0003 rfstat=3D0003 =
mode=3D33<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp; 0<BR>Sending 8820:&nbsp;=20
psc=3Df0002400 status=3D0400 tfstat=3D0003 rfstat=3D0003 =
mode=3D07<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp;=20
0<BR>Sent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0000 tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
2&nbsp; rfnum&nbsp;&nbsp; 0<BR>Sending 0000:&nbsp; psc=3Df0002400 =
status=3D0000=20
tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; tfnum&nbsp;&nbsp; =
2&nbsp;=20
rfnum&nbsp;&nbsp;=20
0<BR>Sent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0000 tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
4&nbsp; rfnum&nbsp;&nbsp; 0<BR>TFNUM Wait:&nbsp;&nbsp; psc=3Df0002400 =
status=3D0000=20
tfstat=3D0002 rfstat=3D0002 mode=3D07<BR>&nbsp;&nbsp; tfnum&nbsp;&nbsp; =
2&nbsp;=20
rfnum&nbsp;&nbsp; =
0<BR>TxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
psc=3Df0002400 status=3D0500 tfstat=3D0003 rfstat=3D0003 =
mode=3D07<BR>&nbsp;&nbsp;=20
tfnum&nbsp;&nbsp; 0&nbsp; rfnum&nbsp;&nbsp;=20
4<BR>RxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0500 tfstat=3D0003 rfstat=3D0003 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
0&nbsp; rfnum&nbsp;&nbsp; 4<BR>&nbsp; Received=20
ffff<BR>RxRDY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0500 tfstat=3D0003 rfstat=3D0003 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
0&nbsp; rfnum&nbsp;&nbsp; 2<BR>&nbsp; Received=20
ffff<BR>EXIT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psc=3Df0002400=20
status=3D0400 tfstat=3D0003 rfstat=3D0003 mode=3D07<BR>&nbsp;&nbsp; =
tfnum&nbsp;&nbsp;=20
0&nbsp; rfnum&nbsp;&nbsp; 0</FONT></DIV></BODY></HTML>

------=_NextPart_000_00EE_01C68A46.09E05B40--
