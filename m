Message-ID: <3E2EFBBC.7C9CFC4C@midrivers.com>
Date: Wed, 22 Jan 2003 13:14:52 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: Prakash kanthi <pkanthi@yahoo.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux Kernel hangs after execve('/bin/sh')
References: <20030122195006.67877.qmail@web41207.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prakash,

I had the same trouble -- in my case, a couple of different
ways.

try compiling without -Bstatic, but do 2 different trials:
compile your test
-msoft-float and -mhard-float -- if either of these works then
the libraries you've got on your ram disk are either floating
point emulation, or hardware FP, respectively.  the compile must
match the libs in terms of floating point.l

the other things to look at are which libs you've got in your
ram disk.  if you've cut it down you might have cut it down
too far.  I'm running w/ the ELDK /lib and /usr/lib w/o
anything removed.   try that until you get things working and
then you can explore which packages need what libs.

Mark



Prakash kanthi wrote:
>
> Hurray .......
>
> Daris, you suggestion seem to work. I Compiled my
> hello.c with -Bstatic (size was almost 1MB), added it
> to ramdisk and it works. So now the problem is
> narrowed down to, being not able to work with the
> shared libraries.
>
> One point is that, i DID NOT get any errors (atleast
> on the screen) while execve was loading shared
> libraries in the process of executing /bin/sh. But for
> sure, my problem is related to it.
>
> I really appreciate any suggestions related to this
> issue.
>
> Thanks,
> Prakash
>
> --- Daris A Nevil <dnevil@snmc.com> wrote:
> >
> > Prakash,
> >
> > Try compiling your hello.c program with the -Bstatic
> > flag.  That will
> > eliminate the need to load libraries, and should
> > show if there are other
> > problems.  If that works OK then we can focus on why
> > your library loading
> > is failing.
> >
> > Regards,
> > Daris Nevil
> >
> >
> > Prakash kanthi said:
> > >
> > > Hi FOlks,
> > >
> > > I finally reached the last step (hopefully) of
> > linux
> > > kernel booting process. Kernel gets stuck after
> > doing
> > > a 'execve("/bin/sh")'. I tried using different
> > > ramdisks, still no difference.
> > >
> > > I added few printk's in the source, following the
> > > function call path from 'execve' call. Following
> > is
> > > the output. You can see that, execve goes through
> > > without any file permission problems and
> > subsequently
> > > it tries to open /lib/ld.so.1 flawlessly. After
> > that i
> > > see nothing on the terminal.
> > >
> > > ---------
> > > init:Trying to bring /bin/sh up.
> > > do_execve:enter for /bin/sh
> > > open_exec:enter for /bin/sh.
> > > open_exec:Permission error=0.
> > > dentry_open:enter.
> > > dentry_open: after file->f_op->open. 0
> > > open_exec:enter for /lib/ld.so.1.
> > > open_exec:Permission error=0.
> > > dentry_open:enter.
> > > dentry_open: after file->f_op->open. 0
> > > do_execve: after search_binary_handler. retval=0
> > > -----------
> > >
> > >
> > > I wrote a small standalone program hello.c to
> > test, if
> > > i can dynamically load it from init() instead of
> > > loading /bin/sh. I compiled the program added it
> > to my
> > > ramdisk and called from init(). Following is the
> > > output. You can see that, it did all of it that it
> > did
> > > for /bin/sh and also tried to open
> > /etc/ld.so.preload
> > > and /etc/ld.so.cache and failed. But again towards
> > the
> > > end, it tries to open /lib/libc.so.6 and succeds
> > but
> > > still no output is displayed that hello.c is
> > trying to
> > > print.
> > >
> > > ---------
> > > init:Trying to bring /bin/hello up.
> > > do_execve:enter for /bin/hello
> > > open_exec:enter for /bin/hello.
> > > open_exec:Permission error=0.
> > > dentry_open:enter.
> > > dentry_open: after file->f_op->open. 0
> > > open_exec:enter for /lib/ld.so.1.
> > > open_exec:Permission error=0.
> > > dentry_open:enter.
> > > dentry_open: after file->f_op->open. 0
> > > do_execve: after search_binary_handler. retval=0
> > > sys_open:enter for /etc/ld.so.preload.
> > > sys_open:unused_fd=3.
> > > filp_open:enter for /etc/ld.so.preload.
> > > filp_open:open_namei error -2.
> > > sys_open:enter for /etc/ld.so.cache.
> > > sys_open:unused_fd=3.
> > > filp_open:enter for /etc/ld.so.cache.
> > > filp_open:open_namei error -2.
> > > sys_open:enter for /lib/libc.so.6.
> > > sys_open:unused_fd=3.
> > > filp_open:enter for /lib/libc.so.6.
> > > filp_open:open_namei error 0.
> > > dentry_open:enter.
> > > dentry_open: after file->f_op->open. 0
> > > -----------
> > >
> > > Can someone please throw some light on this?
> > >
> > > Thanks,
> > > Prakash
> > >
> > >
> >
> >
> > Daris A Nevil
> > Simple Network Magic Corporation
> > 401 Kentucky
> > McKinney, Texas 75069
> > http://www.snmc.com
> > 972-562-3751
> >
> >
> >
>

--
Mark Pilon
Minolta-QMS

P.O. Box 37
325 Dawson County Road 227
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
