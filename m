Message-ID: <36A0E079.F90619F5@jlc.net>
Date: Sat, 16 Jan 1999 13:54:50 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Johnnie Peters <jpeters@phx.mcd.mot.com>
CC: Michael Meissner <meissner@cygnus.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Cort Dougan <cort@persephone.cs.nmt.edu>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
References: <Pine.LNX.3.96.990113130844.3715A-100000@persephone.cs.nmt.edu> <369F5EB6.E34F17E8@mucmot.muenchen.europe.mcd.mot.com> <19990115165805.A28318@tiktok.cygnus.com> <369FF02B.8684CA2A@phx.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Johnnie Peters wrote:

> I think this is the same problem I was seeing.  This machine is also the known as
> the Utah.  I fixed this in arch/ppc/boot/misc.c.  Here is the diff:
>
> Michael Meissner wrote: 454c454
> <       if (( (unsigned long)zimage_start <= 0x01000000 ) && initrd_start)
> ---
> >       if ( (unsigned long)zimage_start <= 0x01000000 )

Wait a minute.....this isn't the problem.  Making this change will
break other machines.


> > > > }       loaded at:     00400400 00415FD0
> > > > }       relocated to:  00600000 00615BD0
> > > > }       zimage at:     0040A400 0049A889
> > > > }       avail ram:     00400000 00600000

For whatever reason, at the end of the memory relocation process,
we force the available ram buffer to the location above.  What happened
in this case is the load image was copied into memory into the space
we assumed was to be used for free memory.

This boot process has become a nightmare.  At first glance it looks
pretty generic, but it is full of assumptions about how specific types
of systems load images.  There are actually two different loading
locations, above 8 Meg (physical) for most machines or at exactly
2 Meg for small memory systems like the 8xx boards.  When you load
the initial image between these locations, as in this example, the boot
process is unlikely to work.

The initial boot code is built to run at either 1 Meg or 6 Meg.  When started
it relocates itself to those locations.  We should clean up the code in
misc.c to do something similar.  The only restriction in this case would be
the boot code (plus bss, which people often forget) must not overlap the
zImage or the ramdisk.  In other words, the correct thing to do is not
force the abosolute location of the free memory.  We already go through
the arithmetic to find some free memory, so why not just use it?

In this case, removing the fragment of code:

    #ifndef CONFIG_MBX
        /* this is safe, just use it */
        /* I don't know why it didn't work for me on the MBX with 20 MB
         * memory.  I guess something was saved up there, but I can't
         * figure it out......we are running on luck.  -- Dan.
         */
        avail_ram = (char *)0x00400000;
        end_avail = (char *)0x00600000;
#endif

would likely work.  Just change the #ifdef above to #if 0.  Let me know
what happens in this case.


Thanks.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
