Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 04133B7CF8
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 16:46:26 +1000 (EST)
Date: Mon, 19 Apr 2010 23:45:56 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
In-Reply-To: <YeFfFNFyTSF.A.vUB.fSSzLB@tosh>
Message-ID: <alpine.DEB.2.01.1004192339190.13016@bogon.housecafe.de>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh> <YeFfFNFyTSF.A.vUB.fSSzLB@tosh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	adobriyan@gmail.com, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Apr 2010 at 05:19, Rafael J. Wysocki wrote:
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=15589
> Subject		: 2.6.34-rc1: Badness at fs/proc/generic.c:316
> Submitter	: Christian Kujau <lists@nerdbynature.de>
> Date		: 2010-03-13 23:53 (38 days old)
> Message-ID	: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
> References	: http://marc.info/?l=linux-kernel&m=126852442903680&w=2

Yes, unless something in this area has changed from -rc4 to -rc5, this is 
still printed during boot:


device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
name 'pulses/rev'
------------[ cut here ]------------
Badness at fs/proc/generic.c:317
NIP: c00e14b8 LR: c00e14b8 CTR: c01fc2c0
REGS: c045bdc0 TRAP: 0700   Not tainted  (2.6.34-rc4)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22000022  XER: 20000000
TASK = c043b410[0] 'swapper' THREAD: c045a000
GPR00: c00e14b8 c045be70 c043b410 00000024 000012ff ffffffff ffffffff 00000000 
GPR08: ef808320 c0458670 00000000 000012ff 42000028 00000000 00cb3ccc 00cb39b8 
GPR16: 00cd682c 00cb3ca8 00cb38c8 00cb39ac 00240e18 00240e20 00cb3954 00240e24 
GPR24: 00000000 0049b000 c045be98 c045bec8 c0da0a42 c0da0a42 00000006 00000000 
NIP [c00e14b8] __xlate_proc_name+0xd0/0xf8
LR [c00e14b8] __xlate_proc_name+0xd0/0xf8
Call Trace:
[c045be70] [c00e14b8] __xlate_proc_name+0xd0/0xf8 (unreliable)
[c045be90] [c00e1a2c] __proc_create+0x60/0xf0
[c045bec0] [c00e2194] proc_create_data+0x54/0xc4
[c045bee0] [c00e6310] __proc_device_tree_add_prop+0x64/0xd4
[c045bf00] [c00e64b4] proc_device_tree_add_node+0x134/0x164
[c045bf20] [c00e6434] proc_device_tree_add_node+0xb4/0x164
[c045bf40] [c00e6434] proc_device_tree_add_node+0xb4/0x164
[c045bf60] [c00e6434] proc_device_tree_add_node+0xb4/0x164
[c045bf80] [c00e6434] proc_device_tree_add_node+0xb4/0x164
[c045bfa0] [c0421c30] proc_device_tree_init+0x4c/0x78
[c045bfb0] [c0421698] proc_root_init+0xcc/0xf0
[c045bfc0] [c040e798] start_kernel+0x230/0x284
[c045bff0] [00003444] 0x3444
Instruction dump:
93ba0000 38600000 93fb0000 80010024 bb410008 38210020 7c0803a6 4e800020 
3c60c03c 7f84e378 386300a8 48273a45 <0fe00000> 80010024 3860fffe bb410008 


-- 
BOFH excuse #37:

heavy gravity fluctuation, move computer to floor rapidly
