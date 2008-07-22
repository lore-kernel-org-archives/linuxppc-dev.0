Return-Path: <akash.bhatnagar@vnl.in>
Received: from mailx.vnl.in (unknown [125.19.52.136])
	by ozlabs.org (Postfix) with ESMTP id C1046DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 13:10:08 +1000 (EST)
From: Akash Bhatnagar <akash.bhatnagar@vnl.in>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Date: Tue, 22 Jul 2008 08:29:11 +0530
Subject: Help required i2c-mpc driver 
Message-ID: <50660FB7D5A72645933E13611D51D54A10BF96EB20@mailserver.vnl.in>
Content-Type: multipart/alternative;
	boundary="_000_50660FB7D5A72645933E13611D51D54A10BF96EB20mailservervnl_"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_000_50660FB7D5A72645933E13611D51D54A10BF96EB20mailservervnl_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
            I am working on implementation of I2C driver for both MPC8540(A=
) & MPC8560(B) in Master Mode scenarios. The problem I am facing is given b=
elow

If I read any buffer part via I2C bus from A to B continuously,the driver i=
s working fine. However during this processing ,if B tries to read any buff=
er register from A the bus will goes into low state (both SCL and SDA are l=
ow).The error that it was showing are mainly NO ACK  and Remote IO errors. =
After this I suspect that it may be the problem form slave receive function=
 that I implemented. The reference Manual says that you have to set I2CCR[T=
XAK] bit after slave receive finishes. But how does slave knows wether this=
 will last byte of transaction.Only Master have this knowledge. The slave i=
mplementation is as follows:-

#ifdef CONFIG_MPC_I2C_SLAVE

                        // lost arbitration?
                        if ((priv->read(&priv->regs->i2csr) & MPC_I2CSR_MAL=
))
                        {

                                    priv->write(&priv->regs->i2csr, 0, MPC_=
I2CSR_MAL);
                                    if ((priv->read(&priv->regs->i2csr) & M=
PC_I2CSR_MAAS))
                                    {
                                                mpc_slave_address_match(pri=
v);
                                    }
                        }
                        else
                        {
                                    if ((priv->read(&priv->regs->i2csr) & M=
PC_I2CSR_MAAS))
                                    {
                                                mpc_slave_address_match(pri=
v);
                                    }
                                    else if ((priv->read(&priv->regs->i2ccr=
) & MPC_I2CCR_MTX))
                                    {
                                                mpc_slave_tx(priv);
                                    }
                                    else
                                    {
                                                mpc_slave_rx(priv);
                                    }
                        }
#endif
            }

static inline void mpc_slave_rx(struct mpc_i2c_private *priv)
{
            buffer =3D priv->read(&priv->regs->i2cdr);

            -------------Some Montavista Event Broker Part-----------

}

Since I am new in I2C functionality, Please point out any mistake I was doi=
ng.

This message and any attachment therewith is privileged, confidential and p=
roprietary in nature and the property of the originator. It is intended sol=
ely and exclusively for use by the individual to whom it is addressed. It s=
hould not be circulated or used for any purpose other than for what is stat=
ed. If you have received this message erroneously, please notify the origin=
ator immediately. If you are not the intended recipient, you are notified t=
hat you are strictly prohibited from using, copying, altering, or disclosin=
g the contents of this message and are called upon to delete the same from =
your system. Any contradictory action by you may invite penal consequences.=
 Vihaan Networks Limited accepts no responsibility for loss or damage arisi=
ng from the use of the information transmitted by this email including but =
not limited to damage from virus."

--_000_50660FB7D5A72645933E13611D51D54A10BF96EB20mailservervnl_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1519002094;
	mso-list-type:hybrid;
	mso-list-template-ids:1939255154 -600781912 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-number-format:roman-lower;
	mso-level-text:"%1\)";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-.5in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; I
am working on implementation of I2C driver for both MPC8540(A) &amp; MPC856=
0(B)
in Master Mode scenarios. The problem I am facing is given below<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>If I read any buffer part via =
I2C
bus from A to B continuously,the driver is working fine. However during this
processing ,if B tries to read any buffer register from A the bus will goes
into low state (both SCL and SDA are low).The error that it was showing are=
 mainly
NO ACK &nbsp;and Remote IO errors. After this I suspect that it may be the
problem form <b><span style=3D'font-weight:bold'>slave receive function </s=
pan></b>that
I implemented. The reference Manual says that you have to set I2CCR[TXAK] b=
it
after slave receive finishes. But how does slave knows wether this will last
byte of transaction.Only Master have this knowledge. The slave implementati=
on
is as follows:- <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>#ifdef
CONFIG_MPC_I2C_SLAVE<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'><o:p>&nbsp;<=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //
lost arbitration?<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
((priv-&gt;read(&amp;priv-&gt;regs-&gt;i2csr) &amp; MPC_I2CSR_MAL)) <o:p></=
o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></fo=
nt></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font><=
/i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;write(&amp;priv-&=
gt;regs-&gt;i2csr,
0, MPC_I2CSR_MAL);<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
((priv-&gt;read(&amp;priv-&gt;regs-&gt;i2csr) &amp; MPC_I2CSR_MAAS)) <o:p><=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></font>=
</i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc_slave_address_match(priv)=
;<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font>=
</i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></fo=
nt></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
((priv-&gt;read(&amp;priv-&gt;regs-&gt;i2csr) &amp; MPC_I2CSR_MAAS)) <o:p><=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></font>=
</i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc_slave_address_match(priv)=
;<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
if ((priv-&gt;read(&amp;priv-&gt;regs-&gt;i2ccr) &amp; MPC_I2CCR_MTX)) <o:p=
></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></font>=
</i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc_slave_tx(priv);<o:p></o:p=
></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></font>=
</i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc_slave_rx(priv);<o:p></o:p=
></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font>=
</i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></fo=
nt></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>#endif<o:p><=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span><=
/font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'><o:p>&nbsp;<=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>static inlin=
e void
mpc_slave_rx(struct mpc_i2c_private *priv)<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>{<o:p></o:p>=
</span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer
=3D priv-&gt;read(&amp;priv-&gt;regs-&gt;i2cdr);<o:p></o:p></span></font></=
i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'><o:p>&nbsp;<=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------Some
Montavista Event Broker Part-----------<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'><o:p>&nbsp;<=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>}<o:p></o:p>=
</span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><i><font size=3D2 face=3DAr=
ial><span
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'><o:p>&nbsp;<=
/o:p></span></font></i></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>Since I am new in I2C function=
ality,
Please point out any mistake I was doing.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

<pre>This message and any attachment therewith is privileged, confidential =
and proprietary in nature and the property of the originator. It is intende=
d solely and exclusively for use by the individual to whom it is addressed.=
 It should not be circulated or used for any purpose other than for what is=
 stated. If you have received this message erroneously, please notify the o=
riginator immediately. If you are not the intended recipient, you are notif=
ied that you are strictly prohibited from using, copying, altering, or disc=
losing the contents of this message and are called upon to delete the same =
from your system. Any contradictory action by you may invite penal conseque=
nces. Vihaan Networks Limited accepts no responsibility for loss or damage =
arising from the use of the information transmitted by this email including=
 but not limited to damage from virus."
</pre></body>

</html>

--_000_50660FB7D5A72645933E13611D51D54A10BF96EB20mailservervnl_--
