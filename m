Message-ID: <40169C35.5020602@gcctech.com>
Date: Tue, 27 Jan 2004 12:13:25 -0500
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: cjohnson@gcctech.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb problems
References: <4016965F.5060706@gcctech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, answering some of my own questions:

in host-side gdb, use the two commands:
set solib-absolute-prefix
set solib-search-path

I set the first to /dev/null and the second to the path where my
filesystem is constructed and its /lib directory (where all my shared
libs are on the host).

All the below error messages go away, but I am left with my original
problem.  I can set breakpoints but they don't work.  What am I missing?

Christopher R. Johnson wrote:

>
> Maybe not the right list for this, if you have a suggestion for
> somewhere better let me know...
>
> My new tool chain build is working well, except that debugging with
> gdb/gdbserver is somewhat broken.  I figured out that I needed thread_db
> and have that built in now and delivered to the target platform.
>
> Problem #1: When I start host side gdb, I get the message:
> warning: unable to find dynamic linker breakpoint function
> GDB will be unable to debug shared library initializers
> and track explicitly loaded dynamic code
>
> I don't need to debug initializers, so I set a breakpoint at main and
> continue.  Two error messages appear:
> Error while mapping shared library sections:
> /lib/ld.so.1: No such file or directory
> Error while mapping shared library symbols:
> /lib/ld.so.1: No such file or directory
>
> The program starts and breakpoint don't work.
>
> Problem #2:  (Maybe related?) on the target side gdbserver, after
> starting things with "c" on the host side, this message appears:
> gdb: error initializing thread_db library.
> gdb: error initializing thread_db library.
>
> Yes, twice.
>
> Why is the host side looking in /lib for target libraries?  Can I
> control that?  How?
>
> Why is gdbserver on the target having trouble?  I see I have correctly
> delivered the thread_db library in /lib on the target, so what gives?
>
> Any help or guidance would be greatly appreciated.  I build my toolchain
> with crosstools.
>
> --
> Christopher R. Johnson
>
>
>

--
Christopher R. Johnson
Principal Software Engineer
GCC Printers
(781)276-8763


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
