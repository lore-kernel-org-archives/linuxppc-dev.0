Return-Path: <s104259@yahoo.it>
Date: Fri, 14 Mar 2008 16:57:35 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: I2s driver - sorry for the last unreadable mail
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/html; charset=utf-8
Message-ID: <348545.16764.qm@web23115.mail.ird.yahoo.com>
Reply-To: s104259@yahoo.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<table cellspacing=3D'0' cellpadding=3D'0' border=3D'0' ><tr><td style=3D'f=
ont: inherit;'>Pedro just send me this routine:<br>static int I2S_setup(){<=
br>int i;<br>// &nbsp;&nbsp;&nbsp; u32 val32;<br>// CDM<br>&nbsp;&nbsp;&nbs=
p; struct mpc52xx_cdm __iomem *cdm;<br>// <br>// &nbsp;&nbsp;&nbsp; /* GPIO=
 Modification */<br>&nbsp;&nbsp;&nbsp; struct mpc52xx_gpio __iomem *gpio;<b=
r><br>// &nbsp;&nbsp;&nbsp; /* END GPIO Modification */<br>// <br>&nbsp;&nb=
sp;&nbsp; cdm =3D ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE)=
;<br>&nbsp;&nbsp;&nbsp; gpio =3D ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), M=
PC52xx_GPIO_SIZE);<br>// <br>&nbsp;&nbsp;&nbsp; switch(psc_num) {<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 1:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; initiator_tx =3D SDMA_INITIATOR_PSC1_TX;<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; initiator_rx =3D SDMA_IN=
ITIATOR_PSC1_RX;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;
 break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 2:<br>&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; initiator_tx =3D SDMA_INITIATOR_P=
SC2_TX;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; initiat=
or_rx =3D SDMA_INITIATOR_PSC2_RX;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; default:=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; panic("snd-I2S=
mgt.o: invalid value for psc_num (%i)\n",psc_num);<br>&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; };<br><br>=
&nbsp;&nbsp;&nbsp; /* 528MHz/(0x1f+1)=3D16.5 MHz */<br>&nbsp;&nbsp;&nbsp; c=
dm-&gt;mclken_div_psc2 =3D 0x8001; // Mhz MCLK ( Khz * )<br>&nbsp;&nbsp;&nb=
sp; psc-&gt;command =3D (MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);<=
br>&nbsp;&nbsp;&nbsp; /* PSC2 CODEC with Master Clock */<br>&nbsp;&nbsp;&nb=
sp; gpio-&gt;port_config |=3D 0x70;<br>&nbsp;&nbsp;&nbsp; /* PSC2 clock ena=
ble
 */<br>&nbsp;&nbsp;&nbsp; cdm-&gt;clk_enables |=3D 0x40;<br><br>&nbsp;&nbsp=
;&nbsp; // PSC reset<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_=
RST_RX;<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_RST_TX;<br>&n=
bsp;&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_SEL_MODE_REG_1;<br>&=
nbsp;&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_RST_ERR_STAT;<br><b=
r><br>&nbsp;&nbsp;&nbsp; // PSC setup I2S<br>&nbsp;&nbsp;&nbsp; psc-&gt;mod=
e =3D 0;<br>&nbsp;&nbsp;&nbsp; psc-&gt;rfalarm =3D RX_ALARM;<br>&nbsp;&nbsp=
;&nbsp;&nbsp; psc-&gt;tfalarm =3D TX_ALARM;<br>&nbsp;&nbsp;&nbsp; psc-&gt;r=
fcntl =3D RX_GRAN;<br>&nbsp;&nbsp;&nbsp;&nbsp; psc-&gt;tfcntl =3D TX_GRAN;<=
br>&nbsp;&nbsp;&nbsp; psc-&gt;mpc52xx_psc_imr =3D 0x0000;<br><br>&nbsp;&nbs=
p;&nbsp; psc-&gt;sicr =3D 0x0FE00000;<br>&nbsp;&nbsp;&nbsp; psc-&gt;ctur =
=3D 0x1f; //Frame length 0x17<br><br>&nbsp;&nbsp;&nbsp; psc-&gt;ccr =3D 0x3=
f5D; //LRCK&nbsp; KHz, BitCLK&nbsp; MHz&nbsp; 0x3f05!<br><br>// &nbsp;&nbsp=
;&nbsp; psc-&gt;sicr |=3D
 /* DELAY_TIME_SLOT |*/ MULTIWD_ENABLE | CLK_POL_RISING;<br>// &nbsp;&nbsp;=
&nbsp; <br>// &nbsp;&nbsp;&nbsp; psc-&gt;sicr |=3D GEN_CLK_INT;<br><br>&nbs=
p;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_RST_RX;<br>&nbsp;&nbsp;&nbsp=
; psc-&gt;command =3D MPC52xx_PSC_RST_TX;<br>&nbsp;&nbsp;&nbsp; psc-&gt;com=
mand =3D MPC52xx_PSC_SEL_MODE_REG_1;<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =
=3D MPC52xx_PSC_RST_ERR_STAT;<br>// <br>// &nbsp;&nbsp;&nbsp; // setup the =
sdma tasks<br>&nbsp;&nbsp;&nbsp; tx_sdma =3D sdma_alloc(PERIODS_HW+1);<br>&=
nbsp;&nbsp;&nbsp; rx_sdma =3D sdma_alloc(PERIODS_HW+1);<br><br>&nbsp;&nbsp;=
&nbsp; if (!tx_sdma || !rx_sdma) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 printk("sdma_alloc failed\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; re=
turn -ENOMEM;<br>&nbsp;&nbsp;&nbsp; }<br>//&nbsp;&nbsp;&nbsp; asimmini<br>/=
/ &nbsp;&nbsp;&nbsp; sdma_gen_bd_rx_init(rx_sdma, (phys_addr_t)&amp;(psc-&g=
t;rfdata), PERIODSIZE_HW, initiator_rx, 6);<br>&nbsp;&nbsp;&nbsp;
 sdma_gen_bd_rx_init(0, rx_sdma, (phys_addr_t)&amp;(psc-&gt;rfdata), initia=
tor_rx, 6,PERIODSIZE_HW);<br>// &nbsp;&nbsp;&nbsp; sdma_gen_bd_tx_init(tx_s=
dma, (phys_addr_t)&amp;(psc-&gt;tfdata), PERIODSIZE_HW, initiator_tx, 6);<b=
r>&nbsp;&nbsp;&nbsp; sdma_gen_bd_tx_init(0, tx_sdma, (phys_addr_t)&amp;(psc=
-&gt;tfdata), initiator_tx, 6);<br><br>&nbsp;&nbsp;&nbsp; printk("txtask is=
 %d rxtask is %d\n", tx_sdma-&gt;tasknum, rx_sdma-&gt;tasknum);<br>// <br>&=
nbsp;&nbsp;&nbsp; // prepare the ring buffers&nbsp;&nbsp;&nbsp; ASIMMINI<br=
>&nbsp;&nbsp;&nbsp; //for(i=3D0;i<br>&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp=
; tasknum %d\n", sdma_irq(rx_sdma), MPC52xx_SDMA_IRQ_BASE + rx_sdma-&gt;tas=
knum);<br>&nbsp;&nbsp;&nbsp; if (request_irq(sdma_irq(rx_sdma), I2S_rx_irq,=
 0, "SPI rx dma", NULL)){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(K=
ERN_ERR "SPI: SDMA rx irq allocation failed\n");<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>&nbsp;&nbsp;&nbsp; }
 <br>&nbsp;&nbsp;&nbsp; else <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; prin=
tk("SPI: SDA rx irq allocation succeded\n");<br>&nbsp;&nbsp;&nbsp; if (requ=
est_irq(sdma_irq(tx_sdma), I2S_tx_irq, 0, "SPI tx dma", NULL)){<br>&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "SPI: SDMA tx irq allocation =
failed\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -EINVAL;<br>&nb=
sp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else <br>&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; printk("SPI: SDA tx irq allocation succeded\n");<br>&nbsp;&nbsp=
;&nbsp; <br>// <br>// &nbsp;&nbsp;&nbsp; // clear any pending interrupts<br=
>&nbsp;&nbsp;&nbsp; sdma_clear_irq(tx_sdma);<br>&nbsp;&nbsp;&nbsp; sdma_cle=
ar_irq(rx_sdma);<br>// <br>&nbsp;&nbsp;&nbsp; printk("Before activating the=
 tasks\n");<br>// &nbsp;&nbsp;&nbsp; // activate the tasks<br>// &nbsp;&nbs=
p;&nbsp; sdma_enable(tx_sdma);<br>// &nbsp;&nbsp;&nbsp; sdma_enable(rx_sdma=
);<br>// <br>// &nbsp;&nbsp;&nbsp; printk("about to enable SPI
 psc\n");<br>&nbsp;&nbsp;&nbsp; udelay(100);<br>// <br>// &nbsp;&nbsp;&nbsp=
; // enable transmitter and receiver<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =
=3D MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE;<br>// //&nbsp;&nbsp;&nbs=
p; psc-&gt;command =3D MPC52xx_PSC_TX_ENABLE;<br>// <br>// <br>// // &nbsp;=
&nbsp;&nbsp; I2S_print(__FUNCTION__);<br>// <br>// // &nbsp;&nbsp;&nbsp; pc=
m1680_read();<br>// //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcm1=
680_configure(44100);<br>// // &nbsp;&nbsp;&nbsp; pcm1680_read();<br>&nbsp;=
&nbsp;&nbsp; return 0;<br>}<br><br>But i have some problems.<br><br>i don't=
 have any of thiese functions:<br><br>sdma_alloc<br>rx_sdma<br>sdma_gen_bd_=
rx_init<br>sdma_gen_bd_tx_init<br>sdma_irq<br>sdma_clear_irq<br><br>and som=
e define:<br>I2S_rx_irq<br>I2S_tx_irq<br><br><br></td></tr></table><br>=0A=
=0A=0A=0A=0A      <hr size=3D1>=0AInviato da <a  =0Ahref=3D"http://us.rd.ya=
hoo.com/mailuk/taglines/isp/control/*http://us.rd.yahoo.com/evt=3D52437/*ht=
tp://it.docs.yahoo.com/mail/overview/index.html" target=3D_blank>Yahoo! Mai=
l</a>.=0A<br>=0AIl servizio di posta con lo spazio illimitato.
