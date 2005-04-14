Return-Path: <andre.bitzer@gmx.ch>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C86E167A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 19:03:31 +1000 (EST)
From: =?iso-8859-1?Q?Andr=E9_Bitzer?= <andre.bitzer@gmx.ch>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 14 Apr 2005 11:08:03 +0200
Message-ID: <000601c540d1$77406aa0$6428a8c0@BitzerLaepi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Boot problems (NFS)
Reply-To: andre.bitzer@gmx.ch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I work with the 860FADS-Board and have the following problem:
I load the kernel to the flash with the u-boot (1.1.2). at startup of
the system, i copy the kernel to RAM and start it.
(set bootargs nfsroot=/tftpboot/busybox,nolock rw
ip=192.168.40.144:192.168.40.120::::eth0:on;
 setenv bootcmd "cp.b 0xfe080000 0x100000 0xf7fff; bootm")

But, when i don't establish a network connection to my server (nfs-root)
with u-boot, the kernel will hang with this messages:

PQRM: Init
PQFEC: Init
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
PQFEC: Open eth0 device
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.40.144, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.40.144, domain=, nis-domain=(none),
     bootserver=192.168.40.120, rootserver=192.168.40.120, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.40.120
portmap: server 192.168.40.120 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.40.120
portmap: server 192.168.40.120 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.40.120 not responding, timed out
Root-NFS: Server returned error -5 while mounting /tftpboot/busybox
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00

if i first open a tftp connection to my server with u-boot, then the
kernel starts properly.

With tcpdump i do the following dumps:

kernel start:

09:49:54.506470 arp who-has linux.site tell 192.168.40.144
09:49:54.506492 arp reply linux.site is-at 00:01:02:af:02:f0
09:49:54.506737 IP 192.168.40.144.mdbs_daemon > linux.site.sunrpc: UDP,
length: 56
09:49:54.508045 IP linux.site.sunrpc > 192.168.40.144.mdbs_daemon: UDP,
length: 28
09:49:54.522869 IP 192.168.40.144.mdbs_daemon > linux.site.sunrpc: UDP,
length: 56
09:49:54.523310 IP linux.site.sunrpc > 192.168.40.144.mdbs_daemon: UDP,
length: 28
09:49:54.524804 IP 192.168.40.144.mdbs_daemon > linux.site.783: UDP,
length: 64
09:49:54.547407 IP linux.site.783 > 192.168.40.144.mdbs_daemon: UDP,
length: 60
09:49:54.550351 IP 192.168.40.144.4024160259 > linux.site.nfs: 108
getattr [|nfs]
09:49:54.552402 IP linux.site.nfs > 192.168.40.144.4024160259: reply ok
96 getattr DIR 40755 ids 0/0 sz 480
09:49:54.553425 IP 192.168.40.144.4024160260 > linux.site.nfs: 108
fsstat [|nfs]
09:49:54.553473 IP linux.site.nfs > 192.168.40.144.4024160260: reply ok
48 fsstat tsize 32768 bsize 4096 blocks 1311254 bfree 198425 bavail
198425
09:49:54.564656 IP 192.168.40.144.4024160261 > linux.site.nfs: 108
getattr [|nfs]
09:49:54.564711 IP linux.site.nfs > 192.168.40.144.4024160261: reply ok
96 getattr DIR 40755 ids 0/0 sz 480
09:49:54.565727 IP 192.168.40.144.4024160262 > linux.site.nfs: 108
getattr [|nfs]
09:49:54.565759 IP linux.site.nfs > 192.168.40.144.4024160262: reply ok
96 getattr DIR 40755 ids 0/0 sz 480
09:49:54.566751 IP 192.168.40.144.4024160263 > linux.site.nfs: 116
lookup [|nfs]
09:49:54.597890 IP linux.site.nfs > 192.168.40.144.4024160263: reply ok
128 lookup [|nfs]
09:49:54.617168 IP 192.168.40.144.4024160264 > linux.site.nfs: 116
lookup [|nfs]
09:49:54.621860 IP linux.site.nfs > 192.168.40.144.4024160264: reply ok
128 lookup [|nfs]
09:49:54.623180 IP 192.168.40.144.4024160265 > linux.site.nfs: 116
lookup [|nfs]
09:49:54.637662 IP linux.site.nfs > 192.168.40.144.4024160265: reply ok
128 lookup [|nfs]
09:49:54.638776 IP 192.168.40.144.4024160266 > linux.site.nfs: 108
readlink [|nfs]
09:49:54.638900 IP linux.site.nfs > 192.168.40.144.4024160266: reply ok
48 readlink "../bin/busybox"
09:49:54.639991 IP 192.168.40.144.4024160267 > linux.site.nfs: 116
lookup [|nfs]
09:49:54.649638 IP linux.site.nfs > 192.168.40.144.4024160267: reply ok
128 lookup [|nfs]
09:49:54.650727 IP 192.168.40.144.4024160268 > linux.site.nfs: 120
lookup [|nfs]
09:49:54.663338 IP linux.site.nfs > 192.168.40.144.4024160268: reply ok
128 lookup [|nfs]
09:49:54.664753 IP 192.168.40.144.4024160269 > linux.site.nfs: 120 read
[|nfs]
09:49:54.684925 IP linux.site.nfs > 192.168.40.144.4024160269: reply ok
1472 read
09:49:54.684933 IP linux.site > 192.168.40.144: udp
......

kernel don't start:

nothing happens on the network interface!!

rpcinfo -p on server:
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100227    3   udp   2049  nfs_acl
    100003    2   tcp   2049  nfs
    100003    3   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100021    1   udp  32768  nlockmgr
    100021    3   udp  32768  nlockmgr
    100021    4   udp  32768  nlockmgr
    100024    1   udp  32768  status
    100021    1   tcp  32768  nlockmgr
    100021    3   tcp  32768  nlockmgr
    100021    4   tcp  32768  nlockmgr
    100024    1   tcp  32768  status
    100005    1   udp    783  mountd
    100005    1   tcp    786  mountd
    100005    2   udp    783  mountd
    100005    2   tcp    786  mountd
    100005    3   udp    783  mountd
    100005    3   tcp    786  mountd

can anybody help me??

thanks!
