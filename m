MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2E4BC.C5B4EB22"
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Fri, 7 Mar 2003 10:18:14 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B7634E6@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Dayton, Dean" <deand@aiinet.com>
Cc: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C2E4BC.C5B4EB22
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> Oh, I almost forgot. Yes I would like to see your test=20
> program. One of the
> reasons I haven't chased the problem is because it keeps=20
> disappearing;-)
>=20
> Dean Dayton

Here is, in attachement, the test program.
There are two files in the tar:

  -- testprintk.c --
    A module that adds a device /dev/tpk.
    Once a file descriptor is obtained on this device,
    an internal timer starts, which calls "printk",
    each 10 ticks (100ms in my setup). When the file descriptor
    is released, the timer stops.

  -- main.c --
    A simple user mode program that opens /dev/tpk,
    and then performs an infinite loop printing to the stdout.
    When the program stops (Ctrl-C), the descriptor will be
    released by Linux, stopping the internal timer.

With that test, the problem almost immediatly appears.

BTW, the same problem is on the 860 also, which can be diagnosed the =
same way.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Qu=E9bec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

------_=_NextPart_001_01C2E4BC.C5B4EB22
Content-Type: application/x-gzip;
	name="testprintk.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: testprintk.tar.gz
Content-Disposition: attachment;
	filename="testprintk.tar.gz"

H4sICB61aD4CA3Rlc3RwcmludGsudGFyAO1Xe2/iRhDnbz7FhEonk1JiyKsqvVa9ALmoHJwIXFW1
lWXsNexlvba8a0J6ve/eWb8wYK5RpTup1f4UxfbO7Dx3ZwZJhAwjyuVD26l9Jpgd07y+uKiZiOur
y+Rpdrrp0zQvLju4dn113u2cd88vO8jfvb7q1MCsfQHEQtoRQO29uwieSHSU73FFCKv97/AV5Q6L
XQLfM8rjzZkTcI8u26sf6vuUBxJxwqoolFNZte6JqlWXrD1h4d9xgYLZi8r1kHIWOA+7NFv4Z7Ht
OEQk+pDiucSDN5P+fDQ4kOEHbsxIIoFwl3oF/81kPLy7tb7tXpl7wv3QUauHWqnv26FV0FJ5e+I2
mwppm82hMFy0EoFl2/BwSupAGrOVzV1GLAlLa/UorfJiL+cUMoodCR5FxiAkES4GXOAOIS0vCEUP
9jgl9UlkMSqU2OSjV6+vA+qCw4jN49BKI2aotWahBysGyPBB6eBGJoryAJ05bZWNgNPDPRFByYL8
4zYVSl5OJYmiIIIbm0PA2RMsCDiBHyK7C7YAG7LcIiMTpK7UqaO540Ae2Q91QCiWiMg44u9sFhN4
CSaqVZSzU7hR/kMcggh8AksWLGwGazui9oIR0W634fQsk4JKktAZ8CILIqD9iuYTXxBpvCgS0AIT
PaV/ksAzisVmc6t2SpaYDJQgA5AronJPHZJGRTwhxQcjSX0z11+IaatsoBN5Ynp75CzwGUf2lTPt
HynkSj+jzCBjPB+NWtDAvY0W9AfvhvfWcGSNJ+NBK5HxHBTbfprPJhZ+jedvWtWrz5Z5b90Nb15P
4S/1Np3fTtK3X+b30xY8W0o5RcrTUkr6eBtUKtJIpHcKRIwlh7g/FqfAMyqj+DKRBs2E6UNuTtpz
DWjMBvezt9O78ezn72BoJ2cZEx+VDkEi7uR33sjPFGL30H4zGE8waCn1Y/I/uQE7GnOVOxr7EV2j
lsQXIbyY4bVige0St40Km7nEvZqauVs24gSvzp6L+wWkkJYXt60jZX969QN9VeWomV1hTM+cb8O1
vTBZWtJkxAWLcZijPNMuYVXXuH40X1n0Yr4NmdqQe6hsSz1QxuRVMHFmFj7MUk0xF3TJMess4EsI
7cj2Ifctz9hrwlhaDB6DiLlgeFHgq+KFBTEO5UkzzVV2kRPD22QT0ogIwOPxnnoexdevoWOmObBd
t8rTj/VnlHe6V6i93Nrjmns7dNeWdnI+kmpbpngxd5K79bII0CftLZ8gs8r86k5z1INPHYAdNWlW
rdHdzWB8PzAat29HKgH/wfnPtyn/fJP/s+Z/86q7nf873XPk71xc6/n/C8//Qro0SAZodXvUuTDU
ix0tnRY4KwzSKb6vf/ujVHn7VKhhCBax5xEsVktQjVG6QSyL6QjHnzXSjXQ57a0tsO4m41dDHIZK
bfaWoLr0TrpEOBENJY57KHFb1dswW9kSHiljoBInE1paPbbjGF5sF2tIUrwa6gfHWTqzTKxpfzIe
/Zp1Imxhig/7Z2e/dYXJqFnavG29QDZUGp1tb1SPxxVabRyKUQXcO1bAY4H1BdsZaZZ7LUqsaWho
aGhoaGhoaGhoaGhoaGhoaGhoaGho/Hv8DeeYLN0AKAAA

------_=_NextPart_001_01C2E4BC.C5B4EB22--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
