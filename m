Message-Id: <4.2.2.20000306113008.00a67be0@mail.kerbango.com>
Date: Mon, 06 Mar 2000 11:45:19 -0800
To: Brad Parker <brad@parker.boston.ma.us>, Brad Hards <bradh@dynamite.com.au>
From: Steve Calfee <calfee@kerbango.com>
Subject: Re: commproc.c
Cc: Björn Lundberg <bjorn.lundberg@inu.se>,
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200003061622.LAA34076@p2.parker.boston.ma.us>
References: <Your message of "Sun, 05 Mar 2000 15:58:44 GMT." <38C28434.E79774E6@dynamite.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:22 AM 3/6/00 -0500, Brad Parker wrote:


>Brad Hards wrote:
>...
> >The 850 Users Manual contains info (including how to program) on the USB
> >host as part of CPM doco - it is chapter 32, and has been recently
> >updated:
> >http://www.mot.com/SPS/RISC/netcomm/aesop/mpc8XX/850/32_USB.pdf
> >
> >The whole users manual is linked off:
> >http://www.mot.com/SPS/RISC/netcomm/docs/pubs/850UM.html
>
>I beg to differ - the docs don't really cover host mode at all and
>don't explain a number of things you might need to know to make it
>work.  I've sent feedback to MOT about this already.  The docs are
>really minimal and not very helpful for host mode.  They are just
>barely enough for function mode.
>
>-brad
I eagerly read these docs, but they just repeat the info in the PPC 823
manual.

The whole USB host architecture is bizarre, it looks like it was crafted by
someone who understood uarts and serial I/O very well, but USB only
marginally. For example, the idea of having separate areas for receive and
transmit BDs, for a host controlled half-duplex communication line adds
complexity and makes no sense. At least you can get around it in software.
Also, the idea that a NAK or STAL is an error that should stop transmission
of a BD list is a major roadblock to getting any bandwidth out of the USB
Bus. Right now I am trying to figure out why I don't get a TX interrupt
after sending a IN PID with the I bit set in the BD.....

Software timers for SOF can get to USB spec +- .5 microseconds 99.9% of the
time (NFS shuts off interrupts for long periods of time occasionally). The
SOF timing will probably be good enough for most devices. Philips audio
Isochronous devices require +- 1 USB bit times (=1/12,000,000=.083
microseconds), too tight for Linux timer interrupts.

Enough complaining, I am convinced that a reasonably functional USB host
stack is possible.

Steve

Steve Calfee	--	embedded systems consultant
calfee@home.com
Kerbango phone: (408) 517-3355
home office ph: (510) 657-6039


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
