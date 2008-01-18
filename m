Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 82D96DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:31:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85969.8509640A"
Subject: RE: Problems with PCI on 8280
Date: Thu, 17 Jan 2008 18:27:46 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D8@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
	<478FD066.5000803@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B039BA0D6@ismail.innsys.innovsys.com>
	<478FE248.1030101@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85969.8509640A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Scott Wood

>Hmm...  that suggests that something in u-boot's setup is either=20
>incorrect, or (more likely in this case) doesn't match the device tree.

Turns out u-boot was not setting u the inbound window size correctly.
It was hardcoded to 512MB and we have a gig of ram. Set it correctly, =
and CPI now works fully even without fixup_pci()

>Ah.  Yes, I was assuming both windows would be the same size.  The code =

>should be changed to check that, and if any conditions for setting=20
>PCIBRx/PCIMSKx fail, check to see if the firmware-provided values work=20
>(and if not, bail without touching anything).

yup. In our case we only need one window.

BTW. there is a bug in the inbound window size calculation.
The mem_log2 variable sould be the shift value, not 1<< shift.
and on the next line the window size mask sould be anded with =
0x000f_ffff before or'ed with 0xa000_0000


------_=_NextPart_001_01C85969.8509640A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Problems with PCI on 8280</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: Scott Wood<BR>
<BR>
&gt;Hmm...&nbsp; that suggests that something in u-boot's setup is =
either<BR>
&gt;incorrect, or (more likely in this case) doesn't match the device =
tree.<BR>
<BR>
Turns out u-boot was not setting u the inbound window size =
correctly.<BR>
It was hardcoded to 512MB and we have a gig of ram. Set it correctly, =
and CPI now works fully even without fixup_pci()<BR>
<BR>
&gt;Ah.&nbsp; Yes, I was assuming both windows would be the same =
size.&nbsp; The code<BR>
&gt;should be changed to check that, and if any conditions for =
setting<BR>
&gt;PCIBRx/PCIMSKx fail, check to see if the firmware-provided values =
work<BR>
&gt;(and if not, bail without touching anything).<BR>
<BR>
yup. In our case we only need one window.<BR>
<BR>
BTW. there is a bug in the inbound window size calculation.<BR>
The mem_log2 variable sould be the shift value, not 1&lt;&lt; shift.<BR>
and on the next line the window size mask sould be anded with =
0x000f_ffff before or'ed with 0xa000_0000<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C85969.8509640A--
