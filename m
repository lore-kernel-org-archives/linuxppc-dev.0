Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 186A8DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 10:05:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8595D.6971739C"
Subject: RE: Problems with PCI on 8280
Date: Thu, 17 Jan 2008 17:05:11 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D6@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
	<478FD066.5000803@freescale.com>
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

------_=_NextPart_001_01C8595D.6971739C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>From: Scott Wood=20
>Are you using cuImage, or a regular uImage with a device-tree-aware =
u-boot

cuImage for now.

>If the former, try commenting out the call to fixup_pci() in=20
>arch/powerpc/boot/cuboot-pq2.c and let me know if that changes =
anything.

Did that, That made our PCI bus fail completely

Looking in fixup_pci, I see it sets up one outbound window to the size =
of prefechable and non-prefetcabe memory
and anoter one to the size of the IO.

We have our PCI set up to ONE 512MB outbound range doing all three.=20
(I can see where you'd save on mem usage by doing two)

I do see a bug tho.
In our case prefetch is 256MB, memio is 128MB.
the calculation for outbound wiondow 1 sets the size to ~(pref+mmio-1). =
That only works if the resulting size is a power of 2.

If we comment out the rewrite of the outbound windows, we get PCI to =
work.
But since our u-boot sets everything up correctly (Including prefecable =
memory) we should not need this? or is it rewriting the device tree in =
some way?




------_=_NextPart_001_01C8595D.6971739C
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

<P><FONT SIZE=3D2>&gt;From: Scott Wood<BR>
&gt;Are you using cuImage, or a regular uImage with a device-tree-aware =
u-boot<BR>
<BR>
cuImage for now.<BR>
<BR>
&gt;If the former, try commenting out the call to fixup_pci() in<BR>
&gt;arch/powerpc/boot/cuboot-pq2.c and let me know if that changes =
anything.<BR>
<BR>
Did that, That made our PCI bus fail completely<BR>
<BR>
Looking in fixup_pci, I see it sets up one outbound window to the size =
of prefechable and non-prefetcabe memory<BR>
and anoter one to the size of the IO.<BR>
<BR>
We have our PCI set up to ONE 512MB outbound range doing all three.<BR>
(I can see where you'd save on mem usage by doing two)<BR>
<BR>
I do see a bug tho.<BR>
In our case prefetch is 256MB, memio is 128MB.<BR>
the calculation for outbound wiondow 1 sets the size to ~(pref+mmio-1). =
That only works if the resulting size is a power of 2.<BR>
<BR>
If we comment out the rewrite of the outbound windows, we get PCI to =
work.<BR>
But since our u-boot sets everything up correctly (Including prefecable =
memory) we should not need this? or is it rewriting the device tree in =
some way?<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8595D.6971739C--
