Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F59C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 11:08:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143D320652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 11:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143D320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42THf55cFRzF3Dp
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 22:08:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42THbf5BGKzF3Bf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 22:06:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42THbf0zXXz9sD2;
 Mon,  8 Oct 2018 22:06:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v5 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <cover.1538687073.git.christophe.leroy@c-s.fr>
References: <cover.1538687073.git.christophe.leroy@c-s.fr>
Date: Mon, 08 Oct 2018 22:06:03 +1100
Message-ID: <87pnwk1yw4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
>
> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.

This is blowing up pretty nicely with CONFIG_KMEMLEAK enabled, haven't
had time to dig further:

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000022064
Oops: Kernel access of bad area, sig: 11 [#9]
LE SMP NR_CPUS=32 NUMA 
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-gcc-7.3.1-00103-gc795acc08338 #268
NIP:  c000000000022064 LR: c0000000000220c0 CTR: c00000000001f5c0
REGS: c000000001244a50 TRAP: 0380   Not tainted  (4.19.0-rc3-gcc-7.3.1-00103-gc795acc08338)
MSR:  8000000000001033 <SF,ME,IR,DR,RI,LE>  CR: 48022244  XER: 20000000
CFAR: c0000000000220c4 IRQMASK: 1 
GPR00: c0000000000220c0 c000000001244cd0 c00000000124b200 0000000000000001 
GPR04: c000000001201180 0000000000000070 c000000001275ef8 0000000000000000 
GPR08: 0000000000000000 0000000000000001 0000000000003f90 2b6e6f6d6d6f635f 
GPR12: c00000000001f5c0 c000000001450000 0000000000000000 0000000002e2be38 
GPR16: 000000007dc54c70 0000000002d854b8 0000000000000000 c000000000d87f00 
GPR20: c000000000d87ef0 c000000000d87ee0 c000000000d87f08 c00000000006c1a8 
GPR24: c000000000d87ec8 0000000000000000 7265677368657265 c000000000062a04 
GPR28: 0000000000000006 c000000001201180 0000000000000000 0000000000000000 
NIP [c000000000022064] show_stack+0xe4/0x2b0
LR [c0000000000220c0] show_stack+0x140/0x2b0
Call Trace:
[c000000001244cd0] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c000000001244da0] [c00000000002245c] show_regs+0x22c/0x430
[c000000001244e50] [c00000000002ae8c] __die+0xfc/0x140
[c000000001244ed0] [c00000000002b954] die+0x74/0xf0
[c000000001244f10] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c000000001244f80] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c000000001244fc0] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c0000000012452b0] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c000000001245380] [c00000000002245c] show_regs+0x22c/0x430
[c000000001245430] [c00000000002ae8c] __die+0xfc/0x140
[c0000000012454b0] [c00000000002b954] die+0x74/0xf0
[c0000000012454f0] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c000000001245560] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c0000000012455a0] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c000000001245890] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c000000001245960] [c00000000002245c] show_regs+0x22c/0x430
[c000000001245a10] [c00000000002ae8c] __die+0xfc/0x140
[c000000001245a90] [c00000000002b954] die+0x74/0xf0
[c000000001245ad0] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c000000001245b40] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c000000001245b80] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c000000001245e70] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c000000001245f40] [c00000000002245c] show_regs+0x22c/0x430
[c000000001245ff0] [c00000000002ae8c] __die+0xfc/0x140
[c000000001246070] [c00000000002b954] die+0x74/0xf0
[c0000000012460b0] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c000000001246120] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c000000001246160] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c000000001246450] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c000000001246520] [c00000000002245c] show_regs+0x22c/0x430
[c0000000012465d0] [c00000000002ae8c] __die+0xfc/0x140
[c000000001246650] [c00000000002b954] die+0x74/0xf0
[c000000001246690] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c000000001246700] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c000000001246740] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c000000001246a30] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c000000001246b00] [c00000000002245c] show_regs+0x22c/0x430
[c000000001246bb0] [c00000000002ae8c] __die+0xfc/0x140
[c000000001246c30] [c00000000002b954] die+0x74/0xf0
[c000000001246c70] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c000000001246ce0] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c000000001246d20] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c000000001247010] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c0000000012470e0] [c00000000002245c] show_regs+0x22c/0x430
[c000000001247190] [c00000000002ae8c] __die+0xfc/0x140
[c000000001247210] [c00000000002b954] die+0x74/0xf0
[c000000001247250] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c0000000012472c0] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c000000001247300] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at show_stack+0xe4/0x2b0
    LR = show_stack+0x140/0x2b0
[c0000000012475f0] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
[c0000000012476c0] [c00000000002245c] show_regs+0x22c/0x430
[c000000001247770] [c00000000002ae8c] __die+0xfc/0x140
[c0000000012477f0] [c00000000002b954] die+0x74/0xf0
[c000000001247830] [c00000000006e0f8] bad_page_fault+0xe8/0x180
[c0000000012478a0] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
[c0000000012478e0] [c000000000008ce8] large_addr_slb+0x158/0x160
--- interrupt: 380 at save_context_stack+0x70/0x110
    LR = save_context_stack+0x64/0x110
[c000000001247bd0] [c000000001247c10] init_stack+0x3c10/0x4000 (unreliable)
[c000000001247c10] [c000000000ee2268] log_early+0xc0/0x100
[c000000001247c70] [c000000000ede7f8] memblock_virt_alloc_internal+0x1cc/0x210
[c000000001247d20] [c000000000edec00] memblock_virt_alloc_try_nid+0x94/0xfc
[c000000001247db0] [c000000000f08efc] early_init_dt_alloc_memory_arch+0x2c/0x40
[c000000001247dd0] [c000000000991200] __unflatten_device_tree+0xa0/0x1e0
[c000000001247e60] [c000000000f0a1d8] unflatten_device_tree+0x48/0x68
[c000000001247e90] [c000000000eab6fc] setup_arch+0x4c/0x3fc
[c000000001247f00] [c000000000ea3df8] start_kernel+0x88/0x604
Instruction dump:
3ec2ffb4 3b800041 3bc00001 3b600000 3b18ccc8 3a73cd00 3a94ccf0 3ab5cce0 
635a7265 3ad6cd08 48000054 2e3e0000 <ea5f0000> ebdf0010 419200e8 7fbbf040 
random: get_random_bytes called from print_oops_end_marker+0x6c/0xa0 with crng_init=0
---[ end trace 0000000000000000 ]---



cheers
