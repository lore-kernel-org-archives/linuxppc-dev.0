Return-Path: <gil-ad@myrealbox.com>
Received: from sa10.bezeqint.net (sa10.bezeqint.net [192.115.104.24])
	by ozlabs.org (Postfix) with ESMTP id 8A97D68884
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 09:32:51 +1100 (EST)
From: Gil Madar <gil-ad@myrealbox.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Fri, 16 Dec 2005 00:20:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512160020.20891.gil-ad@myrealbox.com>
Subject: Crash after successfully mounting root filesystem over NFS
Reply-To: gil-ad@myrealbox.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I dumped part of the output, kept in the log_buf.
Please note the MPC866 receives an exception during access to the dual port ram...
This, of course leads to another exception, and so on.
The exception is during early stages of running busybox.
If I run a
while ( 1 ) schedule();
instead of loading root filesystem over NFS, the target respondes to pings without any problem.
I'm clueless whether this is a setup problem, or a software broblem.
I appreciate any comment.

Thans for your time,
Gil

----------------8X----------------------------------------------------------------
<6>NET: Registered protocol family 17
<4>IP-Config: Complete:
<4>      device=eth0, addr=10.0.0.4, mask=255.0.0.0, gw=10.0.0.138,
<4>     host=idu, domain=, nis-domain=(none),
<4>     bootserver=10.0.0.2, rootserver=10.0.0.2, rootpath=
<5>Looking up port of RPC 100003/2 on 10.0.0.2
<5>Looking up port of RPC 100005/1 on 10.0.0.2
<4>VFS: Mounted root (nfs filesystem).
<4>Freeing unused kernel memory: 92k init
<6>init() line 782 /bin/busybox
<4>Oops: kernel access of bad area, sig: 11 [#1]
<4>Oops: kernel access of bad area, sig: 11 [#2]
<4>NIP: C016A1AC LR: C0010FEC SP: C02ED340 REGS: c02ed290 TRAP: 0300    Not tainted
<4>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>DAR: 0F002820, DSISR: C0000000
<4>TASK = c02e9ae0[1] 'busybox' THREAD: c02ec000
<4>Last syscall: 11
<6>GPR00: 00000000 C02ED340 C02E9AE0 0F002820 C02903D0 0000002E 0EFFFFFF 00000000
<6>GPR08: C0260000 C026BF34 0F002820 C026BF34 00000001 00011F48 1007D900 00000000
<6>GPR16: C037E090 00000007 C02EDF10 00000000 0A000002 00000000 00000801 C0260000
<6>GPR24: C025EAC4 00001032 C0260000 C0260000 C0290000 000009CA 0000099C 0000000D
<4>Call trace: [00000000]  [c0011148]  [c0011714]  [c001153c]  [c0011338]  [c00033d4]  [c0009f38]  [c0002f20]  [c018f964]  [c019d52c]  [c018f9b4]  [c01a941c]  [c01ab380]  [c01c6b14]  [c01c6f30]
<0>Kernel panic - not syncing: Aiee, killing interrupt handler!
<4> <0>Rebooting in 180 seconds..Oops: kernel access of bad area, sig: 11 [#3]
<4>NIP: C000C99C LR: C00042BC SP: C02ED080 REGS: c02ecfd0 TRAP: 0300    Not tainted
<4>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>DAR: 0F00001C, DSISR: C0000000
<4>TASK = c02e9ae0[1] 'busybox' THREAD: c02ec000
<4>Last syscall: 11
<6>GPR00: C00042BC C02ED080 C02E9AE0 C02ED0C0 C0290000 C0290000 C0260000 000009CA
<6>GPR08: C0290000 0F000000 C02EC000 00010100 002E9CA8 00011F48 1007D900 00000000
<6>GPR16: C037E090 00000007 C02EDF10 00000000 0A000002 00000000 00000801 C0260000
<6>GPR24: C025EAC4 00001032 C0260000 C0290000 001CFDE0 00000001 C028E360 C02ED0C0
<4>Call trace: [c00042bc]  [c000312c]  [c0004a6c]  [c0013a6c]  [c00033f0]  [c0009f38]  [c0002f20]  [c01e0f78]  [00000000]  [c0011148]  [c0011714]  [c001153c]  [c0011338]  [c00033d4]  [c0009f38]
<4>Oops: kernel access of bad area, sig: 11 [#4]
<4>NIP: C000C99C LR: C00042BC SP: C02ECE90 REGS: c02ecde0 TRAP: 0300    Not tainted
<4>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>DAR: 0F00001C, DSISR: C0000000
<4>TASK = c02e9ae0[1] 'busybox' THREAD: c02ec000
----------------8X----------------------------------------------------------------
