Date: Mon, 13 Mar 2000 18:02:42 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work
 onppcwithr128
In-Reply-To: <Pine.LNX.4.21.0003131530380.1561-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10003131729540.1152-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > We'll see if that's a problem; right now it hangs earlier.
> >
>
>   Earlier than what ? The Xserver does its pci magic (badly in this
> case it seems) very early, by the time you reach fbdevHWModeInit
> its already done.

Earlier than screen init. fbScreenInit is what I get stuck at after
bypassing the ioctl.

> > > The PCI warnings that you get most likely will tell us where the problem
> > > is, can you send the logfile over ?
> >
> > Relevant log excerpt:
> >
> > (II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
> > (II) Module fbdevhw: vendor="The XFree86 Project"
> > 	compiled for 4.0, module version = 0.0.1
> > (II) FBDev(1): using default device
> > (**) FBDev(1): claimed PCI slot 0:17:0
> > (WW) ****INVALID MEM ALLOCATION**** b: 0x81000000 e: 0x81ffffff correcting
> > own
> >         [0] -1  0x81fff000 - 0x81ffffff (0x1000) MXB
> > 	[1] -1  0x00000c00 - 0x00000cff (0x100) IXB
> > (WW) ****INVALID IO ALLOCATION**** b: 0xc00 e: 0xcff correcting
>
>     Here is the problem, for some reason the xserver doesn't like
> the pci mem/io mappings for the card and "corrects" them :(

The PCI mappings should not prevent the fb ioctls from working. Anyway I
can try to mess with the code to leave the mapping untouched.

There's a lot more going on: in 32 bit mode the X server complains about
invalid weight (000) and refuses to probe OK. In 16 bit mode some part of
the server assumes 565 bit weighting but the kernel code only ever sees
000. I'm a bit confused here. In 8 bit mode, I get the X server to print a
message like:

fbdev trace: FBDevScreenInit: before screeninit8/16/32
fbdevHW: fbScreenInit: before fbSetupScreen 		< my trace message


	This should not happen!
	An unresolved function was called!

That's in programs/Xserver/fb/fbscreen.c. fbSetupScreen ought to print
another message on entry but that never happens. fbSetupScreen is defined
in the very same source file. Funny.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
