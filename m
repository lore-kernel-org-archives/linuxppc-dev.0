From: Alan Mimms <alanm@unforgettable.com>
Date: Sat, 01 Jan 2000 22:17:44 GMT
Message-ID: <20000101.22174400@alanm.penguinpowered.com>
Subject: Re: cross-compiling & debugging embedded-linux apps
To: Jim Lewis <jlewis@mvista.com>
CC: Brendan.Simon@ctam.com.au, linux-embedded <linux-embedded@waste.org>,
        Cross-GCC <crossgcc@sourceware.cygnus.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <386CD9C2.D00DDE27@mvista.com>
References: <386C3615.E14AE6DD@ctam.com.au> <386CD9C2.D00DDE27@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had pretty good luck running gdb on the target with my sources NFS 
mounted.  You can talk to its command line from a telnet window, which 
is pretty acceptable unless you're addicted to those eye-candy GUIs 
that smear lipstick on the gdb chicken...<g>

a

>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 12/31/99, 8:28:50 AM, Jim Lewis <jlewis@mvista.com> wrote regarding 
Re: cross-compiling & debugging embedded-linux apps:


> Brendan J Simon wrote:

> > I have a powerpc embedded system (MPC860, 4MB Flash, 16MB RAM, 
ethernet,
> > rs232).  I have compiled the kernel and can boot it using a root
> > filesystem via initrd or nfs.  The root filesystem is a minimal one 
that
> > was on the linuxppc-embedded ftp site.  It basically has /bin/sh,
> > /bin/ls and a few libraries in /lib.
> >
> > I NEED to be able to compile apps from the sources.  I have managed to
> > cross-compile ncurses and bash.  I can't get bash to run at all (even 
a
> > statically compiled version).  I get segmentaion faults.  I'm 
currently
> > using SASH which I have cross-compiled as a static binary.  I compiled 
a
> > test app (bjs1.c) which outputs a string every second.  It is compiled
> > as a static binary (bjs1-static) and a shared binary (bjs1-shared).  
The
> > static binary works but the shared one does not.  I assume it is some
> > library problem but I can't figure out what.

> I think you are right. What libraries are you linking against? I think 
the the
> minroot FS from the embedded FTP site uses libc 1.99. I have had 
nothing but
> trouble when trying to mix libraries.

> If you did build against different libraries, one way you could do is 
to
> create a new directory for your shared application and the shared 
objects you
> linked against. Make sure to include the ld.so.1 executable. Then, at 
the
> target SASH prompt, issue the following:
> > /test/ld.so.1 --library-path /test /test/bjs1-shared

> > The output of the sash
> > session is below.
> >
> > Stand-alone shell (version 1.0)
> > > ./bjs1-static
> > BJS1: Brendan was here
> > BJS1: Brendan was here
> > BJS1: Brendan was here
> > pid 7: killed (signal 2)
> > >
> > > ./bjs1-shared
> > pid 8: killed (signal 11)
> > >
> >
> > I have all the libraries on the root filesystem.  The rpc.nfsd daemon
> > seems to read the entire file but sash says the process is killed with
> > signal 11 (segmentation fault).  I have no idea how to debug this.  I
> > don't think there is a simulator for the mpc860 as part of gdb.  Is
> > there a way of debugging this on the target with powerpc-gdb and an
> > ethernet or serial connection ?

> Yes, there is. Dan posted some gdbserver sources a while back. That 
allows you
> to do cross debug. But you are likely to have the same problems 
building
> gdbserver that you are having with your simple test application.

> >
> >
> > How does the kernel know where to look for libraries ?  I assume there
> > are some default locations like /lib.  I haven't got an ld.so.conf 
setup
> > nor do I have ldconfig.

> The 'default' location seems to be built in to the executable. 
Usually,
> /lib/ld.so.1 is invoked and it tries to open ld.so.cache to determine 
where
> libraries are. If it cannot find /etc/ld.so.cache, then it just uses 
default
> locations that were "compiled in". The ld.so.cache is created by 
ldconfig,
> which reads ld.so.conf to determine how to build ld.so.cache.

> >
> >
> > It can't be that hard to get a simple 10 line program to execute as a
> > shared binary.  It must be something really simple that I am missing.
> >
> > Thanks for any help,
> > Brendan Simon.

> --
> Jim Lewis
> Sr. Field Applications Engineer
> MontaVista Software, Inc.
> (817)261-9088 http://www.mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
