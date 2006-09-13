Return-Path: <Ronnie.Hedlund@optronic.se>
Received: from oskmsx.optronic.se (196.net103.skekraft.net [213.199.103.196])
	by ozlabs.org (Postfix) with SMTP id DEE1267A3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 16:50:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6D6FF.BA6A201D"
Subject: USB problem in linux 2.4.20
Date: Wed, 13 Sep 2006 08:42:05 +0200
Message-ID: <518B77BB6246D54D9E88FC49AFB0389DA9C49E@seskoptronicmsx.optronic.local>
From: "ductusrhe" <Ronnie.Hedlund@optronic.se>
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

------_=_NextPart_001_01C6D6FF.BA6A201D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
We have a problem with the usb-lowlevel and/or usb-storage components.
OS        Montavista Preview Linux 2.4.20
Processor PPC440EP
=20
We use an USB disc-on-chip quite heavily to store data from many threads =
(about 17).
The problem is that sometimes all threads/apps that use the usb device =
hangs (forever) waiting for disc access, and the CPU load goes down to =
0.

We have located the hanging to wait_for_completion() in command_abort() =
in scsiglue.c.
Since this is an error handling function, it might either be a bug in =
it, or that which caused the error to happen is the problem. The hanging =
happens every time the command_abort() is run.
Perhaps it's the scsi timeout of 30 sec, since so many threads are =
running...?

I wonder if someone have encountered this problem, solved it, found =
patches, or if someone knows of fixes that are currently in the 2.6 =
kernel for this processor that solves the problem.
=20

Some files involved:
=20
drivers/usb/usb-ocp-ohci.c=20
drivers/usb/usb.c
drivers/usb/storage/scsiglue.c
drivers/usb/storage/scsi_error.c
=20
=20
/Ronnie Hedlund

------_=_NextPart_001_01C6D6FF.BA6A201D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>Hi,</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>We have a problem with =
the =0A=
usb-lowlevel and/or usb-storage =0A=
components.<BR>OS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Montavis=
ta =0A=
Preview Linux 2.4.20<BR>Processor PPC440EP</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>We use an USB =
disc-on-chip quite =0A=
heavily to store data from many threads (about 17).<BR>The problem is =
that =0A=
sometimes all threads/apps&nbsp;that use the usb device hangs (forever) =
waiting =0A=
for disc access, and the CPU load goes down to 0.</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2><BR>We have located the =
hanging to =0A=
wait_for_completion() in command_abort() in scsiglue.c.<BR>Since this is =
an =0A=
error handling function, it might either be a bug in it, or that which =
caused =0A=
the error to happen is the problem. The hanging happens every time the =0A=
command_abort() is run.<BR>Perhaps it's the scsi timeout of 30 sec, =
since so =0A=
many threads are running...?</FONT></DIV><FONT face=3DArial =
color=3D#000000 size=3D2>=0A=
<DIV><BR>I wonder if someone have encountered this problem, solved it, =
found =0A=
patches, or if someone knows of fixes that are currently in the 2.6 =
kernel for =0A=
this processor that solves the problem.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><BR>Some files involved:</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>drivers/usb/usb-ocp-ohci.c <BR>drivers/usb/usb.c</DIV>=0A=
<DIV>drivers/usb/storage/scsiglue.c<BR>drivers/usb/storage/scsi_error.c</=
DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>/Ronnie Hedlund</FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C6D6FF.BA6A201D--
