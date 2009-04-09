Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0D0DBDDF48
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 17:16:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 25C3829EC9
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 09:15:28 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26347-05 for <linuxppc-dev@ozlabs.org>;
	Thu,  9 Apr 2009 09:15:27 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id C0BF429EBA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 09:15:27 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: MPC5200 FEC driver crashing on 2.6.30-rc1....
Date: Thu, 9 Apr 2009 09:19:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904090919.44620.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

Seems like there are some NAPI changes not being (correctly) applied to the 
MPC5200 FEC driver...

[ 1319.265289] ------------[ cut here ]------------
[ 1319.274699] kernel BUG at .../arch/powerpc/include/asm/dma-mapping.h:164!
[ 1319.297488] Oops: Exception in kernel mode, sig: 5 [#1]
[ 1319.308086] PREEMPT mpc5200-simple-platform
[ 1319.316572] Modules linked in:
[ 1319.322773] NIP: c01dbef8 LR: c01dbec8 CTR: 00000000
[ 1319.332852] REGS: c3a9dc80 TRAP: 0700   Not tainted  (2.6.29-07103-gd0b70e8-dirty)
[ 1319.348212] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 42008448  XER: 20000000
[ 1319.361684] TASK = c387acb0[1876] 'ifconfig' THREAD: c3a9c000
[ 1319.372988] GPR00: 00000001 c3a9dd30 c387acb0 c3a13820 00000000 c3a13820 c3a13e11 c5000020
[ 1319.389982] GPR08: 00000001 00000000 c5001000 00000008 22008444 100adabc 03fc1000 00000001
[ 1319.406973] GPR16: ffffffff 00000000 007fff00 03fbb790 c3a9de08 ffff8914 c388410c c386b400
[ 1319.423967] GPR24: c3884100 c394b640 c0400000 c386b5e8 c386b400 c5001000 c39c3600 c39bb3c0
[ 1319.441359] NIP [c01dbef8] mpc52xx_fec_alloc_rx_buffers+0xac/0x1a8
[ 1319.453914] LR [c01dbec8] mpc52xx_fec_alloc_rx_buffers+0x7c/0x1a8
[ 1319.466276] Call Trace:
[ 1319.471250] [c3a9dd30] [c01dbeb0] mpc52xx_fec_alloc_rx_buffers+0x64/0x1a8 (unreliable)
[ 1319.487345] [c3a9dd60] [c01dc444] mpc52xx_fec_open+0x128/0x2d0
[ 1319.499221] [c3a9dda0] [c02458f4] dev_open+0xc0/0x118
[ 1319.509493] [c3a9ddc0] [c0244678] dev_change_flags+0x84/0x1ac
[ 1319.521176] [c3a9dde0] [c028b1b8] devinet_ioctl+0x638/0x758
[ 1319.532501] [c3a9de50] [c028bca8] inet_ioctl+0xcc/0xf8
[ 1319.542956] [c3a9de60] [c02325a8] sock_ioctl+0x60/0x2e8
[ 1319.553576] [c3a9de80] [c0096e44] vfs_ioctl+0x40/0xc0
[ 1319.563840] [c3a9dea0] [c009728c] do_vfs_ioctl+0x3c8/0x748
[ 1319.574986] [c3a9df10] [c009764c] sys_ioctl+0x40/0x74
[ 1319.585284] [c3a9df40] [c0011878] ret_from_syscall+0x0/0x38
[ 1319.596606] --- Exception: c01 at 0xfe8b6a4
[ 1319.596622]     LR = 0xff0573c
[ 1319.611264] Instruction dump:
[ 1319.617281] a13f0018 380005f2 817f0020 815f000c 7d2959d6 7c09512e 7fa95214 80be0098
[ 1319.633037] 41920104 813c0264 7d200034 5400d97e <0f000000> 801a5218 3c854000 7f63db78
[ 1319.649160] ---[ end trace a3057d5e6d98e2c6 ]---

Best regards,

-- 
David Jander
Protonic Holland.
