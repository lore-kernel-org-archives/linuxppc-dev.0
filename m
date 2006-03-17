Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx1.wipro.com (wip-cdctls-mx1.wipro.com
	[203.91.201.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B400679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Mar 2006 04:09:26 +1100 (EST)
Received: from wip-cdctls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5EA843C40DF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 22:09:03 +0530 (IST)
Received: from chn-snr-bh2.wipro.com (chn-snr-bh2.wipro.com [10.145.50.92])
	by wip-cdctls-mx1.wipro.com (Postfix) with ESMTP id 523223C401C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 22:09:03 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C649E2.1E573420"
Subject: Loopback configurations for SCC, FCC in MPC8247
Date: Fri, 17 Mar 2006 22:12:50 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A07C16BAA@CHN-SNR-MBX01.wipro.com>
References: <85FE12CF7DBACF47A201840B70C4425C02F52273@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
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

------_=_NextPart_001_01C649E2.1E573420
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


 Hi all,=0D

I am using MPC8247. I am using FCC0, FCC1, SCC3 and SCC4 in Ethernet mode.=
 I want to enable local loopback in FCC and SCC. I tried in the following=
 combinations of registers for SCC

   case ETH_LOOPBK_ENBL:=0D
        printk("%s, ETH_LOOPBK_ENBL\n",__FUNCTION__);=0D
                                                                           =
                                                 =0D

        /* ENABLE the LOOP back by setting the 24th and 25th bits=0D
         * as 0 and 1 in GSMRL */=0D
        cep->sccp->scc_gsmrl |=3D SCC_GSMRL_DIAG_LOOP;=0D
        cpm2_immr->im_cpmux.cmx_scr &=3D ~CMX_CLK_MASK;=0D
        cpm2_immr->im_cpmux.cmx_scr |=3D CMX_LPCLK_ROUTE;=0D
        //cep->sccp->scc_gsmrh |=3D (SCC_GSMRH_CDS | SCC_GSMRH_CTSS);=0D
                                                                           =
                                                 =0D

        /* Configure PSMR for enabling- Promiscuos mode, simultaneous Tx,=
 Rx=0D
         * and Full duplex mode */=0D
        //cep->sccp->scc_psmr |=3D (SCC_PSMR_PRO | SCC_PSMR_LPB |=
 SCC_PSMR_FDE);=0D
        cep->sccp->scc_psmr |=3D (SCC_PSMR_PRO | SCC_PSMR_FDE);=0D
        return 0;=0D
                                                                           =
                                                 =0D

      case ETH_LOOPBK_DSBL:=0D
        printk("%s, ETH_LOOPBK_DSBL\n",__FUNCTION__);=0D
        /* Disable the LOOP back and revert back to normal operation by=0D
         * setting the 24th and 25th bits as 0 and 0 in GSMRL */=0D
        cep->sccp->scc_gsmrl &=3D ~SCC_GSMRL_DIAG_LOOP;=0D
        cpm2_immr->im_cpmux.cmx_scr &=3D ~CMX_CLK_MASK;=0D
        cpm2_immr->im_cpmux.cmx_scr |=3D CMX_CLK_ROUTE;=0D

   //cep->sccp->scc_gsmrh &=3D ~(SCC_GSMRH_CDS | SCC_GSMRH_CTSS);=0D
                                                                           =
                                                 =0D

        /* Revert PSMR settings */=0D
//      cep->sccp->scc_psmr &=3D ~(SCC_PSMR_PRO | SCC_PSMR_LPB |=
 SCC_PSMR_FDE);=0D
        cep->sccp->scc_psmr &=3D ~(SCC_PSMR_PRO | SCC_PSMR_FDE);=0D
        return 0;=0D

Following combinations for FCC=0D

       case ETH_LOOPBK_ENBL:=0D
        /* Enable loop back by setting the diag bits in GFMR. Promiscus=
 mode is=0D
         * enabled by setting the FPSMR bit */=0D
        cep->fccp->fcc_gfmr  |=3D FCC_GFMR_DIAG_LE;=0D
        cep->fccp->fcc_fpsmr |=3D (FCC_PSMR_PRO | FCC_PSMR_FDE |=
 FCC_PSMR_LPB);=0D
        printk("%s[FCC %2d]: Local Loopback Enabled  [GFMR - 0x%08x, FPSMR=
 - 0x%08x]\n", dev->name, cep->fip->fc_fccnum, cep->fccp->fcc_gfmr,=
 cep->fccp->fcc_fpsmr);

        return 0;=0D
                                                                           =
                                                 =0D

      case ETH_LOOPBK_DSBL:=0D
        /* Disable loopback and promiscus mode */=0D
        cep->fccp->fcc_gfmr  &=3D ~FCC_GFMR_DIAG_ALE;=0D
        cep->fccp->fcc_fpsmr &=3D ~(FCC_PSMR_PRO | FCC_PSMR_FDE |=
 FCC_PSMR_LPB);=0D
        printk("%s[FCC %2d]: Local Loopback Disabled [GFMR - 0x%08x, FPSMR=
 - 0x%08x]\n", dev->name, cep->fip->fc_fccnum, cep->fccp->fcc_gfmr,=
 cep->fccp->fcc_fpsmr);

        return 0;=0D



With the above cases the loopback is not enabling. Can any one suggest me=
 the register configurations for eabling loopback in FCC and SCC.=0D

Thanks in advance=0D

srideep




The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments.=0D

WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.
=0D
www.wipro.com
------_=_NextPart_001_01C649E2.1E573420
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Diso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>

<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7638.1">
<TITLE>Loopback configurations for SCC, FCC in MPC8247</TITLE>
</HEAD>
<BODY>
<DIV dir=3Dltr id=3DidOWAReplyText19948>
<DIV dir=3Dltr><FONT color=3D#000000 face=3DArial size=
=3D2>&nbsp;</FONT><FONT size=3D2>Hi=0D
all,</FONT> </DIV></DIV>
<DIV>
<P><FONT size=3D2>I am using MPC8247. I am using FCC0, FCC1, SCC3 and SCC4=
 in=0D
Ethernet mode. I want to enable local loopback in FCC and SCC. I tried in=
 the=0D
following combinations of registers for SCC</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp; case ETH_LOOPBK_ENBL:</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%s,=0D
ETH_LOOPBK_ENBL\n",__FUNCTION__);</FONT> <BR><FONT=0D
size=
=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=0D
</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ENABLE the=
 LOOP=0D
back by setting the 24th and 25th bits</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * as 0 and 1 in=
 GSMRL=0D
*/</FONT> <BR><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
cep-&gt;sccp-&gt;scc_gsmrl |=3D SCC_GSMRL_DIAG_LOOP;</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cpm2_immr-&gt;im_cpmux.cmx_scr=0D
&amp;=3D ~CMX_CLK_MASK;</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cpm2_immr-&gt;im_cpmux.cmx_scr=0D
|=3D CMX_LPCLK_ROUTE;</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 //cep-&gt;sccp-&gt;scc_gsmrh=0D
|=3D (SCC_GSMRH_CDS | SCC_GSMRH_CTSS);</FONT> <BR><FONT=0D
size=
=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=0D
</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Configure=
 PSMR for=0D
enabling- Promiscuos mode, simultaneous Tx, Rx</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and Full duplex=
 mode=0D
*/</FONT> <BR><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
//cep-&gt;sccp-&gt;scc_psmr |=3D (SCC_PSMR_PRO | SCC_PSMR_LPB |=0D
SCC_PSMR_FDE);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cep-&gt;sccp-&gt;scc_psmr |=3D=0D
(SCC_PSMR_PRO | SCC_PSMR_FDE);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</FONT>=
 <BR><FONT=0D
size=
=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=0D
</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 ETH_LOOPBK_DSBL:</FONT>=0D
<BR><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%s,=0D
ETH_LOOPBK_DSBL\n",__FUNCTION__);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable the LOOP=
 back and=0D
revert back to normal operation by</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * setting the=
 24th and=0D
25th bits as 0 and 0 in GSMRL */</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cep-&gt;sccp-&gt;scc_gsmrl=0D
&amp;=3D ~SCC_GSMRL_DIAG_LOOP;</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cpm2_immr-&gt;im_cpmux.cmx_scr=0D
&amp;=3D ~CMX_CLK_MASK;</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cpm2_immr-&gt;im_cpmux.cmx_scr=0D
|=3D CMX_CLK_ROUTE;</FONT> </P>
<P><FONT size=3D2>&nbsp;&nbsp; //cep-&gt;sccp-&gt;scc_gsmrh &amp;=3D=
 ~(SCC_GSMRH_CDS=0D
| SCC_GSMRH_CTSS);</FONT> <BR><FONT=0D
size=
=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=0D
</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Revert PSMR=
=0D
settings */</FONT> <BR><FONT size=3D2>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
cep-&gt;sccp-&gt;scc_psmr &amp;=3D ~(SCC_PSMR_PRO | SCC_PSMR_LPB |=0D
SCC_PSMR_FDE);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cep-&gt;sccp-&gt;scc_psmr=0D
&amp;=3D ~(SCC_PSMR_PRO | SCC_PSMR_FDE);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</FONT> </P>
<P><FONT size=3D2>Following combinations for FCC</FONT> </P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=0D
ETH_LOOPBK_ENBL:</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable loop back by=
 setting=0D
the diag bits in GFMR. Promiscus mode is</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * enabled by=
 setting the=0D
FPSMR bit */</FONT> <BR><FONT size=
=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
cep-&gt;fccp-&gt;fcc_gfmr&nbsp; |=3D FCC_GFMR_DIAG_LE;</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cep-&gt;fccp-&gt;fcc_fpsmr |=3D=0D
(FCC_PSMR_PRO | FCC_PSMR_FDE | FCC_PSMR_LPB);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%s[FCC %2d]:=
 Local=0D
Loopback Enabled&nbsp; [GFMR - 0x%08x, FPSMR - 0x%08x]\n", dev-&gt;name,=0D
cep-&gt;fip-&gt;fc_fccnum, cep-&gt;fccp-&gt;fcc_gfmr,=0D
cep-&gt;fccp-&gt;fcc_fpsmr);</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 0;</FONT>=0D
<BR><FONT=0D
size=
=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=0D
</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=
 ETH_LOOPBK_DSBL:</FONT>=0D
<BR><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable=
 loopback=0D
and promiscus mode */</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
cep-&gt;fccp-&gt;fcc_gfmr&nbsp; &amp;=3D ~FCC_GFMR_DIAG_ALE;</FONT>=
 <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cep-&gt;fccp-&gt;fcc_fpsmr=0D
&amp;=3D ~(FCC_PSMR_PRO | FCC_PSMR_FDE | FCC_PSMR_LPB);</FONT> <BR><FONT=0D
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%s[FCC %2d]:=
 Local=0D
Loopback Disabled [GFMR - 0x%08x, FPSMR - 0x%08x]\n", dev-&gt;name,=0D
cep-&gt;fip-&gt;fc_fccnum, cep-&gt;fccp-&gt;fcc_gfmr,=0D
cep-&gt;fccp-&gt;fcc_fpsmr);</FONT></P>
<P><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 0;</FONT>=0D
</P><BR><BR>
<P><FONT size=3D2>With the above cases the loopback is not enabling. Can=
 any one=0D
suggest me the register configurations for eabling loopback in FCC and SCC.=
=0D
</FONT></P>
<P><FONT size=3D2>Thanks in advance</FONT> </P>
<P><FONT size=3D2>srideep</FONT></P></DIV>

</BODY>
</HTML>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments. <br>
<br>
WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.<br>
 <br>
www.wipro.com<br>
</font></td></tr></table>
------_=_NextPart_001_01C649E2.1E573420--
