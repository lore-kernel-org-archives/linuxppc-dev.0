Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75E042C00E1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 00:15:13 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Saravanan S <sarans1987@gmail.com>
Subject: RE: Standalone SRIO Driver for Linux
Date: Mon, 16 Jul 2012 14:15:06 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D10287EC@corpmail1.na.ads.idt.com>
References: <CAEqOc-QpXcwbLuJXLbGv3VgccKnkMrdGV+ZdwFaFZCzjG3K7Mw@mail.gmail.com>
 <8D983423E7EDF846BB3056827B8CC5D10285E9@corpmail1.na.ads.idt.com>
 <CAEqOc-QzeNz0z33yegaa-9FVpbcCUaMix4-Gfkn0P8Y3487YsA@mail.gmail.com>
In-Reply-To: <CAEqOc-QzeNz0z33yegaa-9FVpbcCUaMix4-Gfkn0P8Y3487YsA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

With current way of device reporting in RapidIO subsystem you will need
to have at least one SRIO device (switch or EP) attached to your mport
to be able to find a reference to that mport device object. Like in the cod=
e fragment below:

static int rioport_init_module(void)
{
	int ret, i;
	dev_t dev =3D 0;
	struct rio_mport *mport;
	struct rio_net *net;
	struct rio_dev *rdev =3D NULL;
	struct rio_mport *port;

... skip ...

	rdev =3D rio_get_device(RIO_ANY_ID, RIO_ANY_ID, rdev);
	if (NULL =3D=3D rdev)
		return -ENODEV;

	mport =3D rdev->net->hport;
	net =3D rdev->net;
... skip ...
}

I would like to mention that 2.6.34 kernel is quite behind on rapidio suppo=
rt updates.
There are multiple changes/updates added added since 2.6.34.
You may consider backporting these updates to your kernel version
if you are unable to use one of the latest kernel versions.

Alex.


From: Saravanan S [mailto:sarans1987@gmail.com]=20
Sent: Saturday, July 14, 2012 2:25 AM
To: Bounine, Alexandre
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Standalone SRIO Driver for Linux

Hi ,
=A0 =A0 =A0Thanks for the reply . i will try to share some of my code later=
 . Looking forward to ur ideas.=A0

Regards,

S.Saravanan
On Fri, Jul 13, 2012 at 6:18 PM, Bounine, Alexandre <Alexandre.Bounine@idt.=
com> wrote:
This should work. We use similar approach to test our mport HW drivers.
=A0
Alex.
=A0
From: Linuxppc-dev [mailto:linuxppc-dev-bounces+alexandre.bounine=3Didt.com=
@lists.ozlabs.org] On Behalf Of Saravanan S
Sent: Friday, July 13, 2012 2:16 AM
To: linuxppc-dev@lists.ozlabs.org
Subject: Standalone SRIO Driver for Linux
=A0
Hi ,

=A0=A0=A0=A0=A0 Iam currently working on the GE make DSP230 board consistin=
g of Quad PowerPC8640 nodes =A0 interconnected by SRIO with Linux 2.6.34 . =
However the only way to access the SRIO is through rionet facility . Our re=
quirement is to use the SRIO interconnect without the Ethernet overheads. T=
his would definitely enable higher speeds (though I cant find any throughpu=
t figures for SRIO in Linux on the net ??? ).=A0 My query is that whether a=
ny attempt has been made=A0 to develop a=A0 standalone driver and API to ac=
cess the messaging=A0 and doorbell services of SRIO . If no then request yo=
u to please provide inputs on the same. From my study I have the following =
thoughts for the driver :

a) Have a character device interface for user .
b) Basically use the rio support functions provided in rio.c like=A0 rio_ad=
d_inb_buffer ,=A0 rio_add_outb_message to transfer and receive messages and=
 add buffers .
c) Maintain a dedicated ring of buffers in the driver and transfer=A0 data =
to and from the buffer to user space .


Is this the right direction . Would really appreciate any inputs . thanks i=
n advance.

Regards,

S.Saravanan

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
