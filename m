Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA7C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:16:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED9B20850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED9B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YqSn5yMVzDqTQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 22:16:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YqQn5nW4zDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 22:14:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43YqQj1nLCz9v0H5;
 Tue,  8 Jan 2019 12:14:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DRZOfOHpQQDy; Tue,  8 Jan 2019 12:14:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43YqQj19Csz9v245;
 Tue,  8 Jan 2019 12:14:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 510178B7D9;
 Tue,  8 Jan 2019 12:14:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id n7mlBIddv2Tn; Tue,  8 Jan 2019 12:14:22 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ED5458B7D7;
 Tue,  8 Jan 2019 12:14:21 +0100 (CET)
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
To: Breno Leitao <leitao@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
 <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
 <87k1jftshx.fsf@concordia.ellerman.id.au>
 <1949511b-4918-876c-3fcc-431451dff39a@debian.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1ce6a6b8-58ea-8e63-acb2-f2c4a8770c5c@c-s.fr>
Date: Tue, 8 Jan 2019 12:14:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1949511b-4918-876c-3fcc-431451dff39a@debian.org>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Le 08/01/2019 à 12:11, Breno Leitao a écrit :
> Hi Michael,
> 
> On 1/8/19 7:20 AM, Michael Ellerman wrote:
>> Breno Leitao <leitao@debian.org> writes:
>>
>>> hi Christophe,
>>>
>>> On 1/3/19 3:19 PM, LEROY Christophe wrote:
>>>> Breno Leitao <leitao@debian.org> a écrit :
>>>>
>>>>> This patch simply adds definitions for the MSR bits and some macros to
>>>>> test for MSR TM bits.
>>>>>
>>>>> This was copied from arch/powerpc/include/asm/reg.h generic MSR part.
>>>>
>>>> Can't we find a way to avoid duplicating such defines ?
>>>
>>> I think there are three possible ways, but none of them respect the premises
>>> we are used too. These are the possible ways I can think of:
>>>
>>> 1) Including arch/powerpc/include/asm as part of the selftest compilation
>>> process.
>>>     Problem: This might break the selftest independence of the kbuild system.
>>>
>>> 2) Generate a temporary header file inside selftests/include which contains
>>> these macros at compilation time.
>>>     Problem: The problem as above.
>>>
>>> 3) Define MSR fields at userspace headers (/usr/include).
>>>     Problem: I am not sure userspace should have MSR bits information.
>>>
>>> Do you suggest me to investigate any other way?
>>
>> In this case I think we can probably just copy the few #defines we need.
> 
> Cool. That is the very same thing as suggested by Christophe. I sent the v4
> yesterday, with this change already.

It didn't get through. Latest is still v3 it seems, look 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=71262

Christophe

> 
> Thanks for looking at it.
> 
