Message-Id: <200012040859.eB48wj301431@denx.local.net>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.4.0-test11 - MPC860T FEC question. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 04 Dec 2000 01:43:05 +0100."
             <200012040043.eB40h5028102@denx.local.net>
Date: Mon, 04 Dec 2000 09:58:45 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:

> I just found another problem with the FEC / MII code. It happens when
> I try to use BOOTP in the Linux kernel (I haven't been doing this for
> a long time, since _if_ we use BOOTP, we do so in PPCBoot,  and  pass
> all information to the kernel instead of running BOOTP twice).
>
> Here is what I see:
...

I fixed one of the problems, which was my own fault when patching the
code.

But the other one remains:

...
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: IBM-DCXA-210000, ATA DISK drive
ide0 at 0xc2000000-0xc2000007,0xc2000106 on irq 10
hda: 19640880 sectors (10056 MB) w/420KiB Cache, CHS=19485/16/63
Partition check:
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6
eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 12, addr 00:d0:93:00:01:cb
eth0: Phy @ 0x0, type LXT971 (0x001378e1)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
eth0: config: auto-negotiation on, 100HDX, 10HDX.
Sending BOOTP requests............. timed out!
IP-Config: Auto-configuration of network failed.
eth0: status: link up, 100 Mbps Half Duplex, auto-negotiation complete.
...

Then I wrote:

> It seems the "link up" interrupt comes much too late for the
> "IP-Config" part; shouldn't we wait in fec_enet_open() for
> "fep->link" to come up?

I was wrong here. The _interrupt_ comes  just  when  it  should.  The
problem is that the function which actually sets the "fep->link" flag
(mii_relink)  is  not  run  immediately,  but  from a queue_task(...,
&tq_scheduler) call - and it's scheduled much too late for  BOOTP  to
work.

I have hacked the code so that it sets the "fep->link" flag in
mii_parse_sr() which actually detects the status change. Now I get:

...
eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 12, addr 00:d0:93:00:01:cb
eth0: Phy @ 0x0, type LXT971 (0x001378e1)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
eth0: config: auto-negotiation on, 100HDX, 10HDX.
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.0.0.2, my address is 10.0.0.99
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 10.0.0.2
eth0: status: link up, 100 Mbps Half Duplex, auto-negotiation complete.
Looking up port of RPC 100005/2 on 10.0.0.2
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 44k init
Stand-alone shell (version 2.1)
>

This works for me, but it's still conceptually  broken.  mii_relink()
is still running much too late (it doesn't do any harm though).

How should we handle this? I've tried to  compare  against  the  82xx
code  in "fcc_enet.c", but this seems to be kind of incomplete; there
is no mii_link code at all, and the mii_relink()  function  is  never
used.

Am I missing something? Isn't bk://hq.fsmlabs.com:5005  the  location
for most current sources?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
