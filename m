Subject: Weird interrupt problem
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-ucK6nKLzBlp2Y33RYoYr"
Date: 08 Aug 2002 01:05:17 +0200
Message-Id: <1028761518.1262.1236.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-ucK6nKLzBlp2Y33RYoYr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Today this happened to me the second time: All of a sudden, the USB
mouse stopped working. At the same time this appeared in the syslog:

Aug  7 17:19:57 tibook kernel: Unhandled interrupt 1d, disabled=20

Plugging the mouse to the other socket worked, but it wouldn't work
again in the original one. As you can see in the attached
/proc/interrupts, interrupt 29 (=3D1d) is unknown. Interestingly,
interrupt 28 seems to be for the USB socket which stopped working (I
think it was the same one when the first problem first occured, might be
coincidence though). Was it somehow rewarded for its 100'000th
occurence? ;) Seriously, is it possible that the number changed somehow?


This wouldn't be all that bad, if the whole system wasn't very sluggish
afterwards. When it occured the first time, I had CONFIG_TAU enabled in
the kernel, which Ben said might cause the sluggishness at least. But
now it's disabled.


This is on a TiBook III/667 running 2.4.18-ben0-lotsanicestuff if it
matters. The first occurence was with 2.4.19-presomething-ben0.


Has anyone experienced anything similar?


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

--=-ucK6nKLzBlp2Y33RYoYr
Content-Disposition: attachment; filename=interrupts.BAD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=interrupts.BAD; charset=ISO-8859-1

           CPU0      =20
  1:       1908   OpenPIC   Edge      Built-in Sound out
  2:          0   OpenPIC   Edge      Built-in Sound in
 19:     132189   OpenPIC   Level     ide0
 20:         51   OpenPIC   Level     ide1
 25:    1557896   OpenPIC   Level     VIA-PMU
 26:        226   OpenPIC   Level     keywest i2c
 27:      33611   OpenPIC   Level     usb-ohci
 28:     108865   OpenPIC   Level     usb-ohci
 41:    1800835   OpenPIC   Level     eth0
 42:          0   OpenPIC   Level     keywest i2c
 47:     398650   OpenPIC   Level     GPIO1/ADB
 55:          0   OpenPIC   Edge      NMI - XMON
 57:         19   OpenPIC   Level     Airport
 61:          1   OpenPIC   Edge      Headphone detect
BAD:          1

--=-ucK6nKLzBlp2Y33RYoYr--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
