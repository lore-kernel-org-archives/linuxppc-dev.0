Return-Path: <prvs=441ccb01c=michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 6C2EA1A0928
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 03:40:11 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Tue, 6 Jan 2015 16:40:06 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E2009B9@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E2008FE@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1501051045470.1485-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1501051045470.1485-100000@iolanthe.rowland.org>
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

> > > > Hi,
> > > >=20
> > > > I am dealing with a USB EHCI driver bug. Here is the info:
> > > >=20
> > > > My configuration:
> > > > -----------------
> > > >=20
> > > > Host: Freescale i.MX512 with ARM Cortex A8 (USB 2.0 host=20
> > > > controller) Linux kernel: 2.6.31, using EHCI USB driver
> > >
> > > As mentioned by other people, the age of that kernel makes any bug re=
port completely irrelevant.  It's hard to count the number of non-trivial c=
hanges that have  > been made to the isochronous code in ehci-hcd since 2.6=
.31, but there have been quite a few.
> > >
> > > > Hub: 4-PORT USB 1.1 HUB (Texas Instruments PN: tusb2046b)
> > > > Devices: 4 USB 1.1 audio codecs (Texas Instruments PN: pcm2901)
> > > >=20
> > > > Note: each codec is being used in R/W access, so with 4 codecs, I=20
> > > > have
> > > > 4 playback and 4 capture streams.
> > > >=20
> > > > My problem:
> > > > -----------
> > > >=20
> > > > I have usb urb leaks when connecting more than 1 codec to the USB=20
> > > > 1.1 Hub.
> > >
> > > What do you mean by "urb leak"?  Normally, people use the word "leak"=
 =20
> > > to refer to memory that is dynamically allocated and never deallocate=
d, but you seem to mean something else.
> >=20
> > You are right. What I mean by leak is the following: At application=20
> > level, all my calls to "Read" or "Write" operation to the codec driver=
=20
> > will return with the correct amount of bytes read/written, with a=20
> > "choppy" sound. Then when looking at lower levels:
> >=20
> > snd_pcm_oss_write (pcm_oss.c)  -> OK
> > snd_pcm_lib_write (pcm_lib.c)  -> OK
> > usb_submit_urb  (urb.c)  -> FAIL with 3 codecs
> >=20
> > The "FAIL" here indicates that the total amount of bytes transferred=20
> > does not correspond to what was expected. And indeed the sound is=20
> > "choppy" when using more than a certain amount of bandwidth. However=20
> > this amount of bandwidth is higher when connecting only 1 codec with=20
> > different settings (48khz-stereo 16-bits instead of 32 khz-mono=20
> > 16-bits).So at some point it looks like the bug is in the scheduler, on=
ly with several isochronous links.
>=20
> Agreed.
>=20
> > > The amount of bandwidth available is usually not as much of an issue=
=20
> > > as the ability of the scheduling alogorithm to divide the bandwidth a=
mong the streams.  The algorithm is not very smart and it often runs into a=
 wall even when lots of physical bandwidth is still available.
> >=20
> > That is interresting, however, I have an older kernel running an OHCI=20
> > driver which is able to handle 4 codecs. Same usb hardware (codecs and=
=20
> > hub), but older kernel on a different CPU, with much less power. This=20
> > makes me believe that there's a solution to make it work...
>=20
> Of course there is: Install an OHCI host controller and use it to drive y=
our codecs.  It should work fine.
>=20
> The periodic scheduling algorithm for OHCI is very different from the alg=
orithm for EHCI.

According to your knowledge, how much time would you think it takes to
change the EHCI driver with an OHCI one? And can you tell if the OHCI drive=
r
will work on my hardware given that the Host controller of the i.MX512 is
a USB2.0 host controller? (OHCI was implemented for USB 1.x from what I
understand) I tried to do so several days ago with the built-in configurato=
r
(I am using "ltib"), but the configurator does not allow selecting the
OHCI driver; I tried manually but it turned into compiler errors...

>=20
> > > How does your hardware connect the host controller to a full-speed=20
> > > device?  Is there an internal hub (Intel motherboards have used this=
=20
> > > approach)?  Is there a companion USB-1.1 controller (older motherboar=
ds from Intel and other companys have used this approach)?  Does the EHCI c=
ontroller have a built-in Transaction Translator (some SOC systems use this=
 approach)?
> >=20
> > The CPU is a Freescale i.MX512, with 3 USB 2.0 Host controllers. My=20
> > hub is connected to the main CPU board with a standard USB cable, so=20
> > it's easy to swap my 4-port hub from a USB 1.1 to a USB 2.0. My codecs=
=20
> > are always the same: USB 1.1 Texas Instruments PN# pcm2901. I don't=20
> > believe there's a built-in Transaction Translator. How can I check that=
?
>=20
> You can tell by seeing what shows up in the "lsusb -t" output when you pl=
ug in the USB-1.1 hub.  If the hub's parent is the EHCI controller then the=
re must be a built-in TT.
>=20
> Also, if you enable CONFIG_USB_DEBUG in your kernel then the dmesg log fo=
r boot-up should say whether or not the controller has a built-in TT.
>=20
> > > > Question:
> > > > ---------
> > > >=20
> > > > Before attempting to upgrade to an earlier kernel driver (this is
> > >
> > > "upgrade to an earlier kernel driver" is a contradiction in terms. =20
> > > Moving to an earlier driver would be a _downgrade_.
> >=20
> > Sorry, I meant to say "newer"...
> >=20
> > > > a fairly big amount of work), I would really like to know if this=20
> > > > problem would still be in the 3.x kernels. Has anyone seen that=20
> > > > issue in 3.x kernels?
> > >
> > > It depends a lot on the system hardware.  Many people are using USB=20
> > > audio in 3.x kernels with no problem.  On the other hand, some people=
 have reported a bug (quite different from yours) so recently that the patc=
h to fix it has not yet been merged.
> >=20
> > I understand. However, if one could test the following with a 3.x kerne=
l:
> > - CPU with USB 2.0 Host controller (using EHCI-hcd driver)
> > - 4-port USB 1.1 Hub
> > - 4x USB codecs (configured at 32khz-mono, 16-bits audio)
> >=20
> > Then try to stream audio on each of the 4 codecs at the same time=20
> > (this includes one Read and one Write stream on each codec, so total of=
 4 "Read"
> > and 4 "Write" streams. Then listen to the output...
>=20
> The result is likely to depend on what other USB hardware is attached.
>=20
> > If sound is ok when using only 1 codec and becomes choppy when adding=20
> > a second codec, then it means that this issue is still in the 3.x=20
> > kernel. This answer will tell me if it is worth working on using a newe=
r kernel or not.
> > I have to say that I'm not a linux expert, so I see the migration to a=
=20
> > newer kernel as a quite big amount of work...
>=20
> Why don't you try this yourself?  It's easy to do; borrow a regular PC wi=
th a USB-2 host controller, boot it from a Live-CD version of Linux, plug i=
n your hub with the codecs, and see what happens.

Good point. I'll try that for sure. This will at least let me know if this
issue has been corrected in the latest kernel.

Michael Tessier
