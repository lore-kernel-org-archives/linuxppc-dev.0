Message-ID: <3CEE31D4.1010905@eccincorp.com>
Date: Fri, 24 May 2002 08:28:04 -0400
From: Jon Baker <jon@eccincorp.com>
Reply-To: jon@eccincorp.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Embedded Planet RPX Classic NFS Mount error 111 with Red Hat 7.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am new to embedded Linux and am trying to setup Hard Hat 1.2 with an Embedded
Planet RPX Classic MPC860T / CLLF_BW31 with Red Hat 7.2.

A co-worker currently has this running fine with Red Hat 6.2.

I am trying to get the MPC860 target to boot up and NFS mount to my Hard
Hat development directory tree on my Red Hat 7.2 PC.  We currently have this
working with Red Hat 6.2.  We have used the 6.2 configuration as a guide.  With
Red Hat 7.2 I get

   nfs: RPC call returned error 111

See the last couple lines of the following minicom capture and the couple things
that I tried listed afterwards:

== minicom.cap =============================================
 >go
[Go 00200000]
loaded at:     00200000 0020C580
relocated to:  00180000 0018C580
board data at: 001801C8 001801E4
relocated to:  00200100 0020011C
zimage at:     00207000 0026EE68
avail ram:     0026F000 01000000

Linux/PPC load: root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.14 (root@jbakerlinux) (gcc version 2.95.2 19991030 (2.95.3
prerelease/franzo)) #30 Fri May 17 12:11:00 EDT 2002
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 15012k available (764k kernel code, 568k data, 40k init) [c0000000,c1000000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured

++++++++++++++++++++++++++
+ Efficient Channel Coding
+ copyright 2001
+ firmware build date: 18 Jan 2002  11:00 EST
+
+
+ NVRAM checksum good
+ STAR board - auto detected
+ CLLF rev 'BW31' FEC drivers installed - forced
+
+ loading ECC drivers:
+ loadFPGA successful
+ DEBUG successful
+ appIO successful
+ appmem successful
++++++++++++++++++++++++++

RAM disk driver initialized:  16 RAM disks of 16384K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:10:ec:00:28:f4
fec: Phy @ 0x0, type 0x001378e1
fec: link down
fec: 10 Mbps, Half-Duplex
eth1: FEC ENET Version 0.1, 00:10:ec:80:28:f4
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.0.0.136, my address is 10.0.0.106
Looking up port of RPC 100003/2 on 10.0.0.136
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.0.0.136
nfs: RPC call returned error 111
RPC: task of released request still queued!
RPC: (task is on xprt_pending)
nfs_read_super: get root fattr failed
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..


== end minicom.cap =========================================

I have read a couple of posts and have tried the following:

1) I believe I have the firewall disabled (via Gnome Service Configurator)

2) Red Hat 7.2 does start portmap before nfs via the rcX.d scripts
    (I also manually turned off the dhcpd and nfs service and then
    turned them back on so I don't believe it is a portmap/nfs start
    sequence conflict.)

3) I have tried various options in my /etc/exports file (see commented entries)

== /etc/exports ============================================

#
#/opt/hardhat/devkit/ppc/8xx/target (rw,no_root_squash,no_all_squash)
#/opt/hardhat/devkit/ppc/8xx/target *(rw,no_root_squash,no_all_squash)
#/opt/hardhat/devkit/ppc/8xx/target
10.0.0.0/255.255.255.0(rw,no_root_squash,no_all_squash)
#/opt/hardhat/devkit/ppc/8xx/target 10.0.0(rw)
#/opt/hardhat/devkit/ppc/8xx/target 10.0.0(ro)
#/opt/hardhat/devkit/ppc/8xx/target
10.0.0.0/255.255.255.0(ro,no_root_squash,no_all_squash)
#/opt/hardhat/devkit/ppc/8xx/target 10.0.0.106(ro,no_root_squash)
/opt/hardhat/devkit/ppc/8xx/target 10.0.0.106(ro,no_root_squash,no_all_squash)

== end /etc/exports ========================================

4) I tried the following /etc/hosts.allow

== /etc/hosts.allow ========================================
#
# hosts.allow	This file describes the names of the hosts which are
#
	allowed to use the local INET services, as decided
#
	by the '/usr/sbin/tcpd' server.
#
ALL:ALL

== end /etc/hosts.allow ====================================

5) Here is the dhcpd.conf

== /etc/dhcpd.conf =========================================


allow bootp;
subnet 10.0.0.0 netmask 255.255.0.0 {
   default-lease-time 1209600;			#two weeks
   max-lease-time 31557600;			#one year
   group {
     host endymion {
       hardware ethernet 00:10:ec:00:28:f4;
       fixed-address 10.0.0.106;
       option root-path
         "/opt/hardhat/devkit/ppc/8xx/target";
     }


   }
}

== end /etc/dhcpd.conf =====================================

6) Here is the activity in /var/log/messages (looks successful)

== /var/log/messages =======================================

May 17 16:30:37 jbakerlinux rpc.mountd: Caught signal 15, un-registering and
exiting.
May 17 16:30:38 jbakerlinux nfs: rpc.mountd shutdown succeeded
May 17 16:30:38 jbakerlinux nfs: rpc.mountd startup succeeded
May 17 16:31:01 jbakerlinux dhcpd: BOOTREQUEST from 00:10:ec:00:28:f4 via eth0
May 17 16:31:01 jbakerlinux dhcpd: BOOTREPLY for 10.0.0.106 to endymion
(00:10:ec:00:28:f4) via eth0
May 17 16:31:07 jbakerlinux rpc.mountd: authenticated mount request from
10.0.0.106:800 for /opt/hardhat/devkit/ppc/8xx/target
(/opt/hardhat/devkit/ppc/8xx/target)

== end /var/log/messages ===================================

Does anyone have any ideas?  Is there something different from RH 6.2 to 7.2 or
did I just configure something wrong?

Thanks,

Jon

===================================
Jon Baker
Software Engineer
Efficient Channel Coding, Inc.
216-635-1610
www.eccincorp.com
===================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
