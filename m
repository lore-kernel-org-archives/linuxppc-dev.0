Subject: Re: ibook2r2 & strange freeze.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: "Linuxppc-Dev@Lists.    " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1051284468.2467.179.camel@localhost.localdomain>
References: <1051284468.2467.179.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1051292592.2104.9.camel@gaston>
Mime-Version: 1.0
Date: 25 Apr 2003 19:43:12 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> By unstable I mean that the computer completely freeze during boot time,
> around the time rc.sysinit is launched. Unfortunately I'm rather new to
> linux kernel so I don't know how to provide more information on the
> crash (maybe should I configure the kernel with xmon ?).
> In a divide&conquer approach I found that the part of rc.sysinit which
> 'uploads' the console font to the font layer was triggering the crash.

Can you try 2 things and let me know if one of them helps ?

 - Compile without CPUFREQ support
 - Use video=radeon:noaccel on the command line to disable acceleration
   on console

> I then re-installed from scratch everything (because I thought there
> could have been a fs corruption somewhere which had corrupted the
> fonts), but no chance it crashed again.
>
> I then commented-out this part of rc.sysinit and then I could boot up to
> the login prompt.
>
> But the kernel was still unstable, and still froze at completely random
> time (mounting a cdrom, vi'ing some text files, rsyncing a kernel,
> compiling the kernel).
>
> I decided to have a look to the latest devel kernel (namely
> 2.4.21-pre7-ben0 and 2.4.21-rc1-ben0) but no chance again, when booted
> with video=radeonfb (or with nothing) they're oopsing during the boot (I
> can provide more information if needed). With video=ofonly, everything
> went smooth.
>
> As I wasn't sure the crash came from my compiled kernel, I also tried
> pre-built kernel from penguinppc.org (the following dmesg output has
> been taken from this kernel). This kernel was relatively stable with my
> modified rc.sysinit, but failed with the original rc.sysinit.
>
> So, what should I do to have a stable kernel with radeonfb ?

That's interesting. I need to investigate...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
