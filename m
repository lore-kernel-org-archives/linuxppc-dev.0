Message-ID: <4118282C375DF64EA700135193EEB8CA75CB72@ACUSH02>
From: "Beckwith, Stephen @ GNS" <Stephen.Beckwith@L-3com.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Login Problem on 8260
Date: Thu, 13 Nov 2003 12:12:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings!
  I would like to thank all the "guru's" on this list for their wonderful
insight, it has
helped me a great deal to get to where I am, but I am now in need of some
more assistance.
Please pardon my "verbosity" in explaining my situation, I have learned from
past
experience that the more details one gives, the better the answers are.
I have a custom platform with 2 MPC8260's, but only 1 is running Embedded
Linux. It has currently 64M SDRAM DIMM. We have been working on getting
PPCBoot running (Version 1.1.5),
but as of now, we are NOT using this (it's new hardware, still using ICE).
We setup
the system via "chopped" PPCBoot running in DPRAM to setup SDRAM only.  We
then load
the Kernel via ICE (VisionII) and run.  The Kernel is built to mount a root
file system
running on an old MAC (PPC Based, running Debian 2.2).  The root file
system's origin is
unknown at this time, could be 2.2 based or 2.4 based. The kernel being
loaded to the
target is 2.4.18 (source is unknown, tool chain is a 2.95.3 flavor, again,
source is
unknown, I'm just being the clean up guy here).  The kernel will boot, runs
INIT and
I get to the point of a login prompt.  Then, Nothing!  When I type, I get no
echo.  I have verified HW is working with o-Scope, we see characters inbound
to 8260.
We are using SCC2 as our "console" and "serial" port (SCC1 is for IPC to
other 8260,
Ethernet on FCC1, SCC3 is RS485 port, all other comm ports are GPIO).  I
scanned
the list and found a patch which enables using SCC's as serial/console
ports.  I applied this patch (some done manually as my copy of Linux has
been modified by others already).  This all compiled and ran.  I see ttyS3
being setup during boot.  However, still nothing.
At a higher level:  Inittab has an entry to setup getty on ttyS3 (@ 19200 as
defined
in a hard-coded bd_t structure in the kernel).  Adding ttyS3 to securetty
causes the
system to "bomb" prior to seeing INIT banner, it gets hung in page_fault or
some signal
processing routines.  Remove this entry, I can get thru to the login prompt.
I also
removed items in pam.d, keeping only "other" and modified to pam_permit.
I replaced the line in inittab for the getty with bash and I got the bash
prompt, but
same result: can't type anything.
I see files created in /var/run, and also /var/log, the kern.log and syslog
are updated,
but only to the point before INIT runs.  Nothing in dmesg log.  (the
syslog.conf has
also been modified, only starts initial stuff, no mail, etc. is needed or
used)
Several questions:
1.  Does the mounted root file system need to at the same revision as the
kernel?
(i.e., can a 2.4.18 kernel use a 2.2 file system?)
2.  What else am I missing here?  Can this be a kernel problem or is it more
of a
configuration type setup with the root file system.

Enclosed below is the latest printout.  Other file can be sent if needed.
Thanks in advance for your assistance.
Regards,
Stephen Beckwith,
System Engineer, L-3 Com GNS

Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.18 (steveb@telecom2.aydin-telecom.com) (gcc version 2.95.3
200
10315 (release)) #64 Wed Nov 12 16:27:02 EST 2003
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs
ip=166.20.228.225:166.20.228.230:166.20.228.1
:255.255.252.0:tm12::off nfsroot=166.20.228.230:/tftpboot/tm12 rw
Warning: real time clock seems stuck!
Calibrating delay loop... 133.12 BogoMIPS
Memory: 63140k available (904k kernel code, 336k data, 56k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS3 on SCC2 at 0x8100, BRG4
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
eth0: FCC ENET Version 0.2, 00:a0:1e:a8:7b:cf
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
IP-Config: Complete:
      device=eth0, addr=166.20.228.225, mask=255.255.252.0, gw=166.20.228.1,
     host=tm12, domain=, nis-domain=(none),
     bootserver=166.20.228.230, rootserver=166.20.228.230, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 166.20.228.230
Looking up port of RPC 100005/1 on 166.20.228.230
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
INIT: version 2.78 booting
rcS: Loop
Mounting /proc filesystem...
Setting kernel variables.
Loading the saved-state of the serial devices...
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
rcS: DONE
INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.
Login enabled...

tm12 login:

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
