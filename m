Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE67BC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:30:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7112172C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7112172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M4dB6BtDzF3CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:30:54 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M4b049SKzF390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 18:28:59 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42M4Zr5NBWz9ttRf;
 Fri, 28 Sep 2018 10:28:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ZlYInmZgdXCi; Fri, 28 Sep 2018 10:28:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42M4Zr4n2Xz9ttBd;
 Fri, 28 Sep 2018 10:28:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B0678B8CB;
 Fri, 28 Sep 2018 10:28:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id V8ubInMGcyzY; Fri, 28 Sep 2018 10:28:54 +0200 (CEST)
Received: from PO15451 (unknown [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 46C8A8B8C2;
 Fri, 28 Sep 2018 10:28:54 +0200 (CEST)
Subject: Re: [PATCH] powerpc: wire up memtest
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <b3f2074b89ef0e3352fb11b69be30caeaa823fa0.1535360497.git.christophe.leroy@c-s.fr>
 <871s9euw4m.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <9f0055e2-ebd1-649b-272e-cb9b58bd4e15@c-s.fr>
Date: Fri, 28 Sep 2018 10:28:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871s9euw4m.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 28/09/2018 à 05:41, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Add call to early_memtest() so that kernel compiled with
>> CONFIG_MEMTEST really perform memtest at startup when requested
>> via 'memtest' boot parameter.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/setup-common.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 93fa0c99681e..904b728eb20d 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -33,6 +33,7 @@
>>   #include <linux/serial_8250.h>
>>   #include <linux/percpu.h>
>>   #include <linux/memblock.h>
>> +#include <linux/bootmem.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/hugetlb.h>
>>   #include <asm/debugfs.h>
>> @@ -917,6 +918,8 @@ void __init setup_arch(char **cmdline_p)
>>   	/* Parse memory topology */
>>   	mem_topology_setup();
>>   
>> +	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
> 
> On a ppc64le VM this boils down to early_memtest(0, 0) for me.
> 
> I think it's too early, we don't set up max_low_pfn until
> initmem_init().
> 
> If I move it after initmem_init() then it does something more useful:

Ok. On my 8xx max_low_pfn is set in mem_topology_setup().

Moving the test afte initmem_init() still works on the 8xx so I'll do that.

Thanks for testing.

Christophe

> 
> early_memtest: # of tests: 17
>    0x0000000001450580 - 0x0000000001450800 pattern 4c494e5558726c7a
>    0x0000000001450c00 - 0x0000000003600000 pattern 4c494e5558726c7a
>    0x00000000047c0000 - 0x000000002fff0000 pattern 4c494e5558726c7a
>    0x0000000030000000 - 0x000000003ff24000 pattern 4c494e5558726c7a
>    0x000000003fff4000 - 0x000000003fff4c00 pattern 4c494e5558726c7a
>    0x000000003fff5000 - 0x000000003fff5300 pattern 4c494e5558726c7a
>    0x000000003fff5c00 - 0x000000003fff5f00 pattern 4c494e5558726c7a
>    0x000000003fff6800 - 0x000000003fff6b00 pattern 4c494e5558726c7a
>    0x000000003fff7400 - 0x000000003fff7700 pattern 4c494e5558726c7a
>    0x000000003fff8000 - 0x000000003fff8300 pattern 4c494e5558726c7a
>    0x000000003fff8c00 - 0x000000003fff8f00 pattern 4c494e5558726c7a
>    0x000000003fff9800 - 0x000000003fff9b00 pattern 4c494e5558726c7a
>    0x000000003fffa400 - 0x000000003fffa700 pattern 4c494e5558726c7a
>    0x000000003fffb000 - 0x000000003fffb300 pattern 4c494e5558726c7a
>    0x000000003fffbc00 - 0x000000003fffbf00 pattern 4c494e5558726c7a
>    0x000000003fffc800 - 0x000000003fffcb00 pattern 4c494e5558726c7a
>    0x000000003fffd400 - 0x000000003fffd700 pattern 4c494e5558726c7a
>    0x000000003fffe000 - 0x000000003fffe100 pattern 4c494e5558726c7a
>    0x0000000040000000 - 0x00000000ffc10000 pattern 4c494e5558726c7a
>    0x00000000fffa0000 - 0x00000000fffa5b00 pattern 4c494e5558726c7a
>    0x0000000100000000 - 0x00000001ffbe0000 pattern 4c494e5558726c7a
>    0x00000001fff60000 - 0x00000001fff61b00 pattern 4c494e5558726c7a
>    0x00000001fffec000 - 0x00000001fffec4b8 pattern 4c494e5558726c7a
>    0x00000001fffec524 - 0x00000001fffec528 pattern 4c494e5558726c7a
> 
> 
> cheers
> 
