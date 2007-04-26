Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 32387DDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 16:56:31 +1000 (EST)
Date: Thu, 26 Apr 2007 01:56:44 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: cbe_cpufreq crashes my machine
Message-ID: <20070426065644.GA24799@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704260147.35878.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704260147.35878.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 01:47:35AM +0200, Arnd Bergmann wrote:
> I can't see any check in here that finds out if you are actually running on
> the right hardware. 

Seems like this came along with our use of cbe_cpufreq.c as a basis. You
don't do it either! :-)

Enabling CONFIG_CBE_CPUFREQ makes my machine die a horrible death,
see below. I'd post a patch if I knew what machine compatible fields to
compare with, but I have no clue what's considered approprate to check
for on cell.


Unable to handle kernel paging request for data at address 0x00000888
Faulting instruction address: 0xc000000000036b14
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2
Modules linked in:
NIP: C000000000036B14 LR: C000000000036B08 CTR: C000000000036A60
REGS: c00000007fd83830 TRAP: 0300   Not tainted  (2.6.20)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 82000022  XER: 20000000
DAR: 0000000000000888, DSISR: 0000000040000000
TASK = c00000000ffc5820[1] 'swapper' THREAD: c00000007fd80000 CPU: 0
GPR00: C00000000093F940 C00000007FD83AB0 C000000000916EC0 0000000000000000
GPR04: C00000000068343F C0000000009C1208 C00000007F8FAE00 0000000000000000
GPR08: C000000000859720 0000000000000888 C0000000009C3DE0 0000000000000000
GPR12: 0000000000000000 C000000000779600 0000000000000000 C000000000684808
GPR16: 4000000000000000 C0000000006834E0 0000000000000000 0000000000000000
GPR20: 0000000000764880 C000000000764880 C000000000764AF0 0000000000764AF0
GPR24: C000000000684308 C00000000085FAE8 C0000000025DD028 0000000000000000
GPR28: FFFFFFFFFFFFFFF4 C00000007F8FAC38 C000000000784B58 C00000007F8FAC00
NIP [C000000000036B14] .cbe_cpufreq_cpu_init+0xb4/0x12c
LR [C000000000036B08] .cbe_cpufreq_cpu_init+0xa8/0x12c
Call Trace:
[C00000007FD83AB0] [C000000000036AA8] .cbe_cpufreq_cpu_init+0x48/0x12c (unreliable)
[C00000007FD83B40] [C0000000004831FC] .cpufreq_add_dev+0x158/0x4f4
[C00000007FD83D00] [C00000000033A5E4] .sysdev_driver_register+0xbc/0x158
[C00000007FD83D90] [C000000000482FF0] .cpufreq_register_driver+0xd0/0x184
[C00000007FD83E40] [C0000000007421B4] .cbe_cpufreq_init+0x1c/0x34
[C00000007FD83EC0] [C0000000000093B4] .init+0x1c4/0x39c
[C00000007FD83F90] [C000000000022E10] .kernel_thread+0x4c/0x68
Instruction dump:
800b0000 2f80fffe 409effe4 e93e8038 380061a8 e87f000e 901f0018 f93f0030
4bffe239 60000000 39230888 7c0004ac <e9230888> 0c090000 4c00012c ebbe8008



-Olof
