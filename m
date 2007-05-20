Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDFEDDDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 08:11:03 +1000 (EST)
Date: Sun, 20 May 2007 23:10:54 +0100 (BST)
From: Christian Kujau <lists@nerdbynature.de>
To: linux-kernel@vger.kernel.org
Subject: Badness at include/linux/slub_def.h
Message-ID: <Pine.LNX.4.64.0705202304530.14522@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "evil@g-house.de"@mail.g-house.de
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi there,

yet another[0] badness, again from this very iBook running vanilla 
2.6.22-rc1-git8:

[41653.487050] Badness at include/linux/slub_def.h:77
[41653.487060] Call Trace:
[41653.487068] [ecafbcb0] [c0008d00] show_stack+0x3c/0x194 (unreliable)
[41653.487097] [ecafbce0] [c01426d4] report_bug+0x84/0xf4
[41653.487116] [ecafbcf0] [c0010280] program_check_exception+0xbc/0x530
[41653.487137] [ecafbd20] [c0011f8c] ret_from_except_full+0x0/0x4c
[41653.487154] --- Exception: 700 at get_slab+0x248/0x260
[41653.487168]     LR = __kmalloc+0x1c/0x9c
[41653.487176] [ecafbde0] [101dfbc8] 0x101dfbc8 (unreliable)
[41653.487213] [ecafbe10] [c0080398] __kmalloc+0x1c/0x9c
[41653.487227] [ecafbe30] [c01c2150] drm_rmdraw+0x26c/0x29c
[41653.487243] [ecafbe80] [c01c2b74] drm_ioctl+0xe0/0x250
[41653.487257] [ecafbeb0] [c00924a0] do_ioctl+0x9c/0xa8
[41653.487273] [ecafbed0] [c0092530] vfs_ioctl+0x84/0x490
[41653.487287] [ecafbf10] [c009297c] sys_ioctl+0x40/0x74
[41653.487301] [ecafbf40] [c0011930] ret_from_syscall+0x0/0x38
[41653.487315] --- Exception: c01 at 0xfd132a8
[41653.487327]     LR = 0xfd13240


This happens when I execute glxinfo(1) - but it happens only once. The 
second time the message is not printed. As with the other reports, the 
command actually works, DRI is working too and the system remains 
stable. Please see http://nerdbynature.de/bits/2.6.22-rc1-git8/ for more 
details.

Thanks,
Christian.

[0] http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036466.html
     http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036468.html
-- 
BOFH excuse #334:

50% of the manual is in .pdf readme files
