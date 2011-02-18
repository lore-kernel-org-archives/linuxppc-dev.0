Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 271D0B7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Feb 2011 03:00:18 +1100 (EST)
Message-ID: <4D5E8FA7.3080307@c-s.fr>
Date: Fri, 18 Feb 2011 16:26:31 +0100
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: MPC866, Help, SPI blocked at startup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Sometimes (but rather often) I get SPI tasks hanging.

I get the following trace, as if both tasks where blocking each other, 
or they are waiting for a third task ?

Can someone help or tell what I should look at ?

[ 240.939898] INFO: task ff000a80.spi:197 blocked for more than 120 seconds.
[ 240.946495] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 240.954416] ff000a80.spi D 00000000 0 197 2 0x00000000
[ 240.960474] Call Trace:
[ 240.962816] [c1961d20] [c009cd80] d_free+0x68/0x7c (unreliable)
[ 240.968668] [c1961de0] [c00076fc] __switch_to+0x54/0x70
[ 240.974175] [c1961df0] [c0235c8c] schedule+0x42c/0x4d4
[ 240.979058] [c1961e40] [c0235fb8] schedule_timeout+0x30/0x1cc
[ 240.984759] [c1961e80] [c0235714] wait_for_common+0xe0/0x18c
[ 240.990392] [c1961ec0] [c017a480] mpc8xxx_spi_bufs+0x3d0/0x4c8
[ 240.996365] [c1961ee0] [c017a6a8] mpc8xxx_spi_work+0x130/0x290
[ 241.001987] [c1961f50] [c0035240] worker_thread+0x14c/0x200
[ 241.007713] [c1961fb0] [c003960c] kthread+0x7c/0x80
[ 241.012755] [c1961ff0] [c000e660] kernel_thread+0x4c/0x68
[ 241.017947] INFO: task firmware/mcr300:244 blocked for more than 120 
seconds.
[ 241.025131] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 241.032846] firmware/mcr3 D 00000000 0 244 2 0x00000000
[ 241.038833] Call Trace:
[ 241.041462] [c198fd90] [0000000f] 0xf (unreliable)
[ 241.046043] [c198fe50] [c00076fc] __switch_to+0x54/0x70
[ 241.051198] [c198fe60] [c0235c8c] schedule+0x42c/0x4d4
[ 241.056253] [c198feb0] [c0235fb8] schedule_timeout+0x30/0x1cc
[ 241.061957] [c198fef0] [c0235714] wait_for_common+0xe0/0x18c
[ 241.067797] [c198ff30] [c0178f7c] spi_sync+0x8c/0xb4
[ 241.072586] [c198ff70] [c0185704] fpga_fw_load+0x15c/0x3b8
[ 241.077968] [c198ff90] [c015da9c] request_firmware_work_func+0x58/0x84
[ 241.084434] [c198ffb0] [c003960c] kthread+0x7c/0x80
[ 241.089228] [c198fff0] [c000e660] kernel_thread+0x4c/0x68

Regards
C. Leroy
