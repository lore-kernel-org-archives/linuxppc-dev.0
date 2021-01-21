Return-Path: <SRS0=iciS=GY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCFC433E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 10:19:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43D9221F8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 10:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43D9221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLz0S0Gd1zDr5n
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 21:19:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLyy43x36zDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2021 21:17:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DLyxs3nT1z9v6LZ;
 Thu, 21 Jan 2021 11:17:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IuF8rVa5Or7Y; Thu, 21 Jan 2021 11:17:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DLyxs2wgwz9v6LV;
 Thu, 21 Jan 2021 11:17:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 94E288B7F9;
 Thu, 21 Jan 2021 11:17:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id oAVzoo93QngR; Thu, 21 Jan 2021 11:17:38 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 55CB18B771;
 Thu, 21 Jan 2021 11:17:38 +0100 (CET)
Subject: Re: [PATCH 02/13] module: add a module_loaded helper
To: David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
References: <20210121074959.313333-1-hch@lst.de>
 <20210121074959.313333-3-hch@lst.de>
 <9052b54a-e05a-1534-9e0f-c73c8b3509bd@csgroup.eu>
 <39a4c883684c418ba324c3db702802b6@AcuMS.aculab.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <474764c3-7aff-1119-95bb-2180b6a12c78@csgroup.eu>
Date: Thu, 21 Jan 2021 11:17:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <39a4c883684c418ba324c3db702802b6@AcuMS.aculab.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 21/01/2021 à 11:13, David Laight a écrit :
> From: Christophe Leroy

Sorry I hit "Reply to the list" instead of "Reply all"

Cc Christoph H. who is the author.

>> Sent: 21 January 2021 10:00
>>
>> Le 21/01/2021 à 08:49, Christoph Hellwig a écrit :
>>> Add a helper that takes modules_mutex and uses find_module to check if a
>>> given module is loaded.  This provides a better abstraction for the two
>>> callers, and allows to unexport modules_mutex and find_module.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    drivers/gpu/drm/drm_fb_helper.c |  7 +------
>>>    include/linux/module.h          |  3 +++
>>>    kernel/module.c                 | 14 ++++++++++++--
>>>    kernel/trace/trace_kprobe.c     |  4 +---
>>>    4 files changed, 17 insertions(+), 11 deletions(-)
>>>
>>
>>> diff --git a/include/linux/module.h b/include/linux/module.h
>>> index 7a0bcb5b1ffccd..b4654f8a408134 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -589,6 +589,9 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
>>>    /* Search for module by name: must hold module_mutex. */
>>>    struct module *find_module(const char *name);
>>>
>>> +/* Check if a module is loaded. */
>>> +bool module_loaded(const char *name);
>>
>> Maybe module_is_loaded() would be a better name.
> 
> I can't see the original patch.

You have it there 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210121074959.313333-3-hch@lst.de/

> 
> What is the point of the function.
> By the time it returns the information is stale - so mostly useless.
> 
> Surely you need to use try_module_get() instead?
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
