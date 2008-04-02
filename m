Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95959DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 17:26:55 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m326QxCq006807
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 17:26:59 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m326TSOf283612
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 17:29:28 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m326PkpD014232
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 16:25:46 +1000
Message-ID: <47F326E0.3010604@linux.vnet.ibm.com>
Date: Wed, 02 Apr 2008 11:55:36 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [BUG] 2.6.25-rc8-mm1 kernel panic while bootup on powerpc
References: <20080401213214.8fbb6d6b.akpm@linux-foundation.org>
In-Reply-To: <20080401213214.8fbb6d6b.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The 2.6.25-rc8-mm1 kernel panic's while bootup on the power machine(s).

[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/powerpc/mm/init_64.c:240!
[    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
[    0.000000] SMP NR_CPUS=32 NUMA PowerMac
[    0.000000] Modules linked in:
[    0.000000] NIP: c0000000003d1dcc LR: c0000000003d1dc4 CTR: c00000000002b6ac
[    0.000000] REGS: c00000000049b960 TRAP: 0700   Not tainted  (2.6.25-rc8-mm1-autokern1)
[    0.000000] MSR: 9000000000021032 <ME,IR,DR>  CR: 44000088  XER: 20000000
[    0.000000] TASK = c0000000003f9c90[0] 'swapper' THREAD: c000000000498000 CPU: 0
[    0.000000] GPR00: c0000000003d1dc4 c00000000049bbe0 c0000000004989d0 0000000000000001 
[    0.000000] GPR04: d59aca40f0000000 000000000b000000 0000000000000010 0000000000000000 
[    0.000000] GPR08: 0000000000000004 0000000000000001 c00000027e520800 c0000000004bf0f0 
[    0.000000] GPR12: c0000000004bf020 c0000000003fa900 0000000000000000 0000000000000000 
[    0.000000] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    0.000000] GPR20: 0000000000000000 0000000000000000 0000000000000000 4000000001400000 
[    0.000000] GPR24: 00000000017d64b0 c0000000003d6250 0000000000000000 c000000000504000 
[    0.000000] GPR28: 0000000000000000 cf000000001f8000 0000000001000000 cf00000000000000 
[    0.000000] NIP [c0000000003d1dcc] .vmemmap_populate+0xb8/0xf4
[    0.000000] LR [c0000000003d1dc4] .vmemmap_populate+0xb0/0xf4
[    0.000000] Call Trace:
[    0.000000] [c00000000049bbe0] [c0000000003d1dc4] .vmemmap_populate+0xb0/0xf4 (unreliable)
[    0.000000] [c00000000049bc70] [c0000000003d2ee8] .sparse_mem_map_populate+0x38/0x60
[    0.000000] [c00000000049bd00] [c0000000003c242c] .sparse_early_mem_map_alloc+0x54/0x94
[    0.000000] [c00000000049bd90] [c0000000003c250c] .sparse_init+0xa0/0x20c
[    0.000000] [c00000000049be50] [c0000000003ab7d0] .setup_arch+0x1ac/0x218
[    0.000000] [c00000000049bee0] [c0000000003a36ac] .start_kernel+0xe0/0x3fc
[    0.000000] [c00000000049bf90] [c000000000008594] .start_here_common+0x54/0xc0
[    0.000000] Instruction dump:
[    0.000000] 7fe3fb78 7ca02a14 4082000c 3860fff4 4800003c e92289c8 e96289c0 e9090002 
[    0.000000] e8eb0002 4bc575cd 60000000 78630fe0 <0b030000> 7ffff214 7fbfe840 7fe3fb78 
[    0.000000] ---[ end trace 31fd0ba7d8756001 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
