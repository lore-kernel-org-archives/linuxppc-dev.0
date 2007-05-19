Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E146DDF07
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 06:19:43 +1000 (EST)
Received: from [80.192.55.227] (helo=[10.0.0.30])
	by mail.g-house.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1HpVOr-0000FR-VG
	for linuxppc-dev@ozlabs.org; Sat, 19 May 2007 22:19:38 +0200
Date: Sat, 19 May 2007 21:19:37 +0100 (BST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: Badness at drivers/base/core.c
Message-ID: <Pine.LNX.4.64.0705192046410.14522@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "evil@g-house.de"@mail.g-house.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again,

tracking 2.6-git is fun, here's what I get when I do rmmod(8) on a 
loaded module:

[14240.857547] Device 'windfarm.0' does not have a release() function, 
it is broken and must be fixed.
[14240.857647] ------------[ cut here ]------------
[14240.857659] Badness at drivers/base/core.c:107
[14240.857669] Call Trace:
[14240.857676] [eea5fd20] [c0008d00] show_stack+0x3c/0x194 (unreliable)
[14240.857705] [eea5fd50] [c0142764] report_bug+0x84/0xf4
[14240.857722] [eea5fd60] [c0010280] program_check_exception+0xbc/0x530
[14240.857742] [eea5fd90] [c0011f8c] ret_from_except_full+0x0/0x4c
[14240.857757] --- Exception: 700 at device_release+0x80/0x88
[14240.857784]     LR = device_release+0x80/0x88
[14240.857791] [eea5fe60] [c0143a24] kobject_cleanup+0x70/0xac
[14240.857806] [eea5fe80] [c0144b20] kref_put+0x54/0x6c
[14240.857820] [eea5fe90] [c01439a4] kobject_put+0x24/0x34
[14240.857833] [eea5fea0] [c01df3b8] put_device+0x1c/0x2c
[14240.857848] [eea5feb0] [c01e513c] platform_device_put+0x1c/0x2c
[14240.857868] [eea5fec0] [f2143d30] windfarm_core_exit+0x2c/0x70c [windfarm_core]
[14240.857893] [eea5fed0] [c0053450] sys_delete_module+0x19c/0x200
[14240.857910] [eea5ff40] [c0011930] ret_from_syscall+0x0/0x38
[14240.857923] --- Exception: c01 at 0xff783d8
[14240.857951]     LR = 0x10001424

This one is for windfarm_core @ 2.6.22-rc1-git7. However this seems to 
happen for *some* (but not all) other modules as well, I've seen this on 
the same iBook/G4 for the kafs module @ 2.6.20-15-powerpc (ubuntu):

  [ 1941.063663] kAFS: Red Hat AFS client v0.1 registering.
  [ 1941.064601] kAFS: Started kafstimod 11857
  [ 1941.064923] kAFS: Started kafsasyncd 11858
  [ 1941.065234] <== afs_fs_init() = 0
  [ 1945.170279] kAFS: Red Hat AFS client v0.1 unregistering.
  [ 1945.171269] ------------[ cut here ]------------
  [ 1945.172065] Badness at fs/proc/generic.c:732
  [ 1945.172820] Call Trace:
  [ 1945.172824] [CF5C9D20] [C0008BB0] show_stack+0x3c/0x194 (unreliable)
  [ 1945.172844] [CF5C9D50] [C0110400] report_bug+0x84/0xf4
  [ 1945.172855] [CF5C9D60] [C0011ED4] program_check_exception+0xd4/0x520
  [ 1945.172869] [CF5C9DB0] [C0013B4C] ret_from_except_full+0x0/0x4c
  [ 1945.172878] --- Exception: 700 at remove_proc_entry+0xec/0x1b0
  [ 1945.172892]     LR = remove_proc_entry+0x68/0x1b0
  [ 1945.172896] [CF5C9EB0] [F2655074] afs_proc_cleanup+0x30/0x40 [kafs]
  [ 1945.172926] [CF5C9EC0] [F2659290] afs_exit+0x38/0x48 [kafs]
  [ 1945.172935] [CF5C9ED0] [C00517F4] sys_delete_module+0x190/0x1f4
  [ 1945.172946] [CF5C9F40] [C00134F0] ret_from_syscall+0x0/0x38
  [ 1945.172952] --- Exception: c01 at 0xff783d8
  [ 1945.172980]     LR = 0x10001424

However, the module unloads and loads again just fine, machine seems to 
be stable. To be honest, I don't really care because I hardly ever use 
rmmod(8) and I just stumbled over these messages when playing around 
with bcm43xx. I just want to let you know...

details and .config: http://nerdbynature.de/bits/2.6.2x-powerpc/

thanks,
Christian.
-- 
BOFH excuse #64:

CPU needs recalibration
