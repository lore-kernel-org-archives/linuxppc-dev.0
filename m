Return-Path: <stern+5493f9d4@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by lists.ozlabs.org (Postfix) with SMTP id 7F13D1A0C5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 03:47:35 +1100 (AEDT)
Date: Wed, 17 Dec 2014 11:40:53 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: Re: PROBLEM: USB isochronous urb leak on EHCI driver
In-Reply-To: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
Message-ID: <Pine.LNX.4.44L0.1412171119590.2947-100000@netrider.rowland.org>
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

On Mon, 15 Dec 2014, Michael Tessier wrote:

> Hi,
> 
> I am dealing with a USB EHCI driver bug. Here is the info:
> 
> My configuration:
> -----------------
> 
> Host: Freescale i.MX512 with ARM Cortex A8 (USB 2.0 host controller)
> Linux kernel: 2.6.31, using EHCI USB driver

As mentioned by other people, the age of that kernel makes any bug
report completely irrelevant.  It's hard to count the number of
non-trivial changes that have been made to the isochronous code in 
ehci-hcd since 2.6.31, but there have been quite a few.

> Hub: 4-PORT USB 1.1 HUB (Texas Instruments PN: tusb2046b)
> Devices: 4 USB 1.1 audio codecs (Texas Instruments PN: pcm2901)
> 
> Note: each codec is being used in R/W access, so with 4 codecs, I have
> 4 playback and 4 capture streams.
> 
> My problem:
> -----------
> 
> I have usb urb leaks when connecting more than 1 codec to the USB 1.1
> Hub.

What do you mean by "urb leak"?  Normally, people use the word "leak"  
to refer to memory that is dynamically allocated and never deallocated,
but you seem to mean something else.

> (the result is that some of the audio data is not transferred,
> part of the sound is simply missing) No problem when using only 1
> of the 4 codecs connected to the hub; When I connect a second codec,
> the sound quality starts to degrade. With 3 codecs, we just cannot
> recognize a speach.
> 
> Tests and observations:
> -----------------------
> 
> Since I have 3 usb ports available on the i.MX512, I tried to connect
> 3 codecs directly on USB ports: the sound is perfect on each of the
> three ports.
> 
> I bought a consumer USB 2.0 Hub: no problem when using 3 codecs
> connected to that Hub, however, the audio will completly stop on all
> channels when connecting the 4th codec.

Above you said the sound started to degrade when the second codec was 
connected; here you say there is no problem when using 3 of them.  
Which is it?  Do you mean that the high-speed hub works better than the 
full-speed hub?

> I checked the communication between the Hub (USB 1.1) and the Host
> controller (USB 2.0) with a scope and concluded that the
> communication speed is 1.5 MBytes/s has expected (so the 
> communication is downgraded to USB 1.1, since codecs and hub are USB
> 1.1 devices).
> 
> Also, I know that there is physically enough bandwidth to
> transfer the data for two reasons:
> 1) I have an older CPU with a USB 1.1 host controller (using the OHCI
> driver), using the same hub and the same codecs: works like a champ,
> using less than 50% of the available bandwidth (observed with a
> scope)
> 2) 1 audio stream is 32khz-mono, 16 bits = 64 kB/s,
> 4 codecs = 8 streams(R/W) x 64 kB/s = 512 kB/s (out of 1.5MB/s)

The amount of bandwidth available is usually not as much of an issue as
the ability of the scheduling alogorithm to divide the bandwidth among
the streams.  The algorithm is not very smart and it often runs into a
wall even when lots of physical bandwidth is still available.

> I noticed that my sound problem starts happening with only 2 codecs
> (4 streams, 256 kB/s). I first thought that it was a bandwidth
> limitation, so I decided to connect only 1 codec using more bandwidth.
> I configured it to 48khz-stereo (16-bits), using 384 kB/s for both
> read and write streams: no problem. With that configuration, the 
> scope shows about 30% of total bandwidth usage (300us used out of 1ms
> periods). Then, I added a second codec (48khz-stereo-16bits): very
> strange, now the total bandwidth usage felt down to about 200us, which
> seems to keep the same, whatever the number of codec I add (I also
> tried 3 and 4...). So it looks like the scheduler is not able to
> properly allocate Isochronous time slots when more than one device is
> connected to the hub. However, without the hub, it works perfectly.

How does your hardware connect the host controller to a full-speed 
device?  Is there an internal hub (Intel motherboards have used this 
approach)?  Is there a companion USB-1.1 controller (older motherboards 
from Intel and other companys have used this approach)?  Does the EHCI 
controller have a built-in Transaction Translator (some SOC systems use 
this approach)?

> Another interresting fact is that at application level, the Read and
> Write operations are returning the good amount of bytes read/written.
> This is not the case at kernel level: I noticed that function
> "usb_submit_urb" (from /drivers/usb/core/urb.c) will only tranfer
> part of the "urbs" when the sound is degraded. I tried to figure out
> where the leak comes from without success. Also, there are no error
> messages from kernel so everything appears to work well, excepted
> that part of the sound is missing!
> 
> I can't change my hardware (this is in the hand of customers), so
> the only possible solution for me is to correct the software.
> 
> I tried to change my ehci driver with the one from kernel 2.6.39.4
> but did not work, same problem.
> 
> Question:
> ---------
> 
> Before attempting to upgrade to an earlier kernel driver (this is

"upgrade to an earlier kernel driver" is a contradiction in terms.  
Moving to an earlier driver would be a _downgrade_.

> a fairly big amount of work), I would really like to know if this
> problem would still be in the 3.x kernels. Has anyone seen that
> issue in 3.x kernels?

It depends a lot on the system hardware.  Many people are using USB
audio in 3.x kernels with no problem.  On the other hand, some people
have reported a bug (quite different from yours) so recently that the
patch to fix it has not yet been merged.

> I am pretty new to USB driver debugging, so any ideas of where/how
> to find solutions will be appreciated. Thank you very much in advance
> for the support. Also don't hesitate to redirect me if I'm not at the
> right place to ask these questions. I can also provide some code if
> someone need it to help.

Your first step should be to use an up-to-date kernel, as recommended 
by other people.

Alan Stern
