Return-Path: <mstarzewski@xes-inc.com>
Received: from xes-inc.com (unknown [24.196.136.110])
	by ozlabs.org (Postfix) with ESMTP id 2B2F667A85
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 03:11:17 +1100 (EST)
Message-ID: <0bb801c520d1$25c5f070$1500340a@matts>
From: "Matthew Starzewski" <mstarzewski@xes-inc.com>
To: "akash kaul" <akashkaul@deccanetworld.com>
References: <001201c52091$61bcb130$1b69cb0a@BGCW0166>
Date: Fri, 4 Mar 2005 09:45:10 -0600
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0BB5_01C5209E.DB247B90"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MCC driver help
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

------=_NextPart_000_0BB5_01C5209E.DB247B90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Akash,

What hardware are you using?  I know Extreme Engineering
has 8280-capable cards with a Linux MCC driver available.

PMC:
http://www.xes-inc.com/Products/XPort/XPort2000/XPort2000.html

PCI:
http://www.xes-inc.com/Products/XPort/XPort2010/XPort2010.html

CompactPCI:
http://www.xes-inc.com/Products/XPort/XPort2020/XPort2020.html

For what it's worth,
Matt

  ----- Original Message -----=20
  From: akash kaul=20
  To: linuxppc-embedded@ozlabs.org=20
  Sent: Friday, March 04, 2005 2:08 AM
  Subject: MCC driver help


  =20

  =20

  Hi All,

  =20

      We are developing MCC driver for MPC8280. We are using TDMD2  for =
2 channels in HDLC mode.=20

  =20

      Currently we are testing using internal/external loopback setting. =
For this we have connected BRG6 Output to CLK19 and TMR3IN (timer3 =
input). The TMR3O(timer 3 output) is fed to L1RSYNC. We are receiving =
GUN interrupt. In the first interrupt we are receiving IDL interrupt =
followwd by GUN interrupt and the driver stops.

      We have verified the reasons given for this.But not able to =
overcome this problem.

      I have pasted some of the code snippets of my driver which i am =
doubtful of.  I hope to get some comments from the group on this.

  =20

      Please find below  some of the code snippets:=20

  =20

      /*Configuring SIxMR for TDMD2*/

      immap->im_siramctl2.si_dmr =3D 0xA68;   /*(SI_M_CRT | =
SI_M_SDM_INTERNAL_LOOPBACK | SI_M_SAD_0 | SI_M_CE | SI_M_FE | SI_M_SL | =
SI_M_RFSD_2BIT_DELAY);*/

      /* SI2 RAM programming*/

      immap->im_si2txram[0] =3D ( SIRAM_MCC | (SIRAM_CNT_1<<2) =
|SIRAM_RESOL_BYTE| (128<<5));
      immap->im_si2txram[1] =3D ( SIRAM_MCC | (SIRAM_CNT_8<<2) | =
SIRAM_RESOL_BYTE | SIRAM_ENTRY_LAST | (129<<5));

  =20

      immap->im_si2rxram[0] =3D ( SIRAM_MCC | (SIRAM_CNT_1<<2) =
|SIRAM_RESOL_BYTE| (128<<5));
      immap->im_si2rxram[1] =3D ( SIRAM_MCC |(SIRAM_CNT_8<<2) =
|SIRAM_RESOL_BYTE| SIRAM_ENTRY_LAST | (129<<5));

      /*Clock and BRG6 initialization */

      immap->im_cpmtimer.cpmt_tmr3=3D 0x0e; =
/*(CPM_TIMER_ICLK|CPM_TIMER_GE|CPM_TIMER_FRR);*/
      immap->im_cpmtimer.cpmt_trr3=3D  0x41;   /* 63 bits :: Is this =
right, I have set it to 63 because my first channel is 1 bit wide and =
second channel is 64 bit wide */
      immap->im_cpmtimer.cpmt_tgcr2 =3D 0x09 ;=20
      immap->im_brgc6 =3D 0x00010000;  /* Directly feeding BRG6 with =
BRG_CLK which is of 33Mhz in my board*/

  =20

      /*Port pin configuration*/

      immap->im_ioport.iop_psorb  |=3D =
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);    =20
      immap->im_ioport.iop_pdirb  &=3D =
~(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);  =20

      immap->im_ioport.iop_pparb  |=3D =
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);   =20

  =20

      immap->im_ioport.iop_psora &=3D ~(TDMD2_CLK19);=20

      immap->im_ioport.iop_pdira &=3D ~(TDMD2_CLK19);=20
      immap->im_ioport.iop_ppara |=3D (TDMD2_CLK19);=20

     =20

      immap->im_ioport.iop_psorc  &=3D ~(TDMD2_TIN3 | TDMD2_BRGO6 =
|TDMD2_TOUT3);

      immap->im_ioport.iop_pdirc  |=3D (TDMD2_BRGO6 | TDMD2_TOUT3);=20
      immap->im_ioport.iop_pdirc  &=3D ~(TDMD2_TIN3);=20

      immap->im_ioport.iop_pparc  |=3D (TDMD2_TIN3 | TDMD2_BRGO6 | =
TDMD2_TOUT3);=20

   =20

      immap->im_cpmux.cmx_si2cr |=3D (TDMD2_CLK19_CS);

  =20

      /*Initialize RxBDs.*/  called for two channels

   =20

        for (index =3D 0; index < MAX_NUM_BD; index++)
         {
            if( index !=3D (MAX_NUM_BD-1) )  /* If not the last RxBD for =
this channel */
            {
               rx_tx_bd->rx_bd[index+offset].cbd_sc =3D 0x9000; /* =
Empty, Interrupt */
            }
            else  /* if last RxBD for this channel */
            {
               rx_tx_bd->rx_bd[index+offset].cbd_sc =3D 0xB000;   /* =
Empty, Interrupt,and wrap */
            }

  =20

            /* set the CM bit in the RxBDS         */
            rx_tx_bd->rx_bd[index+offset].cbd_sc |=3D 0x0200;   /* set =
continuous bit */

  =20

            /* clear the buffer length */
            rx_tx_bd->rx_bd[index+offset].cbd_datlen =3D 0;

  =20

            /* set address to point to proper receive area for   this BD =
in the bufferpool scheme this program uses */
            va_ptr =3D (u32 *)cpm2_hostalloc(MAX_BUF_LEN, 8);
            rx_tx_bd->rx_bd[index+offset].cbd_bufaddr =3D (uint =
)__pa(va_ptr);

  =20

         } /* end for loop initializing RxBDs */

  /* Initialize TxBDs and RX BDs for both the channels*/

  =20

    for ( offset =3D 0, counter =3D 0; counter < NUM_CHANS_PER_TDM;)
      {
         /* Initialize TxBDs. */
         for (index=3D0; index < MAX_NUM_BD; index++)
         {
            if( index !=3D (MAX_NUM_BD-1) )  /* If not the last TxBD for =
this channel */
            {
               /* Set Ready bit */
               rx_tx_bd->tx_bd[index+offset].cbd_sc =3D 0x8000;

  =20

               /* If this channel is HDLC, also set Last and TC bits */
               rx_tx_bd->tx_bd[index+offset].cbd_sc |=3D 0x0C00;
            }
            else  /* if last TxBD for this channel */
            {
               /* Set Ready, Wrap bits */
               rx_tx_bd->tx_bd[index+offset].cbd_sc =3D 0xA000;

  =20

               /* If this channel is HDLC, also set Last and TC bits */
               rx_tx_bd->tx_bd[index+offset].cbd_sc |=3D 0x0C00;
            };

  =20

            /* set the CM bit in the TxBDS         */
             rx_tx_bd->tx_bd[index+offset].cbd_sc |=3D 0x0200;   /* set =
continuous bit */

  =20

            /* set address to point to proper receive area for this BD =
in the bufferpool scheme this program uses */
             va_ptr =3D (u32 *)cpm2_hostalloc(MAX_BUF_LEN, 8);
             memset(va_ptr,(u8)'B', MAX_BUF_LEN);
             rx_tx_bd->tx_bd[index+offset].cbd_bufaddr =3D (uint =
)__pa(va_ptr);


            /* load the buffer length */
             rx_tx_bd->tx_bd[index+offset].cbd_datlen =3D =
54;//MAX_BUF_LEN;
         }/* end for loop initializing TxBDs */

  =20

   offset =3D (++ counter * MAX_NUM_BD);
  } /* End of outer for loop*/

    /* MCC Init*/

  =20

      #define TDM    3

      immap->im_mcc2.mcc_mccf =3D TDM | (TDM << 2) | (TDM << 4) | (TDM =
<< 6); /* Enable TDM2 to use channels 128 to 225 */

  =20

      /* Clear all the interrupts and enable the required interrupts */
      immap->im_mcc2.mcc_mcce =3D (MCC_EM_GOV  | MCC_EM_GUN | =
MCC_EM_TINT | MCC_EM_TQOV |
                                 MCC_EM_RINT3 | MCC_EM_QOV3 | =
MCC_EM_RINT2 | MCC_EM_QOV2
                                |MCC_EM_RINT1 | MCC_EM_QOV1 | =
MCC_EM_RINT0 | MCC_EM_QOV0);

  =20

      immap->im_mcc2.mcc_mccm =3D (MCC_EM_GOV  | MCC_EM_GUN | =
MCC_EM_TINT | MCC_EM_TQOV |
                                 MCC_EM_RINT3 | MCC_EM_QOV3 | =
MCC_EM_RINT2 | MCC_EM_QOV2
                                |MCC_EM_RINT1 | MCC_EM_QOV1 | =
MCC_EM_RINT0 | MCC_EM_QOV0);

      Note : Apart from this i am doing global channel parameters, =
channel specific parameters and xtra channel parameters.

  =20

    /* Initialising the TX and Rx parameters */

      while ((immap->im_cpm.cp_cpcr & CPCR_FLG) !=3D READY_TO_RX_CMD);

      immap->im_cpm.cp_cpcr =3D CPCR_INIT_TX_RX_ONECHANL | psbc | =
(128<<6)| CPCR_FLG;       /* ISSUE COMMAND */

      while ((immap->im_cpm.cp_cpcr & CPCR_FLG) !=3D READY_TO_RX_CMD);

  =20

      while ((immap->im_cpm.cp_cpcr & CPCR_FLG) !=3D READY_TO_RX_CMD);

      immap->im_cpm.cp_cpcr =3D CPCR_INIT_TX_RX_ONECHANL | psbc | =
(129<<6)| CPCR_FLG;       /* ISSUE COMMAND */

      while ((immap->im_cpm.cp_cpcr & CPCR_FLG) !=3D READY_TO_RX_CMD);

  =20

    /*Enabling TDMD2 */

      immap->im_siramctl2.si_gmr =3D  1 << 3;

  =20

  =20

  Any hint would be greatly appreciated.



  =20

   Best Regards,


   -Akash Kaul



-------------------------------------------------------------------------=
-----


  _______________________________________________
  Linuxppc-embedded mailing list
  Linuxppc-embedded@ozlabs.org
  https://ozlabs.org/mailman/listinfo/linuxppc-embedded

------=_NextPart_000_0BB5_01C5209E.DB247B90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3DWord.Document name=3DProgId>
<META content=3D"MSHTML 6.00.2722.900" name=3DGENERATOR>
<META content=3D"Microsoft Word 10" name=3DOriginator><LINK=20
href=3D"cid:filelist.xml@01C520BF.7B2630F0" rel=3DFile-List><!--[if gte =
mso 9]><xml>
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
<STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in =
1.25in; mso-header-margin: .5in; mso-footer-margin: .5in; =
mso-paper-source: 0; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.EmailStyle18 {
	COLOR: navy; FONT-FAMILY: Arial; mso-style-type: personal-reply; =
mso-style-noshow: yes; mso-ansi-font-size: 10.0pt; mso-bidi-font-size: =
10.0pt; mso-ascii-font-family: Arial; mso-hansi-font-family: Arial; =
mso-bidi-font-family: Arial
}
SPAN.GramE {
	mso-style-name: ""; mso-gram-e: yes
}
DIV.Section1 {
	page: Section1
}
</STYLE>
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
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US style=3D"tab-interval: .5in" vLink=3Dpurple =
link=3Dblue=20
bgColor=3Dwhite>
<DIV>Akash,</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What hardware are you using?&nbsp; I =
know Extreme=20
Engineering</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>has&nbsp;8280-capable cards&nbsp;with a =

Linux&nbsp;MCC driver available.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>PMC:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.xes-inc.com/Products/XPort/XPort2000/XPort2000.html">h=
ttp://www.xes-inc.com/Products/XPort/XPort2000/XPort2000.html</A></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>PCI:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.xes-inc.com/Products/XPort/XPort2010/XPort2010.html">h=
ttp://www.xes-inc.com/Products/XPort/XPort2010/XPort2010.html</A></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>CompactPCI:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.xes-inc.com/Products/XPort/XPort2020/XPort2020.html">h=
ttp://www.xes-inc.com/Products/XPort/XPort2020/XPort2020.html</A></FONT><=
/DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>For what it's worth,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Matt</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dakashkaul@deccanetworld.com=20
  href=3D"mailto:akashkaul@deccanetworld.com">akash kaul</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinuxppc-embedded@ozlabs.org=20
  =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Friday, March 04, 2005 =
2:08=20
AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> MCC driver help</DIV>
  <DIV><BR></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial color=3Dnavy size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">H<FONT =
color=3Dnavy><SPAN=20
  style=3D"COLOR: navy">i =
</SPAN></FONT>All,</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;We&nbsp;are=20
  developing&nbsp;MCC driver for MPC8280.&nbsp;We are using =
TDMD2&nbsp;&nbsp;for=20
  2 channels in HDLC mode. </SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; =
Currently we=20
  are testing using internal/external loopback setting. For this =
we&nbsp;have=20
  connected BRG6 Output to CLK19 and TMR3IN (timer3 input). The =
TMR3O(timer 3=20
  output) is fed to L1RSYNC. We are receiving GUN interrupt. In the =
first=20
  interrupt we are receiving IDL interrupt&nbsp;followwd by =
GUN&nbsp;interrupt=20
  and the driver stops.</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;We have=20
  verified the reasons given for this.But not able to overcome this=20
  problem.</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;I have=20
  pasted some of the code snippets of my driver which i am doubtful =
of.&nbsp; I=20
  hope to get some comments from the group on=20
  this.</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; =
Please find=20
  below&nbsp; some of the code snippets: =
</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  <STRONG><B><FONT face=3DArial><SPAN style=3D"FONT-FAMILY: =
Arial">/*Configuring=20
  SIxMR for=20
TDMD2*/</SPAN></FONT></B></STRONG></SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
  class=3DGramE>immap</SPAN>-&gt;im_siramctl2.si_dmr =3D =
0xA68;&nbsp;&nbsp;=20
  /*(SI_M_CRT | SI_M_SDM_INTERNAL_LOOPBACK | SI_M_SAD_0 | SI_M_CE | =
SI_M_FE |=20
  SI_M_SL =
|&nbsp;SI_M_RFSD_2BIT_DELAY);*/</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;<STRONG><B><FONT=20
  face=3DArial><SPAN style=3D"FONT-FAMILY: Arial">/* SI2 RAM=20
  =
programming*/</SPAN></FONT></B></STRONG></SPAN></FONT><o:p></o:p></P></DI=
V>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: 12pt">&nbsp;</SPAN></FONT><FONT =
face=3DArial=20
  size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;immap-&gt;im_si2txram[0]=20
  =3D ( SIRAM_MCC | (SIRAM_CNT_1&lt;&lt;2) |SIRAM_RESOL_BYTE|=20
  (128&lt;&lt;5));<BR>&nbsp;&nbsp;&nbsp; immap-&gt;im_si2txram[1] =3D ( =
SIRAM_MCC=20
  | (SIRAM_CNT_8&lt;&lt;2) | SIRAM_RESOL_BYTE | SIRAM_ENTRY_LAST |=20
  (129&lt;&lt;5));</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_si2rxram[0] =3D ( SIRAM_MCC | (SIRAM_CNT_1&lt;&lt;2)=20
  |SIRAM_RESOL_BYTE| (128&lt;&lt;5));<BR>&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_si2rxram[1] =3D ( SIRAM_MCC |(SIRAM_CNT_8&lt;&lt;2)=20
  |SIRAM_RESOL_BYTE| SIRAM_ENTRY_LAST |=20
  (129&lt;&lt;5));</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  <STRONG><B><FONT face=3DArial><SPAN style=3D"FONT-FAMILY: =
Arial">/*Clock and BRG6=20
  initialization=20
*/</SPAN></FONT></B></STRONG></SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
  class=3DGramE>immap</SPAN>-&gt;im_cpmtimer.cpmt_tmr3=3D 0x0e;=20
  =
/*(CPM_TIMER_ICLK|CPM_TIMER_GE|CPM_TIMER_FRR);*/<BR>&nbsp;&nbsp;&nbsp;&nb=
sp;immap-&gt;im_cpmtimer.cpmt_trr3=3D&nbsp;=20
  0x41;&nbsp;&nbsp; /* 63 bits :: <STRONG><B><FONT face=3DArial><SPAN=20
  style=3D"FONT-FAMILY: Arial">Is this right</SPAN></FONT></B></STRONG>, =
I have=20
  set it to 63 b<FONT color=3Dnavy><SPAN style=3D"COLOR: =
navy">e</SPAN></FONT>cause=20
  my first channel is 1 bit wide and second channel is 64 bit=20
  wide&nbsp;*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
  class=3DGramE>immap</SPAN>-&gt;im_cpmtimer.cpmt_tgcr2 =3D 0x09=20
  ;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;immap-&gt;im_brgc6 =3D =
0x00010000;&nbsp; /*=20
  Directly feeding BRG6 with BRG_CLK which is of 33Mhz in my=20
  board*/</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  <STRONG><B><FONT face=3DArial><SPAN style=3D"FONT-FAMILY: =
Arial">/*Port pin=20
  =
configuration*/</SPAN></FONT></B></STRONG></SPAN></FONT><o:p></o:p></P></=
DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;immap-&gt;im_ioport.iop_psorb&nbsp;=20
  |=3D=20
  =
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR=
>&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_pdirb&nbsp; &amp;=3D=20
  =
~(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);&nbsp;&nbsp;&nbsp;</SPAN></FONT>=
<o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_pparb&nbsp; |=3D=20
  =
(TDMD2_L1TXD|TDMD2_L1RXD|TDMD2_L1RSYNC);&nbsp;&nbsp;&nbsp;&nbsp;</SPAN></=
FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D3><SPAN style=3D"FONT-SIZE: =
12pt">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_psora &amp;=3D=20
  ~(TDMD2_CLK19);&nbsp;</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_pdira &amp;=3D=20
  ~(TDMD2_CLK19);&nbsp;<BR>&nbsp;&nbsp;&nbsp; =
immap-&gt;im_ioport.iop_ppara |=3D=20
  (TDMD2_CLK19); <o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  </SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_psorc&nbsp; &amp;=3D ~(TDMD2_TIN3 | =
TDMD2_BRGO6=20
  |TDMD2_TOUT3);</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_pdirc&nbsp; |=3D (TDMD2_BRGO6 |=20
  TDMD2_TOUT3);&nbsp;<BR>&nbsp;&nbsp;&nbsp; =
immap-&gt;im_ioport.iop_pdirc&nbsp;=20
  &amp;=3D ~(TDMD2_TIN3);&nbsp;</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_ioport.iop_pparc&nbsp; |=3D (TDMD2_TIN3 | TDMD2_BRGO6 |=20
  TDMD2_TOUT3); </SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;</SPAN></FONT><o:p></o:p></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_cpmux.cmx_si2cr |=3D=20
  (TDMD2_CLK19_CS);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><STRONG><B><FONT =
face=3DArial=20
  size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;=20
  /*Initialize RxBDs.*/&nbsp; called for two=20
  channels</SPAN></FONT></B></STRONG><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><STRONG><B><FONT =
face=3DArial=20
  size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;</SPAN></FONT></B></STRONG><FONT=20
  face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=20
  (index =3D 0; index &lt; MAX_NUM_BD;=20
  index++)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( index =
!=3D=20
  (MAX_NUM_BD-1) )&nbsp; /* If not the last RxBD for this channel=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
  rx_tx_bd-&gt;rx_bd[index+offset].cbd_sc =3D 0x9000; /* Empty, =
Interrupt=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else&nbsp; =
/* if=20
  last RxBD for this channel=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
  rx_tx_bd-&gt;rx_bd[index+offset].cbd_sc =3D 0xB000;&nbsp;&nbsp; /* =
Empty,=20
  Interrupt,and wrap=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /* set the CM bit in the =
RxBDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  rx_tx_bd-&gt;rx_bd[index+offset].cbd_sc |=3D 0x0200;&nbsp;&nbsp; /* =
set=20
  continuous bit */<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /* clear the buffer length=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  rx_tx_bd-&gt;rx_bd[index+offset].cbd_datlen =3D=20
  0;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /* set address to point to proper receive area =
for&nbsp;&nbsp;&nbsp;this BD in=20
  the bufferpool scheme this program uses=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_ptr =
=3D (u32=20
  *)cpm2_hostalloc(MAX_BUF_LEN,=20
  8);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  rx_tx_bd-&gt;rx_bd[index+offset].cbd_bufaddr =3D (uint=20
  )__pa(va_ptr);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  } /* end for loop initializing RxBDs =
*/<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">/* <STRONG><B><FONT=20
  face=3DArial><SPAN style=3D"FONT-FAMILY: Arial">Initialize TxBDs and =
RX BDs for=20
  both the=20
  =
channels</SPAN></FONT></B></STRONG>*/<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp; for ( offset =3D =
0, counter =3D=20
  0; counter &lt; NUM_CHANS_PER_TDM;)<BR>&nbsp;&nbsp;&nbsp;=20
  {<BR><STRONG><B><FONT face=3DArial><SPAN=20
  style=3D"FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Initialize=20
  TxBDs. */</SPAN></FONT></B></STRONG><B><SPAN=20
  style=3D"FONT-WEIGHT: bold"><BR><STRONG><B><FONT face=3DArial><SPAN=20
  style=3D"FONT-FAMILY: =
Arial">&nbsp;</SPAN></FONT></B></STRONG></SPAN></B>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
  for (index=3D0; index &lt; MAX_NUM_BD;=20
  index++)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( index =
!=3D=20
  (MAX_NUM_BD-1) )&nbsp; /* If not the last TxBD for this channel=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
  /* Set Ready bit=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc =3D=20
  0x8000;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
  /* If this channel is HDLC, also set Last and TC bits=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc |=3D=20
  0x0C00;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else&nbsp; =
/* if=20
  last TxBD for this channel=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
  /* Set Ready, Wrap bits=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc =3D=20
  0xA000;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
  /* If this channel is HDLC, also set Last and TC bits=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc |=3D=20
  0x0C00;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  };<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /* set the CM bit in the =
TxBDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_sc |=3D 0x0200;&nbsp;&nbsp; /* =
set=20
  continuous bit */<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /* set address to point to proper receive area for&nbsp;this BD in the =

  bufferpool scheme this program uses=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
va_ptr =3D=20
  (u32 *)cpm2_hostalloc(MAX_BUF_LEN,=20
  8);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  memset(va_ptr,(u8)'B',=20
  =
MAX_BUF_LEN);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_bufaddr =3D (uint=20
  )__pa(va_ptr);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /* load the buffer length=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  rx_tx_bd-&gt;tx_bd[index+offset].cbd_datlen =3D=20
  54;//MAX_BUF_LEN;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;}/* end for =
loop=20
  initializing TxBDs */<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;offset =3D (++ =
counter *=20
  MAX_NUM_BD);<BR>} /* End of outer for=20
loop*/<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><STRONG><B><FONT =
face=3DArial=20
  size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp; /* =
MCC=20
  Init*/</SPAN></FONT></B></STRONG><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><STRONG><B><FONT =
face=3DArial=20
  size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;=20
  #define TDM&nbsp;&nbsp;&nbsp; 3</SPAN></FONT></B></STRONG><FONT =
face=3DArial=20
  size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_mcc2.mcc_mccf =3D&nbsp;TDM | (TDM &lt;&lt; 2) | (TDM =
&lt;&lt; 4) |=20
  (TDM &lt;&lt; 6); /* Enable TDM2 to use channels 128 to 225=20
  */<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; /* =
Clear all=20
  the interrupts and enable the required interrupts =
*/<BR>&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_mcc2.mcc_mcce =3D (MCC_EM_GOV&nbsp; | MCC_EM_GUN | =
MCC_EM_TINT |=20
  MCC_EM_TQOV=20
  =
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  MCC_EM_RINT3 | MCC_EM_QOV3 | MCC_EM_RINT2 |=20
  =
MCC_EM_QOV2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  |MCC_EM_RINT1 | MCC_EM_QOV1 | MCC_EM_RINT0 |=20
  MCC_EM_QOV0);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_mcc2.mcc_mccm =3D (MCC_EM_GOV&nbsp; | MCC_EM_GUN | =
MCC_EM_TINT |=20
  MCC_EM_TQOV=20
  =
|<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  MCC_EM_RINT3 | MCC_EM_QOV3 | MCC_EM_RINT2 |=20
  =
MCC_EM_QOV2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  |MCC_EM_RINT1 | MCC_EM_QOV1 | MCC_EM_RINT0 |=20
  MCC_EM_QOV0);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; Note =
: Apart=20
  from this i am doing global channel parameters, channel specific =
parameters=20
  and xtra channel parameters.<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><STRONG><B><FONT =
face=3DArial=20
  size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;/*=20
  Initialising the TX and Rx =
parameters&nbsp;*/</SPAN></FONT></B></STRONG><FONT=20
  face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp; &nbsp; while=20
  ((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D=20
  READY_TO_RX_CMD);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_cpm.cp_cpcr =3D CPCR_INIT_TX_RX_ONECHANL | psbc | =
(128&lt;&lt;6)|=20
  CPCR_FLG;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ISSUE COMMAND=20
  */<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; while =

  ((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D=20
  READY_TO_RX_CMD);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; while =

  ((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D=20
  READY_TO_RX_CMD);<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp;=20
  immap-&gt;im_cpm.cp_cpcr =3D CPCR_INIT_TX_RX_ONECHANL | psbc | =
(129&lt;&lt;6)|=20
  CPCR_FLG;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ISSUE COMMAND=20
  */<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; while =

  ((immap-&gt;im_cpm.cp_cpcr &amp; CPCR_FLG) !=3D=20
  READY_TO_RX_CMD);<o:p></o:p></SPAN></FONT></P></DIV></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;<STRONG><B><FONT=20
  face=3DArial><SPAN style=3D"FONT-FAMILY: Arial">/*Enabling=20
  =
TDMD2&nbsp;*/</SPAN></FONT></B></STRONG><o:p></o:p></SPAN></FONT></P></DI=
V>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;&nbsp;&nbsp; <SPAN =

  class=3DGramE>immap</SPAN>-&gt;im_siramctl2.si_gmr =3D&nbsp; 1 =
&lt;&lt;=20
  3;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3DArial =
size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT =
face=3D"Courier New"=20
  size=3D2><SPAN=20
  style=3D"FONT-SIZE: 11pt; FONT-FAMILY: 'Courier =
New'"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D2><SPAN style=3D"FONT-SIZE: 11pt; mso-bidi-font-family: =
'Courier New'">Any=20
  hint would be greatly appreciated.</SPAN></FONT><FONT size=3D2><SPAN=20
  style=3D"FONT-SIZE: 11pt; mso-bidi-font-family: Arial"><BR=20
  style=3D"mso-special-character: line-break"><![if =
!supportLineBreakNewLine]><BR=20
  style=3D"mso-special-character: line-break"><![endif]><FONT =
color=3Dnavy><SPAN=20
  style=3D"COLOR: navy"><o:p></o:p></SPAN></FONT></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial color=3Dnavy size=3D2><SPAN=20
  style=3D"FONT-SIZE: 11pt; COLOR: navy; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D2><SPAN style=3D"FONT-SIZE: 11pt; mso-bidi-font-family: =
Arial">&nbsp;Best=20
  Regards,<o:p></o:p></SPAN></FONT></P></DIV>
  <DIV>
  <P class=3DMsoNormal style=3D"MARGIN-LEFT: 0.5in"><FONT face=3D"Times =
New Roman"=20
  size=3D2><SPAN=20
  style=3D"FONT-SIZE: 11pt; mso-bidi-font-family: =
Arial"><BR>&nbsp;-Akash=20
  Kaul<o:p></o:p></SPAN></FONT></P></DIV></DIV>
  <P>
  <HR>

  =
<P></P>_______________________________________________<BR>Linuxppc-embedd=
ed=20
  mailing=20
  =
list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listin=
fo/linuxppc-embedded</BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0BB5_01C5209E.DB247B90--
