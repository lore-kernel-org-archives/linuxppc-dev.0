Date: Tue, 21 Mar 2000 11:28:31 -0600 (CST)
From: Don Holmgren <djholm@fnal.gov>
Reply-To: Don Holmgren <djholm@fnal.gov>
To: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: root nfs boot problems
In-Reply-To: <38D78FAC.7D6831CC@email.sps.mot.com>
Message-ID: <Pine.SGI.3.95.1000321111628.2421C-100000@hppc.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't believe the "neighbour table overflow" errors are the problem.  I
get them frequently but otherwise have success.

It looks like a problem on your nfs server.  The "unable to get nfsd port
number from server" and "unable to get mountd port number from server"
messages indicate that at minimum, the portmapper is not running on your
server.  Perhaps mountd and/or nfsd are also not running.

If you've not done this already, you should verify from another machine
that you can mount the root file system from your server.  Also, it's
always been useful for me to monitor system logs on my server when
debugging nfs root mounts - make sure your target board actually is making
contact, make sure your server grants access, etc...

Don Holmgren
Fermilab


On Tue, 21 Mar 2000, Stephan Ruettiger (r0337c) wrote:

>
> Hello Simon,
>
> i have actually the same problem as you have in NOV 99 (showing below),
> but i don't find the answer to your problem in the mailinglist-archive
> (linuxppc-embedded). So i hope you can tell me how you have solved this
> problem. I use a 2.2.13 kernel with math emulation.
> The same configuration with the old kernel (2.1.119 - no module support)
> works fine.
>
> > I am trying to boot embedded-2.2.5 kernel using a nfsr root filesystem.
> > Here is a log of the console session.  I get a "neighbour table
> > overflow" error.  What does this mean ?  I have a look in the source but
> > can't figure out what is happening.
> >
> > Thanks,
> > Brendan Simon.
> >
> > loaded at:     FF801000 FF813BAC
> > relocated to:  00100000 00112BAC
> > board data at: 001001F8 00100214
> > relocated to:  00200100 0020011C
> > zimage at:     FF808000 FF8690B9
> > avail ram:     00201000 00400000
> >
> > Linux/PPC load: root=/dev/nfs nfsaddrs=203.21.127.132:203.21.127.160
> > nfsroot=203.21.127.160:/sys/ads-root
> > Uncompressing Linux...done.
> > Now booting the kernel
> > Linux version 2.2.5 (root@k9) (gcc version egcs-2.91.66 19990314
> > (egcs-1.1.2 rel
> > ease)) #39 Fri Nov 12 17:49:11 EST 1999
> > Boot arguments: root=/dev/nfs nfsaddrs=203.21.127.132:203.21.127.160
> > nfsroot=203
> > .21.127.160:/sys/ads-root
> > time_init: decrementer frequency = 93750000/60
> > Calibrating delay loop... 24.52 BogoMIPS
> > Memory: 15188k available (700k kernel code, 464k data, 32k init)
> > [c0000000,c1000
> > 000]
> > POSIX conformance testing by UNIFIX
> > Linux NET4.0 for Linux 2.2
> > Based upon Swansea University Computer Society NET3.039
> > NET4: Unix domain sockets 1.0 for Linux NET4.0.
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP
> > Starting kswapd v 1.5
> > CPM UART driver version 0.02
> > ttyS00 at 0x0280 is a SMC
> > ttyS01 at 0x0100 is a SCC
> > ttyS02 at 0x0200 is a SCC
> > pty: 256 Unix98 ptys configured
> > RAM disk driver initialized:  16 RAM disks of 4096K size
> > eth0: CPM ENET Version 0.2, 00:d0:1f:11:22:33
> > IP-Config: Guessing netmask 255.255.255.0
> > neighbour table overflow
> > neighbour table overflow
> > neighbour table overflow
> > neighbour table overflow
> > portmap: server 203.21.127.160 not responding, timed out
> > Root-NFS: Unable to get nfsd port number from server, using default
> > Looking up port of RPC 100005/1 on 203.21.127.160
> > neighbour table overflow
> > neighbour table overflow
> > neighbour table overflow
> > neighbour table overflow
> > portmap: server 203.21.127.160 not responding, timed out
> > Root-NFS: Unable to get mountd port number from server, using default
> > neighbour table overflow
> > neighbour table overflow
> > neighbour table overflow
> > neighbour table overflow
> > mount: server 203.21.127.160 not responding, timed out
> > Root-NFS: Server returned error -5 while mounting /sys/ads-root
> > VFS: Unable to mount root fs via NFS, trying floppy.
> > VFS: Cannot open root device 02:00
> > Kernel panic: VFS: Unable to mount root fs on 02:00
> > Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
> > Emulation
> > Rebooting in 180 seconds..Machine check in kernel mode.
> > Caused by (from msr): regs c0f4bb30 Machine check signal - probably due
> > to mm fa
> > ult
>
>
> ------------------------
> Stephan Ruettiger
> Motorola Munich
> r0337c@email.sps.mot.com
> ------------------------
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
