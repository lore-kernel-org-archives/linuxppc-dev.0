From: =?iso-8859-1?B?R+lyYXJkIEd16XZlbA==?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with FCC under 2.4.18 kernel
Date: Mon, 18 Nov 2002 17:36:13 +0100
Message-ID: <000001c28f20$9c8236a0$3101a8c0@DOMAIN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm running the 2.4.18 linux kernel on a custom 8260 board.

Sometimes I have the following problem with the ethernet 0 device while
using a NFS.
	Sending BOOTP requests . OK
	IP-Config: Got BOOTP answer from 192.168.1.65, my address is 192.168.1.145
	IP-Config: Complete:
      	device=eth0, addr=192.168.1.145, mask=255.255.255.0,
gw=255.255.255.255,
     	host=192.168.1.145, domain=, nis-domain=(none),
     	bootserver=192.168.1.65, rootserver=192.168.1.65,
rootpath=/home/targetnfs/ver_cour
	NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
	Looking up port of RPC 100003/2 on 192.168.1.65
	Looking up port of RPC 100005/1 on 192.168.1.65
	VFS: Mounted root (nfs filesystemÿ
	Oops: kernel access of bad area, sig: 11
	NIP: C002AF58 XER: 00000000 LR: C002AEF8 SP: C010B1F0 REGS: c010b140 TRAP:
0300    Not tainted
	MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
	DAR: 401F66D4, DSISR: 20000000
	TASK = c0109430[0] 'swapper' Last syscall: 120
	last math c1f9e000 last altivec 00000000
	GPR00: DFFFFFFF C010B1F0 C0109430 00000001 00009032 C010B300 00000004
C01F66C0
	GPR08: C1F84000 401F66BC 00000800 00000003 42000022 1005D7A0 34068873
FF010000
	GPR16: 8AC410E4 CA800C11 FF010000 78E4841E 00001032 0010B2F0 00000000
C0003F8C
	GPR24: C000506C 00000400 00000000 C0150000 00000020 C01565E8 C010B1F8
C01565E0
	Call backtrace:
	C00C34CC C008E648 C008A5D0 C008A224 C0004F90 C00050C0 C0003F8C
	C00203F0 C00055F8 C0005620 C0003910 C0119718 0000372C
	Kernel panic: Aiee, killing interrupt handler!
	In interrupt handler - not syncing

The last function calls are fcc_enet_rx and alloc_skb.

The problem happens while I mount the NFS or later while the init phase is
running.
If I can enter under the busybox application, I have no more problem with
the fcc device.

I can increase the problem frequency if I ping on the target while the boot
phase.
It seems the problem happens if I receive frames during this boot phase.
With an embedded ramdisk, it works fine.

Does anyone already meet this situation ?

Thanks in advance.
Gérard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
