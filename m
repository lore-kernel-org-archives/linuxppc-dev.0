Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk1.physik.uni-konstanz.de",
	Issuer "Mittelerde" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 840A6DDE34
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 09:17:02 +1000 (EST)
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 0664F3A999
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 00:45:19 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07420-16 for <linuxppc-dev@ozlabs.org>;
	Sun, 12 Aug 2007 00:45:18 +0200 (CEST)
Received: from bogon.sigxcpu.org (port-212-202-236-178.static.qsc.de
	[212.202.236.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id E3A0E3A992
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Aug 2007 00:45:17 +0200 (CEST)
Date: Sun, 12 Aug 2007 00:42:42 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linuxppc-dev@ozlabs.org
Subject: Oops on boot with 2.6.23-rc2-g2c9d365c
Message-ID: <20070811224241.GA9770@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I'm seeing the following oops on a Powerbook 6,1 with
2.6.23-rc2-g2c9d365c (and also with earlier 2.6.23, 2.6.22 is fine) and
am quiet clueless. Any ideas before ist start bisecting?
 -- Guido

Registering PowerMac CPU frequency driver
Low: 533 Mhz, High: 867 Mhz, Boot: 866 Mhz
------------[ cut here ]------------
Badness at kernel/irq/resend.c:70
NIP: c0050b2c LR: c0050b00 CTR: c0016738
REGS: cff43c30 TRAP: 0700   Not tainted  (2.6.23-rc2-g2c9d365c)
MSR: 00021032 <ME,IR,DR>  CR: 48002084  XER: 20000000
TASK = cff41830[1] 'swapper' THREAD: cff42000
GPR00: 00000001 cff43ce0 cff41830 00000178 0000002f 80000000 00000000 0000002f 
GPR08: 000186a0 c02a0000 4048002f 00000000 00082208 00000000 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 41400000 01668460 00000000 
GPR24: c0273000 c02a0000 c02a0000 00000000 00000000 0000002f 00024008 c0279fb8 
NIP [c0050b2c] check_irq_resend+0x5c/0xc0
LR [c0050b00] check_irq_resend+0x30/0xc0
Call Trace:
[cff43ce0] [c0050b00] check_irq_resend+0x30/0xc0 (unreliable)
[cff43d00] [c0050658] enable_irq+0x84/0xa8
[cff43d10] [c014ab54] pmu_resume+0x80/0xc4
[cff43d20] [c00219d4] pmu_set_cpu_speed+0x19c/0x1b4
[cff43db0] [c002157c] do_set_cpu_speed+0xb4/0x160
[cff43dd0] [c002176c] pmac_cpufreq_target+0x48/0x6c
[cff43df0] [c01719f8] __cpufreq_driver_target+0x38/0x50
[cff43e00] [c017384c] cpufreq_governor_userspace+0x1c8/0x224
[cff43e20] [c0171dd4] __cpufreq_governor+0x64/0xbc
[cff43e40] [c01728bc] __cpufreq_set_policy+0x174/0x19c
[cff43e60] [c01735b0] cpufreq_add_dev+0x258/0x2f8
[cff43f20] [c013d9a4] sysdev_driver_register+0x78/0xe8
[cff43f40] [c01732dc] cpufreq_register_driver+0xa4/0x120
[cff43f50] [c025880c] pmac_cpufreq_setup+0x66c/0x688
[cff43f80] [c024a1e4] kernel_init+0xc8/0x284
[cff43ff0] [c001084c] kernel_thread+0x44/0x60
Instruction dump:
4e800421 801f0000 3d20c005 57cb052a 39290eb8 2f0b0400 7f804800 419e0030 
3d20c02a 80098508 7c000034 5400d97e <0f000000> 2f800000 41be0048 38000001 
io scheduler noop registered (default)
io scheduler cfq registered
