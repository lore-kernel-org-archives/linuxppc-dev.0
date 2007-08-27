Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id 7BEDEDDF24
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 21:08:16 +1000 (EST)
Subject: RE: STK5200 pci_enable_device problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E89A.8EF6488E"
Date: Mon, 27 Aug 2007 14:08:12 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F070B927E@itri.bte.mam.gov.tr>
References: <7B9A8FF57DBB524190E98CABF6E56F078FAE4E@itri.bte.mam.gov.tr>
	<46CD3618.70801@sympatec.com>
From: "Mustafa Cayir" <mustafa.cayir@bte.mam.gov.tr>
To: "Oliver Rutsch" <orutsch@sympatec.com>,
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

------_=_NextPart_001_01C7E89A.8EF6488E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi ,
i use 2.4.25 kernel and eldk 3.1.1 on TQM5200 board. i tried denx 2.6.19 =
kernel to port on TQM5200 but i couldn't.
Did you port 2.6 kernel on TQM5200? Did pci device start working =
succesfully after porting 2.6 kernel to TQM5200 board.





-----Original Message-----
From: =
linuxppc-embedded-bounces+mustafa.cayir=3Dbte.mam.gov.tr@ozlabs.org on =
behalf of Oliver Rutsch
Sent: Thu 8/23/2007 10:24 AM
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
=20
Hi Mustafa,

> Hi all,
>=20
[...]
>=20
> My pci driver is able to scan pci bus and find succesfully the pci
> device. After this point, pci_enable_device function returns
> following error:
>=20
> PCI:  Device 00:18.0 not available because of resource collisions
>=20

Which ELDK and kernel do you use? I had the same problem on this board=20
with a PLX9054 based PCI card on a 2.4.25 kernel. I switched to the 2.6=20
kernel and the 4.1 ELDK and the card was scanned correctly.
But keep in mind that the linux PLX drivers do not work out of the box=20
with a big endian platform like the MPC5200. Although there is a=20
BIG_ENDIAN flag in the makefiles there are still some places left in the =

driver code which have to be patched (the parts with int64 adresses).
It's not so easy to compile the PLX drivers on the 4.1 ELDK because of=20
missing headers in the ppc architecture. I managed to build the drivers=20
for the 2.6.19 kernel and I was able to work with the card except the=20
DMA routines (still working on this issue).

Hope this helps. Bye,

--=20
Dipl. Ing. Oliver Rutsch
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


------_=_NextPart_001_01C7E89A.8EF6488E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: STK5200 pci_enable_device problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi ,<BR>
i use 2.4.25 kernel and eldk 3.1.1 on TQM5200 board. i tried denx 2.6.19 =
kernel to port on TQM5200 but i couldn't.<BR>
Did you port 2.6 kernel on TQM5200? Did pci device start working =
succesfully after porting 2.6 kernel to TQM5200 board.<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: =
linuxppc-embedded-bounces+mustafa.cayir=3Dbte.mam.gov.tr@ozlabs.org on =
behalf of Oliver Rutsch<BR>
Sent: Thu 8/23/2007 10:24 AM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: STK5200 pci_enable_device problem<BR>
<BR>
Hi Mustafa,<BR>
<BR>
&gt; Hi all,<BR>
&gt;<BR>
[...]<BR>
&gt;<BR>
&gt; My pci driver is able to scan pci bus and find succesfully the =
pci<BR>
&gt; device. After this point, pci_enable_device function returns<BR>
&gt; following error:<BR>
&gt;<BR>
&gt; PCI:&nbsp; Device 00:18.0 not available because of resource =
collisions<BR>
&gt;<BR>
<BR>
Which ELDK and kernel do you use? I had the same problem on this =
board<BR>
with a PLX9054 based PCI card on a 2.4.25 kernel. I switched to the =
2.6<BR>
kernel and the 4.1 ELDK and the card was scanned correctly.<BR>
But keep in mind that the linux PLX drivers do not work out of the =
box<BR>
with a big endian platform like the MPC5200. Although there is a<BR>
BIG_ENDIAN flag in the makefiles there are still some places left in =
the<BR>
driver code which have to be patched (the parts with int64 =
adresses).<BR>
It's not so easy to compile the PLX drivers on the 4.1 ELDK because =
of<BR>
missing headers in the ppc architecture. I managed to build the =
drivers<BR>
for the 2.6.19 kernel and I was able to work with the card except =
the<BR>
DMA routines (still working on this issue).<BR>
<BR>
Hope this helps. Bye,<BR>
<BR>
--<BR>
Dipl. Ing. Oliver Rutsch<BR>
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
------_=_NextPart_001_01C7E89A.8EF6488E--
