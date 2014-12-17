Return-Path: <Peter.Chen@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0122.outbound.protection.outlook.com [207.46.100.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCEBF1A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 13:21:32 +1100 (AEDT)
From: Peter Chen <Peter.Chen@freescale.com>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Wed, 17 Dec 2014 02:21:24 +0000
Message-ID: <BN3PR0301MB0849131A4DE4D5E0E425C769816D0@BN3PR0301MB0849.namprd03.prod.outlook.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
In-Reply-To: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>=20
> My configuration:
> -----------------
>=20
> Host: Freescale i.MX512 with ARM Cortex A8 (USB 2.0 host controller) Linu=
x
> kernel: 2.6.31, using EHCI USB driver
> Hub: 4-PORT USB 1.1 HUB (Texas Instruments PN: tusb2046b)
> Devices: 4 USB 1.1 audio codecs (Texas Instruments PN: pcm2901)
>=20
> Note: each codec is being used in R/W access, so with 4 codecs, I have
> 4 playback and 4 capture streams.
>=20
> My problem:
> -----------
>=20
> I have usb urb leaks when connecting more than 1 codec to the USB 1.1 Hub=
.
> (the result is that some of the audio data is not transferred, part of th=
e sound is
> simply missing) No problem when using only 1 of the 4 codecs connected to=
 the
> hub; When I connect a second codec, the sound quality starts to degrade. =
With
> 3 codecs, we just cannot recognize a speach.
>=20
> Tests and observations:
> -----------------------
>=20
> Since I have 3 usb ports available on the i.MX512, I tried to connect
> 3 codecs directly on USB ports: the sound is perfect on each of the three=
 ports.
>=20
> I bought a consumer USB 2.0 Hub: no problem when using 3 codecs connected
> to that Hub, however, the audio will completly stop on all channels when
> connecting the 4th codec.
>=20
> I checked the communication between the Hub (USB 1.1) and the Host
> controller (USB 2.0) with a scope and concluded that the communication sp=
eed
> is 1.5 MBytes/s has expected (so the communication is downgraded to USB 1=
.1,
> since codecs and hub are USB
> 1.1 devices).
>=20
> Also, I know that there is physically enough bandwidth to transfer the da=
ta for
> two reasons:
> 1) I have an older CPU with a USB 1.1 host controller (using the OHCI dri=
ver),
> using the same hub and the same codecs: works like a champ, using less th=
an
> 50% of the available bandwidth (observed with a
> scope)
> 2) 1 audio stream is 32khz-mono, 16 bits =3D 64 kB/s,
> 4 codecs =3D 8 streams(R/W) x 64 kB/s =3D 512 kB/s (out of 1.5MB/s)
>=20
> I noticed that my sound problem starts happening with only 2 codecs
> (4 streams, 256 kB/s). I first thought that it was a bandwidth limitation=
, so I
> decided to connect only 1 codec using more bandwidth.
> I configured it to 48khz-stereo (16-bits), using 384 kB/s for both read a=
nd write
> streams: no problem. With that configuration, the scope shows about 30% o=
f
> total bandwidth usage (300us used out of 1ms periods). Then, I added a se=
cond
> codec (48khz-stereo-16bits): very strange, now the total bandwidth usage =
felt
> down to about 200us, which seems to keep the same, whatever the number of
> codec I add (I also tried 3 and 4...). So it looks like the scheduler is =
not able to
> properly allocate Isochronous time slots when more than one device is
> connected to the hub. However, without the hub, it works perfectly.
>=20

I am wonder if it is similar problem I met when using multiple interrupt tr=
ansfers,
when you find you lose the data, try to run 'top' to show cpu utilization, =
if it is
close to 100%, it means the ehci can't queue request in time, so the host c=
an't send IN
token in time.

Using a USB bus analyzer can also verify it.

Peter

> Another interresting fact is that at application level, the Read and Writ=
e
> operations are returning the good amount of bytes read/written.
> This is not the case at kernel level: I noticed that function "usb_submit=
_urb"
> (from /drivers/usb/core/urb.c) will only tranfer part of the "urbs" when =
the
> sound is degraded. I tried to figure out where the leak comes from withou=
t
> success. Also, there are no error messages from kernel so everything appe=
ars
> to work well, excepted that part of the sound is missing!
>=20
> I can't change my hardware (this is in the hand of customers), so the onl=
y
> possible solution for me is to correct the software.
>=20
> I tried to change my ehci driver with the one from kernel 2.6.39.4 but di=
d not
> work, same problem.
>=20
> Question:
> ---------
>=20
> Before attempting to upgrade to an earlier kernel driver (this is a fairl=
y big
> amount of work), I would really like to know if this problem would still =
be in the
> 3.x kernels. Has anyone seen that issue in 3.x kernels?
>=20
> I am pretty new to USB driver debugging, so any ideas of where/how to fin=
d
> solutions will be appreciated. Thank you very much in advance for the sup=
port.
> Also don't hesitate to redirect me if I'm not at the right place to ask t=
hese
> questions. I can also provide some code if someone need it to help.
>=20
> Attached is a dump of my "dmesg" after startup.
>=20
> Michael Tessier
>=20
>=20
>=20
>=20
>=20
>=20
