Message-ID: <3C00772F.783F8720@netfall.com>
Date: Sat, 24 Nov 2001 20:44:31 -0800
From: Andrew Sharp <andy@netfall.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Kernel crashing problems on oldworld
References: <20011123032512.C387@Obsession>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Tillman wrote:
>
> I have a PowerBase 180 oldworld powerpc with Debian woody
> (2.2.19-pmac). I started having a crashing problem about 4 weeks ago,
> the easiest way to repeat it was to use nano (1.0.5/1.0.6) to edit a
> document, and select the Search function or the save-file function. In
> either case, the computer would freeze as it was attempting to update
> the help keys across the bottom of the screen. This never occurred in
> nano-tiny, which is a reduced-library version.
>
> There is no kernel message with this crash, it simply freezes the
> machine. I tried strace, its log gets cut off shortly after the
> keystroke which causes the crash, so it's not much help.
>
> I traced the execution of the code from nano into the ncurses library,
> and determined that it was crashing right after a call to
> _nc_flush(). Here is an example backtrace just prior to a crash:
>
> in doupdate() at ../ncurses/tty/tty_update.c:787   _nc_flush();
> called by wrefresh() at ../ncurses/base/lib-refresh.c:60
> called by bottombars() at ../nano/winio.c:562
> called by display_main_list() at ../nano/winio.c:1152
> called by search_abort() at search.c:298
>
> The maintainer says that _nc_flush() simply calls fflush. Of course,
> that function is called many times in this and other programs -- it is
> only these special circumstances in which it causes a crash.
>
> This problem doesn't occur on my newworld powerpc, but it is
> reliably repeatable on my oldworld. I also got serveral crashes in
> dselect which uses the same ncurses library.
>
> I verified that the same thing happens if I install on a different
> partition, even a different disk. It did *not* repeat on another
> oldworld computer (PowerCenter 150) with the same woody installation
> (it's on an external SCSI disk, I just moved the disk to the new
> machine) - so I concluded it was some conflict with my ATY Mach64 card
> (which according to lspci, is an ATI 3D Rage I/II 215GT [Mach64GT]
> (rev 41). I tried adding video=atyfb to the kernel arguments, that did
> not affect it.
>
> I constructed a patch which prevents the crash; not sure if it would
> be much help in determining the true cause though. The patch just uses
> wredrawln to claim that the 2 help lines are corrupt and asks for them
> to be completely redrawn rather than just refreshed.
>
> Another interesting point is that I can run all the ncurses test
> programs except worm, which crashes in a few seconds, but only when
> the console it's running on is actually visible. And, the blink and
> underline attributes don't seem to work on my system.
>
> Finally, I downloaded the kernel-image-2.4.12-powerpc package to see
> if changing the kernel would make a difference. It did, the nano crash
> disappeared. The worm crash is still present, though.
>
> I can continue trying to trace the problem in worm, if there's
> interest, since it's present in both kernels. Or if there's interest
> in the kernel 2.2.19 nano problem, whatever... I am interested in
> helping track down the problem because it's such a hard crash. My
> filesystem is of course damaged when I have to hard reboot.
>
> I signed up to the list. Let me know what I can try. And Happy
> Thanksgiving!

Thanks.  Are you sure it's not just some memory that's gone bad
rather than a conflict with the video card?

a


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
