From: kbhend <kbhend@business.wm.edu>
To: "Kevin Buettner" <kev@primenet.com>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org, gdt@linuxppc.org
Subject: Re: gdb broken under linuxppc r5 tools
Date: Mon, 2 Aug 1999 11:21:19 -0400
Content-Type: text/plain
References: <990801202455.ZM22552@redrock.lan>
MIME-Version: 1.0
Message-Id: <99080211313600.00413@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kevin,

> Kevin, Franz, et.al,
> 
> Earlier this year, Metrowerks and I signed the copyright assignments
> required by the FSF.  Beginning August 9, I will be starting work at
> Cygnus as a GDB engineer.  One of the things that I'll work on is a
> merge of my patches into the current gdb mainline.  It'll be my goal
> to get a solid, usable gdb up and running on Linux/PPC again.

Congrats!  It is good to hear from you again!  We still miss you on the LinuxPPC
JDK porting team!  Care to rejoin?!? :-)

As for gdb, something changed seriously between Paul's 2.2.1 kernel running on
a R4.1 build (gdb was very very stable when debugging shared libs) and Paul's
2.2.10 kernel running LinuxPPC R5 or YDL.

I tried Gary's 4.18 src rpm and it rebuilt fine under R5 but shows exactly the
same error mode as the 4.17 builds.  I will put a breakpoint at a function in a
shared lib (such as awt_allocate_colors in libawt.so) and the function address
returned by gdb when it says it places the breakpoint is typically not a valid
address (typically something in 0x00XXXXXX or 0x0XXXXXXX range).  
Sometimes it ends up putting the breakpoint into another routine (often glibc)
which you can see if luckily your code uses that other shared lib.

This is so frustrating.  If I can find (by chance) the actual location of the
shared lib routine (by disassmebling large pieces of memory) and use the exact
address to place the breakpoint, it will actually stop there.

Some change to the debugging symbols must have been made to cause this I think,
but I am not sure.

Anyway, I hope you can recreate these problems and can find a solution!!!!

Thanks,

Kevin H.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
