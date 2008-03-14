Return-Path: <s104259@yahoo.it>
Date: Fri, 14 Mar 2008 14:21:18 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: RE: I2S driver
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
In-Reply-To: <BLU106-W3340DC3BF1A9FD27E9FCD3CA100@phx.gbl>
MIME-Version: 1.0
Content-Type: text/html; charset=utf-8
Message-ID: <342534.14911.qm@web23107.mail.ird.yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
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
ont: inherit;'>Hi Pedro, i'm Angelo.<br><br>You just send me this mail:<br>=
start mail<br><br>As I told you, here is the configuration routine for the =
I2S module. <br>Please, notice that this module whas built to work on the o=
ld 2.6.16 <br>kernel and old dma driver:<br><br>static int I2S_setup(void) =
{<br>&nbsp;&nbsp;&nbsp; int i;<br>// &nbsp;&nbsp;&nbsp; u32 val32;<br>&nbsp=
;&nbsp;&nbsp; // CDM<br>&nbsp;&nbsp;&nbsp; struct mpc52xx_cdm __iomem *cdm;=
<br>// <br>// &nbsp;&nbsp;&nbsp; /* GPIO Modification */<br>&nbsp;&nbsp;&nb=
sp; struct mpc52xx_gpio __iomem *gpio;<br><br>// &nbsp;&nbsp;&nbsp; /* END =
GPIO Modification */<br>// <br>&nbsp;&nbsp;&nbsp; cdm =3D ioremap(MPC52xx_P=
A(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);<br>&nbsp;&nbsp;&nbsp; gpio =3D io=
remap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);<br>// <br>&nbsp;=
&nbsp;&nbsp; switch(psc_num) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cas=
e
 1:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; initiator_t=
x =3D SDMA_INITIATOR_PSC1_TX;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; initiator_rx =3D SDMA_INITIATOR_PSC1_RX;<br>&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; case 2:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; initiator_tx =3D SDMA_INITIATOR_PSC2_TX;<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; initiator_rx =3D SDMA_INITIATOR_PSC2_RX;<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; default:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; panic("snd-I2Smgt.o: invalid value for psc_num<br=
>(%i)\n",psc_num);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; break;<br>&nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; /* 528MHz/(0x=
1f+1)=3D16.5 MHz */<br>&nbsp;&nbsp;&nbsp; cdm-&gt;mclken_div_psc2 =3D 0x800=
1; //
 Mhz MCLK ( Khz * )<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D (MPC52xx_PSC_=
TX_DISABLE | MPC52xx_PSC_RX_DISABLE);<br>&nbsp;&nbsp;&nbsp; /* PSC2 CODEC w=
ith Master Clock */<br>&nbsp;&nbsp;&nbsp; gpio-&gt;port_config |=3D 0x70;<b=
r>&nbsp;&nbsp;&nbsp; /* PSC2 clock enable */<br>&nbsp;&nbsp;&nbsp; cdm-&gt;=
clk_enables |=3D 0x40;<br><br>&nbsp;&nbsp;&nbsp; // PSC reset<br>&nbsp;&nbs=
p;&nbsp; psc-&gt;command =3D MPC52xx_PSC_RST_RX;<br>&nbsp;&nbsp;&nbsp; psc-=
&gt;command =3D MPC52xx_PSC_RST_TX;<br>&nbsp;&nbsp;&nbsp;&nbsp; psc-&gt;com=
mand =3D MPC52xx_PSC_SEL_MODE_REG_1;<br>&nbsp;&nbsp;&nbsp;&nbsp; psc-&gt;co=
mmand =3D MPC52xx_PSC_RST_ERR_STAT;<br><br><br>&nbsp;&nbsp;&nbsp; // PSC se=
tup I2S<br>&nbsp;&nbsp;&nbsp; psc-&gt;mode =3D 0;<br>&nbsp;&nbsp;&nbsp; psc=
-&gt;rfalarm =3D RX_ALARM;<br>&nbsp;&nbsp;&nbsp;&nbsp; psc-&gt;tfalarm =3D =
TX_ALARM;<br>&nbsp;&nbsp;&nbsp; psc-&gt;rfcntl =3D RX_GRAN;<br>&nbsp;&nbsp;=
&nbsp;&nbsp; psc-&gt;tfcntl =3D TX_GRAN;<br>&nbsp;&nbsp;&nbsp; psc-&gt;mpc5=
2xx_psc_imr =3D
 0x0000;<br><br>&nbsp;&nbsp;&nbsp; psc-&gt;sicr =3D 0x0FE00000;<br>&nbsp;&n=
bsp;&nbsp; psc-&gt;ctur =3D 0x1f; //Frame length 0x17<br><br>&nbsp;&nbsp;&n=
bsp; psc-&gt;ccr =3D 0x3f5D; //LRCK&nbsp; KHz, BitCLK&nbsp; MHz&nbsp; 0x3f0=
5!<br><br>// &nbsp;&nbsp;&nbsp; psc-&gt;sicr |=3D /* DELAY_TIME_SLOT |*/ MU=
LTIWD_ENABLE | CLK_POL_RISING;<br>// &nbsp;&nbsp;&nbsp; <br>// &nbsp;&nbsp;=
&nbsp; psc-&gt;sicr |=3D GEN_CLK_INT;<br><br>&nbsp;&nbsp;&nbsp; psc-&gt;com=
mand =3D MPC52xx_PSC_RST_RX;<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC5=
2xx_PSC_RST_TX;<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_SEL_M=
ODE_REG_1;<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_RST_ERR_ST=
AT;<br>// <br>// &nbsp;&nbsp;&nbsp; // setup the sdma tasks<br>&nbsp;&nbsp;=
&nbsp; tx_sdma =3D sdma_alloc(PERIODS_HW+1);<br>&nbsp;&nbsp;&nbsp; rx_sdma =
=3D sdma_alloc(PERIODS_HW+1);<br><br>&nbsp;&nbsp;&nbsp; if (!tx_sdma || !rx=
_sdma) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk("sdma_alloc
 failed\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ENOMEM;<br>&n=
bsp;&nbsp;&nbsp; }<br>// <br>// &nbsp;&nbsp;&nbsp; sdma_gen_bd_rx_init(rx_s=
dma, (phys_addr_t)&amp;(psc-&gt;rfdata),<br>PERIODSIZE_HW, initiator_rx, 6)=
;<br>&nbsp;&nbsp;&nbsp; sdma_gen_bd_rx_init(0, rx_sdma, (phys_addr_t)&amp;(=
psc-&gt;rfdata),<br>initiator_rx, 6, PERIODSIZE_HW);<br>// &nbsp;&nbsp;&nbs=
p; sdma_gen_bd_tx_init(tx_sdma, (phys_addr_t)&amp;(psc-&gt;tfdata),<br>PERI=
ODSIZE_HW, initiator_tx, 6);<br>&nbsp;&nbsp;&nbsp; sdma_gen_bd_tx_init(0, t=
x_sdma, (phys_addr_t)&amp;(psc-&gt;tfdata),<br>initiator_tx, 6);<br><br>&nb=
sp;&nbsp;&nbsp; printk("txtask is %d rxtask is %d\n", tx_sdma-&gt;tasknum,<=
br>rx_sdma-&gt;tasknum);<br>// <br>&nbsp;&nbsp;&nbsp; // prepare the ring b=
uffers<br>&nbsp;&nbsp;&nbsp; for(i=3D0;itasknum %d\n", sdma_irq(rx_sdma), M=
PC52xx_SDMA_IRQ_BASE +<br>rx_sdma-&gt;tasknum);<br>&nbsp;&nbsp;&nbsp; if (r=
equest_irq(sdma_irq(rx_sdma), I2S_rx_irq, 0, "SPI rx dma",<br>NULL))
 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR "SPI: SDMA rx i=
rq allocation failed\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -=
EINVAL;<br>&nbsp;&nbsp;&nbsp; } else printk("SPI: SDA rx irq allocation suc=
ceded\n");<br>&nbsp;&nbsp;&nbsp; if (request_irq(sdma_irq(tx_sdma), I2S_tx_=
irq, 0, "SPI tx dma",<br>NULL)) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
printk(KERN_ERR "SPI: SDMA tx irq allocation failed\n");<br>&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; return -EINVAL;<br>&nbsp;&nbsp;&nbsp; } else printk(=
"SPI: SDA tx irq allocation succeded\n");<br>&nbsp;&nbsp;&nbsp; <br>// <br>=
// &nbsp;&nbsp;&nbsp; // clear any pending interrupts<br>&nbsp;&nbsp;&nbsp;=
 sdma_clear_irq(tx_sdma);<br>&nbsp;&nbsp;&nbsp; sdma_clear_irq(rx_sdma);<br=
>// <br>&nbsp;&nbsp;&nbsp; printk("Before activating the tasks\n");<br>// &=
nbsp;&nbsp;&nbsp; // activate the tasks<br>// &nbsp;&nbsp;&nbsp; sdma_enabl=
e(tx_sdma);<br>// &nbsp;&nbsp;&nbsp; sdma_enable(rx_sdma);<br>//
 <br>// &nbsp;&nbsp;&nbsp; printk("about to enable SPI psc\n");<br>&nbsp;&n=
bsp;&nbsp; udelay(100);<br>// <br>// &nbsp;&nbsp;&nbsp; // enable transmitt=
er and receiver<br>&nbsp;&nbsp;&nbsp; psc-&gt;command =3D MPC52xx_PSC_TX_EN=
ABLE | MPC52xx_PSC_RX_ENABLE;<br>// //&nbsp;&nbsp;&nbsp; psc-&gt;command =
=3D MPC52xx_PSC_TX_ENABLE;<br>// <br>// <br>// // &nbsp;&nbsp;&nbsp; I2S_pr=
int(__FUNCTION__);<br>// <br>// // &nbsp;&nbsp;&nbsp; pcm1680_read();<br>//=
 //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcm1680_configure(44100=
);<br>// // &nbsp;&nbsp;&nbsp; pcm1680_read();<br><br>&nbsp;&nbsp;&nbsp; re=
turn 0;<br>};<br>end mail<br><br>I solved my proplems of porting from 2.6.1=
7 to 2.16.22 kernel <br>version, but in the module static int I2S_setup(voi=
d) i found <br>the sequent problems.<br><br>In this piece of code:<br><br>s=
witch(psc_num) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 1:<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; initiator_tx =3D
 SDMA_INITIATOR_PSC1_TX;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; initiator_rx =3D SDMA_INITIATOR_PSC1_RX;<br>&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; case 2:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; initiator_tx =3D SDMA_INITIATOR_PSC2_TX;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; initiator_rx =3D SDMA_INITIATOR_PSC2_RX;<br>&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; default:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; panic("snd-I2Smgt.o: invalid value for psc_num<br>(%i)=
\n",psc_num);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; b=
reak;<br>&nbsp;&nbsp;&nbsp; };<br><br>This define are undeclared:<br>SDMA_I=
NITIATOR_PSC1_TX<br>SDMA_INITIATOR_PSC1_RX<br>SDMA_INITIATOR_PSC2_TX<br>SDM=
A_INITIATOR_PSC2_RX<br><br>so perhaps i don't have some header
 files.<br><br>Also this variable are undefined:<br>psc_num, tx_sdma, rx_sd=
ma.<br><br>And where i can found this function:<br>- sdma_gen_bd_rx_init<br=
>- sdma_gen_bd_tx_init<br><br>However there are some other errors like:<br>=
// <br>// prepare the ring buffers<br>&nbsp;&nbsp;&nbsp; for(i=3D0;itasknum=
 %d\n", sdma_irq(rx_sdma), MPC52xx_SDMA_IRQ_BASE +<br>&nbsp;rx_sdma-&gt;tas=
knum);<br>&nbsp;&nbsp;&nbsp; if (request_irq(sdma_irq(rx_sdma), I2S_rx_irq,=
 0, "SPI rx dma", NULL))<br>&nbsp;{<br>.....<br>I think there are some mist=
akes in your copy and paste operation, so <br>i don't know how solve it.<br=
><br>Thanks for help.<br></td></tr></table><br>=0A=0A=0A=0A=0A      <hr siz=
e=3D1>=0AInviato da <a  =0Ahref=3D"http://us.rd.yahoo.com/mailuk/taglines/i=
sp/control/*http://us.rd.yahoo.com/evt=3D52437/*http://it.docs.yahoo.com/ma=
il/overview/index.html" target=3D_blank>Yahoo! Mail</a>.=0A<br>=0AIl serviz=
io di posta con lo spazio illimitato.
