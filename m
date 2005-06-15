Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-nj2gw-1.online-age.net (ext-nj2gw-1.online-age.net
	[216.35.73.163]) by ozlabs.org (Postfix) with ESMTP id 2A7E867B56
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:47:40 +1000 (EST)
Received: from int-nj2gw-6.online-age.net (int-nj2gw-6 [3.159.236.70])
	by ext-nj2gw-1.online-age.net (8.12.9/8.12.9/990426-RLH) with ESMTP id
	j5FF7MwU021510 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 11:07:23 -0400 (EDT)
Received: from cinmlef05.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-nj2gw-6.online-age.net (8.12.9/8.12.8/990426-RLH) with ESMTP id
	j5FF7LBc013992 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 11:07:22 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Jun 2005 10:09:44 -0500
Message-ID: <45ABD2373C33C4459D42B40EC4F346F207E81735@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud \(GE Infrastructure\)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux 2.4.26 boot over network
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a 440GX based board running Linux 2.4.26

I have successfully booted  over the network by setting the boot =
argument to
Kernel command line: console=3DttyS0,9600n8 root=3D/dev/nfs rw =
ip=3Dbootp da104_gpio=3D8

IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
eth0: IBM emac, MAC 00:30:f7:71:35:20
eth0: Link is Up
eth0: Speed: 10, Half duplex.
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.49.189, my address is =
192.168.49.1
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.49.1, mask=3D255.255.255.0, =
gw=3D255.255.255.255,
     host=3D192.168.49.1, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.49.189, rootserver=3D192.168.49.189, =
rootpath=3D/home/proj/at921/Filesys/usr/local/gefnes/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.49.189
Looking up port of RPC 100005/1 on 192.168.49.189

Now, I am trying to boot Linux over the network using the following boot =
arguments:
Kernel command line: console=3DttyS0,9600n8 console=3Dtty0 =
root=3D/dev/nfs rw =
nfsroot=3D192.168.49.189:/home/proj/at921/Filesys/usr/local/gefnes/target=
 192.168.49.1:192.168.49.189::255.255.255.0::eth0:off da104_gpio=3D8

It ends up failing:

TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.49.189
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.49.189
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 101
mount: RPC call returned error 101
Root-NFS: Server returned error -101 while mounting =
/home/proj/at921/Filesys/usr/local/gefnes/target
eth0: Link is Up
eth0: Speed: 10, Half duplex.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or 02:00


While debugging I noticed that emac_open was not even called yet. Hence, =
no packets come out.=20
Linux tried to look up for a RPC port before the EMAC port is is opened.

Is that a problem that has already been seen?
