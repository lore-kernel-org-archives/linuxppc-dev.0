Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id 9077967A2F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 13:03:15 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 40so87909rnz
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 18:03:13 -0800 (PST)
Message-ID: <c3d0340b05021518037b1758cc@mail.gmail.com>
Date: Tue, 15 Feb 2005 18:03:12 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Incomplete network configuration information when booting from NFS
	root on Ebony
Reply-To: Shawn Jin <shawnxjin@gmail.com>
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

Is anybody using linux-2.6.10 from kernel.org for testing IBM Ebony board?

I found that 2.6.10 is not aware of U-Boot. That is, it neither
understands U-Boot's bd_info nor parses U-Boot's bootargs. So even if
the ethernet MAC address is set for EMAC0 on uboot, the kernel doesn't
get the value from it. Instead it reads MAC address from Ebony VPD,
which results in FF:FF:FF:FF:FF:FF. Isn't it strange that mac address
isn't set in its VPD?

After some hacks in arch/ppc/platforms/4xx/ebony.c, the kernel now can
get MAC address and boot arguments from uboot. However a new problem
occurs. When the kernel tries to mount a NFS root filesystem, it
complains incomplete network configuration information. See the
following message dump. Any hints to solve the problem? Thanks a lot.

## Transferring control to Linux (at address 00000000) ...
Linux version 2.6.10 (xjin@swl001.scs.agilent.com) (gcc version 3.3.3
(DENX ELDK 3.1 3.3.3-8)) #11 T
ue Feb 15 16:41:47 PST 2005
IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
Built 1 zonelists
Kernel command line: root=/dev/nfs rw
nfsroot=192.68.0.47:/opt/eldk3.1/ppc_4xx
ip=192.168.0.245:192.168.0.47:::::off

<snipped>

mal0: Initialized, 4 tx channels, 2 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM emac, MAC 00:04:ac:e3:1b:bb
eth0: Found Generic MII PHY (0x08)
zmii0: input 1 in RMII mode
eth1: IBM emac, MAC FF:FF:FF:FF:FF:FF
eth1: Found Generic MII PHY (0x09)

<--- only eth0's mac address is set on uboot -->

mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: Link is Up
eth0: Speed: 100, Full duplex.
IP-Config: Incomplete network configuration information.

????

Looking up port of RPC 100003/2 on 130.27.84.47
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 130.27.84.47
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 101
mount: RPC call returned error 101
Root-NFS: Server returned error -101 while mounting /opt/eldk3.1/ppc_4xx
VFS: Unable to mount root fs via NFS, trying floppy.
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
 <0>Rebooting in 180 seconds..<6>eth0: Link is Up
eth0: Speed: 100, Full duplex.

-Shawn.
