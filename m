Date: Wed, 5 Jan 2000 03:34:01 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Brendan J Simon <Brendan.Simon@ctam.com.au>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dynamic binaries not working.
Message-ID: <20000105033401.A18896@drow.res.cmu.edu>
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local> <3872D1EA.DF497905@ctam.com.au> <3872E8B5.F088FE57@fadata.bg> <3872ECED.6E46EBF6@ctam.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3872ECED.6E46EBF6@ctam.com.au>; from Brendan.Simon@ctam.com.au on Wed, Jan 05, 2000 at 06:04:14PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 05, 2000 at 06:04:14PM +1100, Brendan J Simon wrote:
> 
> Momchil 'Velco' Velikov wrote:
> 
> > Brendan J Simon wrote:
> > > I am having problems getting simple shared executalbes to work on my embedded powerpc system
> > > (MPC860).  I am using an egcs-1.1.2 cross compiler and have cross-compiled linux-2.2.5 kernel,
> > > glibc-2.1 and some simple test applications.  I have an app that outputs a string every second
> > > using puts().  If I compile with "powerpc-linux-gcc -m860 -static" it works, but if I compile
> > > with "powerpc-linux-gcc -m860 -shared" it doesn't work.  I am mount root via nfs and the nfs
> >
> > -shared is used to *create* a shared library. You need -Bdynamic in
> > order to force the executable to be linked against shared libraries.
> 
> I removed the -shared argument and the executable now looks a lot better interms of the vaddr and
> program headers etc.  I used "powerpc-linux-gcc -Wall -mcpu=860 -fpic -o bjs1 bjs1.c".  I tried
> with -fPIC, -fpic and without either.  The program still does not run however.  The output of
> objdump -p  is below.

You should not need -fpic in any form for the binary.

Also, you're using old versions of tools - I really strongly recommend
upgrading.  GCC 2.95.2 is worlds better than egcs 1.1.2 was, and the
new binutils (2.9.5.0.x) fix many nasty little bugs.

Nothing below looked wrong to my inexperienced eye...

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
