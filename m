Message-ID: <3A6E224E.C0305107@mvista.com>
Date: Tue, 23 Jan 2001 17:31:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: CONFIG_HIGHMEM on PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Please excuse me if this was talked about recently (or not so
recently)...

Has anyone tried CONFIG_HIGHMEM on PPC lately?

If so, did it work?  Its not working for me (2.4.0-test13-pre3).

When I have 512 MB or less, works fine; as soon as I go over 512 MB, it
[almost] comes up fine, bootp's okay but then complains that there is no
initial console and no init found.  Here are the last few lines from the
console output (run with 1GB of memory with the memory ctlr having the
memory set up correctly and with the memory all contiguous):

Linux Tulip driver version 0.9.11 (November 3, 2000)
eth0: Digital DS21143 Tulip rev 65 at 0x7fff00, 00:01:AF:02:9D:99, IRQ
18.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3)
block.
eth0:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0x7ffe80, 00:01:AF:02:9D:98, IRQ
29.
eth1:  EEPROM default media type Autosense.
eth1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3)
block.
eth1:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
Sending BOOTP requests..... OK
IP-Config: Got BOOTP answer from 192.168.1.1, my address is 192.168.1.3
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/2 on 192.168.1.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 184k init 4k prep 4k openfirmware
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..


I need to look closer at ioremap_base, etc. but I have it set to
0xf0000000 which where I have BAT 0 set to map 1-1 up to 0xffffffff
(various devices are from 0xf000000 on up; PCI memory space at
0x80000000; PCI I/O space at 0xfc000000).

I'd appreciate any thoughts/suggestions.

Thanks,

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
