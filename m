Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99188C65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 13:37:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035EE20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 13:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035EE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TLyn4TRJzF3F6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:37:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TLnr4JZrzF3D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 00:30:08 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42TLnZ5L8Gz9ttC5;
 Mon,  8 Oct 2018 15:29:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id iZ47MVDwQMIN; Mon,  8 Oct 2018 15:29:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42TLnZ4qClz9ttBY;
 Mon,  8 Oct 2018 15:29:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AFDC8B7B0;
 Mon,  8 Oct 2018 15:30:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id b8zbsA4bxLbQ; Mon,  8 Oct 2018 15:30:04 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BA5A88B7B7;
 Mon,  8 Oct 2018 15:30:03 +0200 (CEST)
Subject: Re: [PATCH v5 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <cover.1538687073.git.christophe.leroy@c-s.fr>
 <87pnwk1yw4.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <23afad6f-7feb-b36f-e27e-d1b48350517d@c-s.fr>
Date: Mon, 8 Oct 2018 13:30:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87pnwk1yw4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/08/2018 11:06 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>> moves the thread_info into task_struct.
>>
>> Moving thread_info into task_struct has the following advantages:
>> - It protects thread_info from corruption in the case of stack
>> overflows.
>> - Its address is harder to determine if stack addresses are
>> leaked, making a number of attacks more difficult.
> 
> This is blowing up pretty nicely with CONFIG_KMEMLEAK enabled, haven't
> had time to dig further:

Nice :)

I have the same issue on PPC32.
Seems like when descending the stack, save_context_stack() calls 
validate_sp(), which in turn calls valid_irq_stack() when the first test 
fails.
But than early, hardirq_ctx[cpu] is NULL.
With sp = 0, valid_irq_stack() used to return false because it expected 
sp to be above the thread_info. But now that thread_info is gone, sp = 0 
is valid when stack = NULL.

The following fixes it:

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index afe76f7f316c..3e534147fd8f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2006,6 +2006,9 @@ int validate_sp(unsigned long sp, struct 
task_struct *p,
  {
  	unsigned long stack_page = (unsigned long)task_stack_page(p);

+	if (sp < THREAD_SIZE)
+		return 0;
+
  	if (sp >= stack_page + sizeof(struct thread_struct)
  	    && sp <= stack_page + THREAD_SIZE - nbytes)
  		return 1;


Looking at this I also realise I forgot to remove the sizeof(struct 
thread_struct) from here. And this sizeof() was buggy, it should have 
been thread_info instead of thread_struct, but nevermind as it is going 
away.

Christophe
> 
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc000000000022064
> Oops: Kernel access of bad area, sig: 11 [#9]
> LE SMP NR_CPUS=32 NUMA
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-gcc-7.3.1-00103-gc795acc08338 #268
> NIP:  c000000000022064 LR: c0000000000220c0 CTR: c00000000001f5c0
> REGS: c000000001244a50 TRAP: 0380   Not tainted  (4.19.0-rc3-gcc-7.3.1-00103-gc795acc08338)
> MSR:  8000000000001033 <SF,ME,IR,DR,RI,LE>  CR: 48022244  XER: 20000000
> CFAR: c0000000000220c4 IRQMASK: 1
> GPR00: c0000000000220c0 c000000001244cd0 c00000000124b200 0000000000000001
> GPR04: c000000001201180 0000000000000070 c000000001275ef8 0000000000000000
> GPR08: 0000000000000000 0000000000000001 0000000000003f90 2b6e6f6d6d6f635f
> GPR12: c00000000001f5c0 c000000001450000 0000000000000000 0000000002e2be38
> GPR16: 000000007dc54c70 0000000002d854b8 0000000000000000 c000000000d87f00
> GPR20: c000000000d87ef0 c000000000d87ee0 c000000000d87f08 c00000000006c1a8
> GPR24: c000000000d87ec8 0000000000000000 7265677368657265 c000000000062a04
> GPR28: 0000000000000006 c000000001201180 0000000000000000 0000000000000000
> NIP [c000000000022064] show_stack+0xe4/0x2b0
> LR [c0000000000220c0] show_stack+0x140/0x2b0
> Call Trace:
> [c000000001244cd0] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c000000001244da0] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001244e50] [c00000000002ae8c] __die+0xfc/0x140
> [c000000001244ed0] [c00000000002b954] die+0x74/0xf0
> [c000000001244f10] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c000000001244f80] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c000000001244fc0] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c0000000012452b0] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c000000001245380] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001245430] [c00000000002ae8c] __die+0xfc/0x140
> [c0000000012454b0] [c00000000002b954] die+0x74/0xf0
> [c0000000012454f0] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c000000001245560] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c0000000012455a0] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c000000001245890] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c000000001245960] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001245a10] [c00000000002ae8c] __die+0xfc/0x140
> [c000000001245a90] [c00000000002b954] die+0x74/0xf0
> [c000000001245ad0] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c000000001245b40] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c000000001245b80] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c000000001245e70] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c000000001245f40] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001245ff0] [c00000000002ae8c] __die+0xfc/0x140
> [c000000001246070] [c00000000002b954] die+0x74/0xf0
> [c0000000012460b0] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c000000001246120] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c000000001246160] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c000000001246450] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c000000001246520] [c00000000002245c] show_regs+0x22c/0x430
> [c0000000012465d0] [c00000000002ae8c] __die+0xfc/0x140
> [c000000001246650] [c00000000002b954] die+0x74/0xf0
> [c000000001246690] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c000000001246700] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c000000001246740] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c000000001246a30] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c000000001246b00] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001246bb0] [c00000000002ae8c] __die+0xfc/0x140
> [c000000001246c30] [c00000000002b954] die+0x74/0xf0
> [c000000001246c70] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c000000001246ce0] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c000000001246d20] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c000000001247010] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c0000000012470e0] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001247190] [c00000000002ae8c] __die+0xfc/0x140
> [c000000001247210] [c00000000002b954] die+0x74/0xf0
> [c000000001247250] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c0000000012472c0] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c000000001247300] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at show_stack+0xe4/0x2b0
>      LR = show_stack+0x140/0x2b0
> [c0000000012475f0] [c00000000002217c] show_stack+0x1fc/0x2b0 (unreliable)
> [c0000000012476c0] [c00000000002245c] show_regs+0x22c/0x430
> [c000000001247770] [c00000000002ae8c] __die+0xfc/0x140
> [c0000000012477f0] [c00000000002b954] die+0x74/0xf0
> [c000000001247830] [c00000000006e0f8] bad_page_fault+0xe8/0x180
> [c0000000012478a0] [c000000000074f48] slb_miss_large_addr+0x68/0x2e0
> [c0000000012478e0] [c000000000008ce8] large_addr_slb+0x158/0x160
> --- interrupt: 380 at save_context_stack+0x70/0x110
>      LR = save_context_stack+0x64/0x110
> [c000000001247bd0] [c000000001247c10] init_stack+0x3c10/0x4000 (unreliable)
> [c000000001247c10] [c000000000ee2268] log_early+0xc0/0x100
> [c000000001247c70] [c000000000ede7f8] memblock_virt_alloc_internal+0x1cc/0x210
> [c000000001247d20] [c000000000edec00] memblock_virt_alloc_try_nid+0x94/0xfc
> [c000000001247db0] [c000000000f08efc] early_init_dt_alloc_memory_arch+0x2c/0x40
> [c000000001247dd0] [c000000000991200] __unflatten_device_tree+0xa0/0x1e0
> [c000000001247e60] [c000000000f0a1d8] unflatten_device_tree+0x48/0x68
> [c000000001247e90] [c000000000eab6fc] setup_arch+0x4c/0x3fc
> [c000000001247f00] [c000000000ea3df8] start_kernel+0x88/0x604
> Instruction dump:
> 3ec2ffb4 3b800041 3bc00001 3b600000 3b18ccc8 3a73cd00 3a94ccf0 3ab5cce0
> 635a7265 3ad6cd08 48000054 2e3e0000 <ea5f0000> ebdf0010 419200e8 7fbbf040
> random: get_random_bytes called from print_oops_end_marker+0x6c/0xa0 with crng_init=0
> ---[ end trace 0000000000000000 ]---
> 
> 
> 
> cheers
> 
