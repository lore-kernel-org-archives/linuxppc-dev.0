Message-ID: <XFMail.990118130140.gthomas@cygnus.co.uk>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <36A0E079.F90619F5@jlc.net>
Date: Mon, 18 Jan 1999 13:01:40 -0000 (GMT)
From: Gary Thomas <gthomas@cygnus.co.uk>
To: Dan Malek <dmalek@jlc.net>, Michael Meissner <meissner@cygnus.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu,
        Cort Dougan <cort@persephone.cs.nmt.edu>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Michael Meissner <meissner@cygnus.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 16-Jan-99 Dan Malek wrote:
> 
> Johnnie Peters wrote:
> 
>> I think this is the same problem I was seeing.  This machine is also the known as
>> the Utah.  I fixed this in arch/ppc/boot/misc.c.  Here is the diff:
>>
>> Michael Meissner wrote: 454c454
>> <       if (( (unsigned long)zimage_start <= 0x01000000 ) && initrd_start)
>> ---
>> >       if ( (unsigned long)zimage_start <= 0x01000000 )
> 
> Wait a minute.....this isn't the problem.  Making this change will
> break other machines.
> 
> 
>> > > > }       loaded at:     00400400 00415FD0
>> > > > }       relocated to:  00600000 00615BD0
>> > > > }       zimage at:     0040A400 0049A889
>> > > > }       avail ram:     00400000 00600000
> 
> For whatever reason, at the end of the memory relocation process,
> we force the available ram buffer to the location above.  What happened
> in this case is the load image was copied into memory into the space
> we assumed was to be used for free memory.
> 
> This boot process has become a nightmare.  At first glance it looks
> pretty generic, but it is full of assumptions about how specific types
> of systems load images.  There are actually two different loading
> locations, above 8 Meg (physical) for most machines or at exactly
> 2 Meg for small memory systems like the 8xx boards.  When you load
> the initial image between these locations, as in this example, the boot
> process is unlikely to work.
> 
> The initial boot code is built to run at either 1 Meg or 6 Meg.  When started
> it relocates itself to those locations.  We should clean up the code in
> misc.c to do something similar.  The only restriction in this case would be
> the boot code (plus bss, which people often forget) must not overlap the
> zImage or the ramdisk.  In other words, the correct thing to do is not
> force the abosolute location of the free memory.  We already go through
> the arithmetic to find some free memory, so why not just use it?
> 
> In this case, removing the fragment of code:
> 
>     #ifndef CONFIG_MBX
>         /* this is safe, just use it */
>         /* I don't know why it didn't work for me on the MBX with 20 MB
>          * memory.  I guess something was saved up there, but I can't
>          * figure it out......we are running on luck.  -- Dan.
>          */
>         avail_ram = (char *)0x00400000;
>         end_avail = (char *)0x00600000;
>#endif
> 
> would likely work.  Just change the #ifdef above to #if 0.  Let me know
> what happens in this case.
> 
> 
> Thanks.
> 
> 
>     -- Dan

Here's what I got to work (patches):

diff -ur /tmp/linux-2.2.0p5/arch/ppc/boot/misc.c /usr/src/linux-2.2.0p5/arch/ppc/boot/misc.c
--- /tmp/linux-2.2.0p5/arch/ppc/boot/misc.c     Mon Dec 21 16:37:20 1998
+++ /usr/src/linux-2.2.0p5/arch/ppc/boot/misc.c Sun Jan 17 12:15:03 1999
@@ -411,7 +417,7 @@
        if ( INITRD_OFFSET )
                end_avail = (char *)0x01000000;
        else
-               end_avail = (char *)0x00400000;
+               end_avail = (char *)0x00800000;
 
        /* let residual data tell us it's higher */
        if ( (unsigned long)residual > 0x00800000 )
@@ -522,6 +528,7 @@
 
 #ifndef CONFIG_MBX
        /* this is safe, just use it */
+#if 0 /* Hah!  This is really wrong on PreP boxes with OF */
        /* I don't know why it didn't work for me on the MBX with 20 MB
         * memory.  I guess something was saved up there, but I can't
         * figure it out......we are running on luck.  -- Dan.
@@ -529,6 +536,7 @@
        avail_ram = (char *)0x00400000;
        end_avail = (char *)0x00600000;
 #endif
+#endif
        puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
        puthex((unsigned long)end_avail); puts("\n");
 
I'll try upgrading to 2.2.0p7 tonight and see how that works.

I haven't been able to get the PS/2 mouse working yet.  Also, I'll try to stitch
in the code I had in the 2.0.XX kernels to handle/fake residual data on the PreP
boxes - so I can have my 64M RAM back :-)

Please note: I'm either 'gthomas@cygnus.co.uk' or 'gdt@linuxppc.org', not 'gdt@cygnus.com'.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
