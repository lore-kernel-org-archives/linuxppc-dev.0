Date: Fri, 5 Feb 1999 08:08:33 -0600 (CST)
Message-Id: <v03110700b2e0568f1bac@[129.59.235.1]>
In-Reply-To: <XFMail.990204091831.frank.pierce@hedb.uib.no>
References: <v03110700b2ddf6681e95@[129.59.235.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: frank.pierce@hedb.uib.no, <linuxppc-dev@lists.linuxppc.org>
From: "Marcus H. Mendenhall" <marcus.h.mendenhall@vanderbilt.edu>
Subject: RE: Many random crashes in 2.2.0 (and previous kernels)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, I checked.  On my machine the cache is fine, according to cpuinfo :

here is cat /proc/cpuinfo:

processor	: 0
cpu		: 750
temperature 	: 0 C
clock		: 300MHz
revision	: 2.2
bogomips	: 601.29
zero pages	: total 0 (0Kb) current: 0 (0Kb) hits: 0/148 (0%)
machine		: Power Macintosh
motherboard	: AAPL,Gossamer MacRISC
L2 cache	: 1024K unified pipelined-syncro-burst
memory		: 128MB

Does you machine actually have an L2 cache?  It seems as if the cache
problem on your PCPro machine may be a red herring with respect to the
crashing.

Has anyone else out these been having this problem?  From the lack of any
other responses, it seems that I am almost the only one.  Are other people
running on machines similar to this one (rev 2 G3 300 MHz) successfully?  I
would like some feed back from successes and failures so that I can try to
isolate what it is that is different about my machine and poke directly at
that part of the kernel.  The crashes are just infrequent enough to make
debugging difficult (low data rate), but frequent enough to make serious
use difficult.

Thanks.

Marcus Mendenhall


>I have had the same craches on a PowerCenterPro. Looking in
>/proc/cpuinfo I see that the L2 cache is not registered. I
>was thinking it could have something to do with that since
>the I have virtually the same system on the pb3400c which
>works just fine.
>
>
>Im running the 2.2.0 kernel from kernel.org and R5
>
>
>On
>03-Feb-99 Marcus H. Mendenhall wrote:
>>
>> To the list:
>>
>> I have been experiencing many random kernel panics in all
>> kernels since
>> sometime around the 2.1.100's.  The panics happen at
>> times of high disk
>> activity (process creation, termination, system startup &
>> shutdown).
>> Kernels which have exhibited this have been both stock,
>> precompiled kernels
>> from samba.anu.edu.au and home built kernels, using vger
>> and kernel.org
>> sources.  I have applied Loic Prylli's arch/ppc/mm/init.c
>> patch, which made
>> no obvious difference.
>>
>> Here is my system:
>> PowerMac G3 rev 2 300 MHz, BMAC ethernet, 128 MB RAM, 64
>> MB swap, using
>> internal IDE disk, Mac keyboard, 19" monitor on
>> ATY,Mach3DUPro display.
>> The machine shows no signs of instability running MacOS.
>>
>> The errors have happened using older non-fb video and
>> current fb video,
>> with or without X running, with or without atalkd & papd
>> running.
>>
>> The error often occurs as a bad object or bad area panic.
>> Often, the bad
>> object is mm->pgd.  For the last few days I have been
>> looking into the
>> slices of the kernel from which most of these emanate.
>> Unfortunately, I
>> have only collected partial tracebacks since the 180
>> second autoreboot
>> doesn't give be time to write everything down.  I don't
>> have another
>> machine handy to use a serial console.  I may have to
>> lengthen the time
>> before autoreboot soon. :-(
>>
>> One of the faults comes from mm/slab.c kmem_cache_free.
>> It is called from
>> mm_put, which is called from release_task.  This error
>> often occurs during
>> system shutdown.  I have turned on debugging features in
>> slab.c, but
>> haven't gotten any useful information from it yet.
>>
>> Another, which I generated today while trying to force
>> crashes with X off
>> so I could at least see the backtrace, was as quite
>> interesting.  I did
>> find / -type f -size -50 -exec grep "mm->pgd" \{\} \;
>> -print
>> which heavily excercises all kinds of i/o, especially
>> process creation and
>> destruction (since every file less than 50 blocks found
>> launches grep!).
>> The failure I got while running this generated two
>> backtraces.
>>
>> The first backtrace started in (reading in most-recent to
>> older order)
>> do_rw_proc, to sys_read, to syscall_ret_1, and then into
>> user space in grep.
>>
>> This backtrace was interrupted by other which went (same
>> order)
>> instruction_dump, bad_page_fault, do_page_fault,
>> int_return, do_rw_proc,
>> sys_read, syscall_ret_1, and then again to userland.
>>
>> This never happens on my home 7300/180, using the same
>> kernels, but happens
>> to frequently on my G3 at work as to make heavy use very
>> difficult.  I can
>> certainly use LyX and other "light-duty" programs for
>> extended periods
>> without any problem, but as soon as I create a lot of
>> disk activity and
>> process creation/destruction activity, the system melts.
>>
>> I have in the past reported much smaller pieces of this
>> to the group,
>> thinking it might be related to the old "ide device i/o
>> slowdown" problem,
>> or the bad interrupts problem, but I see no sign of these
>> happening
>> (although sometines at the time of the panic, I see a
>> message something of
>> order "in interrupt... not syncing".  This message is
>> sufficiently
>> infrequently observed that I can't provide
>> furtherinformation on it).
>>
>> If anyone else is seeing this kind of behavior, or has
>> any idea of a
>> solution, please let me know.  At present I have looked
>> into just about
>> everything except an exorcist.
>>
>> Thanks.
>>
>> Marcus Mendenhall
>>
>>
>>
>>
>> [[ This message was sent via the linuxppc-user mailing
>> list. Replies are ]]
>> [[ not forced back to the list, so be sure to  Cc
>> linuxppc-user  if your ]]
>> [[ reply is of general interest. To unsubscribe from
>> linuxppc-user, send ]]
>> [[ the message 'unsubscribe' to
>> linuxppc-user-request@lists.linuxppc.org ]]
>
>----------------------------------
>E-Mail: frank@cmc.uib.no
>Phone(Private):55234679
>Phone(Work):55589279
>Mob.: 93289455
>Date: 04-Feb-99
>Time: 09:10:39
>
>This message was sent by XFMail
>----------------------------------




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
