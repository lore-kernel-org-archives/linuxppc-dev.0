Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C638DC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:05:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9C621841
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9C621841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KQrx6sfdzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 18:05:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KQpd0vcrzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 18:03:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43KQpX6x2nz9v2Rx;
 Wed, 19 Dec 2018 08:03:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ZLGtgowk6JAG; Wed, 19 Dec 2018 08:03:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43KQpX6M43z9v2Rw;
 Wed, 19 Dec 2018 08:03:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BF4F88B85D;
 Wed, 19 Dec 2018 08:03:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gxj39CXns4St; Wed, 19 Dec 2018 08:03:33 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B2D78B754;
 Wed, 19 Dec 2018 08:03:33 +0100 (CET)
Subject: Re: [PATCH v3] powerpc: implement CONFIG_DEBUG_VIRTUAL
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr>
 <87y38nrkto.fsf@concordia.ellerman.id.au>
 <87a7l2s6p3.fsf@concordia.ellerman.id.au>
 <f725ff38-4dd8-0657-6023-4b0b5b0d5f4e@c-s.fr>
Message-ID: <5e18c60e-9572-5844-b17d-aa55e7ff4709@c-s.fr>
Date: Wed, 19 Dec 2018 07:03:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f725ff38-4dd8-0657-6023-4b0b5b0d5f4e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 12/19/2018 06:57 AM, Christophe Leroy wrote:
> 
> 
> Le 19/12/2018 à 01:26, Michael Ellerman a écrit :
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> This patch implements CONFIG_DEBUG_VIRTUAL to warn about
>>>> incorrect use of virt_to_phys() and page_to_phys()
>>>
>>> This commit is breaking my p5020ds booting a 32-bit kernel with:
>>>
>>>    smp: Bringing up secondary CPUs ...
>>>    __ioremap(): phys addr 0x7fef5000 is RAM lr ioremap_coherent
>>>    Unable to handle kernel paging request for data at address 0x00000000
>>>    Faulting instruction address: 0xc002e950
>>>    Oops: Kernel access of bad area, sig: 11 [#1]
>>>    BE SMP NR_CPUS=24 CoreNet Generic
>>>    Modules linked in:
>>>    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
>>> 4.20.0-rc2-gcc-7.0.1-00138-g9a0380d299e9 #148
>>>    NIP:  c002e950 LR: c002eb20 CTR: 00000001
>>>    REGS: e804bd20 TRAP: 0300   Not tainted  
>>> (4.20.0-rc2-gcc-7.0.1-00138-g9a0380d299e9)
>>>    MSR:  00021002 <CE,ME>  CR: 28004222  XER: 00000000
>>>    DEAR: 00000000 ESR: 00000000
>>>    GPR00: c002eb20 e804bdd0 e8050000 00000000 00021002 00000000 
>>> 00000050 00021002
>>>    GPR08: 2d3f0000 00000001 00000000 00000004 24000842 00000000 
>>> c00026d0 00000000
>>>    GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 
>>> 00000000 00000001
>>>    GPR24: 00029002 7fef5140 30000000 00000000 00000000 00000040 
>>> 00000001 00000000
>>>    NIP [c002e950] smp_85xx_kick_cpu+0x120/0x410
>>>    LR [c002eb20] smp_85xx_kick_cpu+0x2f0/0x410
>>>    Call Trace:
>>>    [e804bdd0] [c002eb20] smp_85xx_kick_cpu+0x2f0/0x410 (unreliable)
>>>    [e804be20] [c0012e38] __cpu_up+0xc8/0x230
>>>    [e804be50] [c0040b34] bringup_cpu+0x34/0x110
>>>    [e804be70] [c00418a8] cpu_up+0x128/0x250
>>>    [e804beb0] [c0b84b14] smp_init+0xc4/0x10c
>>>    [e804bee0] [c0b75c1c] kernel_init_freeable+0xc8/0x250
>>>    [e804bf20] [c00026e8] kernel_init+0x18/0x120
>>>    [e804bf40] [c0011298] ret_from_kernel_thread+0x14/0x1c
>>>    Instruction dump:
>>>    7fb3e850 57bdd1be 2e1d0000 41d20250 57bd3032 393dffc0 7e6a9b78 
>>> 5529d1be
>>>    39290001 7d2903a6 60000000 60000000 <7c0050ac> 394a0040 4200fff8 
>>> 7c0004ac
>>>    ---[ end trace edcab2a1dfd5b38c ]---
>>>
>>>
>>> Which is obviously this hunk:
>>>
>>>> diff --git a/arch/powerpc/mm/pgtable_32.c 
>>>> b/arch/powerpc/mm/pgtable_32.c
>>>> index 4fc77a99c9bf..68d204a45cd0 100644
>>>> --- a/arch/powerpc/mm/pgtable_32.c
>>>> +++ b/arch/powerpc/mm/pgtable_32.c
>>>> @@ -143,7 +143,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long 
>>>> size, pgprot_t prot, void *call
>>>>        * Don't allow anybody to remap normal RAM that we're using.
>>>>        * mem_init() sets high_memory so only do the check after that.
>>>>        */
>>>> -    if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
>>>> +    if (slab_is_available() && virt_addr_valid(p) &&
>>>>           page_is_ram(__phys_to_pfn(p))) {
>>>>           printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>>>>                  (unsigned long long)p, __builtin_return_address(0));
>>>
>>>
>>> I'll try and come up with a fix tomorrow.
>>
>> Actually I think that change is just wrong. virt_addr_valid() takes a
>> virtual address, but p is a physical address.
>>
>> So I'll drop this hunk for now, which makes the patch a no-op when
>> DEBUG_VIRTUAL is n which is probably the way it should be.
> 
> The hunk is obviously wrong for sure. Anyway there's a problem, most 
> likely high_memory is not a valid virtual address, so without this hunk 
> I get the following warning at every ioremap():
> 
> [    0.000000] WARNING: CPU: 0 PID: 0 at 
> ./arch/powerpc/include/asm/io.h:809 __ioremap_caller+0x9c/0x180
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
> 4.20.0-rc6-s3k-dev-00677-g9c98dcab6203-dirty #615
> [    0.000000] NIP:  c000fcd0 LR: c000fc64 CTR: 00000000
> [    0.000000] REGS: c073de50 TRAP: 0700   Not tainted 
> (4.20.0-rc6-s3k-dev-00677-g9c98dcab6203-dirty)
> [    0.000000] MSR:  00021032 <ME,IR,DR,RI>  CR: 28944422  XER: 0000f940
> [    0.000000]
> [    0.000000] GPR00: c000fe04 c073df00 c06e1450 00000001 00004023 
> c073df38 c0018f50 00000001
> [    0.000000] GPR08: 00002000 08000000 00002000 00000000 88944224 
> 00600000 00000000 07ff9580
> [    0.000000] GPR16: 00000000 07ffb94c 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [    0.000000] GPR24: 00000000 c0760000 0000019f ff000000 ff000000 
> c000fe04 00004000 c0018f50
> [    0.000000] NIP [c000fcd0] __ioremap_caller+0x9c/0x180
> [    0.000000] LR [c000fc64] __ioremap_caller+0x30/0x180
> [    0.000000] Call Trace:
> [    0.000000] [c073df00] [c02fc23c] of_address_to_resource+0x114/0x154 
> (unreliable)
> [    0.000000] [c073df30] [c000fe04] ioremap_wt+0x20/0x30
> [    0.000000] [c073df40] [c0018f50] mpc8xx_pic_init+0x70/0xf8
> [    0.000000] [c073df80] [c0655b84] mpc8xx_pics_init+0x10/0x6c
> [    0.000000] [c073df90] [c0675080] cmpc885_pics_init+0x14/0x118
> [    0.000000] [c073dfa0] [c0652eb0] init_IRQ+0x24/0x38
> [    0.000000] [c073dfb0] [c0650b10] start_kernel+0x2a8/0x3d4
> [    0.000000] [c073dff0] [c0002258] start_here+0x44/0x98
> [    0.000000] Instruction dump:
> [    0.000000] 419e00b8 7f83e378 480013fd 7c7d1b79 41820030 576304be 
> 7c63ea14 80010034
> [    0.000000] bb410018 7c0803a6 38210030 4e800020 <0fe00000> 7f9c4840 
> 409cffc4 480000a8
> [    0.000000] random: get_random_bytes called from 
> print_oops_end_marker+0x60/0x84 with crng_init=0
> [    0.000000] ---[ end trace 25d7f28ce013ad37 ]---
> 
> I'll try and come with solution during the day.

In fact the solution is the following:

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 4fc77a99c9bf..60401af2bc8f 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -143,7 +143,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long 
size, pgprot_t prot, void *call
  	 * Don't allow anybody to remap normal RAM that we're using.
  	 * mem_init() sets high_memory so only do the check after that.
  	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	if (slab_is_available() && (p <= virt_to_phys(high_memory - 1)) &&
  	    page_is_ram(__phys_to_pfn(p))) {
  		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
  		       (unsigned long long)p, __builtin_return_address(0));


I'll send an updated patch in a few minutes.

Christophe
