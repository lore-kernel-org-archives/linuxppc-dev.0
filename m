From: "Peter Falk" <peter.falk@audiodev.com>
To: "'Gerrit Van de Velde'" <gvd@denayer.wenk.be>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on MPC5200 - LITE5200EVAL
Date: Wed, 11 Feb 2004 10:53:59 +0100
Message-ID: <007d01c3f084$f8751d80$0b01030a@pfalkxp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_007E_01C3F08D.5A398580"
In-reply-to: <1076491141.4841.6.camel@nios>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_007E_01C3F08D.5A398580
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Had the same problem with garbage, apparently a rounding problem in the
baudrate calculation.
The above patch shows the changes suggested by someone on the net, can't
remember his name but it is on the patches page of sourceforge.net.
After application of this it worked fine.
One gotcha, hardware handshake off on your terminal software! U-Boot
wants it off, The motorola DBUG wants it on, this kept me busy for a
day.

Regards,

Peter Falk

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Gerrit
Van de Velde
Sent: Wednesday, 11 February, 2004 10:19
To: Andrew Dennison
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux on MPC5200 - LITE5200EVAL



<snip>

> #dBUG commands to load u-boot via tftp
> set mac 00:01:AF:52:01:xx # see MPC5200LITE doco for how to choose xx
> value set client lite.ip.address set server tftpserver.ip.address
> set netmask your.netmask
> dn -i -o 0x100000 /tftpboot/u-boot.bin
> fe 0xff000000 0xff050000
> fp 0xff000000 0xff040000 0x100000
> #power off and change link to boot low
> #power up to u-boot
>

I followed these instructions and it all worked out fine (left out the
examples directory of U boot though) , but after the reboot in lowboot
jumper configuration, i only see garbage on my minicom screen. I can
figure out some characters that look familiar (like the countdown for
the autostart) so I assume it's working correctly but doesn't get
displayed right. I also can't interrupt the countdown so input doesn't
work. Already tried to change the 115200 8N1 settings of the
communications (but why would they change anyway..) and didn't help.

What could possibly be wrong ??

> read u-boot wiki to do it differently:)
>
> NOTE: if you have a Version 2.0 board and want 16MiB flash to actually
work
> you should ensure J24 is in the 2-3 position (J24 is a 0R resistor on
the
> bottom of the board).
> It is stupid for the jumper to be in the 1-3 position when 16MiB is
loaded
> but that is the way my board was. Seems like a manufacturing error:(
>

checked it and there's a resistor between 2-3 and not 1-3 so i guess
that's right.. (I have version 2.0 Lite)

> Andrew

Regards,
Gerrit



------=_NextPart_000_007E_01C3F08D.5A398580
Content-Type: application/octet-stream;
	name="serdiff.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="serdiff.patch"

Index: serial.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/u-boot/u-boot/cpu/mpc5xxx/serial.c,v=0A=
retrieving revision 1.1=0A=
diff -r1.1 serial.c=0A=
73c73=0A=
< 	baseclk =3D gd->ipb_clk / 32;=0A=
---=0A=
> 	baseclk =3D (gd->ipb_clk+16) / 32;=0A=
88c88=0A=
< 	div =3D baseclk / gd->baudrate;=0A=
---=0A=
> 	div =3D (baseclk+gd->baudrate/2) / gd->baudrate;=0A=
157c157=0A=
< 	baseclk =3D gd->ipb_clk / 32;=0A=
---=0A=
> 	baseclk =3D (gd->ipb_clk+16) / 32;=0A=
161c161=0A=
< 	div =3D baseclk / gd->baudrate;=0A=
---=0A=
> 	div =3D (baseclk+gd->baudrate/2) / gd->baudrate;=0A=

------=_NextPart_000_007E_01C3F08D.5A398580--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
