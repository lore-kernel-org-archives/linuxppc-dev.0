Message-ID: <389734F9.55CF7C4A@snom.de>
Date: Tue, 01 Feb 2000 20:33:13 +0100
From: Nicolas-Peter Pohland <pohland@snom.de>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: LiuTao <tliu@ict.ac.cn>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13: Now booting the kernel
References: <38910239.BFB31D0E@ctam.com.au> <3891367F.1F7C44C9@ict.ac.cn> <3894FE7F.523331D9@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan J Simon wrote:
>
> LiuTao wrote:
>
> > Hi Brendan:
> >
> > mpc8xx-2.2.13 still doesn't run on my board. I use emulator(EST tool)
> > to debug the system through JTAG port. I download the zImage to the
> > board, then run it. Something displayed on serial port:
> > loaded at:     00800000 0080B1C8
> > board data at: 00800158 00800180
> > relocated to:  007F0100 007F0128
> > zimage at:     00830263 0088A2B1
> > avail ram:     0088B000 01000000
> >
> > Linux/PPC load:
> > Uncompressing Linux...done.
> > Now booting the kernel
> >
> > Now, the program has unziped the image section(vmlinux) to 0x0,
> > then jump to 0x0 to enter the linux kernel. Then the program
> > call identify_machine() in head.S. Here, the problem happened.
> > Because the content in location of identify_machine() is not
> > correct. I don't know the reason. Maybe unzip has problem?
> > I sent help main to the maillist, but nobody give me any
> > suggestions.
> > My board is customed too. What kind of debug tool are you using
> > to debug linux on your board?

Hi guys,

I do not have the original message so pardon me for responding to this
one.
I had a similar problem at this location:

1. There were different versions of where the uncompressed kernel is
started from.
Once it was done directly from address 0 and the other time the content
of
location 0 was used. Make sure the arch/ppc/kernel and arch/ppc/mbxboot
directories
match regarding this point.

2. Make sure that the DER reg is set to 0 when using an emulator.
Especially
an ADI board for the FADS. For example "rms der 0".

I hope this helps,
Nicolas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
