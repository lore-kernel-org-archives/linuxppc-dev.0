Date: Sat, 26 Feb 2000 09:23:14 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000226162314.ZM9153@saguaro.lan>
In-Reply-To: Pierre Sarrazin <sarrazip@machinasapiens.com>
        "Re: Help w/ gdb" (Feb 16,  2:11pm)
References: <38AAF67E.36D2@machinasapiens.com>
To: Pierre Sarrazin <sarrazip@machinasapiens.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Help w/ gdb
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 16,  2:11pm, Pierre Sarrazin wrote:

[lots of stuff snipped]
> The program executes fine by itself, as well as in GDB without
> breakpoints.
>
> Here is the scenario.  I enter GDB and set a breakpoint on this line
> of prog.c:
>
>         (*function)();
>
> Then I run the program and GDB stops on that line. I give the "step"
> command and get this:
>
> ---------------------------------------------------------------------------
> (gdb) break 15
> Breakpoint 1 at 0x1800734: file prog.c, line 15.
> (gdb) run
> Starting program: /home/sarrazip/pgm/bug-gdb-dll/prog
>
> Breakpoint 1, main (argc=1, argv=0x7ffffbd4) at prog.c:15
> 15              (*function)();
> (gdb) step
> 0x161a61c in library_function () at libfoo.c:7
> 7       }
> (gdb) next
> This is library_function()
> --------------------------
> main (argc=1, argv=0x7ffffbd4) at prog.c:17
> 17              dlclose(handle);
> (gdb)
> ---------------------------------------------------------------------------

Pierre,

Thanks for including the program and detailed bug report.  I mentioned in
earlier email that I was merging the patches for linux/ppc gdb into the
current sourcebase.  I am happy to report that this merge is complete and
that the source may be downloaded from the sourceware site.  See

    http://sourceware.cygnus.com/gdb

for more information.  Franz Sirl has also created an RPM from sources
earlier in the week and placed it in

    ftp://devel.linuxppc.org/users/fsirl/

(I'm not sure if his sources contain my most recent shared library fixes
though.)

Anyway, when I run your program, I'm now seeing the following
(correct, I believe) output:

    GNU gdb 20000204
    Copyright 1998 Free Software Foundation, Inc.
    GDB is free software, covered by the GNU General Public License, and you are
    welcome to change it and/or distribute copies of it under certain conditions.
    Type "show copying" to see the conditions.
    There is absolutely no warranty for GDB.  Type "show warranty" for details.
    This GDB was configured as "powerpc-unknown-linux-gnu"...
    (gdb) b 15
    Breakpoint 1 at 0x1800734: file prog.c, line 15.
    (gdb) r
    Starting program: /home/kev/ctests/pierre/prog

    Breakpoint 1, main (argc=1, argv=0x7ffffd54) at prog.c:15
    15              (*function)();
    (gdb) s
    library_function () at libfoo.c:5
    5               printf("This is library_function()\n");
    (gdb) next
    This is library_function()
    6               printf("--------------------------\n");
    (gdb) next
    --------------------------
    7       }
    (gdb) next
    main (argc=1, argv=0x7ffffd54) at prog.c:17
    17              dlclose(handle);

Kevin

--
Kevin Buettner
kev@primenet.com, kevinb@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
