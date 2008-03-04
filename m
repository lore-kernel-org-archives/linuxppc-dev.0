Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 34DFDDDFF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 03:28:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87E14.47387AFA"
Subject: RE: Xilinx git tree, LLTemac driver
Date: Tue, 4 Mar 2008 08:24:53 -0800
References: <000f01c87dde$30ee1460$92ca3d20$@se>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Magnus Hjorth" <mh@omnisys.se>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080304162455.648B513E0058@mail153-sin.bigfish.com>
Cc: git <git@xilinx.com>
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

------_=_NextPart_001_01C87E14.47387AFA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Magnus,

The change that broke the lltemac driver was very recent, you should be =
able to check out a slightly earlier version to avoid the problem.

We've been following the migration pattern where drivers advertise =
platform devices *and* of devices.  In ARCH=3Dppc, only platform devices =
will ever get created and bound to the driver.  In ARCH=3Dpowerpc, only =
of devices will get created and bound.

Note that the ARCH=3Dpowerpc support is very new (and as evidenced by =
the bug you found, it hasn't been tested as much)...
If you have successes (or more failures), we'd appreciate hearing about =
them.

Steve

-----Original Message-----
From: Magnus Hjorth [mailto:mh@omnisys.se]
Sent: Tue 3/4/2008 1:57 AM
To: linuxppc-embedded@ozlabs.org
Cc: git
Subject: Xilinx git tree, LLTemac driver
=20
Hi,

I'm trying to compile the Linux kernel from the Xilinx git tree
(linux-2.6-xlnx) and am having some trouble with the LLTemac driver, =
having
to do with MAC address settings.=20

There seems to be two routines getting the MAC address in different =
ways.
The xtenet_probe function tries to access an extern bd_t __res, the type
bd_t doesn't exist in the powerpc tree which causes the compilation to =
fail.
Then there is the xtenet_of_probe function which uses =
of_get_mac_address.

What confuses me is that both the regular and the OF driver is =
registered in
the xtenet_init function, I would have expected it to be either/or.=20

Can I expect under the powerpc arch and supplying a .dts file, that the
xtenet_probe function will never be called?=20

Best regards,
Magnus


--

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  V=E4stra Fr=F6lunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se



------_=_NextPart_001_01C87E14.47387AFA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Xilinx git tree, LLTemac driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Magnus,<BR>
<BR>
The change that broke the lltemac driver was very recent, you should be =
able to check out a slightly earlier version to avoid the problem.<BR>
<BR>
We've been following the migration pattern where drivers advertise =
platform devices *and* of devices.&nbsp; In ARCH=3Dppc, only platform =
devices will ever get created and bound to the driver.&nbsp; In =
ARCH=3Dpowerpc, only of devices will get created and bound.<BR>
<BR>
Note that the ARCH=3Dpowerpc support is very new (and as evidenced by =
the bug you found, it hasn't been tested as much)...<BR>
If you have successes (or more failures), we'd appreciate hearing about =
them.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: Magnus Hjorth [<A =
HREF=3D"mailto:mh@omnisys.se">mailto:mh@omnisys.se</A>]<BR>
Sent: Tue 3/4/2008 1:57 AM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Cc: git<BR>
Subject: Xilinx git tree, LLTemac driver<BR>
<BR>
Hi,<BR>
<BR>
I'm trying to compile the Linux kernel from the Xilinx git tree<BR>
(linux-2.6-xlnx) and am having some trouble with the LLTemac driver, =
having<BR>
to do with MAC address settings.<BR>
<BR>
There seems to be two routines getting the MAC address in different =
ways.<BR>
The xtenet_probe function tries to access an extern bd_t __res, the =
type<BR>
bd_t doesn't exist in the powerpc tree which causes the compilation to =
fail.<BR>
Then there is the xtenet_of_probe function which uses =
of_get_mac_address.<BR>
<BR>
What confuses me is that both the regular and the OF driver is =
registered in<BR>
the xtenet_init function, I would have expected it to be either/or.<BR>
<BR>
Can I expect under the powerpc arch and supplying a .dts file, that =
the<BR>
xtenet_probe function will never be called?<BR>
<BR>
Best regards,<BR>
Magnus<BR>
<BR>
<BR>
--<BR>
<BR>
Magnus Hjorth, M.Sc.<BR>
Omnisys Instruments AB<BR>
Gruvgatan 8<BR>
SE-421 30&nbsp; V=E4stra Fr=F6lunda, SWEDEN<BR>
Phone: +46 31 734 34 09<BR>
Fax: +46 31 734 34 29<BR>
<A HREF=3D"http://www.omnisys.se">http://www.omnisys.se</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C87E14.47387AFA--
