Date: Fri, 14 Jan 2000 13:29:50 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Niklaus Giger <n.giger@netstal.com>
cc: linuxppc-embedded@lists.linuxppc.org,
        Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: Help Sought: 8390-Ethernet Troubles on PowerPC 4xx Port
In-Reply-To: <s87e4deb.081@netstal.com>
Message-ID: <Pine.SGI.4.10.10001141230510.254646-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Niklaus (and others),

Thanks again for the insight on the Oak 8390-based Ethernet driver. The
polled register read/write macros did the trick (at least partially so).

I've done the modification fairly cleanly; however, I'm not sure that the
kernel maintainers will accept the attendant changes to 8390.[ch] via the
nic_{i,o}[s]{b,w}[p] macros. We'll see.

The board now at least ARPs through the interface to the NFS server and
the NFS server responds. However, that's as far as it gets at this point
(see below). Any ideas? In the interim, I'm going to try experimenting
with a few more things.

Linux version 2.3.39 (grant@brule) (gcc version 2.95.2 19991024 (release)) #29 Fri Jan 14 11:07:27 CST 2000
On node 0 totalpages: 00000800
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 9.73 BogoMIPS
Memory: 6664k available (768k kernel code, 560k data, 44k init) [c0000000,c0800000]
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
Starting kswapd v1.6
Shoulda called rs_init...
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: National DP83902AV at 08:00:5a:c8:02:b4, found at 0xf4000000, using IRQ 27.
Looking up port of RPC 100003/2 on 192.168.68.90
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.
portmap: server 192.168.68.90 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.68.90
Device lo is down.
Device lo is down.
Device lo is down.

A trace of the network activity:

grant@stcroix% sudo tcpdump -a -e -vv -N host oak
tcpdump: listening on eth0
11:21:20.533481 8:0:5a:c8:2:b4 Broadcast arp 64: arp who-has stcroix tell oak
11:21:20.533481 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:20.533481 8:0:5a:c8:2:b4 0:5:2:3e:b7:3a ip 342: oak.bootpc > stcroix.bootps: xid:0x2 C:oak [|bootp] (ttl 30, id 1)
11:21:20.533481 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 ip 342: stcroix.bootps > oak.bootpc: xid:0x2 C:oak Y:oak S:stcroix [|bootp] (ttl 64, id 28151)
11:21:20.613484 8:0:5a:c8:2:b4 0:5:2:3e:b7:3a ip 70: oak.3909 > stcroix.tftp: 27 RRQ "/tftpboot/vmlinux.img" (ttl 30, id 52224)

[ Whole bunch of oak<--->stcroix UDP transfers of vmlinux.img deleted ]

[ OK...Linux is up and running...now a whole bunch of ARPs ]

11:21:25.533659 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp who-has oak tell stcroix
11:21:26.383689 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:26.383689 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:27.383724 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:27.383724 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:28.383759 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:28.383759 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:31.393866 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:31.393866 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:32.393902 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:32.393902 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:33.393937 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:33.393937 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:41.424221 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:41.424221 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:42.424257 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:42.424257 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a
11:21:43.424292 8:0:5a:c8:2:b4 Broadcast arp 60: arp who-has stcroix tell oak
11:21:43.424292 0:5:2:3e:b7:3a 8:0:5a:c8:2:b4 arp 42: arp reply stcroix is-at 0:5:2:3e:b7:3a

[ ... ]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
