Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C9BECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:35:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763DB21479
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763DB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c2P93MbgzF3ZF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 21:35:25 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c2LX1Vx5zF3T8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 21:33:08 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42c2LQ5yGqz9ttFs;
 Fri, 19 Oct 2018 12:33:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7d6wqLIv8ToS; Fri, 19 Oct 2018 12:33:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42c2LQ5NKtz9ttBP;
 Fri, 19 Oct 2018 12:33:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C6408B912;
 Fri, 19 Oct 2018 12:33:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id wVYY97TnjaL8; Fri, 19 Oct 2018 12:33:04 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ED2E68B90C;
 Fri, 19 Oct 2018 12:33:03 +0200 (CEST)
Subject: Re: [PATCH] idle/x86: remove the call to boot_init_stack_canary()
 from cpu_startup_entry()
To: Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <f1b058d6a73cfb68b36dc755df5aaa7a064875b1.1539935852.git.christophe.leroy@c-s.fr>
 <b9727c41-8278-7b83-e5e1-61268dc768d5@suse.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <be4bccb4-9573-360d-5c49-d0bf1a3ecf70@c-s.fr>
Date: Fri, 19 Oct 2018 12:33:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b9727c41-8278-7b83-e5e1-61268dc768d5@suse.com>
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
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 19/10/2018 à 12:01, Juergen Gross a écrit :
> On 19/10/2018 11:29, Christophe Leroy wrote:
>> commit d7880812b359 ("idle: Add the stack canary init to
>> cpu_startup_entry()") added the call to boot_init_stack_canary()
>> in cpu_startup_entry() in an #ifdef CONFIG_X86 statement, with
>> the intention to remove that #ifdef later.
>>
>> While implementing stack protector for powerpc, it has been
>> observed that calling boot_init_stack_canary() is also needed
>> for powerpc which uses per task (TLS) stack canary like the X86.
>>
>> However, calling boot_init_stack_canary() would break arches
>> using global stack canary (ARM, SH, MIPS and XTENSA).
>>
>> Instead of adding modifying the #ifdef in a
>> implemented the call to boot_init_stack_canary() in the function
>> calling cpu_startup_entry()
> 
> I can't parse this sentence.

Oops, git commit took the #if for a comment and droped it. Fixed in v2.

> 
>>
>> On x86, we have two functions calling cpu_startup_entry():
>> - start_secondary()
>> - cpu_bringup_and_idle()
>>
>> start_secondary() already calls boot_init_stack_canary().
>>
>> This patch adds the call to boot_init_stack_canary() in
>> cpu_bringup_and_idle() and removes it from cpu_startup_entry()
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> With the commit message made understandable you can add my
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 

Thanks
Christophe
