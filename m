Return-Path: <jbe@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 26E70DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 22:09:51 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: Henk Stegeman <henk.stegeman@gmail.com>
Date: Mon, 9 Mar 2009 12:09:34 +0100
References: <ae4f76fd0902200151m461f9336x1e2bbec61f815fde@mail.gmail.com>
	<200903071109.49726.jbe@pengutronix.de>
	<ae4f76fd0903090232n21152b02of5ebcac86c60e53a@mail.gmail.com>
In-Reply-To: <ae4f76fd0903090232n21152b02of5ebcac86c60e53a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903091209.35544.jbe@pengutronix.de>
Subject: Re: Davicom DM9000A on MPC5200B (powerpc) works using a dirty
	offsetting and byte trick
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Henk,

On Montag, 9. M=E4rz 2009, Henk Stegeman wrote:
> I don't understand how this would work,
>
> Now I do one byte-swap, which works.
>  -I byteswap in software, for 16-bit cycles by byte swapping and for 8
> bit cycles by adding an offset of 1.
>  (The byte swapping on the chipselect is off)
>
> Your advice includes two byteswaps, one by re-routing the data bus and
> one by enabling the byte swap on the chip-select.

My experience is the chip select byte swap feature only works correctly if =
you=20
connect a little endian device like I showed you.

> Or does one of them not really swap bytes?

Let me show you how it works. You must ensure you can write/read data in an=
y=20
data width, but at the side of the little endian device it always must be i=
n=20
the correct endianess. This example uses a 32 bit data width, but it works=
=20
for 16 bit, too.
=2D LE shows how a real litte endian CPU would write data
=2D MPC1 shows how MPC5200 will do it, without any byte swap and DO at the
  MPC5200 side is also D0 at the little endian device
=2D MPC2 shows how MPC5200 will do it, with D0 at the MPC5200 side is D24 a=
t the
  little endian device
=2D MPC3 shows how MPC5200 will do it, connected like MPC2 but also the chip
  select byte swap feature enabled
=2D LE DEV shows how the little endian device expects the data

You want to write this data at the given offset into the little endian devi=
ce:

 Bytes: 0:0x34, 1:0x12, 2:0x78, 3:0x56
 Worte:     0:0x1234       2:0x5678
 LONG:            0:0x56781234

Writing as bytes:

 Bytes: 0:0x34, 1:0x12, 2:0x78, 3:0x56

Offset  LE    MPC1  MPC2  MPC3  LE DEV
 0      0x34  0x56  0x34  0x34  0x34
 1      0x12  0x78  0x12  0x12  0x12
 2      0x78  0x12  0x78  0x78  0x78
 3      0x56  0x34  0x56  0x56  0x56
        ^^^^--------^^^^--^^^^--^^^^--> these are correct
              ^^^^--------------------> this is wrong

Writing as words:

 Words:     0:0x1234       2:0x5678

Offset   LE     MPC1  MPC2  MPC3  LE DEV
  0      0x34   0x78  0x12  0x34  0x34
 (1)     0x12   0x56  0x34  0x12  0x12
  2      0x78   0x34  0x56  0x78  0x78
 (3)     0x56   0x12  0x78  0x56  0x56
         ^^^^---------------^^^^--^^^^--> these are correct
                ^^^^--^^^^--------------> these are wrong

Writing as longs:

 LONG:         0:0x56781234

Offset   LE     MPC1  MPC2  MPC3  LE DEV
  0      0x34   0x34  0x56  0x34  0x34
 (1)     0x12   0x12  0x78  0x12  0x12
 (2)     0x78   0x78  0x12  0x78  0x78
 (3)     0x56   0x56  0x34  0x56  0x56
         ^^^^---^^^^ -------^^^^--^^^^--> these are correct
                      ^^^^--------------> this is wrong

So, the MPC3 example always writes correct data.

Hope it helps,
Juergen

=2D-=20
Pengutronix e.K.                              | Juergen Beisert            =
 |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228    =
 |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555=
 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/ =
 |
