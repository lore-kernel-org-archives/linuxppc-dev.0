Message-ID: <386CD4AD.A0311DD9@mvista.com>
Date: Fri, 31 Dec 1999 10:07:09 -0600
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: Alan Mimms <alanm@unforgettable.com>
CC: Brendan.Simon@ctam.com.au, linux-embedded <linux-embedded@waste.org>,
        Cross-GCC <crossgcc@sourceware.cygnus.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross-compiling & debugging embedded-linux apps
References: <386C3615.E14AE6DD@ctam.com.au> <19991231.6583200@alanm.penguinpowered.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:

> You know about the ldd command?  Do 'ldd bjs1-shared' to see what
> libraries you need for your shared executable and make sure they're
> there and built with no floating point.  When you compile and link,
> you're using '-mcpu=860' or '-msoft-float', right?  That also could be
> a problem for you.
>
> I think the seg fault is what Dan's kernel maps the floating point
> handler's exception to - it's really a floating point exception.

On the MPC8xx, the only vector invoked for Floating Point is the Software
Emulation Interrupt, vector 0x1000. SIGSEGV is issued as a result of Machine
Check exception, vector 0x200.

> I COULD be wrong about this.  It's one fo the things I have been meaning
> to look into but haven't yet had the chance.
>
> (Caveat emptor on the above - I'm just a beginner myself.)
>
> a
>
> >>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<
>
> On 12/30/99, 8:50:29 PM, Brendan J Simon <Brendan.Simon@ctam.com.au>
> wrote regarding cross-compiling & debugging embedded-linux apps:
>
> > I have a powerpc embedded system (MPC860, 4MB Flash, 16MB RAM,
> ethernet,
> > rs232).  I have compiled the kernel and can boot it using a root
> > filesystem via initrd or nfs.  The root filesystem is a minimal one
> that
> > was on the linuxppc-embedded ftp site.  It basically has /bin/sh,
> > /bin/ls and a few libraries in /lib.
>
> > I NEED to be able to compile apps from the sources.  I have managed to
> > cross-compile ncurses and bash.  I can't get bash to run at all (even
> a
> > statically compiled version).  I get segmentaion faults.  I'm
> currently
> > using SASH which I have cross-compiled as a static binary.  I compiled
> a
> > test app (bjs1.c) which outputs a string every second.  It is compiled
> > as a static binary (bjs1-static) and a shared binary (bjs1-shared).
> The
> > static binary works but the shared one does not.  I assume it is some
> > library problem but I can't figure out what.  The output of the sash
> > session is below.
>
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
>
> > I have all the libraries on the root filesystem.  The rpc.nfsd daemon
> > seems to read the entire file but sash says the process is killed with
> > signal 11 (segmentation fault).  I have no idea how to debug this.  I
> > don't think there is a simulator for the mpc860 as part of gdb.  Is
> > there a way of debugging this on the target with powerpc-gdb and an
> > ethernet or serial connection ?
>
> > How does the kernel know where to look for libraries ?  I assume there
> > are some default locations like /lib.  I haven't got an ld.so.conf
> setup
> > nor do I have ldconfig.
>
> > It can't be that hard to get a simple 10 line program to execute as a
> > shared binary.  It must be something really simple that I am missing.
>
> > Thanks for any help,
> > Brendan Simon.

--
Jim Lewis
Sr. Field Applications Engineer
MontaVista Software, Inc.
(817)261-9088 http://www.mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
