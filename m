Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEFC433C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:21:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808FB61A25
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808FB61A25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6PKQ1TCfz3cJS
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 01:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6PJX4ynjz3c2D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 01:20:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F6PJQ0zLJz9v03Q;
 Fri, 26 Mar 2021 15:20:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id s0KOf5I51hUM; Fri, 26 Mar 2021 15:20:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F6PJP6Vfbz9v0P3;
 Fri, 26 Mar 2021 15:20:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B5C58B8CF;
 Fri, 26 Mar 2021 15:20:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id apm4h56oZ3Cq; Fri, 26 Mar 2021 15:20:23 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 95C5C8B8C7;
 Fri, 26 Mar 2021 15:20:22 +0100 (CET)
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
To: Andreas Schwab <schwab@linux-m68k.org>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
Date: Fri, 26 Mar 2021 15:20:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87zgyqdn3d.fsf@igel.home>
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
Cc: linux-arch@vger.kernel.org, robh@kernel.org, microblaze <monstr@monstr.eu>,
 daniel@gimpelevich.san-francisco.ca.us, devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xtensa@linux-xtensa.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 nios2 <ley.foon.tan@intel.com>, linux-mips@vger.kernel.org,
 openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, danielwa@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/03/2021 à 15:08, Andreas Schwab a écrit :
> On Mär 26 2021, Christophe Leroy wrote:
> 
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index f8f15332caa2..e7c91ee478d1 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/swiotlb.h>
>>   #include <linux/smp.h>
>>   #include <linux/efi.h>
>> +#include <linux/cmdline.h>
>>   
>>   #include <asm/cpu_ops.h>
>>   #include <asm/early_ioremap.h>
>> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>>   	}
>>   
>>   	pr_err("No DTB passed to the kernel\n");
>> -#ifdef CONFIG_CMDLINE_FORCE
>> -	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>> +	cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>>   	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
> 
> Shouldn't that message become conditional in some way?
> 

You are right, I did something similar on ARM but looks like I missed it on RISCV.

Christophe
