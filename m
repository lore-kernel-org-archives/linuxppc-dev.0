Message-Id: <200104092057.WAA00920@piglet.grunz.lu>
Date: Mon, 9 Apr 2001 22:57:30 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Serial console problems w/ 2.4.1
To: kevin_myer@iu13.k12.pa.us
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0104061050510.1481-100000@pegmatite.iu13.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On   6 Apr, this message from Kevin M. Myer echoed through cyberspace:
> I'm trying to boot an Apple Network Server using a serial console and am
> having trouble doing so.  I have no trouble getting Open Firmware output
> and input to go through the serial port but I can't get the machine to
> boot into Linux.  Originally, I had xmon support compiled in and when I
> would try to boot the kernel, I would get the following output over the
> serial line:
>
> ATZ1V1
> +++

I have the same problem, and haven't had time to investigate in detail.

The above 'text' are modem commands coming from xmon, because by default
xmon is configured to believe you have a modem attached there. I guess
another one of those 'features' we're getting blessed with because this
is what Paulus (author of xmon) uses at this time for his own
development, and this is what gets pusehed into his 'official' kernels.

Try setting via_modem to 0 in arch/ppc/xmon/start.c line 31. Also,
enabling early boot text console under general setup will show you on
screen at boot time what xmon will use to interact.

> I suspect that output is coming from xmon (not sure why) but I disabled
> that and now, there's nothing coming across the serial line.

It was xmon, indeed.

> For the kernel command line, I'm using <kernel-name> console=ttyS0,38400
>
> Open Firmware serial port settings are 38400,8N1,XON/XOFF (and I don't
> know how to change them).  Looking at the macserial driver, it appears to
> use those settings anyway.  Also looking at the driver, I see, at about
> line 2619:
>
> panic("macserial: console not supported yet !");
>
> It seems to be right in the middle of an initialization routine - is it
> really not supported?

At least it was in the past, and it is for me on 2.2 kernels. It wasn't,
however, at one time in the 2.3 kernels; but I believe that problem was
fixed ages ago? I'll re-check... (5 min later) No, that patch is
actually included with the later 2.4 kernels.

Also, I found that I needed to set the logging level differently with
2.4 kernels to get any output on the serial console:

/bin/dmesg -n 7

It seems to be at 0 by default??

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
