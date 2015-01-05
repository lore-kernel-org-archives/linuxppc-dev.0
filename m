Return-Path: <michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 01E3A1A0993
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 02:12:42 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Mon, 5 Jan 2015 15:12:37 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E2008FE@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1412171119590.2947-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1412171119590.2947-100000@netrider.rowland.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On Mon, 15 Dec 2014, Michael Tessier wrote:
>
> > Hi,
> >=20
> > I am dealing with a USB EHCI driver bug. Here is the info:
> >=20
> > My configuration:
> > -----------------
> >=20
> > Host: Freescale i.MX512 with ARM Cortex A8 (USB 2.0 host controller)=20
> > Linux kernel: 2.6.31, using EHCI USB driver
>
> As mentioned by other people, the age of that kernel makes any bug report=
 completely irrelevant.  It's hard to count the number of non-trivial chang=
es that have  > been made to the isochronous code in ehci-hcd since 2.6.31,=
 but there have been quite a few.
>
> > Hub: 4-PORT USB 1.1 HUB (Texas Instruments PN: tusb2046b)
> > Devices: 4 USB 1.1 audio codecs (Texas Instruments PN: pcm2901)
> >=20
> > Note: each codec is being used in R/W access, so with 4 codecs, I have
> > 4 playback and 4 capture streams.
> >=20
> > My problem:
> > -----------
> >=20
> > I have usb urb leaks when connecting more than 1 codec to the USB 1.1=20
> > Hub.
>
> What do you mean by "urb leak"?  Normally, people use the word "leak" =20
> to refer to memory that is dynamically allocated and never deallocated, b=
ut you seem to mean something else.

You are right. What I mean by leak is the following: At application level,
all my calls to "Read" or "Write" operation to the codec driver will return
with the correct amount of bytes read/written, with a "choppy" sound. Then
when looking at lower levels:

snd_pcm_oss_write (pcm_oss.c) 	-> OK
snd_pcm_lib_write (pcm_lib.c) 	-> OK
usb_submit_urb 	(urb.c)		-> FAIL with 3 codecs

The "FAIL" here indicates that the total amount of bytes transferred does
not correspond to what was expected. And indeed the sound is "choppy" when
using more than a certain amount of bandwidth. However this amount of
bandwidth is higher when connecting only 1 codec with different settings
(48khz-stereo 16-bits instead of 32 khz-mono 16-bits).So at some point it
looks like the bug is in the scheduler, only with several isochronous links=
.

>
> > (the result is that some of the audio data is not transferred, part of=
=20
> > the sound is simply missing) No problem when using only 1 of the 4=20
> > codecs connected to the hub; When I connect a second codec, the sound=20
> > quality starts to degrade. With 3 codecs, we just cannot recognize a=20
> > speach.
> >=20
> > Tests and observations:
> > -----------------------
> >=20
> > Since I have 3 usb ports available on the i.MX512, I tried to connect
> > 3 codecs directly on USB ports: the sound is perfect on each of the=20
> > three ports.
> >=20
> > I bought a consumer USB 2.0 Hub: no problem when using 3 codecs=20
> > connected to that Hub, however, the audio will completly stop on all=20
> > channels when connecting the 4th codec.
>
> Above you said the sound started to degrade when the second codec was con=
nected; here you say there is no problem when using 3 of them. =20
> Which is it?  Do you mean that the high-speed hub works better than the f=
ull-speed hub?
>
Yes, that's it. Using the high-speed hub will allow for more data throughpu=
t
before starting to "miss" some usb packets (and result in a choppy sound).

> > I checked the communication between the Hub (USB 1.1) and the Host=20
> > controller (USB 2.0) with a scope and concluded that the communication=
=20
> > speed is 1.5 MBytes/s has expected (so the communication is downgraded=
=20
> > to USB 1.1, since codecs and hub are USB
> > 1.1 devices).
> >=20
> > Also, I know that there is physically enough bandwidth to transfer the=
=20
> > data for two reasons:
> > 1) I have an older CPU with a USB 1.1 host controller (using the OHCI=20
> > driver), using the same hub and the same codecs: works like a champ,=20
> > using less than 50% of the available bandwidth (observed with a
> > scope)
> > 2) 1 audio stream is 32khz-mono, 16 bits =3D 64 kB/s,
> > 4 codecs =3D 8 streams(R/W) x 64 kB/s =3D 512 kB/s (out of 1.5MB/s)
>
> The amount of bandwidth available is usually not as much of an issue as t=
he ability of the scheduling alogorithm to divide the bandwidth among the s=
treams.  The
> algorithm is not very smart and it often runs into a wall even when lots =
of physical bandwidth is still available.

That is interresting, however, I have an older kernel running an OHCI
driver which is able to handle 4 codecs. Same usb hardware (codecs and
hub), but older kernel on a different CPU, with much less power. This makes
me believe that there's a solution to make it work...

> > I noticed that my sound problem starts happening with only 2 codecs
> > (4 streams, 256 kB/s). I first thought that it was a bandwidth=20
> > limitation, so I decided to connect only 1 codec using more bandwidth.
> > I configured it to 48khz-stereo (16-bits), using 384 kB/s for both=20
> > read and write streams: no problem. With that configuration, the scope=
=20
> > shows about 30% of total bandwidth usage (300us used out of 1ms=20
> > periods). Then, I added a second codec (48khz-stereo-16bits): very=20
> > strange, now the total bandwidth usage felt down to about 200us, which=
=20
> > seems to keep the same, whatever the number of codec I add (I also=20
> > tried 3 and 4...). So it looks like the scheduler is not able to=20
> > properly allocate Isochronous time slots when more than one device is=20
> > connected to the hub. However, without the hub, it works perfectly.
>
> How does your hardware connect the host controller to a full-speed device=
?  Is there an internal hub (Intel motherboards have used this approach)?  =
Is there a=20
> companion USB-1.1 controller (older motherboards from Intel and other com=
panys have used this approach)?  Does the EHCI controller have a built-in T=
ransaction=20
> Translator (some SOC systems use this approach)?

The CPU is a Freescale i.MX512, with 3 USB 2.0 Host controllers. My hub
is connected to the main CPU board with a standard USB cable, so it's easy
to swap my 4-port hub from a USB 1.1 to a USB 2.0. My codecs are always
the same: USB 1.1 Texas Instruments PN# pcm2901. I don't believe there's
a built-in Transaction Translator. How can I check that?

> > Another interresting fact is that at application level, the Read and=20
> > Write operations are returning the good amount of bytes read/written.
> > This is not the case at kernel level: I noticed that function=20
> > "usb_submit_urb" (from /drivers/usb/core/urb.c) will only tranfer part=
=20
> > of the "urbs" when the sound is degraded. I tried to figure out where=20
> > the leak comes from without success. Also, there are no error messages=
=20
> > from kernel so everything appears to work well, excepted that part of=20
> > the sound is missing!
> >=20
> > I can't change my hardware (this is in the hand of customers), so the=20
> > only possible solution for me is to correct the software.
> >=20
> > I tried to change my ehci driver with the one from kernel 2.6.39.4 but=
=20
> > did not work, same problem.
> >=20
> > Question:
> > ---------
> >=20
> > Before attempting to upgrade to an earlier kernel driver (this is
>
> "upgrade to an earlier kernel driver" is a contradiction in terms. =20
> Moving to an earlier driver would be a _downgrade_.

Sorry, I meant to say "newer"...

> > a fairly big amount of work), I would really like to know if this=20
> > problem would still be in the 3.x kernels. Has anyone seen that issue=20
> > in 3.x kernels?
>
> It depends a lot on the system hardware.  Many people are using USB audio=
 in 3.x kernels with no problem.  On the other hand, some people have repor=
ted a bug=20
> (quite different from yours) so recently that the patch to fix it has not=
 yet been merged.

I understand. However, if one could test the following with a 3.x kernel:
- CPU with USB 2.0 Host controller (using EHCI-hcd driver)
- 4-port USB 1.1 Hub
- 4x USB codecs (configured at 32khz-mono, 16-bits audio)

Then try to stream audio on each of the 4 codecs at the same time (this
includes one Read and one Write stream on each codec, so total of 4 "Read"
and 4 "Write" streams. Then listen to the output...

If sound is ok when using only 1 codec and becomes choppy when adding a
second codec, then it means that this issue is still in the 3.x kernel. Thi=
s
answer will tell me if it is worth working on using a newer kernel or not.
I have to say that I'm not a linux expert, so I see the migration to a newe=
r
kernel as a quite big amount of work...

> > I am pretty new to USB driver debugging, so any ideas of where/how to=20
> > find solutions will be appreciated. Thank you very much in advance for=
=20
> > the support. Also don't hesitate to redirect me if I'm not at the=20
> > right place to ask these questions. I can also provide some code if=20
> > someone need it to help.
>
> Your first step should be to use an up-to-date kernel, as recommended by =
other people.
>
> Alan Stern

Thank you for your prompt response.

Michael Tessier
