Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C0C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 14:53:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548FC2086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 14:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548FC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FxWw16HPzDqXG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 01:53:48 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FxTR6tP3zDqxZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 01:51:39 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43FxTJ6VWWz9v0Kj;
 Thu, 13 Dec 2018 15:51:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qmnbzjyHf6jM; Thu, 13 Dec 2018 15:51:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43FxTJ5yjHz9ttCS;
 Thu, 13 Dec 2018 15:51:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 262A28B875;
 Thu, 13 Dec 2018 15:51:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OAbhFL3McqCI; Thu, 13 Dec 2018 15:51:34 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B76A8B883;
 Thu, 13 Dec 2018 15:51:32 +0100 (CET)
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
Message-ID: <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
Date: Thu, 13 Dec 2018 15:51:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Again,

Le 13/12/2018 à 13:16, Christophe Leroy a écrit :
> Hi,
> 
> On 12/03/2018 09:55 PM, Jonathan Neuschäfer wrote:
>> Hi,
>>
>> On Thu, Nov 29, 2018 at 07:00:16PM +0000, Christophe Leroy wrote:
>>> This patch reworks mmu_mapin_ram() to be more generic and map as much
>>> blocks as possible. It now supports blocks not starting at address 0.
>>>
>>> It scans DBATs array to find free ones instead of forcing the use of
>>> BAT2 and BAT3.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>
>> I've just tested this series on my Wii, and starting from this patch
>> (03/13), it hangs at the following lines of output:
>>
>> [    0.000000] printk: bootconsole [udbg0] enabled
>> [    0.000000] Total memory = 319MB; using 1024kB for hash table (at 
>> (ptrval))
>>
>> Before this patch it looks like this and boots to userspace:
>>
>> [    0.000000] printk: bootconsole [udbg0] enabled
>> [    0.000000] Total memory = 319MB; using 1024kB for hash table (at 
>> (ptrval))
>> [    0.000000] Linux version 4.20.0-rc5-wii-00022-gfbb911b84755 
>> (jn@longitude) (gcc version 8.2.0 (Debian 8.2.0-9)) #1337 PREEMPT Mon 
>> Dec 3 21:49:02 CET 2018
>> ug_udbg_init: early -> final
>> usbgecko_udbg: ready
>> [    0.000000] Using wii machine description
> 
> Can you tell/provide the .config and dts used ?
> 
> You seem to have 319MB RAM wherease arch/powerpc/boot/dts/wii.dts only 
> has 88MB Memory:
> 
>      memory {
>          device_type = "memory";
>          reg = <0x00000000 0x01800000    /* MEM1 24MB 1T-SRAM */
>                 0x10000000 0x04000000>;    /* MEM2 64MB GDDR3 */
>      };

Putting the same description in my mpc832x board DTS and doing a few 
hacks to get the WII functions called, I get the following:

[    0.000000] Top of RAM: 0x14000000, Total RAM: 0x5800000
[    0.000000] Memory hole size: 232MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x0000000013ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000000017fffff]
[    0.000000]   node   0: [mem 0x0000000010000000-0x0000000013ffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x0000000013ffffff]
[    0.000000] On node 0 totalpages: 22528
[    0.000000]   DMA zone: 640 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 22528 pages, LIFO batch:3
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 21888
[    0.000000] Kernel command line: loglevel=7 
ip=192.168.2.5:192.168.2.2::255.0
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 77060K/90112K available (6548K kernel code, 1156K 
rwdata,
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
[    0.000000]   * 0xfdffd000..0xfe000000  : early ioremap
[    0.000000]   * 0xd5000000..0xfdffd000  : vmalloc & ioremap




root@vgoippro:~# cat /sys/kernel/debug/powerpc/block_address_translation
---[ Instruction Block Address Translation ]---
0: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC coherent
1:         -
2: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC coherent
3:         -
4: 0xd0000000-0xd3ffffff 0x10000000 Kernel EXEC coherent
5:         -
6:         -
7:         -

---[ Data Block Address Translation ]---
0: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW coherent
1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
2: 0xc1000000-0xc17fffff 0x01000000 Kernel RW coherent
3:         -
4: 0xd0000000-0xd3ffffff 0x10000000 Kernel RW coherent
5:         -
6:         -
7:         -


Could you please provide the dmesg and 
/sys/kernel/debug/powerpc/block_address_translation from before this 
patch, so that we can compare and identify the differences if any ?

Thanks
Christophe



> 
> Christophe
> 
>> ...
>>
>> I've tested at patch 1, 2, 3, 4, and 13, so I don't know if it works
>> somewhere in the middle, but probably not.
>>
>> (And in case you're wondering about the 22 in the version string: Those
>> are mostly patches that give me a serial console.)
>>
>> I'm not sure what is going on, because I haven't looked closely at the
>> patches or tried to debug the problem. If you have some debugging tips,
>> I can try them.
>>
>>
>> Jonathan Neuschäfer
>>
