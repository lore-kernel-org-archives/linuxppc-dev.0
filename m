Message-ID: <36795B47.12AFC358@jlc.net>
Date: Thu, 17 Dec 1998 14:28:07 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems starting up system on a MPC823FADS
References: <H0000b360900f795@MHS> <3678D608.D37B7D6E@siemens.at>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Helmut Buchsbaum wrote:

> I've done some configuration changes, too.....
> ......... So I'd be interested in your
> configurational changes!

Almost all of CONFIG_MBX has become a generic
CONFIG_8xx #define.  Instead of having files include
board specific information (like asm/mbx.h or asm/fads.h)
they now just include asm/mpc8xx.h and this file has
the board specific CONFIG_xxx stuff in them.

I am also going to reconfigure the processors so their
IMMRs are all the same at boot time.  Then all that
remains are board specific I/O addresses.  This should
allow any 8xx board to be quickly ported, then you can
add the unique I/O in the warm and fuzzy feeling that
you can at least boot a kernel.


> ...discovered erratic behaviour when using the data cache of my MPC823.

Damn....there are lots of weird silicon bug surrounding the data cache.
I have the code that will work around most of them, but I have not
yet seen anything that runs differently whether or not I include
these changes.  The 860 is affected the worst, and at _exactly_
50 MHz and _exactly_ 3.3 volts.  If you move away from that
the problems disappear more than exponentially.  Try running 40 MHz
if you can.


> .........I turned off any cache and - wow - my
> data were consistent again!

Good idea.  That is usually the first thing I do.  I don't know
what the default cache mode is in the code right now.
Cort and I keep playing with it.  I have some running with
full copyback enabled.....really nice :-).


> Nevertheless my MPC823FADS refuses to
> execute /sbin/init, but since my confidence in MPC823 Rev.0 (!!!)
> vanished completely, ....

I hope the processor upgrade helps, but I have the same
problem on the 860T/FADS sometimes as well.


> ........ My
> MPC8BUG refuses to download that section, it just silently ignores it. I
> circumvented this problem by compiling in the image via 'od' and 'sed'
> magic....

That is the only way.  This is why I dislike the FADS boards.
I spend way too much time developing tools and no time developing
the project software.  I used my FADS board to do some simple
testing, primarily for developing the UPM programming for
the 100 MHz SDRAMs.  I was using the ADI connection to
a WinBlows machine that crashed more often than the code
I was writing on the 860.  I got pissed, reprogrammed the
Mach part to provide an 8-bit boot interface, soldered a
Flash prom socket on the board and bought a ROM simulator
to plug into it.  This is why my fadsrom file on the server
has programs to build S-records and funky format binaries
for downloading into it.  I then wrote the rom code to load
bits from the PCMCIA flash card, and the development
path was compile on the PowerBook and blast the ELF
image to the PCMCIA card.  So, weeks later I was
finally able to write the FEC driver I needed for the 860T.
Once I got a different 860T board, that FADS thing nearly
went to the trash bin.....if it wouldn't have cost so much.....

It is just easier and less expensive to use other types
of boards these days.......something that can actually
load software minutes after you plug it in.......


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
