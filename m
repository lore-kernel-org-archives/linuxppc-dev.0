Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id E3D4DDDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Nov 2007 22:13:11 +1100 (EST)
Subject: RE: MPC880: i2cer register says tx is done but tx buf descriptor is
	still	ready
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C829D3.F8EBAF03"
Date: Sun, 18 Nov 2007 12:12:57 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E2649F4@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EB7C778@aquib01a>
	<473F33BB.7050006@scram.de>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Jochen Friedrich" <jochen@scram.de>
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

------_=_NextPart_001_01C829D3.F8EBAF03
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

A porting of the driver included in kernel 2.4.

Here is an excerpt of the method to send bytes over the i2c bus:
________________________________________________________________________
  i2c->i2c_i2cmr =3D 0x00;	/* Disable I2C interupts */
  i2c->i2c_i2cer =3D 0xff;
  i2c->i2c_i2mod |=3D 1;	/* Enable */
  i2c->i2c_i2com |=3D 0x80;	/* Begin transmission */
  tmo =3D jiffies + 1*HZ;
  /* Busy wait, with a timeout */
  while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo)));
 =20

  if (signal_pending(current) || !tmo){
    force_close(algo_8xx_data);
    if (!tmo)
        printk("IIC write: timeout!\n");

    return -EIO;
  }

  if ((tbdf[0]->cbd_sc | tbdf[1]->cbd_sc) & BD_SC_NAK) {
      printk(KERN_INFO "IIC write; no ack\n");
      if (cpm_debug > 0)
        printk("tx0 sc %04x, tx1 sc %04x\n", =
tbdf[0]->cbd_sc,tbdf[1]->cbd_sc);
   =20
    return 0;
  }

  if ((tbdf[0]->cbd_sc | tbdf[1]->cbd_sc) & BD_SC_READY) {
      printk(KERN_INFO "IIC write; complete but tbuf ready\n");
      if (cpm_debug > 0)
        printk("tx0 sc %04x, tx1 sc %04x\n", =
tbdf[0]->cbd_sc,tbdf[1]->cbd_sc);

    return 0;
  }


-----Original Message-----
From: Jochen Friedrich [mailto:jochen@scram.de]
Sent: Sat 17/11/2007 19.32
To: DI BACCO ANTONIO - technolabs
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC880: i2cer register says tx is done but tx buf =
descriptor is still	ready
=20
Hi Antonio,

> How could it be possible? It happens during the first i2c transactions
> and then no more.=20
>  =20

What linux version? Which driver?

Thanks,
Jochen



------_=_NextPart_001_01C829D3.F8EBAF03
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>RE: MPC880: i2cer register says tx is done but tx buf descriptor =
is still	ready</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>A porting of the driver included in kernel 2.4.<BR>
<BR>
Here is an excerpt of the method to send bytes over the i2c bus:<BR>
________________________________________________________________________<=
BR>
&nbsp; i2c-&gt;i2c_i2cmr =3D =
0x00;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable I2C interupts =
*/<BR>
&nbsp; i2c-&gt;i2c_i2cer =3D 0xff;<BR>
&nbsp; i2c-&gt;i2c_i2mod |=3D 1;&nbsp; /* Enable */<BR>
&nbsp; i2c-&gt;i2c_i2com |=3D 0x80;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Begin transmission */<BR>
&nbsp; tmo =3D jiffies + 1*HZ;<BR>
&nbsp; /* Busy wait, with a timeout */<BR>
&nbsp; while(!(i2c-&gt;i2c_i2cer &amp; 0x12 || time_after(jiffies, =
tmo)));<BR>
&nbsp;<BR>
<BR>
&nbsp; if (signal_pending(current) || !tmo){<BR>
&nbsp;&nbsp;&nbsp; force_close(algo_8xx_data);<BR>
&nbsp;&nbsp;&nbsp; if (!tmo)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;IIC write: =
timeout!\n&quot;);<BR>
<BR>
&nbsp;&nbsp;&nbsp; return -EIO;<BR>
&nbsp; }<BR>
<BR>
&nbsp; if ((tbdf[0]-&gt;cbd_sc | tbdf[1]-&gt;cbd_sc) &amp; BD_SC_NAK) =
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO &quot;IIC write; no =
ack\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpm_debug &gt; 0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;tx0 sc %04x, tx1 =
sc %04x\n&quot;, tbdf[0]-&gt;cbd_sc,tbdf[1]-&gt;cbd_sc);<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; return 0;<BR>
&nbsp; }<BR>
<BR>
&nbsp; if ((tbdf[0]-&gt;cbd_sc | tbdf[1]-&gt;cbd_sc) &amp; BD_SC_READY) =
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO &quot;IIC write; =
complete but tbuf ready\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpm_debug &gt; 0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;tx0 sc %04x, tx1 =
sc %04x\n&quot;, tbdf[0]-&gt;cbd_sc,tbdf[1]-&gt;cbd_sc);<BR>
<BR>
&nbsp;&nbsp;&nbsp; return 0;<BR>
&nbsp; }<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Jochen Friedrich [<A =
HREF=3D"mailto:jochen@scram.de">mailto:jochen@scram.de</A>]<BR>
Sent: Sat 17/11/2007 19.32<BR>
To: DI BACCO ANTONIO - technolabs<BR>
Cc: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: MPC880: i2cer register says tx is done but tx buf =
descriptor is still&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ready<BR>
<BR>
Hi Antonio,<BR>
<BR>
&gt; How could it be possible? It happens during the first i2c =
transactions<BR>
&gt; and then no more.<BR>
&gt;&nbsp;&nbsp;<BR>
<BR>
What linux version? Which driver?<BR>
<BR>
Thanks,<BR>
Jochen<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C829D3.F8EBAF03--
