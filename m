Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 9D3AEDE6A5
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 01:31:49 +1000 (EST)
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id A10E658AE0
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 17:31:40 +0200 (MEST)
Date: Thu, 24 Apr 2008 17:31:40 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Memory corruption
Message-ID: <Pine.LNX.4.64.0804241717510.16220@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1687256500-1209051100=:16220"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1687256500-1209051100=:16220
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi,

I saw some random lockups on my PS3, so I decided to give the current kernel a
try on the PS3 development tool.  It crashes when setting up the network:

| <5>Sending DHCP requests ., OK
| IP-Config: Got DHCP answer from 192.168.106.200, my address is 192.168.106.196
| IP-Config: Complete:
|      device=eth0, addr=192.168.106.196, mask=255.255.255.0, gw=192.168.106.254,
|      host=192.168.106.196, domain=sonytel.be, nis-domain=(none),
|      bootserver=192.168.106.200, rootserver=192.168.106.200, rootpath=/disk-02/ps3linux/debian-powerpc
| <5>Looking up port of RPC 100003/2 on 192.168.106.200
| <0>Unrecoverable FP Unavailable Exception 800 at c000000000305220
| Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
| SMP NR_CPUS=2 PS3
| Modules linked in:
| NIP: c000000000305220 LR: c000000000304d34 CTR: c0000000003051c0
| REGS: c00000000604aa70 TRAP: 0800   Not tainted  (2.6.25-03562-g3dc5063-dirty)
| MSR: 8000000000008032 <EE,IR,DR>  CR: 24004082  XER: 00000000
| TASK = c000000006046040[1] 'swapper' THREAD: c000000006048000 CPU: 0
| <6>GPR00: 0000000000000800 c00000000604acf0 c000000000603a88 c000000006262680 
| <6>GPR04: 0662160400000002 0000000000004000 c0000000064a4110 c00000000062eda8 
| <6>GPR08: c0000000061a6000 0000000000000001 0000000000000100 c0000000062bf880 
| <6>GPR12: 0000001100000000 c000000000548300 0000000000000000 0000000000000000 
| <6>GPR16: 0000000000000000 000000000000005c 0000000000000000 000000000000005c 
| <6>GPR20: c0000000063a9db8 00000000c0a86ac8 0000000000000000 c0000000063a9d08 
| <6>GPR24: 0000000000000040 0000000000004000 c0000000063a9b80 c000000006391e00 
| <6>GPR28: c0000000064a4020 c000000006262680 c0000000005ae478 c00000000604acf0 
| NIP [c000000000305220] .ip_output+0x60/0x8c
| LR [c000000000304d34] .ip_local_out+0x50/0x78
| Call Trace:
| [c00000000604acf0] [c00000000604ada0] 0xc00000000604ada0 (unreliable)
| [c00000000604ad70] [c000000000304d34] .ip_local_out+0x50/0x78
| [c00000000604ae00] [c0000000003050c0] .ip_push_pending_frames+0x364/0x410
| [c00000000604aeb0] [c000000000326a60] .udp_push_pending_frames+0x350/0x408
| [c00000000604af70] [c000000000328048] .udp_sendmsg+0x4c4/0x630
| [c00000000604b0d0] [c0000000003306e4] .inet_sendmsg+0x84/0xb0
| [c00000000604b170] [c0000000002cd430] .sock_sendmsg+0xc4/0x108
| [c00000000604b370] [c0000000002ceed8] .kernel_sendmsg+0x40/0x64
| [c00000000604b400] [c00000000038cc1c] .xs_send_kvec+0xc8/0x100
| [c00000000604b510] [c00000000038cd10] .xs_sendpages+0xbc/0x2f4
| [c00000000604b5e0] [c00000000038ed38] .xs_udp_send_request+0x60/0x148
| [c00000000604b680] [c00000000038b1b8] .xprt_transmit+0x144/0x27c
| [c00000000604b730] [c00000000038776c] .call_transmit+0x248/0x2b0
| [c00000000604b7d0] [c000000000390a68] .__rpc_execute+0xd8/0x314
| [c00000000604b870] [c000000000390d18] .rpc_execute+0x40/0x5c
| [c00000000604b900] [c000000000387fe8] .rpc_run_task+0x84/0xb0
| [c00000000604b9a0] [c00000000038814c] .rpc_call_sync+0x74/0xc0
| [c00000000604ba70] [c00000000039a568] .rpcb_getport_sync+0x110/0x178
| [c00000000604bb80] [c000000000511118] .root_nfs_getport+0x8c/0xbc
| [c00000000604bc30] [c0000000005112f0] .nfs_root_data+0x1a8/0x328
| [c00000000604bd70] [c0000000004f66a8] .mount_root+0x40/0x150
| [c00000000604be10] [c0000000004f695c] .prepare_namespace+0x1a4/0x1f4
| [c00000000604bea0] [c0000000004f5a48] .kernel_init+0x388/0x3c8
| [c00000000604bf90] [c0000000000229c8] .kernel_thread+0x4c/0x68
| Instruction dump:
| e9230028 e8fe8018 7c000026 54001ffe e9090018 78001f24 7d27002a 38000800 
| 7d2948f8 7d6b482a e92b0058 39290001 <c0000000> 00546e70 f9030020 4bfff775 
                                       ^^^^^^^^  ^^^^^^^^
			     should be f92b0058  b003007e

| <4>---[ end trace c7cf3d9b6c787395 ]---
| <0>Kernel panic - not syncing: Attempted to kill init!
| smp_call_function on cpu 0: other cpus not responding (0)
| 
|    System does not reboot automatically.
|    Please press POWER button.
| 
| <7>eth0: no IPv6 routers present

Findings:
  - Disabling CONFIG_INET fixed the problem.
  - I didn't manage to lock up my PS3 afterwards neither.
    But... while typing this, I saw an oops accessing address
    0xf000f000f0007000 somewhere in the networking code, so it looks like some
    corruption is going on after all.
  - Upon closer look, 8 bytes in the instruction dump above are not correct
    and have been overwritten with 0xc000000000546e70, which is the address of
    init_task.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · BIC GEBABEBB08A · IBAN BE39001382358619
---584349381-1687256500-1209051100=:16220--
