MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: mpc 8250 problem with 2.4.19 kernel
Date: Thu, 6 Mar 2003 13:19:53 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BCB@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Wojciech Kromer" <krom@dgt-lab.com.pl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Can anyone tell me the differences between 8250 and 8260.
> I turned off any ATM/utopia of course.
>
> Anyone have expiriences with 8250 ?

We have successfully booted 2.4.19 on 8250, 8255 and 8260.

Note that the 8260 has an HIP3 core, while 8250 has an HIP4 (like the 8260A).
So it has many bug fixes, a lower voltage (and higher speed), a PCI bus, and no UTOPIA.
If you don't use the PCI bus, it should be disabled (/PCI_MODE driven high),
or it will replace the local bus.

Of course, we had to adjust the hardware configuration word and the MODCK[1-3] pins
to support the higher speed of the HIP4.

We had some communication problems with the BDI2000.
At first, we tought it was related to the 8250 itself,
but then we expected it might be a problem of cable length.
We built a shorter cable (between the BDI2000 and the JTAG connector)
and it completely fixed the problem.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
