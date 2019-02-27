Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E3C10F16
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:36:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC6A20842
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="n/5fz8Hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC6A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448VtB4Kk0zDqDl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 20:36:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="n/5fz8Hc"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Vqs0bhxzDqDl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 20:33:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 448Vqj08s6z9tym3;
 Wed, 27 Feb 2019 10:33:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=n/5fz8Hc; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7BioI3QsAtIX; Wed, 27 Feb 2019 10:33:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 448Vqh66lQz9tym2;
 Wed, 27 Feb 2019 10:33:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551260032; bh=2J8ZHStak5huUflSrXmQipiG9UlMtxkIp962qvsRXZU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=n/5fz8HclyPkav2T51NujPUuj1o/D2Q3VAcSMSRUwQ+HeAJGZDYMW5f4IB9emuUCs
 OqAg46BENn9rbVDS4CyT/zz6/P7rZWcIa+xH/OsxwZNBK3BwrTcokDEXlj0R1YPvg8
 hSsYMvUEtqvPIcl9Fh/RI5Mje9hCW6uKqi5n9dVA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E49E98B8B8;
 Wed, 27 Feb 2019 10:33:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PqVpdgrTPRpE; Wed, 27 Feb 2019 10:33:53 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AE1F98B754;
 Wed, 27 Feb 2019 10:33:53 +0100 (CET)
Subject: Re: BUG: KASAN: stack-out-of-bounds
To: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <c6d80735-0cfe-b4ab-0349-673fc65b2e15@c-s.fr>
 <5f0203bd-77ea-d94c-11b7-1befba439cd4@virtuozzo.com>
 <CACT4Y+Ze0Ezi4uKVZR1nk_EOjNcHd=JLhYq8ahqbfOL_8Jq9iw@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8e6f345b-679c-9e80-6917-b1953241b917@c-s.fr>
Date: Wed, 27 Feb 2019 10:33:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Ze0Ezi4uKVZR1nk_EOjNcHd=JLhYq8ahqbfOL_8Jq9iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Linux-MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
 linuxppc-dev@lists.ozlabs.org, kasan-dev <kasan-dev@googlegroups.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/02/2019 à 10:25, Dmitry Vyukov a écrit :
> On Wed, Feb 27, 2019 at 10:18 AM Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>> On 2/27/19 11:25 AM, Christophe Leroy wrote:
>>> With version v8 of the series implementing KASAN on 32 bits powerpc (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94309), I'm now able to activate KASAN on a mac99 is QEMU.
>>>
>>> Then I get the following reports at startup. Which of the two reports I get seems to depend on the option used to build the kernel, but for a given kernel I always get the same report.
>>>
>>> Is that a real bug, in which case how could I spot it ? Or is it something wrong in my implementation of KASAN ?
>>>
>>> I checked that after kasan_init(), the entire shadow memory is full of 0 only.
>>>
>>> I also made a try with the strong STACK_PROTECTOR compiled in, but no difference and nothing detected by the stack protector.
>>>
>>> ==================================================================
>>> BUG: KASAN: stack-out-of-bounds in memchr+0x24/0x74
>>> Read of size 1 at addr c0ecdd40 by task swapper/0
>>>
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1133
>>> Call Trace:
>>> [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
>>> [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
>>> [c0e9dd10] [c089579c] memchr+0x24/0x74
>>> [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
>>> [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
>>> [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
>>> --- interrupt: c0e9df00 at 0x400f330
>>>      LR = init_stack+0x1f00/0x2000
>>> [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
>>> [c0e9df20] [c0c28e44] early_irq_init+0x38/0x108
>>> [c0e9df50] [c0c16434] start_kernel+0x310/0x488
>>> [c0e9dff0] [00003484] 0x3484
>>>
>>> The buggy address belongs to the variable:
>>>   __log_buf+0xec0/0x4020
>>> The buggy address belongs to the page:
>>> page:c6eac9a0 count:1 mapcount:0 mapping:00000000 index:0x0
>>> flags: 0x1000(reserved)
>>> raw: 00001000 c6eac9a4 c6eac9a4 00000000 00000000 00000000 ffffffff 00000001
>>> page dumped because: kasan: bad access detected
>>>
>>> Memory state around the buggy address:
>>>   c0ecdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>   c0ecdc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> c0ecdd00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
>>>                                     ^
>>>   c0ecdd80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>>>   c0ecde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ==================================================================
>>>
>>
>> This one doesn't look good. Notice that it says stack-out-of-bounds, but at the same time there is
>>          "The buggy address belongs to the variable:  __log_buf+0xec0/0x4020"
>>   which is printed by following code:
>>          if (kernel_or_module_addr(addr) && !init_task_stack_addr(addr)) {
>>                  pr_err("The buggy address belongs to the variable:\n");
>>                  pr_err(" %pS\n", addr);
>>          }
>>
>> So the stack unrelated address got stack-related poisoning. This could be a stack overflow, did you increase THREAD_SHIFT?
>> KASAN with stack instrumentation significantly increases stack usage.
> 
> A straightforward explanation would be that this happens before real
> shadow is mapped and we don't turn off KASAN reports. Should be easy
> to check so worth eliminating this possibility before any other
> debugging.
> 

I confirm this happens _after_ the call of kasan_init() which sets up 
the final shadow mapping. And after the call of kasan_init() I can 
confirm that the entire shadow area is zeroized.

kasan_init() is called at the top of setup_arch() which is called soon 
after the begining of start_kernel() (see 'KASAN init done' below).

early_irq_init() is called long after that.

Booting Linux via __start() @ 0x01000000 ...
Hello World !
Total memory = 128MB; using 256kB for hash table (at (ptrval))
Linux version 5.0.0-rc7+ (root@po16846vm.idsi0.si.c-s.fr) (gcc version 
5.4.0 (GCC)) #1133 Tue Feb 26 03:30:01 UTC 2019
KASAN init done
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x07
Mapped at 0xf77c0000
Found a Keylargo mac-io controller, rev: 0, mapped at 0x(ptrval)
PowerMac motherboard: PowerMac G4 AGP Graphics
boot stdout isn't a display !
Using PowerMac machine description
printk: bootconsole [udbg0] enabled
-----------------------------------------------------
Hash_size         = 0x40000
phys_mem_size     = 0x8000000
dcache_bsize      = 0x20
icache_bsize      = 0x20
cpu_features      = 0x000000000401a00a
   possible        = 0x000000002f7ff14b
   always          = 0x0000000000000000
cpu_user_features = 0x9c000001 0x00000000
mmu_features      = 0x00000001
Hash              = 0x(ptrval)
Hash_mask         = 0xfff
-----------------------------------------------------
Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus 
number: 0->0
PCI host bridge /pci@f2000000 (primary) ranges:
   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000
nvram: Checking bank 0...
Invalid signature
Invalid checksum
nvram: gen0=0, gen1=0
nvram: Active bank is: 0
nvram: OF partition at 0xffffffff
nvram: XP partition at 0xffffffff
nvram: NR partition at 0xffffffff
Zone ranges:
   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
   HighMem  empty
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Built 1 zonelists, mobility grouping on.  Total pages: 32512
Kernel command line: console=/dev/ttyS0
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 93544K/131072K available (8868K kernel code, 1700K rwdata, 3484K 
rodata, 1004K init, 4434K bss, 37528K reserved, 0K cma-reserved, 0K highmem)
Kernel virtual memory layout:
   * 0xf8000000..0x00000000  : kasan shadow mem
   * 0xf7fd0000..0xf8000000  : fixmap
   * 0xf7800000..0xf7c00000  : highmem PTEs
   * 0xf6f36000..0xf7800000  : early ioremap
   * 0xc9000000..0xf6f36000  : vmalloc & ioremap
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 1 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
GMT Delta read from XPRAM: 0 minutes, DST: on
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 
0x171024e7e0, max_idle_ns: 440795205315 ns
clocksource: timebase mult[a000000] shift[24] registered
==================================================================
BUG: KASAN: stack-out-of-bounds in memchr+0x24/0x74
Read of size 1 at addr c0ecdd40 by task swapper/0

...

Christophe
