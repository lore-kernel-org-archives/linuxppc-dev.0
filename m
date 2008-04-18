Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA475DE351
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:42:55 +1000 (EST)
Date: Thu, 17 Apr 2008 22:42:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: 2.6.25-mm1 on the g5
Message-Id: <20080417224248.fdd89284.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It had been running happily and hard for a couple of hours when:


registered taskstats version 1
Freeing unused kernel memory: 304k freed
windfarm: CPUs control loops started.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Unrecoverable exception 4100 at c000000000008c24
Oops: Unrecoverable exception, sig: 6 [#1]
SMP NR_CPUS=4 PowerMac
Modules linked in: autofs
NIP: c000000000008c24 LR: 000000000feea4ac CTR: 000000000feea450
REGS: c000000178fb7bb0 TRAP: 4100   Not tainted  (2.6.25-mm1)
MSR: 9000000000001030 <ME,IR,DR>  CR: 42000424  XER: 20000000
TASK = c000000178aae3c0[24350] 'sed' THREAD: c000000178fb4000 CPU: 2
GPR00: 0000000000004000 c000000178fb7e30 000000000ff41d14 100000000000d032 
GPR04: 000000000000000c 0000000000000400 0000000000000024 0000000000000000 
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR12: 0000000000000000 0000000010023338 0000000000000000 0000000010020000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 000000001003d868 
GPR20: 0000000000000000 00000000ffec39d0 000000001003c850 0000000000000000 
GPR24: 0000000000000000 0000000000000015 000000000000003b 0000000000000400 
GPR28: 000000000ffc69d0 00000000f7ff7000 000000000ffc6e5c 0000000000000400 
NIP [c000000000008c24] restore+0xa4/0xc0
LR [000000000feea4ac] 0xfeea4ac
Call Trace:
[c000000178fb7e30] [c000000000008c54] do_work+0x14/0x2c (unreliable)
Instruction dump:
e88d01e0 f84d01e0 7c841050 e84d01d8 7c422214 f84d01d8 e9a100d8 7c7b03a6 
e84101a0 7c4ff120 e8410170 7c5a03a6 <e8010070> e8410080 e8610088 e8810090 
---[ end trace 07fd463c013eef9d ]---
BUG: soft lockup - CPU#2 stuck for 61s! [swapper:0]
NIP: c000000000013bd4 LR: c000000000013bd4 CTR: c00000000001c9bc
REGS: c00000017a10bbe0 TRAP: 0901   Tainted: G      D    (2.6.25-mm1)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 44ffff28  XER: 00000000
TASK = c00000017a105260[0] 'swapper' THREAD: c00000017a108000 CPU: 2
GPR00: 0000000000000001 c00000017a10be60 c0000000006eac48 c00000000070a200 
GPR04: 0000000000000001 0000000000002d2e 0000000024ffff22 9000000000049032 
GPR08: 0000000000000001 c00000017a108000 c00000017a108000 0000000000000000 
GPR12: 0000000022024448 c00000000062d380 
NIP [c000000000013bd4] .cpu_idle+0x14c/0x154
LR [c000000000013bd4] .cpu_idle+0x14c/0x154
Call Trace:
[c00000017a10be60] [c000000000013ba0] .cpu_idle+0x118/0x154 (unreliable)
[c00000017a10bf00] [c000000000456970] .start_secondary+0x148/0x1b0
[c00000017a10bf90] [c0000000000083c0] .start_secondary_prolog+0xc/0x10
Instruction dump:
4bffff64 7c210b78 7ffffb78 4bffff58 e93b01b0 e8090000 f8410028 60000000 
e9690010 e8490008 7c0903a6 4e800421 <e8410028> 4bffff80 e8030008 e9440008 
BUG: soft lockup - CPU#1 stuck for 936s! [mrtg:24361]
NIP: 000000000eafb6ac LR: 000000000eafb4dc CTR: 0000000000000000
REGS: c000000177197ea0 TRAP: 0901   Tainted: G      D    (2.6.25-mm1)
MSR: 100000000200f032 <EE,PR,FP,ME,IR,DR>  CR: 24422482  XER: 00000000
TASK = c0000001771b5260[24361] 'mrtg' THREAD: c000000177194000 CPU: 1
GPR00: 0000000000000000 00000000ff803c10 00000000f7fe0860 0000000010445278 
GPR04: 0000000000000001 0000000000000007 000000000eb14720 0000000000000007 
GPR08: 0000000010452840 0000000000000040 0000000000000000 0000000010041640 
GPR12: 0000000044422484 000000001001bb2c 
NIP [000000000eafb6ac] 0xeafb6ac
LR [000000000eafb4dc] 0xeafb4dc
Call Trace:
BUG: soft lockup - CPU#0 stuck for 936s! [mrtg:24365]
NIP: 000000000eb34800 LR: 000000000eb345e8 CTR: 000000010eb2bb5c
REGS: c0000001788b3ea0 TRAP: 0901   Tainted: G      D    (2.6.25-mm1)
MSR: 100000000200f032 <EE,PR,FP,ME,IR,DR>  CR: 44422484  XER: 00000000
TASK = c00000017863f5e0[24365] 'mrtg' THREAD: c0000001788b0000 CPU: 0
GPR00: 00000000104670f0 00000000ffba12c0 00000000f7fe0860 0000000010015008 
GPR04: 0000000010137100 0000000000000008 0000000000000003 0000000000000482 
GPR08: 000000001012bbb8 0000000000000002 000000001012aad8 000000001002afe0 
GPR12: 0000000024422442 000000001001bb2c 
NIP [000000000eb34800] 0xeb34800
LR [000000000eb345e8] 0xeb345e8
Call Trace:
BUG: soft lockup - CPU#3 stuck for 936s! [python:24362]
NIP: 000000000fef62c0 LR: 000000000fd31c58 CTR: 000000000fccfcdc
REGS: c000000178e43ea0 TRAP: 0901   Tainted: G      D    (2.6.25-mm1)
MSR: 100000000000f032 <EE,PR,FP,ME,IR,DR>  CR: 22288424  XER: 20000000
TASK = c00000017735b560[24362] 'python' THREAD: c000000178e40000 CPU: 3
GPR00: 0000000000000000 00000000ff83abc0 00000000f7fe0480 00000000ff83b14c 
GPR04: 000000000fd6e354 00000000ff83b148 000000002e736f00 fffffffffefefeff 
GPR08: 000000007f7f0000 000000000fdbff64 0000000000000000 0000000000000000 
GPR12: 0000000000000000 0000000010019b88 
NIP [000000000fef62c0] 0xfef62c0
LR [000000000fd31c58] 0xfd31c58
Call Trace:


That's a pretty crappy trace.  Perhaps netconsole lost some of it, dunno.
