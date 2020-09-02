Return-Path: <SRS0=iKE2=CL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6E5C433E7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 14:16:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4856206E7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 14:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4856206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BhQx03NngzDqyj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 00:16:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BhQrm0SlczDqvK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 00:13:09 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BhQrb14QDz9txSf;
 Wed,  2 Sep 2020 16:13:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GuQVU6E922f3; Wed,  2 Sep 2020 16:13:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BhQrZ4lmSz9txS9;
 Wed,  2 Sep 2020 16:13:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EA6E38B7EE;
 Wed,  2 Sep 2020 16:13:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6937B_9zfpgR; Wed,  2 Sep 2020 16:13:03 +0200 (CEST)
Received: from [10.25.210.31] (po15451.idsi0.si.c-s.fr [10.25.210.31])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F1C98B7E5;
 Wed,  2 Sep 2020 16:13:01 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
To: David Laight <David.Laight@ACULAB.COM>, 'Christoph Hellwig' <hch@lst.de>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
 <61b9a880a6424a34b841cf3dddb463ad@AcuMS.aculab.com>
 <8de54fe0-4be9-5624-dd1d-d95d792e933d@csgroup.eu>
 <0c298e0d972a48bd9ee178225e404b12@AcuMS.aculab.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6e88048a-8b30-400e-11c6-8d91ba77cbb0@csgroup.eu>
Date: Wed, 2 Sep 2020 16:12:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0c298e0d972a48bd9ee178225e404b12@AcuMS.aculab.com>
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 02/09/2020 à 15:51, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 02 September 2020 14:25
>> Le 02/09/2020 à 15:13, David Laight a écrit :
>>> From: Christoph Hellwig
>>>> Sent: 02 September 2020 13:37
>>>>
>>>> On Wed, Sep 02, 2020 at 08:15:12AM +0200, Christophe Leroy wrote:
>>>>>> -		return 0;
>>>>>> -	return (size == 0 || size - 1 <= seg.seg - addr);
>>>>>> +	if (addr >= TASK_SIZE_MAX)
>>>>>> +		return false;
>>>>>> +	if (size == 0)
>>>>>> +		return false;
>>>>>
>>>>> __access_ok() was returning true when size == 0 up to now. Any reason to
>>>>> return false now ?
>>>>
>>>> No, this is accidental and broken.  Can you re-run your benchmark with
>>>> this fixed?
>>>
>>> Is TASK_SIZE_MASK defined such that you can do:
>>>
>>> 	return (addr | size) < TASK_SIZE_MAX) || !size;
>>
>> TASK_SIZE_MAX will usually be 0xc0000000
>>
>> With:
>> addr = 0x80000000;
>> size = 0x80000000;
>>
>> I expect it to fail ....
>>
>> With the formula you propose it will succeed, won't it ?
> 
> Hmmm... Was i getting confused about some comments for 64bit
> about there being such a big hole between valid user and kernel
> addresses that it was enough to check that 'size < TASK_SIZE_MAX'.
> 
> That would be true for 64bit x86 (and probably ppc (& arm??))
> if TASK_SIZE_MAX were 0x4 << 60.
> IIUC the highest user address is (much) less than 0x0 << 60
> and the lowest kernel address (much) greater than 0xf << 60
> on all these 64bit platforms.
> 
> Actually if doing access_ok() inside get_user() you don't
> need to check the size at all.

You mean on 64 bit or on any platform ?

What about a word write to 0xbffffffe, won't it overwrite 0xc0000000 ?

> You don't even need to in copy_to/from_user() provided
> it always does a forwards copy.

Do you mean due to the gap ?
Is it garantied to be a gap ? Even on a 32 bits having TASK_SIZE set to 
0xc0000000 and PAGE_OFFSET set to the same ?


Christophe
