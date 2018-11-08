Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB270ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:54:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0203920684
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0203920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rWBz5rQnzF3SH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 04:54:51 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rW8g69S4zF3Rg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 04:52:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42rW8V0Z4sz9ty80;
 Thu,  8 Nov 2018 18:52:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id BVFx6IIKyaFq; Thu,  8 Nov 2018 18:52:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42rW8T6YLfz9ty77;
 Thu,  8 Nov 2018 18:52:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 04D2D8B86A;
 Thu,  8 Nov 2018 18:52:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dwvbzMPJggSw; Thu,  8 Nov 2018 18:52:45 +0100 (CET)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A037F8B85C;
 Thu,  8 Nov 2018 18:52:45 +0100 (CET)
Subject: Re: [PATCH 0/5] Guarded Userspace Access Prevention on Radix
To: Russell Currey <ruscur@russell.cc>
References: <20181026182916.Horde.8LHYJj4tB_PV5JLEA5Czjw1@messagerie.si.c-s.fr>
 <0e66ee72293811f580bd02ab4ed7967a4b703d70.camel@russell.cc>
 <20181031175845.Horde.o95YpPKYLOaCZUubOS1NRw1@messagerie.si.c-s.fr>
 <cdfb9e078946c63170845d2ec7167a6902514fc1.camel@russell.cc>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3b8d2b1b-548b-5a07-4358-4e645c06f59e@c-s.fr>
Date: Thu, 8 Nov 2018 18:52:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cdfb9e078946c63170845d2ec7167a6902514fc1.camel@russell.cc>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 01/11/2018 à 04:54, Russell Currey a écrit :
> On Wed, 2018-10-31 at 17:58 +0100, LEROY Christophe wrote:
>> Russell Currey <ruscur@russell.cc> a écrit :
>>
>>> On Fri, 2018-10-26 at 18:29 +0200, LEROY Christophe wrote:
>>>> Russell Currey <ruscur@russell.cc> a écrit :
>>>>
>>>>> Guarded Userspace Access Prevention is a security mechanism
>>>>> that
>>>>> prevents
>>>>> the kernel from being able to read and write userspace
>>>>> addresses
>>>>> outside of
>>>>> the allowed paths, most commonly copy_{to/from}_user().
>>>>>
>>>>> At present, the only CPU that supports this is POWER9, and only
>>>>> while using
>>>>> the Radix MMU.  Privileged reads and writes cannot access user
>>>>> data
>>>>> when
>>>>> key 0 of the AMR is set.  This is described in the "Radix Tree
>>>>> Translation
>>>>> Storage Protection" section of the POWER ISA as of version 3.0.
>>>>
>>>> It is not right that only power9 can support that.
>>>
>>> It's true that not only P9 can support it, but there are more
>>> considerations under hash than radix, implementing this for radix
>>> is a
>>> first step.
>>
>> I don't know much about hash, but I was talking about the 8xx which
>> is
>> a nohash ppc32. I'll see next week if I can do something with it on
>> top of your serie.
> 
> My small brain saw the number 8 and assumed you were talking about
> POWER8, I didn't know what 8xx was until now.
> 
> Working on a refactor to make things a bit more generic, and removing
> the radix name and dependency from the config option.

In signal_32.c and signal_64.c, save_user_regs() calls __put_user() to 
modify code, then calls flush_icache_range() on user addresses.

Shouldn't flush_icache_range() be performed with userspace access 
protection unlocked ?

Christophe
