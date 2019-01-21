Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC9C31D64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8304820823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uIcyXAAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8304820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jjbT4SYnzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 18:19:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="uIcyXAAo"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jjY46GDczDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 18:17:11 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43jjXp0tCfz9v4gc;
 Mon, 21 Jan 2019 08:16:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=uIcyXAAo; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 61GoLOnk_gxW; Mon, 21 Jan 2019 08:16:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43jjXn6hrRz9v4gb;
 Mon, 21 Jan 2019 08:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548055017; bh=vJv0qjC91P024h+/ge4sUI2JOyyWiTeIU9Uv+g7IJ5s=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=uIcyXAAo9wkTVhUzniM7mqe9lZ0TELd7e8uQl3gNRa4eVhG199Qk+14jyam+cmb1p
 dFlSwQEPmEw3j3tBWsaj/u5hQqa8r6mZsr8FPEyYorwLMpj/QwJ9JGWIyzmskmRrWf
 8Y75XlG5U/xiYdlIT7LakHqaKgTJSmjy6dnE6+do=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 28B3A8B75A;
 Mon, 21 Jan 2019 08:17:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id f9Nf5AXiHasr; Mon, 21 Jan 2019 08:17:04 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DEF178B74B;
 Mon, 21 Jan 2019 08:17:03 +0100 (CET)
Subject: Re: [PATCH v3 3/3] powerpc/32: Add KASAN support
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <935f9f83393affb5d55323b126468ecb90373b88.1547289808.git.christophe.leroy@c-s.fr>
 <e4b343fa-702b-294f-7741-bb85ed877cdf@virtuozzo.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8d433501-a5a7-8e3b-03f7-ccdd0f8622e1@c-s.fr>
Date: Mon, 21 Jan 2019 08:17:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e4b343fa-702b-294f-7741-bb85ed877cdf@virtuozzo.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/01/2019 à 18:23, Andrey Ryabinin a écrit :
> 
> 
> On 1/12/19 2:16 PM, Christophe Leroy wrote:
> 
>> +KASAN_SANITIZE_early_32.o := n
>> +KASAN_SANITIZE_cputable.o := n
>> +KASAN_SANITIZE_prom_init.o := n
>> +
> 
> Usually it's also good idea to disable branch profiling - define DISABLE_BRANCH_PROFILING
> either in top of these files or via Makefile. Branch profiling redefines if() statement and calls
> instrumented ftrace_likely_update in every if().
> 
> 
> 
>> diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_init.c
>> new file mode 100644
>> index 000000000000..3edc9c2d2f3e
> 
>> +void __init kasan_init(void)
>> +{
>> +	struct memblock_region *reg;
>> +
>> +	for_each_memblock(memory, reg)
>> +		kasan_init_region(reg);
>> +
>> +	pr_info("KASAN init done\n");
> 
> Without "init_task.kasan_depth = 0;" kasan will not repot bugs.
> 
> There is test_kasan module. Make sure that it produce reports.
> 

Thanks for the review.

Now I get the following very early in boot, what does that mean ?

[    0.000000] KASAN init done
[    0.000000] 
==================================================================
[    0.000000] BUG: KASAN: unknown-crash in memblock_alloc_try_nid+0xd8/0xf0
[    0.000000] Write of size 68 at addr c7ff5a90 by task swapper/0
[    0.000000]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
5.0.0-rc2-s3k-dev-00559-g88aa407c4bce #772
[    0.000000] Call Trace:
[    0.000000] [c094ded0] [c016c7e4] 
print_address_description+0x1a0/0x2b8 (unreliable)
[    0.000000] [c094df00] [c016caa0] kasan_report+0xe4/0x168
[    0.000000] [c094df40] [c016b464] memset+0x2c/0x4c
[    0.000000] [c094df60] [c08731f0] memblock_alloc_try_nid+0xd8/0xf0
[    0.000000] [c094df90] [c0861f20] mmu_context_init+0x58/0xa0
[    0.000000] [c094dfb0] [c085ca70] start_kernel+0x54/0x400
[    0.000000] [c094dff0] [c0002258] start_here+0x44/0x9c
[    0.000000]
[    0.000000]
[    0.000000] Memory state around the buggy address:
[    0.000000]  c7ff5980: e2 a1 87 81 bd d4 a5 b5 f8 8d 89 e7 72 bc 20 24
[    0.000000]  c7ff5a00: e7 b9 c1 c7 17 e9 b4 bd a4 d0 e7 a0 11 15 a5 b5
[    0.000000] >c7ff5a80: b5 e1 83 a5 2d 65 31 3f f3 e5 a7 ef 34 b5 69 b5
[    0.000000]                  ^
[    0.000000]  c7ff5b00: 21 a5 c1 c1 b4 bf 2d e5 e5 c3 f5 91 e3 b8 a1 34
[    0.000000]  c7ff5b80: ad ef 23 87 3d a6 ad b5 c3 c3 80 b7 ac b1 1f 37
[    0.000000] 
==================================================================
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] MMU: Allocated 76 bytes of context maps for 16 contexts
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8176
[    0.000000] Kernel command line: console=ttyCPM0,115200N8 
ip=192.168.2.7:192.168.2.2::255.0.0.0:vgoip:eth0:off kgdboc=ttyCPM0
[    0.000000] Dentry cache hash table entries: 16384 (order: 2, 65536 
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 1, 32768 bytes)
[    0.000000] Memory: 99904K/131072K available (7376K kernel code, 528K 
rwdata, 1168K rodata, 576K init, 4623K bss, 31168K reserved, 0K 
cma-reserved)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xffefc000..0xffffc000  : fixmap
[    0.000000]   * 0xf7c00000..0xffc00000  : kasan shadow mem
[    0.000000]   * 0xf7a00000..0xf7c00000  : consistent mem
[    0.000000]   * 0xf7a00000..0xf7a00000  : early ioremap
[    0.000000]   * 0xc9000000..0xf7a00000  : vmalloc & ioremap


Christophe
