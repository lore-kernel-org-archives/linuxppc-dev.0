Return-Path: <SRS0=iciS=GY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 10:14:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C56239D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 10:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C56239D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLysw30WmzDrNV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 21:14:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLyql3j9rzDqW3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2021 21:12:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DLyqV31mGz9v6LW;
 Thu, 21 Jan 2021 11:12:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id zxJatTC41KQg; Thu, 21 Jan 2021 11:12:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DLyqV20H6z9v6LV;
 Thu, 21 Jan 2021 11:12:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 745508B7F9;
 Thu, 21 Jan 2021 11:12:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ktfuIS4yHAOi; Thu, 21 Jan 2021 11:12:07 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F11788B771;
 Thu, 21 Jan 2021 11:12:06 +0100 (CET)
Subject: Re: [PATCH 1/2] crypto: talitos - Work around SEC6 ERRATA (AES-CTR
 mode data size error)
To: Ard Biesheuvel <ardb@kernel.org>
References: <4b7a870573f485b9fea496b13c9b02d86dd97314.1611169001.git.christophe.leroy@csgroup.eu>
 <CAMj1kXE7B05eAnR7KoDCym09Cw5qnzrV8KfNT2zJrko+mFic+w@mail.gmail.com>
 <6b804eff-bc9f-5e05-d479-f398de4e2b30@csgroup.eu>
 <CAMj1kXHz8LdDgfOcifcB-MBMM9-TbymOU_psT3JBFQfyvQ=EjQ@mail.gmail.com>
 <ecdd07b3-afca-7e26-b6b6-3a3a985bc5a1@csgroup.eu>
 <CAMj1kXFNZba9T45RaB_W58Z+4sdAyUDVJM_ZZPk+Y6Mf9DZUQw@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <80ea6d2d-c29e-0c4c-9402-76579fe1eef9@csgroup.eu>
Date: Thu, 21 Jan 2021 11:12:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFNZba9T45RaB_W58Z+4sdAyUDVJM_ZZPk+Y6Mf9DZUQw@mail.gmail.com>
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
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/01/2021 à 11:02, Ard Biesheuvel a écrit :
> On Thu, 21 Jan 2021 at 10:54, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 21/01/2021 à 08:31, Ard Biesheuvel a écrit :
>>> On Thu, 21 Jan 2021 at 06:35, Christophe Leroy
>>> <christophe.leroy@csgroup.eu> wrote:
>>>>
>>>>
>>>>
>>>> Le 20/01/2021 à 23:23, Ard Biesheuvel a écrit :
>>>>> On Wed, 20 Jan 2021 at 19:59, Christophe Leroy
>>>>> <christophe.leroy@csgroup.eu> wrote:
>>>>>>
>>>>>> Talitos Security Engine AESU considers any input
>>>>>> data size that is not a multiple of 16 bytes to be an error.
>>>>>> This is not a problem in general, except for Counter mode
>>>>>> that is a stream cipher and can have an input of any size.
>>>>>>
>>>>>> Test Manager for ctr(aes) fails on 4th test vector which has
>>>>>> a length of 499 while all previous vectors which have a 16 bytes
>>>>>> multiple length succeed.
>>>>>>
>>>>>> As suggested by Freescale, round up the input data length to the
>>>>>> nearest 16 bytes.
>>>>>>
>>>>>> Fixes: 5e75ae1b3cef ("crypto: talitos - add new crypto modes")
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>
>>>>> Doesn't this cause the hardware to write outside the given buffer?
>>>>
>>>>
>>>> Only the input length is modified. Not the output length.
>>>>
>>>> The ERRATA says:
>>>>
>>>> The input data length (in the descriptor) can be rounded up to the nearest 16B. Set the
>>>> data-in length (in the descriptor) to include X bytes of data beyond the payload. Set the
>>>> data-out length to only output the relevant payload (don't need to output the padding).
>>>> SEC reads from memory are not destructive, so the extra bytes included in the AES-CTR
>>>> operation can be whatever bytes are contiguously trailing the payload.
>>>
>>> So what happens if the input is not 16 byte aligned, and rounding it
>>> up causes it to extend across a page boundary into a page that is not
>>> mapped by the IOMMU/SMMU?
>>>
>>
>> What is the IOMMU/SMMU ?
>>
>> The mpc8xx, mpc82xx and mpc83xx which embed the Talitos Security Engine don't have such thing, the
>> security engine uses DMA and has direct access to the memory bus for reading and writing.
>>
> 
> OK, good. So the only case where this could break is when the DMA
> access spills over into a page that does not exist, and I suppose this
> could only happen if the transfer involves a buffer located at the
> very top of DRAM, right?
> 

Right.

Christophe
