Subject: RE: Kernel Panic while building IP or TCP hash tables
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 5 Jun 2003 09:06:21 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED7030377@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevl@interfaceconcept.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I experienced a similar problem with my system, I was not sure if it was specific to my implementation. Can you try the following patch and tell us if it helps?

It registers the IPv4 handling functions AFTER initializing the IP routing stuff. Early packets could enter the stack and crash the system.

--- Kernel.old/net/ipv4/ip_output.c     Thu Jun  5 09:00:39 2003
+++ Kernel/net/ipv4/ip_output.c Thu Jun  5 09:00:28 2003
@@ -1087,11 +1087,11 @@

 void __init ip_init(void)
 {
-       dev_add_pack(&ip_packet_type);
-
        ip_rt_init();
        inet_initpeers();

+       dev_add_pack(&ip_packet_type);
+
 #ifdef CONFIG_IP_MULTICAST
        proc_net_create("igmp", 0, ip_mc_procinfo);
 #endif


Salutations,

--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

> -----Original Message-----
> From: Gérard Guével [mailto:gguevl@interfaceconcept.com]
> Sent: 5 juin, 2003 08:49
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Kernel Panic while building IP or TCP hash tables
>
>
>
> Hello,
>
> I'm running the Elinos 2.4.18 linux kernel on a custom 8260 board.
>
> I have the following kernel panic only if I receive a broadcast or
> unicast frame while the system is building the IP routing cache hash
> table or the TCP hash tables.
>
> Since I can see the start of the "IP: routing ..." string, I think
> the kernel panic occurs before the TCP phase if the printk is,
> as I suppose, a blocking (synchronized ?) write function.
>
> ...
> eth0: FCC ENET Version 0.3, 00:10:cd:31:18:20
> eth1: FCC ENET Version 0.3, 00:10:cd:31:18:21
> eth2: FCC ENET Version 0.3, 00:10:cd:31:18:22
> loop: loaded (max 8 devices)
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing <4>Oops: kernel access of bad area, sig: 11
> NIP: C0090A9C XER: 00000000 LR: C0093528 SP: C0599CA0 REGS:
> c0599bf0 TRAP:
> 0300d
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 75DCDC7A, DSISR: 20000000
> TASK = c0598000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00222298 C0599CA0 C0598000 C05B4080 A8020B0D A8020A0D 00000000
> 00000003
> GPR08: C0120000 C0100000 75DCDBFE C0100000 0000000D 0006B270 AAA96041
> FF010000
> GPR16: 00008149 0A114000 FF010000 41DA5241 00001032 000000BD 0000012B
> C00F5040
> GPR24: 0000012C C05B8400 C05B84DC C05B8400 A8020A0D 00000000 C05B4080
> A8020B0D
> Call backtrace:
> 00000000 C0093528 C0084C20 C00181E0 C00070D8 C0005F2C 73747576
> 000081A4 C0012DA4 C0012E3C C0012F5C C00132A0 C0013194 C00FEAF0
> C00FED54 C00FF5DC C00F67A0 C00F739C C0005B00 C000848C
> Kernel panic: Aiee, killing interrupt handler!
>
> For information the right start is like :
> ...
> eth0: FCC ENET Version 0.3, 00:10:cd:31:17:a0
> eth1: FCC ENET Version 0.3, 00:10:cd:31:17:a1
> eth2: FCC ENET Version 0.3, 00:10:cd:31:17:a2
> loop: loaded (max 8 devices)
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 2048)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ramfs filesystem).
> UNTAR: Extracting root archive: do..
> init started:  BusyBox v0.60.5 (2003î2.20-13:09+0000) multi-call
>
>
> Thanks in advance
> Gérard
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
