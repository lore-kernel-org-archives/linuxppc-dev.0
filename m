Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75798C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 09:21:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCF4217D8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 09:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCF4217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Jsvd4ZLczDqJj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:21:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Jss80lXKzDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 20:18:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Jss26Nmvz9v0SD;
 Tue, 18 Dec 2018 10:18:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ALbEpgF_pcDi; Tue, 18 Dec 2018 10:18:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Jss25nfLz9v0S9;
 Tue, 18 Dec 2018 10:18:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CCB0E8B830;
 Tue, 18 Dec 2018 10:18:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JfPe3BidGXQ6; Tue, 18 Dec 2018 10:18:47 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 71A918B754;
 Tue, 18 Dec 2018 10:18:47 +0100 (CET)
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
 <20181218030538.GA24278@latitude>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9a39d910-2a05-3ce7-c949-296db2d458b9@c-s.fr>
Date: Tue, 18 Dec 2018 09:18:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181218030538.GA24278@latitude>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 12/18/2018 03:05 AM, Jonathan Neuschäfer wrote:
> On Mon, Dec 17, 2018 at 10:29:18AM +0100, Christophe Leroy wrote:
>>> With patches 1-3:
>>> [    0.000000] setbat(0, c0000000, 00000000, 01000000, 311)
>>> [    0.000000] setbat(2, c1000000, 01000000, 00800000, 311)
>>> [    0.000000] setbat(4, d0000000, 10000000, 02000000, 791)
>>
>> What we see is that BAT0 is not used in the origin. I have always wondered
>> the reason, maybe there is something odd behind and BAT0 shall no ne used.
>>
>> Could you try and modify find_free_bat() so that it starts at b = 1 instead
>> of b = 0 ?
> 
> In this case, setbat is called with index 2, 3, and 4, but the Wii still
> doesn't boot.
> 
>>> According to arch/powerpc/include/asm/book3s/32/hash.h,
>>>    - 0x591 = _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | _PAGE_PRESENT
>>>    - 0x311 = _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_COHERENT | _PAGE_PRESENT
>>>    - 0x791 = _PAGE_RW | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | _PAGE_PRESENT
>>>
>>
>> Yes, patch 1 added _PAGE_EXEC which explains this 0x200.
>> Do you confirm it still works well with only patch 1 ?
> 
> Patch 1 alone boots to userspace.
> 

Ok, thanks for testing.

The only difference I see then are the flags. Everything else is seems 
identical.

I know you tried already, but would you mind trying once more with the 
following change ?

diff --git b/arch/powerpc/mm/ppc_mmu_32.c a/arch/powerpc/mm/ppc_mmu_32.c
index 61c10ee00ba2..628fba266663 100644
--- b/arch/powerpc/mm/ppc_mmu_32.c
+++ a/arch/powerpc/mm/ppc_mmu_32.c
@@ -119,7 +119,7 @@ unsigned long __init mmu_mapin_ram(unsigned long 
base, unsigned long top)

  		if (size < 128 << 10)
  			break;
-		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
  		base += size;
  	}

I think we may have some code trying to modify the kernel text without 
using code patching functions.

Thanks,
Christophe


> 
> Jonathan
> 
