Message-ID: <3872E2F7.B7FA2F22@ctam.com.au>
Date: Wed, 05 Jan 2000 17:21:44 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: "Momchil 'Velco' Velikov" <velco@fadata.bg>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux ABI documents and powerpc supplements.
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local> <3872D1EA.DF497905@ctam.com.au> <3872E8B5.F088FE57@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Momchil 'Velco' Velikov wrote:

> Brendan J Simon wrote:
> > I am having problems getting simple shared executalbes to work on my embedded powerpc system
> > (MPC860).  I am using an egcs-1.1.2 cross compiler and have cross-compiled linux-2.2.5 kernel,
> > glibc-2.1 and some simple test applications.  I have an app that outputs a string every second
> > using puts().  If I compile with "powerpc-linux-gcc -m860 -static" it works, but if I compile
> > with "powerpc-linux-gcc -m860 -shared" it doesn't work.  I am mount root via nfs and the nfs
>
> -shared is used to *create* a shared library. You need -Bdynamic in
> order to force the executable to be linked against shared libraries.

I think you are confusing the ld arguments and the gcc arguments.  ld uses -Bdynamic and -Bstatic
for force linking of dynamic or static executables.  If -shared is specified on the gcc command
line then, it is passed to ld as -Bdynamic.  If -static is specified on the gcc command line, then
it is passed to ld as -Bstatic.  That's my understanding of it.  I've just noticed that ld has a
-shared argument also which is used for creating shared libraries as you have stated.  If -shared
on the gcc command line is passed unmodified to ld, then a shared library will be created instead
of an execuable.  I guess I can check using -v.  I should probably just leave the -shared option
out.

Thanks for your help,
Brendan Simon.


The gcc info pages say :

`-static'
     On systems that support dynamic linking, this prevents linking
     with the shared libraries.  On other systems, this option has no
     effect.

`-shared'
     Produce a shared object which can then be linked with other
     objects to form an executable.  Not all systems support this
     option.  You must also specify `-fpic' or `-fPIC' on some systems
     when you specify this option.

`-BPREFIX'
     This option specifies where to find the executables, libraries,
     include files, and data files of the compiler itself.

     The compiler driver program runs one or more of the subprograms
     `cpp', `cc1', `as' and `ld'.  It tries PREFIX as a prefix for each
     program it tries to run, both with and without `MACHINE/VERSION/'
     (*note Target Options::.).

     For each subprogram to be run, the compiler driver first tries the
     `-B' prefix, if any.  If that name is not found, or if `-B' was
     not specified, the driver tries two standard prefixes, which are
     `/usr/lib/gcc/' and `/usr/local/lib/gcc-lib/'.  If neither of
     those results in a file name that is found, the unmodified program
     name is searched for using the directories specified in your
     `PATH' environment variable.

     `-B' prefixes that effectively specify directory names also apply
     to libraries in the linker, because the compiler translates these
     options into `-L' options for the linker.  They also apply to
     includes files in the preprocessor, because the compiler
     translates these options into `-isystem' options for the
     preprocessor.  In this case, the compiler appends `include' to the
     prefix.

     The run-time support file `libgcc.a' can also be searched for using
     the `-B' prefix, if needed.  If it is not found there, the two
     standard prefixes above are tried, and that is all.  The file is
     left out of the link if it is not found by those means.

     Another way to specify a prefix much like the `-B' prefix is to use
     the environment variable `GCC_EXEC_PREFIX'.  *Note Environment
     Variables::.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
