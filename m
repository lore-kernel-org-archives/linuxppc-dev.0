Date: Sat, 13 Mar 1999 23:49:25 -0800 (PST)
From: Matt McLean <keys@yikes.com>
To: Sean Harding <sharding@oregon.uoregon.edu>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68 problem
In-Reply-To: <Pine.SGI.4.10.9903122248320.19776-100000@gutenberg.uoregon.edu>
Message-ID: <Pine.BSF.4.01.9903132346300.1258-100000@brio.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 12 Mar 1999, Sean Harding wrote:

> 
> This evening I decided to take the plunge and try XF68-fbdev on my
> machine. I have a PowerCenter 150 (Platinum video) running a mish-mosh of
> LinuxPPC which no longer can really be associated with a complete release.
> The kernel is 2.1.130 at the moment. 
> 
> I'm getting a seg fault when I try to run the X server. Here's what strace
> has to say about it:
> 
> execve("/usr/X11/bin/XF68", ["/usr/X11/bin/XF68"], [/* 33 vars */]) = 0
> brk(0)                                  = 0x1aa02cc
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> --- SIGSEGV (Segmentation fault) ---
> +++ killed by SIGSEGV +++

This is the strace output, but that's only for syscalls. You'll need to
debug it with GDB instead.
 
> I indeed don't have an /etc/ld.so.preload, and I'm not entireley sure what
> that file should contain. I'm also not clear on why the absence of that
> file is causing the X server to seg fault....

It's not dying because of that open() it's just dying in between it and
the next system call.
 
> Any ideas?

It's hard to say without seeing the backtrace, but I bet upgrading to the
latest glibc and X rpms will fix this... also, which linuxppc release? 4
or 5?

-matt


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
