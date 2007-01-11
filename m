Return-Path: <Daniel.Wyss@securiton.ch>
Received: from mrz.swissptt.ch (outmail37.swisscom.com [138.190.3.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "outmail3.swisscom.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C8E8DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 23:12:38 +1100 (EST)
Received: from stnzolav1.securiton.int (stnzolex1.securiton.int [10.101.10.36])
	by mrz.swissptt.ch with ESMTP id l0BBccYZ004162
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 12:38:39 +0100 (MET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Cannot open /dev/tty0 (No such device)
Date: Thu, 11 Jan 2007 12:38:37 +0100
Message-ID: <381D3B2C62C8B94B95219E2DA47C8DCF08E364@stnzolex2.securiton.int>
From: <Daniel.Wyss@securiton.ch>
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


Hi all,

I am trying to connect on a MPC 885 a Epson display controller (using a
AVNET Evaluation Board).=0D
I already included a frame buffer driver into the Kernel (2.4) that
seems to work fine.
Now i want to run a small X-server (kDrive) on the board but i get in=0D
troubles with the virtual consoles.
When I start the X-server i get the following message.

~ # Xfbdev -screen 320x240x8 -mouse /dev/mouse
Fatal server error:
LinuxInit: Cannot open /dev/tty0 (No such device)



Looking to the /dev/ shows that the device is available
~ # ls -l /dev/tty*
crw-rw-rw-    1 root     root       5,   0 Jan 10  2007 /dev/tty
crw-r-----    1 root     root       4,   0 Jan 10  2007 /dev/tty0
crw-r-----    1 root     root       4,   1 Jan 10  2007 /dev/tty1
crw-r-----    1 root     root       4,   2 Jan 10  2007 /dev/tty2
crw-r-----    1 root     root       4,   3 Jan 10  2007 /dev/tty3
crw--w--w-    1 root     root       3,   0 Jan  1 01:08 /dev/ttyp0
crw-r-----    1 root     root       3,   1 Jan 10  2007 /dev/ttyp1
crw-r-----    1 root     root       3,   2 Jan 10  2007 /dev/ttyp2
crw-r-----    1 root     root       3,   3 Jan 10  2007 /dev/ttyp3


but when I look to=0D

~ # cat /proc/tty/drivers
pty_slave            /dev/ttyp       3   0-255 pty:slave
pty_master           /dev/pty        2   0-255 pty:master
serial               /dev/cua        5      64 serial:callout
serial               /dev/ttyS       4      64 serial
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty


I miss the driver entry =0D
unknown              /dev/tty        4 1-63 console


Does anybody know why the driver for the tty 1-63 is not registered?

Any help welcomed. Thanks in advance.

Daniel

<html>
<body>
<font face =3D "arial" size =3D "1">
---------------------------------------------------------------------------=
------------------------------
This e-mail is confidential and may contain privileged information.
It is intended only for the addressees. If you have received this
e-mail in error, kindly notify us immediately by telephone or e-mail
and delete the message from your system.
---------------------------------------------------------------------------=
------------------------------
</font>
</body>
</html>
