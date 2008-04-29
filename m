Return-Path: <jose.franca@nsn.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AA28.5765EC80"
Subject: SKB corruption on heavy traffic
Date: Tue, 29 Apr 2008 19:39:07 +0100
Message-ID: <56DEE2D3217CD946B290399093C8FA7C212D8D@PTLIEXC001.nsn-intra.net>
From: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
To: <linuxppc-dev@ozlabs.org>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8AA28.5765EC80
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello Community!

	We are developing a MPC8247 based telecom board (512MB), using
linux 2.4 with some proprietary changes on IP stack and we are facing
some problems when we have heavy traffic on our Ethernet interfaces...
Namely:

		- When sending a ping flood we have skb corruption after
some variable time (looks like memory problems). Resuming what seems to
be happening: after release (dealloc) of the skb, the kernel tries to
access it again. To verify this we have implemented a list of "to be
freed" skb to have a delay between the time they are freed by the stack
and the actual dealloc. In this delay we are able to verify that the skb
is changed. =20
		- We have reports of DMA transfers not completed in
heavy traffic.
		- After a while, and skb corrupted messages appearing in
the console, we start to have a scrambled characters. So, after some
seconds we don't understand what is written. This problem solves after
the crash or reboot. Which means that uart also seems to crack in heavy
load or at least some.


Below are some of our traces that show our problem... Someone has some
hints of what could be leading to this?? HHHHEEEEEELLLPP!!!!


Huge Thanks!=20
Filipe.

F:bcmhal_shape_modid_phyport_to_pnum L:1046 Invalid modid received 48
port 3
Apr 25 19:59:14  system: F:bcmhal_shape_modid_phyport_to_pnum L:1046
Invalid modid received 48 port 3=20
Apr 25 19:59:14  system: F:bcm_enet_rx L:1788 Packet received from an
invalid port 3 modid 48=20
F:bcmhal_shape_modid_phyport_to_pnum L:1046 Invalid modid received 48
port 3
Apr 25 20:02:39  system: F:bcmhal_shape_modid_phyport_to_pnum L:1046
Invalid modid received 48 port 3=20
Apr 25 20:02:39  system: F:bcm_enet_rx L:1788 Packet received from an
invalid port 3 modid 48=20
F:bcmhal_shape_modid_phyport_to_pnum L:1046 Invalid modid received 48
port 3
Apr 25 20:06:57  system: F:bcmhal_shape_modid_phyport_to_pnum L:1046
Invalid modid received 48 port 3=20
Apr 25 20:06:57  system: F:bcm_enet_rx L:1788 Packet received from an
invalid port 3 modid 48=20
Apr 25 21:54:06  comd: buf =3D f5 43 7d 43 bb ff 80 18 36 70 6e 91 00 00
01 01 08 0a 00 0e c1 6d 00 00 41 15 6e 29 01 07 04 e6 =20
Apr 25 21:54:08  comd: buf =3D 00 00 00 00 00 00 00 00 00 00 00 00 43 49
47 47 07 05 20 71 00 00 00 00 00 00 00 00 00 00 00 03 =20
Apr 25 21:54:09  system:  skbuff.c:skb_clone:647: Bingle, got a freed
skb being cloned, return NULL!!!<1> skbuff.c:skb_clone:647: Bingle, got
a freed=20
skb being cloned, return NULL!!!<3>tcp_write_xmit: clone failed !=20
Apr 25 21:54:09  comd: buf =3D 00 6e 29 01 07 04 e6 55 7b 00 00 ff ff 33
2d ff ff 00 00 00 0f 33 2d 00 03 00 00 00 08 00 00 00 =20
Apr 25 21:54:09  comd: buf =3D 00 00 00 00 00 00 00 00 00 00 00 00 53 49
44 41 2a 00 5a f9 00 00 00 00 00 00 00 00 00 00 00 01 =20
Apr 25 21:54:11  comd: message data field too long, max=3D12288  fd=3D82
((nil))       source: shelf=3D2021 slot=3D2223 service=3D2425 =
port=3D2627
destination: s
helf=3D1819 slot=3D1a1b service=3D1c1d port=3D1e1f message type: =
28292a2b
length: 2c2d2e2f fd out of sync, will be closed (nil).=20
Oops: Exception in kernel mode, sig: 7
NIP: C0034138 XER: 20000000 LR: C011B73C SP: C04E3D20 REGS: c04e3c70
TRAP: 0600    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C1611DBF, DSISR: 00010920
TASK =3D c04e2000[2] 'keventd' Last syscall: 120=20
last math cb0f8000 last altivec 00000000
GPR00: C1611DBF C04E3D20 C04E2000 C1611DAB 00000000 00000190 C1611DAB
0003CAEC=20
GPR08: C0F98B04 D1C8201A C0F5C018 C0230000 22002024 1031E1BC 0FFD5000
1009B000=20
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000001 00000000
C01E0000=20
GPR24: C01F0000 06D01B7F C04E3E18 00000001 C01D0000 0000158E 0000AC70
C3442DA0=20
TESCR1 0xf0010040: 00100000 TESCR2 0xf0010044: 00000000
ESR 0xf0010884: 00000000=20
PCI_EACR 0xf0010890: 0000000c=20
PCI_EDCR 0xf0010898: 00000000=20
PCI_ECCR 0xf00108a0: 00000000
GFPGA regs=20
0xd0000000 1901200803051610 0000000000090101
0xd0000100 007f7f7f7f7f7f7f 7f7f7f7f7f7f7f7f
0xd0000200 008dd3d3d3d3d3d3 d3d3d3d3d3d3d3d3
0xd0000280 00ffffff00000000 d3d3d3d3d3d3d3d3
0xd0000300 ea19b993faff0040 0000050000001600
0xd0000380 000f0f0f00000000 0000000000000000
0xd0000400 660f01ff0100a5a5 a5a5a5a5a5a5a5a5
0xd0000480 0001010100000000 a5a5a5a5a5a5a5a5
0xd0000500 0f01010101010101 0101010101010101
0xd0000580 003f3f3f00000000 0101010101010101
0xd0000600 1f9a030a24440100 0000000000000000
0xd0000680 00ffffff00000000 0000000000000000
0xd0000690 00ffffff00000000 0000000000000000
0xd00006a0 00ffffff00000000 0000000000000000
0xd00006b0 00e727c000000000 0000000000000000
Call backtrace:=20
C011D8CC C011B73C C011B7D0 C011B9C8 C011BC24 C01496CC C014A054=20
C014D380 C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58=20
C001B338 C002517C C000876C=20
Apr 25 21:54:12  system:  skbuff.c:skb_clone:647: Bingle, got a freed
skb being cloned, return NULL!!!<1> skbuff.c:skb_clone:647: Bingle, got
a freed=20
skb being cloned, return NULL!!!<1> skbuff.c:skb_clone:647: Bingle, got
a freed skb being cloned, return NULL!!!<1> skbuff.c:skb_clone:647:
Bingle, go
t a freed skb being cloned, return NULL!!!9C C0120C58 =20
Apr 25 21:54:12  system: C001B338 C002517C C000876C =20
Apr 25 21:54:12  system: skb_release_data:400 memory ffffee84 out of
range!=20
Apr 25 21:54:12  system: Call backtrace: =20
Apr 25 21:54:12  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:12  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:12  system: C001B338 C002517C C000876C =20
Apr 25 21:54:12  system: skb_release_data:400 memory ffffeea0 out of
range!=20
Apr 25 21:54:12  system: Call backtrace: =20
Apr 25 21:54:12  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:12  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:12  system: C001B338 C002517C C000876C =20
Apr 25 21:54:12  system: skb_release_data:400 memory ffffeec4 out of
range!=20
Apr 25 21:54:12  system: Call backtrace: =20
Apr 25 21:54:12  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:12  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:12  system: C001B338 C002517C C000876C =20
Apr 25 21:54:12  system: skb_release_data:400 memory ffffeef8 out of
range!=20
Apr 25 21:54:12  system: Call backtrace: =20
Apr 25 21:54:12  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:12  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:12  system: C001B338 C002517C C000876C =20
Apr 25 21:54:12  system: skb_release_data:400 memory ffffef34 out of
range!=20
Apr 25 21:54:12  system: Call backtrace: =20
Apr 25 21:54:12  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:12  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:12  system: C001B338 C002517C C000876C =20
Apr 25 21:54:12  system: skb_release_data:400 memory ffffef44 out of
range!=20
Apr 25 21:54:12  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory ffffef54 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory ffffef64 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory ffffef74 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 41646472 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
linux-bcm-core (127): soc_counter_thread: DMA did not finish
buf32=3Dcd380000
linux-bcm-core (132): soc_counter_thread: DMA did not finish
buf32=3Dcd389800
linux-bcm-core (130): soc_counter_thread: DMA did not finish
buf32=3Dcd382400
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 700a0000 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 6d654164 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 2025700a out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 496e2025 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 70293a0a out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:13  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:13  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:13  system: C001B338 C002517C C000876C =20
Apr 25 21:54:13  system: skb_release_data:400 memory 726f6c42 out of
range!=20
Apr 25 21:54:13  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 72616365 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 31000000 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 73202825 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 70526574 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 203d2025 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 726f6c42 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 72616365 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 32000000 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 61636b74 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:14  system: skb_release_data:400 memory 54657374 out of
range!=20
Apr 25 21:54:14  system: Call backtrace: =20
Apr 25 21:54:14  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:14  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:14  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 68756875 out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 10015ddc out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 0000ffff out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 64437472 out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 636b0000 out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
linux-bcm-core (127): soc_counter_thread: DMA did not finish
buf32=3Dcd380000
linux-bcm-core (132): soc_counter_thread: DMA did not finish
buf32=3Dcd389800
linux-bcm-core (130): soc_counter_thread: DMA did not finish
buf32=3Dcd382400
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 014a5374 out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 7053796e out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory ee0e612c out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory 076dc419 out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:15  system: skb_release_data:400 memory e963a535 out of
range!=20
Apr 25 21:54:15  system: Call backtrace: =20
Apr 25 21:54:15  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:15  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:15  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory 0edb8832 out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory e0d5e91e out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory 09b64c2b out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory e7b82d07 out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory 1db71064 out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory f3b97148 out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory 1adad47d out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory f4d4b551 out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory 136c9856 out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory fd62f97a out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:16  system: C001B338 C002517C C000876C =20
Apr 25 21:54:16  system: skb_release_data:400 memory 14015c4f out of
range!=20
Apr 25 21:54:16  system: Call backtrace: =20
Apr 25 21:54:16  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:16  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory fa0f3d63 out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory 3b6e20c8 out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory d56041e4 out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory 3c03e4d1 out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory d20d85fd out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
linux-bcm-core (127): soc_counter_thread: DMA did not finish
buf32=3Dcd380000
linux-bcm-core (132): soc_counter_thread: DMA did not finish
buf32=3Dcd389800
linux-bcm-core (130): soc_counter_thread: DMA did not finish
buf32=3Dcd382400
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory 35b5a8fa out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory dbbbc9d6 out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory 32d86ce3 out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory dcd60dcf out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:17  system: C001B338 C002517C C000876C =20
Apr 25 21:54:17  system: skb_release_data:400 memory 26d930ac out of
range!=20
Apr 25 21:54:17  system: Call backtrace: =20
Apr 25 21:54:17  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:17  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:18  system: C001B338 C002517C C000876C =20
Apr 25 21:54:18  system: skb_release_data:400 memory 21b4f4b5 out of
range!=20
Apr 25 21:54:18  system: Call backtrace: =20
Apr 25 21:54:18  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:18  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:18  system: C001B338 C002517C C000876C =20
Apr 25 21:54:18  system: skb_release_data:400 memory cfba9599 out of
range!=20
Apr 25 21:54:18  system: Call backtrace: =20
Apr 25 21:54:18  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:18  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:18  system: C001B338 C002517C C000876C =20
Apr 25 21:54:18  system: skb_release_data:400 memory 2802b89e out of
range!=20
Apr 25 21:54:18  system: Call backtrace: =20
Apr 25 21:54:18  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:18  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:18  system: C001B338 C002517C C000876C =20
Apr 25 21:54:18  system: skb_release_data:400 memory 2f6f7c87 out of
range!=20
Apr 25 21:54:18  system: Call backtrace: =20
Apr 25 21:54:18  system: C011D8CC C011B720 C011B7D0 C011B9C8 C011BC24
C01496CC C014A054 =20
Apr 25 21:54:18  system: C014D380 C0156584 C0156B70 C0137B08 C0137FD8
C0120B9C C0120C58 =20
Apr 25 21:54:18  system: C001B338 C002517C C000876C =20
Apr 25 21:54:18  system: Oops: Exception in kernel mode, sig: 7=20
Apr 25 21:54:18  system: NIP: C0034138 XER: 20000000 LR: C011B73C SP:
C04E3D20 REGS: c04e3c70 TRAP: 0600    Not tainted=20
Apr 25 21:54:18  system: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

Apr 25 21:54:18  system: DAR: C1611DBF, DSISR: 00010920=20
Apr 25 21:54:18  system: TASK =3D c04e2000[2] 'keventd' Last syscall: =
120

Apr 25 21:54:18  system: last math cb0f8000 last altivec 00000000=20
Apr 25 21:54:18  system: GPR00: C1611DBF C04E3D20 C04E2000 C1611DAB
00000000 00000190 C1611DAB 0003CAEC =20
Apr 25 21:54:18  system: GPR08: C0F98B04 D1C8201A C0F5C018 C0230000
22002024 1031E1BC 0FFD5000 1009B000 =20
Apr 25 21:54:18  system: GPR16: 00000000 00000000 00000000 00000000
003FF000 00000001 00000000 C01E0000 =20
Apr 25 21:54:18  system: GPR24: C01F0000 06D01B7F C04E3E18 00000001
C01D0000 0000158E 0000AC70 C3442DA0 =20
Apr 25 21:54:18  system: TESCR1 0xf0010040: 00100000 TESCR2 0xf0010044:
00000000=20
Apr 25 21:54:18  system: ESR 0xf0010884: 00000000 =20
Apr 25 21:54:18  system: PCI_EACR 0xf0010890: 0000000c =20
Apr 25 21:54:18  system: PCI_EDCR 0xf0010898: 00000000 =20
Apr 25 21:54:18  system: PCI_ECCR 0xf00108a0: 00000000=20



------_=_NextPart_001_01C8AA28.5765EC80
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.14">
<TITLE>SKB corruption on heavy traffic</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello Community!</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">We are developing a MPC8247 based telecom board (512MB), =
using linux 2.4 with some proprietary changes on IP stack and we are =
facing some problems when we have heavy traffic on our Ethernet =
interfaces&#8230; Namely:</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">- When sending a ping flood we have skb corruption after =
some variable time (looks like memory problems). Resuming what seems to =
be happening: after release (dealloc) of the skb, the kernel tries to =
access it again. To verify this we have implemented a list of &quot;to =
be freed&quot; skb to have a delay between the time they are freed by =
the stack and the actual dealloc. In this delay we are able to verify =
that the skb is changed.&nbsp; </FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">- We have reports of DMA transfers not completed in heavy =
traffic.</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">- After a while, and skb corrupted messages appearing in =
the console, we start to have a scrambled characters. So, after some =
seconds we don't understand what is written. This problem solves after =
the crash or reboot. Which means that uart also seems to crack in heavy =
load or at least some.</FONT></P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Below are some of our traces that show =
our problem&#8230; Someone has some hints of what could be leading to =
this?? HHHHEEEEEELLLPP!!!!</FONT></P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Huge Thanks! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Filipe.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">F:bcmhal_shape_modid_phyport_to_pnum =
L:1046 Invalid modid received 48 port 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 19:59:14&nbsp; system: =
F:bcmhal_shape_modid_phyport_to_pnum L:1046 Invalid modid received 48 =
port 3 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 19:59:14&nbsp; system: =
F:bcm_enet_rx L:1788 Packet received from an invalid port 3 modid 48 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">F:bcmhal_shape_modid_phyport_to_pnum =
L:1046 Invalid modid received 48 port 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 20:02:39&nbsp; system: =
F:bcmhal_shape_modid_phyport_to_pnum L:1046 Invalid modid received 48 =
port 3 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 20:02:39&nbsp; system: =
F:bcm_enet_rx L:1788 Packet received from an invalid port 3 modid 48 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">F:bcmhal_shape_modid_phyport_to_pnum =
L:1046 Invalid modid received 48 port 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 20:06:57&nbsp; system: =
F:bcmhal_shape_modid_phyport_to_pnum L:1046 Invalid modid received 48 =
port 3 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 20:06:57&nbsp; system: =
F:bcm_enet_rx L:1788 Packet received from an invalid port 3 modid 48 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:06&nbsp; comd: buf =3D f5 =
43 7d 43 bb ff 80 18 36 70 6e 91 00 00 01 01 08 0a 00 0e c1 6d 00 00 41 =
15 6e 29 01 07 04 e6&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:08&nbsp; comd: buf =3D 00 =
00 00 00 00 00 00 00 00 00 00 00 43 49 47 47 07 05 20 71 00 00 00 00 00 =
00 00 00 00 00 00 03&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:09&nbsp; system:&nbsp; =
skbuff.c:skb_clone:647: Bingle, got a freed skb being cloned, return =
NULL!!!&lt;1&gt; skbuff.c:skb_clone:647: Bingle, got a freed </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">skb being cloned, return =
NULL!!!&lt;3&gt;tcp_write_xmit: clone failed ! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:09&nbsp; comd: buf =3D 00 =
6e 29 01 07 04 e6 55 7b 00 00 ff ff 33 2d ff ff 00 00 00 0f 33 2d 00 03 =
00 00 00 08 00 00 00&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:09&nbsp; comd: buf =3D 00 =
00 00 00 00 00 00 00 00 00 00 00 53 49 44 41 2a 00 5a f9 00 00 00 00 00 =
00 00 00 00 00 00 01&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:11&nbsp; comd: message =
data field too long, max=3D12288&nbsp; fd=3D82 =
((nil))&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; source: shelf=3D2021 =
slot=3D2223 service=3D2425 port=3D2627&nbsp; destination: s</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">helf=3D1819 slot=3D1a1b service=3D1c1d =
port=3D1e1f message type: 28292a2b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
length: 2c2d2e2f fd out of sync, will be closed (nil). </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oops: Exception in kernel mode, sig: =
7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP: C0034138 XER: 20000000 LR: =
C011B73C SP: C04E3D20 REGS: c04e3c70 TRAP: 0600&nbsp;&nbsp;&nbsp; Not =
tainted</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 =
IR/DR: 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">DAR: C1611DBF, DSISR: 00010920</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TASK =3D c04e2000[2] 'keventd' Last =
syscall: 120 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">last math cb0f8000 last altivec =
00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR00: C1611DBF C04E3D20 C04E2000 =
C1611DAB 00000000 00000190 C1611DAB 0003CAEC </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR08: C0F98B04 D1C8201A C0F5C018 =
C0230000 22002024 1031E1BC 0FFD5000 1009B000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR16: 00000000 00000000 00000000 =
00000000 003FF000 00000001 00000000 C01E0000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR24: C01F0000 06D01B7F C04E3E18 =
00000001 C01D0000 0000158E 0000AC70 C3442DA0 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TESCR1 0xf0010040: 00100000 TESCR2 =
0xf0010044: 00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">ESR 0xf0010884: 00000000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PCI_EACR 0xf0010890: 0000000c </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PCI_EDCR 0xf0010898: 00000000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PCI_ECCR 0xf00108a0: 00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GFPGA regs </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000000 1901200803051610 =
0000000000090101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000100 007f7f7f7f7f7f7f =
7f7f7f7f7f7f7f7f</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000200 008dd3d3d3d3d3d3 =
d3d3d3d3d3d3d3d3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000280 00ffffff00000000 =
d3d3d3d3d3d3d3d3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000300 ea19b993faff0040 =
0000050000001600</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000380 000f0f0f00000000 =
0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000400 660f01ff0100a5a5 =
a5a5a5a5a5a5a5a5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000480 0001010100000000 =
a5a5a5a5a5a5a5a5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000500 0f01010101010101 =
0101010101010101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000580 003f3f3f00000000 =
0101010101010101</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000600 1f9a030a24440100 =
0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000680 00ffffff00000000 =
0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd0000690 00ffffff00000000 =
0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd00006a0 00ffffff00000000 =
0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">0xd00006b0 00e727c000000000 =
0000000000000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Call backtrace: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">C011D8CC C011B73C C011B7D0 C011B9C8 =
C011BC24 C01496CC C014A054 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">C014D380 C0156584 C0156B70 C0137B08 =
C0137FD8 C0120B9C C0120C58 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">C001B338 C002517C C000876C </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system:&nbsp; =
skbuff.c:skb_clone:647: Bingle, got a freed skb being cloned, return =
NULL!!!&lt;1&gt; skbuff.c:skb_clone:647: Bingle, got a freed </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">skb being cloned, return =
NULL!!!&lt;1&gt; skbuff.c:skb_clone:647: Bingle, got a freed skb being =
cloned, return NULL!!!&lt;1&gt; skbuff.c:skb_clone:647: Bingle, =
go</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">t a freed skb being cloned, return =
NULL!!!9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: =
skb_release_data:400 memory ffffee84 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: =
skb_release_data:400 memory ffffeea0 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: =
skb_release_data:400 memory ffffeec4 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: =
skb_release_data:400 memory ffffeef8 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: =
skb_release_data:400 memory ffffef34 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: =
skb_release_data:400 memory ffffef44 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:12&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory ffffef54 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory ffffef64 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory ffffef74 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 41646472 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (127): =
soc_counter_thread: DMA did not finish buf32=3Dcd380000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (132): =
soc_counter_thread: DMA did not finish buf32=3Dcd389800</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (130): =
soc_counter_thread: DMA did not finish buf32=3Dcd382400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 700a0000 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 6d654164 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 2025700a out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 496e2025 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 70293a0a out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: =
skb_release_data:400 memory 726f6c42 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:13&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 72616365 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 31000000 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 73202825 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 70526574 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 203d2025 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 726f6c42 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 72616365 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 32000000 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 61636b74 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: =
skb_release_data:400 memory 54657374 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:14&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 68756875 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 10015ddc out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 0000ffff out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 64437472 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 636b0000 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (127): =
soc_counter_thread: DMA did not finish buf32=3Dcd380000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (132): =
soc_counter_thread: DMA did not finish buf32=3Dcd389800</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (130): =
soc_counter_thread: DMA did not finish buf32=3Dcd382400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 014a5374 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 7053796e out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory ee0e612c out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory 076dc419 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: =
skb_release_data:400 memory e963a535 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:15&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory 0edb8832 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory e0d5e91e out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory 09b64c2b out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory e7b82d07 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory 1db71064 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory f3b97148 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory 1adad47d out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory f4d4b551 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory 136c9856 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory fd62f97a out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: =
skb_release_data:400 memory 14015c4f out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:16&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory fa0f3d63 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory 3b6e20c8 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory d56041e4 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory 3c03e4d1 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory d20d85fd out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (127): =
soc_counter_thread: DMA did not finish buf32=3Dcd380000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (132): =
soc_counter_thread: DMA did not finish buf32=3Dcd389800</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">linux-bcm-core (130): =
soc_counter_thread: DMA did not finish buf32=3Dcd382400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory 35b5a8fa out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory dbbbc9d6 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory 32d86ce3 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory dcd60dcf out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: =
skb_release_data:400 memory 26d930ac out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:17&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: =
skb_release_data:400 memory 21b4f4b5 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: =
skb_release_data:400 memory cfba9599 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: =
skb_release_data:400 memory 2802b89e out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: =
skb_release_data:400 memory 2f6f7c87 out of range! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: Call =
backtrace:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C011D8CC =
C011B720 C011B7D0 C011B9C8 C011BC24 C01496CC C014A054&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C014D380 =
C0156584 C0156B70 C0137B08 C0137FD8 C0120B9C C0120C58&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: C001B338 =
C002517C C000876C&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: Oops: =
Exception in kernel mode, sig: 7 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: NIP: =
C0034138 XER: 20000000 LR: C011B73C SP: C04E3D20 REGS: c04e3c70 TRAP: =
0600&nbsp;&nbsp;&nbsp; Not tainted </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: MSR: =
00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: DAR: =
C1611DBF, DSISR: 00010920 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: TASK =3D =
c04e2000[2] 'keventd' Last syscall: 120&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: last =
math cb0f8000 last altivec 00000000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: GPR00: =
C1611DBF C04E3D20 C04E2000 C1611DAB 00000000 00000190 C1611DAB =
0003CAEC&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: GPR08: =
C0F98B04 D1C8201A C0F5C018 C0230000 22002024 1031E1BC 0FFD5000 =
1009B000&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: GPR16: =
00000000 00000000 00000000 00000000 003FF000 00000001 00000000 =
C01E0000&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: GPR24: =
C01F0000 06D01B7F C04E3E18 00000001 C01D0000 0000158E 0000AC70 =
C3442DA0&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: TESCR1 =
0xf0010040: 00100000 TESCR2 0xf0010044: 00000000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: ESR =
0xf0010884: 00000000&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: PCI_EACR =
0xf0010890: 0000000c&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: PCI_EDCR =
0xf0010898: 00000000&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr 25 21:54:18&nbsp; system: PCI_ECCR =
0xf00108a0: 00000000</FONT><SPAN LANG=3D"pt"> </SPAN>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C8AA28.5765EC80--
