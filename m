Return-Path: <stern+54ad1fae@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by lists.ozlabs.org (Postfix) with SMTP id 119E81A09CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 03:00:16 +1100 (AEDT)
Date: Mon, 5 Jan 2015 11:00:06 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
In-Reply-To: <66A26A9AA227D947AF088537F041526E2008FE@VSVR-EX10-MB1.pocatec.com>
Message-ID: <Pine.LNX.4.44L0.1501051045470.1485-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Mon, 5 Jan 2015, Michael Tessier wrote:

> > > Hi,
> > > 
> > > I am dealing with a USB EHCI driver bug. Here is the info:
> > > 
> > > My configuration:
> > > -----------------
> > > 
> > > Host: Freescale i.MX512 with ARM Cortex A8 (USB 2.0 host controller) 
> > > Linux kernel: 2.6.31, using EHCI USB driver
> >
> > As mentioned by other people, the age of that kernel makes any bug report completely irrelevant.  It's hard to count the number of non-trivial changes that have  > been made to the isochronous code in ehci-hcd since 2.6.31, but there have been quite a few.
> >
> > > Hub: 4-PORT USB 1.1 HUB (Texas Instruments PN: tusb2046b)
> > > Devices: 4 USB 1.1 audio codecs (Texas Instruments PN: pcm2901)
> > > 
> > > Note: each codec is being used in R/W access, so with 4 codecs, I have
> > > 4 playback and 4 capture streams.
> > > 
> > > My problem:
> > > -----------
> > > 
> > > I have usb urb leaks when connecting more than 1 codec to the USB 1.1 
> > > Hub.
> >
> > What do you mean by "urb leak"?  Normally, people use the word "leak"  
> > to refer to memory that is dynamically allocated and never deallocated, but you seem to mean something else.
> 
> You are right. What I mean by leak is the following: At application level,
> all my calls to "Read" or "Write" operation to the codec driver will return
> with the correct amount of bytes read/written, with a "choppy" sound. Then
> when looking at lower levels:
> 
> snd_pcm_oss_write (pcm_oss.c) 	-> OK
> snd_pcm_lib_write (pcm_lib.c) 	-> OK
> usb_submit_urb 	(urb.c)		-> FAIL with 3 codecs
> 
> The "FAIL" here indicates that the total amount of bytes transferred does
> not correspond to what was expected. And indeed the sound is "choppy" when
> using more than a certain amount of bandwidth. However this amount of
> bandwidth is higher when connecting only 1 codec with different settings
> (48khz-stereo 16-bits instead of 32 khz-mono 16-bits).So at some point it
> looks like the bug is in the scheduler, only with several isochronous links.

Agreed.

> > The amount of bandwidth available is usually not as much of an issue as the ability of the scheduling alogorithm to divide the bandwidth among the streams.  The
> > algorithm is not very smart and it often runs into a wall even when lots of physical bandwidth is still available.
> 
> That is interresting, however, I have an older kernel running an OHCI
> driver which is able to handle 4 codecs. Same usb hardware (codecs and
> hub), but older kernel on a different CPU, with much less power. This makes
> me believe that there's a solution to make it work...

Of course there is: Install an OHCI host controller and use it to drive
your codecs.  It should work fine.

The periodic scheduling algorithm for OHCI is very different from the
algorithm for EHCI.

> > How does your hardware connect the host controller to a full-speed device?  Is there an internal hub (Intel motherboards have used this approach)?  Is there a 
> > companion USB-1.1 controller (older motherboards from Intel and other companys have used this approach)?  Does the EHCI controller have a built-in Transaction 
> > Translator (some SOC systems use this approach)?
> 
> The CPU is a Freescale i.MX512, with 3 USB 2.0 Host controllers. My hub
> is connected to the main CPU board with a standard USB cable, so it's easy
> to swap my 4-port hub from a USB 1.1 to a USB 2.0. My codecs are always
> the same: USB 1.1 Texas Instruments PN# pcm2901. I don't believe there's
> a built-in Transaction Translator. How can I check that?

You can tell by seeing what shows up in the "lsusb -t" output when you
plug in the USB-1.1 hub.  If the hub's parent is the EHCI controller 
then there must be a built-in TT.

Also, if you enable CONFIG_USB_DEBUG in your kernel then the dmesg log
for boot-up should say whether or not the controller has a built-in TT.

> > > Question:
> > > ---------
> > > 
> > > Before attempting to upgrade to an earlier kernel driver (this is
> >
> > "upgrade to an earlier kernel driver" is a contradiction in terms.  
> > Moving to an earlier driver would be a _downgrade_.
> 
> Sorry, I meant to say "newer"...
> 
> > > a fairly big amount of work), I would really like to know if this 
> > > problem would still be in the 3.x kernels. Has anyone seen that issue 
> > > in 3.x kernels?
> >
> > It depends a lot on the system hardware.  Many people are using USB audio in 3.x kernels with no problem.  On the other hand, some people have reported a bug 
> > (quite different from yours) so recently that the patch to fix it has not yet been merged.
> 
> I understand. However, if one could test the following with a 3.x kernel:
> - CPU with USB 2.0 Host controller (using EHCI-hcd driver)
> - 4-port USB 1.1 Hub
> - 4x USB codecs (configured at 32khz-mono, 16-bits audio)
> 
> Then try to stream audio on each of the 4 codecs at the same time (this
> includes one Read and one Write stream on each codec, so total of 4 "Read"
> and 4 "Write" streams. Then listen to the output...

The result is likely to depend on what other USB hardware is attached.

> If sound is ok when using only 1 codec and becomes choppy when adding a
> second codec, then it means that this issue is still in the 3.x kernel. This
> answer will tell me if it is worth working on using a newer kernel or not.
> I have to say that I'm not a linux expert, so I see the migration to a newer
> kernel as a quite big amount of work...

Why don't you try this yourself?  It's easy to do; borrow a regular PC 
with a USB-2 host controller, boot it from a Live-CD version of Linux, 
plug in your hub with the codecs, and see what happens.

Alan Stern
