From: =?us-ascii?Q?Gerard_Guevel?= <gguevel@interfaceconcept.com>
To: "'Rune Torgersen'" <runet@innovsys.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FCC ethernets not stable
Date: Mon, 21 Jun 2004 10:15:50 +0200
Message-ID: <000001c45768$1d155890$5201a8c0@GEG2400>
MIME-Version: 1.0
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB0A@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I already had this problem with a 2.4.18 kernel.
ie something like :
...
eth0: FCC ENET Version 0.3, 00:10:cd:31:18:20
eth1: FCC ENET Version 0.3, 00:10:cd:31:18:21
eth2: FCC ENET Version 0.3, 00:10:cd:31:18:22
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing <4>Oops: kernel access of bad area, sig: 11
NIP: C0090A9C XER: 00000000 LR: C0093528 SP: C0599CA0 REGS: c0599bf0 TRAP:
0300d
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 75DCDC7A, DSISR: 20000000
TASK = c0598000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00222298 C0599CA0 C0598000 C05B4080 A8020B0D A8020A0D 00000000
00000003
GPR08: C0120000 C0100000 75DCDBFE C0100000 0000000D 0006B270 AAA96041
FF010000
GPR16: 00008149 0A114000 FF010000 41DA5241 00001032 000000BD 0000012B
C00F5040
GPR24: 0000012C C05B8400 C05B84DC C05B8400 A8020A0D 00000000 C05B4080
A8020B0D
Call backtrace:
00000000 C0093528 C0084C20 C00181E0 C00070D8 C0005F2C 73747576
000081A4 C0012DA4 C0012E3C C0012F5C C00132A0 C0013194 C00FEAF0
C00FED54 C00FF5DC C00F67A0 C00F739C C0005B00 C000848C
Kernel panic: Aiee, killing interrupt handler!

I received the right solution from Jean-Denis Boyer (thanks to him...)
>>
It registers the IPv4 handling functions AFTER initializing the IP routing
stuff.
Early packets could enter the stack and crash the system.

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
>>

I never saw this problem after installing this patch.

Regards
Gerard Guevel

-----Message d'origine-----
De : Rune Torgersen
Envoye : ven. 18 juin 2004 16:57
Objet : FCC ethernets not stable

I have notices that the FCC ethernet driver on 2.6.7 (linuxppc-2.5) is
not completely stable. Once in a while I get a kernel oops when the
driver starts.

Never had the problem on 2.6.5 and older.

CPM UART driver version 0.02
ttyS0 on SMC1 at 0x0000, BRG7
eth0: FCC ENET Version 0.3, 00:30:d7:00:01:09
eth1: FCC ENET Version 0.3, 00:30:d7:00:01:0a
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C015045C LR: C013C2A0 SP: DFF3DDA0 REGS: dff3dcf0 TRAP: 0300    Not
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 20000000
TASK = dff3f900[1] 'swapper' THREAD: dff3c000Last syscall: 120
GPR00: 00000000 DFF3DDA0 DFF3F900 C07B79E0 C076CC00 C01F3B0C 00001032
00000002
GPR08: C01F3B0C C0240000 DFF3C000 00000000 8010C082 1001D584 0FFCF000
007FFF74
GPR16: 00000000 00000001 007FFF00 0FFC9824 00000000 FFFFFFFF 00000002
0FF67BD0
GPR24: 00000000 FFFB7465 C01F24E0 00000040 DFF3DE18 C07B79E0 C07B79E0
C07B79E0
Call trace: [c013c2a0]  [c013c3ec]  [c013c56c]  [c001c4f4]  [c001c550]
[c00079d4]  [c000616c]  [c020c6e0]  [c020d0c0]  [c01fc62c]
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

The call trace resolves to:
Address         Function

c013c2a0        netif_receive_skb
c013c3ec        process_backlog
c013c56c        net_rx_action
c001c4f4        __do_softirq
c001c550        do_softirq
c00079d4        do_IRQ
c000616c        ret_from_except
c020c6e0        tcp_init
c020d0c0        inet_init
c01fc62c        do_initcalls

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
