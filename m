Return-Path: <michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CB281A0109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 01:06:34 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Peter Chen <Peter.Chen@freescale.com>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Wed, 17 Dec 2014 14:06:07 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E1FF598@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
 <BN3PR0301MB0849131A4DE4D5E0E425C769816D0@BN3PR0301MB0849.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR0301MB0849131A4DE4D5E0E425C769816D0@BN3PR0301MB0849.namprd03.prod.outlook.com>
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

>>=20
>> My configuration:
>> -----------------
>>=20
>> Host: Freescale i.MX512 with ARM Cortex A8 (USB 2.0 host controller)=20
>> Linux
>> kernel: 2.6.31, using EHCI USB driver
>> Hub: 4-PORT USB 1.1 HUB (Texas Instruments PN: tusb2046b)
>> Devices: 4 USB 1.1 audio codecs (Texas Instruments PN: pcm2901)
>>=20
>> Note: each codec is being used in R/W access, so with 4 codecs, I have
>> 4 playback and 4 capture streams.
>>=20
>> My problem:
>> -----------
>>=20
>> I have usb urb leaks when connecting more than 1 codec to the USB 1.1 Hu=
b.
>> (the result is that some of the audio data is not transferred, part of=20
>> the sound is simply missing) No problem when using only 1 of the 4=20
>> codecs connected to the hub; When I connect a second codec, the sound=20
>> quality starts to degrade. With
>> 3 codecs, we just cannot recognize a speach.
>>=20
>> Tests and observations:
>> -----------------------
>>=20
>> Since I have 3 usb ports available on the i.MX512, I tried to connect
>> 3 codecs directly on USB ports: the sound is perfect on each of the thre=
e ports.
>>=20
>> I bought a consumer USB 2.0 Hub: no problem when using 3 codecs=20
>> connected to that Hub, however, the audio will completly stop on all=20
>> channels when connecting the 4th codec.
>>=20
>> I checked the communication between the Hub (USB 1.1) and the Host=20
>> controller (USB 2.0) with a scope and concluded that the communication=20
>> speed is 1.5 MBytes/s has expected (so the communication is downgraded=20
>> to USB 1.1, since codecs and hub are USB
>> 1.1 devices).
>>=20
>> Also, I know that there is physically enough bandwidth to transfer the=20
>> data for two reasons:
>> 1) I have an older CPU with a USB 1.1 host controller (using the OHCI=20
>> driver), using the same hub and the same codecs: works like a champ,=20
>> using less than 50% of the available bandwidth (observed with a
>> scope)
>> 2) 1 audio stream is 32khz-mono, 16 bits =3D 64 kB/s,
>> 4 codecs =3D 8 streams(R/W) x 64 kB/s =3D 512 kB/s (out of 1.5MB/s)
>>=20
>> I noticed that my sound problem starts happening with only 2 codecs
>> (4 streams, 256 kB/s). I first thought that it was a bandwidth=20
>> limitation, so I decided to connect only 1 codec using more bandwidth.
>> I configured it to 48khz-stereo (16-bits), using 384 kB/s for both=20
>> read and write
>> streams: no problem. With that configuration, the scope shows about=20
>> 30% of total bandwidth usage (300us used out of 1ms periods). Then, I=20
>> added a second codec (48khz-stereo-16bits): very strange, now the=20
>> total bandwidth usage felt down to about 200us, which seems to keep=20
>> the same, whatever the number of codec I add (I also tried 3 and=20
>> 4...). So it looks like the scheduler is not able to properly allocate=20
>> Isochronous time slots when more than one device is connected to the
>> hub. However, without the hub, it works perfectly.
>>=20
>
> I am wonder if it is similar problem I met when using multiple interrupt =
transfers, when you find you lose the data, try to run 'top' to show cpu ut=
ilization, if > it is close to 100%, it means the ehci can't queue request =
in time, so the host can't send IN token in time.
>
> Using a USB bus analyzer can also verify it.
>
> Peter

Thanks Peter, I did it, the CPU usage varies between 0% and 4% so this is n=
ot the case here.
