Return-Path: <gautran@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id 32D30679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 02:45:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C67DBD.0875D3C7"
Subject: RE: Preferred way to configure MTD physical mapping and partitioning
Date: Mon, 22 May 2006 12:30:27 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD41FE690@bosmail.BOS.int.mrv.com>
References: <200605221232.14880.laurent.pinchart@tbox.biz>
From: "Guillaume Autran" <gautran@mrv.com>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C67DBD.0875D3C7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

There is also the "RedBoot" approach that let you create and store your =
partition table in a reserved sector of your flash.
You can enable your kernel to parse and create your MTD partitions =
according. After that, all you need to do is make your boot loader write =
the table in flash. Have a look at the file =
"linux/drivers/mtd/redboot.c".=20

Guillaume.



-----Original Message-----
From: linuxppc-embedded-bounces+gautran=3Dmrv.com@ozlabs.org on behalf =
of Laurent Pinchart
Sent: Mon 5/22/2006 6:32 AM
To: linuxppc-embedded@ozlabs.org
Subject: Preferred way to configure MTD physical mapping and =
partitioning
=20
Hi everybody,

while browsing the kernel sources to find out how other boards configure =
MTD=20
physical mapping and partitioning, I noticed that a couple of different=20
approaches were possible:

- adding a board specific "driver" in drivers/mtd/maps and handle all =
mapping=20
manually
- adding board specific MTD configuration in arch/ppc/platforms with =
calls to=20
physmap_set_partitions() and physmap_configure()
- adding board specific MTD configuration in arch/ppc/platforms with a =
call to=20
physmap_set_partitions(), and using the CONFIG_MTD_PHYSMAP option with=20
physical mapping values provided in the kernel configuration.

Could anyone comment on the preferred approach ?

Best regards,

Laurent Pinchart
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


------_=_NextPart_001_01C67DBD.0875D3C7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: Preferred way to configure MTD physical mapping and =
partitioning</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Laurent,<BR>
<BR>
There is also the &quot;RedBoot&quot; approach that let you create and =
store your partition table in a reserved sector of your flash.<BR>
You can enable your kernel to parse and create your MTD partitions =
according. After that, all you need to do is make your boot loader write =
the table in flash. Have a look at the file =
&quot;linux/drivers/mtd/redboot.c&quot;.<BR>
<BR>
Guillaume.<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+gautran=3Dmrv.com@ozlabs.org on behalf =
of Laurent Pinchart<BR>
Sent: Mon 5/22/2006 6:32 AM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Preferred way to configure MTD physical mapping and =
partitioning<BR>
<BR>
Hi everybody,<BR>
<BR>
while browsing the kernel sources to find out how other boards configure =
MTD<BR>
physical mapping and partitioning, I noticed that a couple of =
different<BR>
approaches were possible:<BR>
<BR>
- adding a board specific &quot;driver&quot; in drivers/mtd/maps and =
handle all mapping<BR>
manually<BR>
- adding board specific MTD configuration in arch/ppc/platforms with =
calls to<BR>
physmap_set_partitions() and physmap_configure()<BR>
- adding board specific MTD configuration in arch/ppc/platforms with a =
call to<BR>
physmap_set_partitions(), and using the CONFIG_MTD_PHYSMAP option =
with<BR>
physical mapping values provided in the kernel configuration.<BR>
<BR>
Could anyone comment on the preferred approach ?<BR>
<BR>
Best regards,<BR>
<BR>
Laurent Pinchart<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C67DBD.0875D3C7--
