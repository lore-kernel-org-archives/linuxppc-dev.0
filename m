Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37A7BDDEFC
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 04:51:45 +1000 (EST)
Received: from [80.192.55.227] (helo=[10.0.0.30])
	by mail.g-house.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1HpU1i-00057q-GG
	for linuxppc-dev@ozlabs.org; Sat, 19 May 2007 20:51:38 +0200
Date: Sat, 19 May 2007 19:51:37 +0100 (BST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: BUG: sleeping function called from invalid context at kernel/rwsem.c
Message-ID: <Pine.LNX.4.64.0705191932560.14522@sheep.housecafe.de>
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

Hi list,

I'm tracking vanilla 2.6-git on this iBook/G4 and sometimes, when 
closing the lid to put it to sleep and opening again to wake it up, the 
kernel barfs with:

[10606.436379] BUG: sleeping function called from invalid context at kernel/rwsem.c:20
[10606.436393] in_atomic():1, irqs_disabled():1
[10606.436399] Call Trace:
[10606.436405] [e79c9d10] [c0008d00] show_stack+0x3c/0x194 (unreliable)
[10606.436436] [e79c9d40] [c0027b28] __might_sleep+0xd4/0xe8
[10606.436463] [e79c9d50] [c00484b4] down_read+0x24/0x5c
[10606.436484] [e79c9d70] [c003ccec] __blocking_notifier_call_chain+0x38/0x74
[10606.436502] [e79c9d90] [c0167664] fb_notifier_call_chain+0x24/0x34
[10606.436531] [e79c9da0] [c0167cbc] fb_set_suspend+0x58/0x6c
[10606.436544] [e79c9dc0] [c0194968] radeonfb_pci_resume+0x1fc/0x3e8
[10606.436572] [e79c9de0] [c0194b78] radeonfb_early_resume+0x24/0x40
[10606.436585] [e79c9e00] [c001ac54] pmac_call_early_video_resume+0x2c/0x3c
[10606.436607] [e79c9e10] [c01f63dc] pmu_ioctl+0x7f8/0xc24
[10606.436629] [e79c9eb0] [c00924a0] do_ioctl+0x9c/0xa8
[10606.436645] [e79c9ed0] [c0092530] vfs_ioctl+0x84/0x490
[10606.436656] [e79c9f10] [c009297c] sys_ioctl+0x40/0x74
[10606.436668] [e79c9f40] [c0011930] ret_from_syscall+0x0/0x38
[10606.436690] --- Exception: c01 at 0xfee32a8
[10606.436722]     LR = 0xfee3240

This happened with 2.6.22-rc1 but has happened with 2.6.22-rc1-git7 
(reproduced just now). However, the suspend works and so does waking up. 
I just wonder if I should be worried by this message.

Please finde more details and config here: 
http://nerdbynature.de/bits/2.6.2x-powerpc/

Oh, speaking of "messages to worry about": lockdep says:

"142 out of 218 testcases failed, as expected." ...why is this 
"expected"?

Thanks,
Christian.
-- 
BOFH excuse #297:

Too many interrupts
