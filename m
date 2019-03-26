Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C8C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 12:58:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C89A20823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 12:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UiCCQ5WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C89A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TB550zH8zDqF6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 23:58:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="UiCCQ5WN"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TB2M02JVzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 23:55:53 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44TB2B2bW4z9v1gl;
 Tue, 26 Mar 2019 13:55:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=UiCCQ5WN; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9I57AftTqaND; Tue, 26 Mar 2019 13:55:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44TB2B1XJfz9v1gh;
 Tue, 26 Mar 2019 13:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553604946; bh=TvigbH1h2KALPmzqyb+VabwfL492c4scfq3E6byADRU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UiCCQ5WN/NAqKHRntaGP4nDeLD6Rv3mNAVbDEO7utC6g/kWPmhzO8tZDSKcKwdY37
 repeT8NKtBxx8uFFwmrG32Aa2dlCPTVsDLjlfxGUU6cu+E3mzLdA6Xlfe8CXhwbOSg
 DtGKb0inNe8D3Ujh/Omebn3N+ywSKJ1zHB0XiVEI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FC398B8D3;
 Tue, 26 Mar 2019 13:55:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OKukCXTG8ZSk; Tue, 26 Mar 2019 13:55:47 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EB4408B8D0;
 Tue, 26 Mar 2019 13:55:46 +0100 (CET)
Subject: Re: Reading `/sys/kernel/debug/kmemleak` takes 3 s and content not
 shown
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <88e651e2-d876-376e-81fa-eab0729ebb47@molgen.mpg.de>
 <f18fb509-bee1-e411-3761-bd28a0d8aab7@molgen.mpg.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ad2278fd-ea56-d715-7efb-c4e0adb7314e@c-s.fr>
Date: Tue, 26 Mar 2019 13:55:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <f18fb509-bee1-e411-3761-bd28a0d8aab7@molgen.mpg.de>
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



Le 26/03/2019 à 13:49, Paul Menzel a écrit :
> Dear Linux folks,
> 
> 
> On 19.02.19 10:44, Paul Menzel wrote:
> 
>> On a the IBM S822LC (8335-GTA) with Ubuntu 18.10, and Linux 5.0-rc5+
>> accessing `/sys/kernel/debug/kmemleak` takes a long time. According to
>> strace it takes three seconds.
>>
>> $ dmesg | grep leak
>> [    4.407957] kmemleak: Kernel memory leak detector initialized
>> [    4.407959] kmemleak: Automatic memory scanning thread started
>> [745989.625624] kmemleak: 1 new suspected memory leaks (see 
>> /sys/kernel/debug/kmemleak)
>> [1002619.951902] kmemleak: 1 new suspected memory leaks (see 
>> /sys/kernel/debug/kmemleak)
>> ```
>>
>> Unfortunately, the leaks supposedly stored in that file are not shown
>> either.
> 
> The problem is still present with Linux 5.0. Do you have an idea, how to 
> fix this?
> 

Have you identified a previous version that works properly ?

If so, have you been able to bisect the problem ?

Christophe
