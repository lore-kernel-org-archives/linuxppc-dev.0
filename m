Return-Path: <akashkaul@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (unknown [61.95.203.221])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5FA867A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 19:17:14 +1100 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j246XjeC016882
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 Mar 2005 12:03:46 +0530
Received: from mail.deccanetworld.com (server.deccanetworld.com [192.168.1.32])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j246Xj1u016877
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 Mar 2005 12:03:45 +0530
From: "akash kaul" <akashkaul@deccanetworld.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 4 Mar 2005 13:38:43 +0530
Message-ID: <001201c52091$61bcb130$1b69cb0a@BGCW0166>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0013_01C520BF.7B74ED30"
In-Reply-To: <010401c5208b$38329830$1769cb0a@srinathtn>
Subject: MCC driver help
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

------=_NextPart_000_0013_01C520BF.7B74ED30
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

 
 
Hi All,
 
    We are developing MCC driver for MPC8280. We are using TDMD2  for 2
channels in HDLC mode. 
 
    Currently we are testing using internal/external loopback setting.
For this we have connected BRG6 Output to CLK19 and TMR3IN (timer3
input). The TMR3O(timer 3 output) is fed to L1RSYNC. We are receiving
GUN interrupt. In the first interrupt we are receiving IDL interrupt
followwd by GUN interrupt and the driver stops.
    We have verified the reasons given for this.But not able to overcome
this problem.
    I have pasted some of the code snippets of my driver which i am
doubtful of.  I hope to get some comments from the group on this.
 
    Please find below  some of the code snippets: 
 
    /*Configuring SIxMR for TDMD2*/
    immap->im_siramctl2.si_dmr = 0xA68;   /*(SI_M_CRT |
SI_M_SDM_INTERNAL_LOOPBACK | SI_M_SAD_0 | SI_M_CE | SI_M_FE | SI_M_SL |
SI_M_RFSD_2BIT_DELAY);*/
    /* SI2 RAM programming*/
    immap->im_si2txram[0] = ( SIRAM_MCC | (SIRAM_CNT_1<<2)
|SIRAM_RESOL_BYTE| (128<<5));
    immap->im_si2txram[1] = ( SIRAM_MCC | (SIRAM_CNT_8<<2) |
SIRAM_RESOL_BYTE | SIRAM_ENTRY_LAST | (129<<5));
 
    immap->im_si2rxram[0] = ( SIRAM_MCC | (SIRAM_CNT_1<<2)
|SIRAM_RESOL_BYTE| (128<<5));
    immap->im_si2rxram[1] = ( SIRAM_MCC |(SIRAM_CNT_8<<2)
|SIRAM_RESOL_BYTE| SIRAM_ENTRY_LAST | (129<<5));
    /*Clock and BRG6 initialization */
    immap->im_cpmtimer.cpmt_tmr3= 0x0e;
/*(CPM_TIMER_ICLK|CPM_TIMER_GE|CPM_TIMER_FRR);*/
    immap->im_cpmtimer.cpmt_trr3=  0x41;   /* 63 bits :: Is this right,
I have set it to 63 because my first channel is 1 bit wide and second
channel is 64 bit wide */
    immap->im_cpmtimer.cpmt_tgcr2 = 0x09 ; 
    immap->im_brgc6 = 0x00010000;  /* Directly feeding BRG6 with BRG_CLK
which is of 33Mhz in my board*/
 
    /*Port pin configuration*/
    immap->im_ioport.iop_psorb  |=
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);     
    immap->im_ioport.iop_pdirb  &=
~(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);   
    immap->im_ioport.iop_pparb  |=
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);    
 
    immap->im_ioport.iop_psora &= ~(TDMD2_CLK19); 
    immap->im_ioport.iop_pdira &= ~(TDMD2_CLK19); 
    immap->im_ioport.iop_ppara |= (TDMD2_CLK19); 
    
    immap->im_ioport.iop_psorc  &= ~(TDMD2_TIN3 | TDMD2_BRGO6
|TDMD2_TOUT3);
    immap->im_ioport.iop_pdirc  |= (TDMD2_BRGO6 | TDMD2_TOUT3); 
    immap->im_ioport.iop_pdirc  &= ~(TDMD2_TIN3); 
    immap->im_ioport.iop_pparc  |= (TDMD2_TIN3 | TDMD2_BRGO6 |
TDMD2_TOUT3); 
  
    immap->im_cpmux.cmx_si2cr |= (TDMD2_CLK19_CS);
 
    /*Initialize RxBDs.*/  called for two channels
  
      for (index = 0; index < MAX_NUM_BD; index++)
       {
          if( index != (MAX_NUM_BD-1) )  /* If not the last RxBD for
this channel */
          {
             rx_tx_bd->rx_bd[index+offset].cbd_sc = 0x9000; /* Empty,
Interrupt */
          }
          else  /* if last RxBD for this channel */
          {
             rx_tx_bd->rx_bd[index+offset].cbd_sc = 0xB000;   /* Empty,
Interrupt,and wrap */
          }
 
          /* set the CM bit in the RxBDS         */
          rx_tx_bd->rx_bd[index+offset].cbd_sc |= 0x0200;   /* set
continuous bit */
 
          /* clear the buffer length */
          rx_tx_bd->rx_bd[index+offset].cbd_datlen = 0;
 
          /* set address to point to proper receive area for   this BD
in the bufferpool scheme this program uses */
          va_ptr = (u32 *)cpm2_hostalloc(MAX_BUF_LEN, 8);
          rx_tx_bd->rx_bd[index+offset].cbd_bufaddr = (uint
)__pa(va_ptr);
 
       } /* end for loop initializing RxBDs */
/* Initialize TxBDs and RX BDs for both the channels*/
 
  for ( offset = 0, counter = 0; counter < NUM_CHANS_PER_TDM;)
    {
       /* Initialize TxBDs. */
       for (index=0; index < MAX_NUM_BD; index++)
       {
          if( index != (MAX_NUM_BD-1) )  /* If not the last TxBD for
this channel */
          {
             /* Set Ready bit */
             rx_tx_bd->tx_bd[index+offset].cbd_sc = 0x8000;
 
             /* If this channel is HDLC, also set Last and TC bits */
             rx_tx_bd->tx_bd[index+offset].cbd_sc |= 0x0C00;
          }
          else  /* if last TxBD for this channel */
          {
             /* Set Ready, Wrap bits */
             rx_tx_bd->tx_bd[index+offset].cbd_sc = 0xA000;
 
             /* If this channel is HDLC, also set Last and TC bits */
             rx_tx_bd->tx_bd[index+offset].cbd_sc |= 0x0C00;
          };
 
          /* set the CM bit in the TxBDS         */
           rx_tx_bd->tx_bd[index+offset].cbd_sc |= 0x0200;   /* set
continuous bit */
 
          /* set address to point to proper receive area for this BD in
the bufferpool scheme this program uses */
           va_ptr = (u32 *)cpm2_hostalloc(MAX_BUF_LEN, 8);
           memset(va_ptr,(u8)'B', MAX_BUF_LEN);
           rx_tx_bd->tx_bd[index+offset].cbd_bufaddr = (uint
)__pa(va_ptr);

          /* load the buffer length */
           rx_tx_bd->tx_bd[index+offset].cbd_datlen = 54;//MAX_BUF_LEN;
       }/* end for loop initializing TxBDs */
 
 offset = (++ counter * MAX_NUM_BD);
} /* End of outer for loop*/
  /* MCC Init*/
 
    #define TDM    3
    immap->im_mcc2.mcc_mccf = TDM | (TDM << 2) | (TDM << 4) | (TDM <<
6); /* Enable TDM2 to use channels 128 to 225 */
 
    /* Clear all the interrupts and enable the required interrupts */
    immap->im_mcc2.mcc_mcce = (MCC_EM_GOV  | MCC_EM_GUN | MCC_EM_TINT |
MCC_EM_TQOV |
                               MCC_EM_RINT3 | MCC_EM_QOV3 | MCC_EM_RINT2
| MCC_EM_QOV2
                              |MCC_EM_RINT1 | MCC_EM_QOV1 | MCC_EM_RINT0
| MCC_EM_QOV0);
 
    immap->im_mcc2.mcc_mccm = (MCC_EM_GOV  | MCC_EM_GUN | MCC_EM_TINT |
MCC_EM_TQOV |
                               MCC_EM_RINT3 | MCC_EM_QOV3 | MCC_EM_RINT2
| MCC_EM_QOV2
                              |MCC_EM_RINT1 | MCC_EM_QOV1 | MCC_EM_RINT0
| MCC_EM_QOV0);
    Note : Apart from this i am doing global channel parameters, channel
specific parameters and xtra channel parameters.
 
  /* Initialising the TX and Rx parameters */
    while ((immap->im_cpm.cp_cpcr & CPCR_FLG) != READY_TO_RX_CMD);
    immap->im_cpm.cp_cpcr = CPCR_INIT_TX_RX_ONECHANL | psbc | (128<<6)|
CPCR_FLG;       /* ISSUE COMMAND */
    while ((immap->im_cpm.cp_cpcr & CPCR_FLG) != READY_TO_RX_CMD);
 
    while ((immap->im_cpm.cp_cpcr & CPCR_FLG) != READY_TO_RX_CMD);
    immap->im_cpm.cp_cpcr = CPCR_INIT_TX_RX_ONECHANL | psbc | (129<<6)|
CPCR_FLG;       /* ISSUE COMMAND */
    while ((immap->im_cpm.cp_cpcr & CPCR_FLG) != READY_TO_RX_CMD);
 
  /*Enabling TDMD2 */
    immap->im_siramctl2.si_gmr =  1 << 3;
 
 
Any hint would be greatly appreciated.


 
 Best Regards,

 -Akash Kaul

------=_NextPart_000_0013_01C520BF.7B74ED30
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C520BF.7B2630F0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>H<font color=3Dnavy><span
style=3D'color:navy'>i </span></font>All,</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;We&n=
bsp;are
developing&nbsp;MCC driver for MPC8280.&nbsp;We are using =
TDMD2&nbsp;&nbsp;for
2 channels in HDLC mode. </span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
Currently we are
testing using internal/external loopback setting. For this we&nbsp;have
connected BRG6 Output to CLK19 and TMR3IN (timer3 input). The =
TMR3O(timer 3 output)
is fed to L1RSYNC. We are receiving GUN interrupt. In the first =
interrupt we
are receiving IDL interrupt&nbsp;followwd by GUN&nbsp;interrupt and the =
driver
stops.</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;We =
have
verified the reasons given for this.But not able to overcome this =
problem.</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;I =
have
pasted some of the code snippets of my driver which i am doubtful =
of.&nbsp; I
hope to get some comments from the group on =
this.</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; Please =
find
below&nbsp; some of the code snippets: </span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
<strong><b><font
face=3DArial><span style=3D'font-family:Arial'>/*Configuring SIxMR for =
TDMD2*/</span></font></b></strong></span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;<spa=
n
class=3DGramE>immap</span>-&gt;im_siramctl2.si_dmr =3D =
0xA68;&nbsp;&nbsp;
/*(SI_M_CRT | SI_M_SDM_INTERNAL_LOOPBACK | SI_M_SAD_0 | SI_M_CE | =
SI_M_FE |
SI_M_SL |&nbsp;SI_M_RFSD_2BIT_DELAY);*/</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;<str=
ong><b><font
face=3DArial><span style=3D'font-family:Arial'>/* SI2 RAM =
programming*/</span></font></b></strong></span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;immap-&gt;=
im_si2txram[0]
=3D ( SIRAM_MCC | (SIRAM_CNT_1&lt;&lt;2) |SIRAM_RESOL_BYTE| =
(128&lt;&lt;5));<br>
&nbsp;&nbsp;&nbsp; immap-&gt;im_si2txram[1] =3D ( SIRAM_MCC |
(SIRAM_CNT_8&lt;&lt;2) | SIRAM_RESOL_BYTE | SIRAM_ENTRY_LAST | =
(129&lt;&lt;5));</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_si2rxram[0] =3D ( SIRAM_MCC | (SIRAM_CNT_1&lt;&lt;2)
|SIRAM_RESOL_BYTE| (128&lt;&lt;5));<br>
&nbsp;&nbsp;&nbsp; immap-&gt;im_si2rxram[1] =3D ( SIRAM_MCC
|(SIRAM_CNT_8&lt;&lt;2) |SIRAM_RESOL_BYTE| SIRAM_ENTRY_LAST | =
(129&lt;&lt;5));</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
<strong><b><font
face=3DArial><span style=3D'font-family:Arial'>/*Clock and BRG6 =
initialization =
*/</span></font></b></strong></span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;<spa=
n
class=3DGramE>immap</span>-&gt;im_cpmtimer.cpmt_tmr3=3D 0x0e;
/*(CPM_TIMER_ICLK|CPM_TIMER_GE|CPM_TIMER_FRR);*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;immap-&gt;im_cpmtimer.cpmt_trr3=3D&nbsp;
0x41;&nbsp;&nbsp; /* 63 bits :: <strong><b><font face=3DArial><span
style=3D'font-family:Arial'>Is this right</span></font></b></strong>, I =
have set
it to 63 b<font color=3Dnavy><span =
style=3D'color:navy'>e</span></font>cause my
first channel is 1 bit wide and second channel is 64 bit =
wide&nbsp;*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;<span =
class=3DGramE>immap</span>-&gt;im_cpmtimer.cpmt_tgcr2
=3D 0x09 ;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;immap-&gt;im_brgc6 =3D 0x00010000;&nbsp; /* =
Directly
feeding BRG6 with BRG_CLK which is of 33Mhz in my =
board*/</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
<strong><b><font
face=3DArial><span style=3D'font-family:Arial'>/*Port pin =
configuration*/</span></font></b></strong></span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;imma=
p-&gt;im_ioport.iop_psorb&nbsp;
|=3D =
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br=
>
&nbsp;&nbsp;&nbsp; immap-&gt;im_ioport.iop_pdirb&nbsp; &amp;=3D
~(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);&nbsp;&nbsp;&nbsp;</span></font>=
<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_ioport.iop_pparb&nbsp; |=3D
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);&nbsp;&nbsp;&nbsp;&nbsp;</span></=
font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_ioport.iop_psora &amp;=3D =
~(TDMD2_CLK19);&nbsp;</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_ioport.iop_pdira &amp;=3D ~(TDMD2_CLK19);&nbsp;<br>
&nbsp;&nbsp;&nbsp; immap-&gt;im_ioport.iop_ppara |=3D (TDMD2_CLK19); =
<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_ioport.iop_psorc&nbsp; &amp;=3D ~(TDMD2_TIN3 | TDMD2_BRGO6
|TDMD2_TOUT3);</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_ioport.iop_pdirc&nbsp; |=3D (TDMD2_BRGO6 | =
TDMD2_TOUT3);&nbsp;<br>
&nbsp;&nbsp;&nbsp; immap-&gt;im_ioport.iop_pdirc&nbsp; &amp;=3D
~(TDMD2_TIN3);&nbsp;</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_ioport.iop_pparc&nbsp; |=3D (TDMD2_TIN3 | TDMD2_BRGO6 |
TDMD2_TOUT3); </span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;</span></font><o=
:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_cpmux.cmx_si2cr |=3D =
(TDMD2_CLK19_CS);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><strong><b><font =
size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
/*Initialize
RxBDs.*/&nbsp; called for two channels</span></font></b></strong><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><strong><b><font =
size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;</span></font></=
b></strong><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; for
(index =3D 0; index &lt; MAX_NUM_BD; index++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( index !=3D
(MAX_NUM_BD-1) )&nbsp; /* If not the last RxBD for this channel */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;rx_bd[index+offset].cbd_sc =3D 0x9000; /* Empty, Interrupt =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else&nbsp; /* if =
last
RxBD for this channel */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;rx_bd[index+offset].cbd_sc =3D 0xB000;&nbsp;&nbsp; /* =
Empty,
Interrupt,and wrap */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
/* set the CM bit in the =
RxBDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;rx_bd[index+offset].cbd_sc |=3D 0x0200;&nbsp;&nbsp; /* set
continuous bit */<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
/* clear the buffer length */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;rx_bd[index+offset].cbd_datlen =3D =
0;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
/* set address to point to proper receive area for&nbsp;&nbsp;&nbsp;this =
BD in
the bufferpool scheme this program uses */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_ptr =3D (u32
*)cpm2_hostalloc(MAX_BUF_LEN, 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;rx_bd[index+offset].cbd_bufaddr =3D (uint =
)__pa(va_ptr);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
} /* end for loop initializing RxBDs */<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>/* <strong><b><font =
face=3DArial><span
style=3D'font-family:Arial'>Initialize TxBDs and RX BDs for both the =
channels</span></font></b></strong>*/<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp; for ( offset =3D 0, =
counter =3D
0; counter &lt; NUM_CHANS_PER_TDM;)<br>
&nbsp;&nbsp;&nbsp; {<br>
<strong><b><font face=3DArial><span =
style=3D'font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* Initialize TxBDs. */</span></font></b></strong><b><span =
style=3D'font-weight:
bold'><br>
<strong><b><font face=3DArial><span =
style=3D'font-family:Arial'>&nbsp;</span></font></b></strong></span></b>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
for (index=3D0; index &lt; MAX_NUM_BD; index++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( index !=3D
(MAX_NUM_BD-1) )&nbsp; /* If not the last TxBD for this channel */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set
Ready bit */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc =3D =
0x8000;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* If this channel is HDLC, also set Last and TC bits */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc |=3D 0x0C00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else&nbsp; /* if =
last
TxBD for this channel */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set
Ready, Wrap bits */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc =3D =
0xA000;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* If this channel is HDLC, also set Last and TC bits */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc |=3D 0x0C00;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
};<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
/* set the CM bit in the =
TxBDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc |=3D 0x0200;&nbsp;&nbsp; /* set
continuous bit */<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
/* set address to point to proper receive area for&nbsp;this BD in the
bufferpool scheme this program uses */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_ptr =3D =
(u32
*)cpm2_hostalloc(MAX_BUF_LEN, 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
memset(va_ptr,(u8)'B', MAX_BUF_LEN);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_bufaddr =3D (uint =
)__pa(va_ptr);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* load the =
buffer
length */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rx_tx_bd-&gt;tx_bd[index+offset].cbd_datlen =3D 54;//MAX_BUF_LEN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;}/* end for loop initializing TxBDs =
*/<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;offset =3D (++ =
counter *
MAX_NUM_BD);<br>
} /* End of outer for loop*/<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><strong><b><font =
size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp; /* MCC =
Init*/</span></font></b></strong><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><strong><b><font =
size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; #define
TDM&nbsp;&nbsp;&nbsp; 3</span></font></b></strong><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_mcc2.mcc_mccf =3D&nbsp;TDM | (TDM &lt;&lt; 2) | (TDM =
&lt;&lt; 4) |
(TDM &lt;&lt; 6); /* Enable TDM2 to use channels 128 to 225 =
*/<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; /* Clear =
all the
interrupts and enable the required interrupts */<br>
&nbsp;&nbsp;&nbsp; immap-&gt;im_mcc2.mcc_mcce =3D (MCC_EM_GOV&nbsp; | =
MCC_EM_GUN
| MCC_EM_TINT | MCC_EM_TQOV |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MCC_EM_RINT3 | MCC_EM_QOV3 | MCC_EM_RINT2 | MCC_EM_QOV2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
|MCC_EM_RINT1 | MCC_EM_QOV1 | MCC_EM_RINT0 | =
MCC_EM_QOV0);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_mcc2.mcc_mccm =3D (MCC_EM_GOV&nbsp; | MCC_EM_GUN | =
MCC_EM_TINT |
MCC_EM_TQOV |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MCC_EM_RINT3 | MCC_EM_QOV3 | MCC_EM_RINT2 | MCC_EM_QOV2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
|MCC_EM_RINT1 | MCC_EM_QOV1 | MCC_EM_RINT0 | =
MCC_EM_QOV0);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; Note : =
Apart from
this i am doing global channel parameters, channel specific parameters =
and xtra
channel parameters.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><strong><b><font =
size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;/* Initialising =
the TX
and Rx parameters&nbsp;*/</span></font></b></strong><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp; &nbsp; while
((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D =
READY_TO_RX_CMD);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_cpm.cp_cpcr =3D CPCR_INIT_TX_RX_ONECHANL | psbc | =
(128&lt;&lt;6)|
CPCR_FLG;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ISSUE COMMAND =
*/<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; while
((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D =
READY_TO_RX_CMD);<o:p></o:p></span></font></p>

</div>

<div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; while
((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D =
READY_TO_RX_CMD);<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
immap-&gt;im_cpm.cp_cpcr =3D CPCR_INIT_TX_RX_ONECHANL | psbc | =
(129&lt;&lt;6)|
CPCR_FLG;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ISSUE COMMAND =
*/<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; while
((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D =
READY_TO_RX_CMD);<o:p></o:p></span></font></p>

</div>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;<strong><b><font=

face=3DArial><span style=3D'font-family:Arial'>/*Enabling =
TDMD2&nbsp;*/</span></font></b></strong><o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; <span
class=3DGramE>immap</span>-&gt;im_siramctl2.si_gmr =3D&nbsp; 1 &lt;&lt; =
3;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:11.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Times New Roman"><span
style=3D'font-size:11.0pt;mso-bidi-font-family:"Courier New"'>Any hint =
would be
greatly appreciated.</span></font><font size=3D2><span =
style=3D'font-size:11.0pt;
mso-bidi-font-family:Arial'><br =
style=3D'mso-special-character:line-break'>
<![if !supportLineBreakNewLine]><br =
style=3D'mso-special-character:line-break'>
<![endif]><font color=3Dnavy><span =
style=3D'color:navy'><o:p></o:p></span></font></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
11.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Times New Roman"><span
style=3D'font-size:11.0pt;mso-bidi-font-family:Arial'>&nbsp;Best =
Regards,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Times New Roman"><span
style=3D'font-size:11.0pt;mso-bidi-font-family:Arial'><br>
&nbsp;-Akash Kaul<o:p></o:p></span></font></p>

</div>

</div>

</body>

</html>

------=_NextPart_000_0013_01C520BF.7B74ED30--
