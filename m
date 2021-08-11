Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F9BC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 14:11:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB4B60FE6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 14:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BB4B60FE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlBZY5VsHz3cJc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 00:11:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlBZ172sSz2yXW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 00:11:03 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GlBYw3mWMz9sWM;
 Wed, 11 Aug 2021 16:11:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lCMQhEIzhF2Y; Wed, 11 Aug 2021 16:11:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GlBYw2ndfz9sSw;
 Wed, 11 Aug 2021 16:11:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 07A218B765;
 Wed, 11 Aug 2021 16:11:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id juncGdzNjqj0; Wed, 11 Aug 2021 16:10:59 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 943C88B7D9;
 Wed, 11 Aug 2021 16:10:59 +0200 (CEST)
Subject: Re: clang/ld.lld build fails with `can't create dynamic relocation
 R_PPC64_ADDR64 against local symbol in readonly segment`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <b647b710-7ae0-3c7e-6996-92ac974b3b2a@molgen.mpg.de>
 <77a69755-5291-285c-45be-c1e42423fddc@molgen.mpg.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <886ac4a5-ad30-b27f-0b80-ec233c571e81@csgroup.eu>
Date: Wed, 11 Aug 2021 16:10:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <77a69755-5291-285c-45be-c1e42423fddc@molgen.mpg.de>
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
Cc: Derek Parker <parkerderek86@gmail.com>, Dmitrii Okunev <xaionaro@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/08/2021 à 20:38, Paul Menzel a écrit :
> Dear Linux folks,
> 
> 
> Am 29.07.21 um 10:23 schrieb Paul Menzel:
> 
>> I just wanted to make you aware that building Linux for ppc64le with clang/lld.ld fails with [1]:
>>
>>      ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against symbol: empty_zero_page 
>> in readonly segment; recompile object files with -fPIC or pass '-Wl,-z,notext' to allow text 
>> relocations in the output
>>      >>> defined in arch/powerpc/kernel/head_64.o
>>      >>> referenced by arch/powerpc/kernel/head_64.o:(___ksymtab+empty_zero_page+0x0)
>>
>> The patch below from one of the comments [2] fixes it.
>>
>> --- i/arch/powerpc/Makefile
>> +++ w/arch/powerpc/Makefile
>> @@ -122,7 +122,7 @@ cflags-$(CONFIG_STACKPROTECTOR)     += -mstack-protector-guard-reg=r2
>>   endif
>>
>>   LDFLAGS_vmlinux-y := -Bstatic
>> -LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
>> +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie -z notext
>>   LDFLAGS_vmlinux        := $(LDFLAGS_vmlinux-y)
>>   LDFLAGS_vmlinux += $(call ld-option,--orphan-handling=warn)
> 
> Any comments, if this is the right fix? Current Linux master branch still fails to build with 
> `LLVM=1` on Ubuntu 21.04 without this change.

Which kernel version are you building ?

Since https://github.com/linuxppc/linux/commit/45b30fafe528601f1a4449c9d68d8ebe7bbc39ad , 
empty_zero_page[] is in arch/powerpc/mm/mem.c not in arch/powerpc/kernel/head_64.o

Do you still have the issue with kernel 5.14 ?

Christophe
