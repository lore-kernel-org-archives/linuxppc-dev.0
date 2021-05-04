Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3FDC433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 14:42:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9AF6024A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 14:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9AF6024A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZMxq5HQ5z30H2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 00:42:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZMxN3dJ0z2y88
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 May 2021 00:41:56 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FZMxF5LB2z9sWB;
 Tue,  4 May 2021 16:41:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gy1HRPGvUFHX; Tue,  4 May 2021 16:41:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FZMxF4LsRz9sW7;
 Tue,  4 May 2021 16:41:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 784268B78D;
 Tue,  4 May 2021 16:41:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id t127O8x4c5H7; Tue,  4 May 2021 16:41:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DC38E8B7B1;
 Tue,  4 May 2021 16:41:52 +0200 (CEST)
Subject: Re: [FSL P50x0] Xorg always restarts again and again after the the
 PowerPC updates 5.13-1
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <c5b0ac7c-525f-0208-7587-c90427eae137@xenosoft.de>
 <0886c1dc-e946-69cb-a0a9-57247acfd080@csgroup.eu>
 <9864cd72-f1aa-4cf5-1cda-b3a10233b24d@xenosoft.de>
 <1b0307be-05cd-ab62-8b22-75ffb59ff76b@csgroup.eu>
 <daace050-6233-77ea-4517-0fd3c4b21057@xenosoft.de>
 <30f559f4-b50a-de63-94e1-761022468684@csgroup.eu>
 <c9a692b4-0ac0-d595-10fa-c3213b1518fc@xenosoft.de>
 <3b7daea5-7b2b-a089-0427-3becb986b6f5@csgroup.eu>
 <1502fb22-680c-7393-238c-f82570806717@xenosoft.de>
 <6a322f04-a81e-ae31-1425-19fda9307b23@csgroup.eu>
 <f253fc33-daa1-e668-31b3-593991531ffb@xenosoft.de>
 <6d3ae417-48de-3b61-f6fe-da951d74fef3@xenosoft.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <07541597-f309-0d33-2c29-6da8fcd10aa1@csgroup.eu>
Date: Tue, 4 May 2021 16:41:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6d3ae417-48de-3b61-f6fe-da951d74fef3@xenosoft.de>
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/05/2021 à 13:02, Christian Zigotzky a écrit :
> Am 04.05.21 um 12:07 schrieb Christian Zigotzky:
>> Am 04.05.21 um 11:49 schrieb Christophe Leroy:
>>>
>>>
>>> Le 04/05/2021 à 11:46, Christian Zigotzky a écrit :
>>>> Am 04.05.21 um 11:11 schrieb Christophe Leroy:
>>>>>
>>>>>
>>>>> Le 04/05/2021 à 11:09, Christian Zigotzky a écrit :
>>>>>> Am 04.05.21 um 10:58 schrieb Christophe Leroy:
>>>>>>>
>>>>>>>
>>>>>>> Le 04/05/2021 à 10:29, Christian Zigotzky a écrit :
>>>>>>>> On 04 May 2021 at 09:47am, Christophe Leroy wrote:
>>>>>>>>> Hi
>>>>>>>>>
>>>>>>>>> Le 04/05/2021 à 09:21, Christian Zigotzky a écrit :
>>>>>>>>>> Hi Christophe,
>>>>>>>>>>
>>>>>>>>>> Thanks for your answer but I think I don't know how it works with the cherry-pick.
>>>>>>>>>>
>>>>>>>>>> $ git bisect start
>>>>>>>>>
>>>>>>>>> As you suspect the problem to be specific to powerpc, I can do
>>>>>>>>>
>>>>>>>>> git bisect start -- arch/powerpc
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> $ git bisect good 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
>>>>>>>>>> $ git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
>>>>>>>>>
>>>>>>>>> You said that powerpc-5.13-1 is bad so you can narrow the search I think:
>>>>>>>>>
>>>>>>>>> git bisect bad powerpc-5.13-1
>>>>>>>>> git bisect good 887f3ceb51cd3~
>>>>>>>> I tried it but without any success.
>>>>>>>>
>>>>>>>> git bisect bad powerpc-5.13-1
>>>>>>>>
>>>>>>>> Output:
>>>>>>>> fatal: Needed a single revision
>>>>>>>> Bad rev input: powerpc-5.13-1
>>>>>>>
>>>>>>> I don't understand, on my side it works. Maybe a difference between your version of git and 
>>>>>>> mine.
>>>>>>>
>>>>>>> In that case, just use the SHA corresponding to the merge:
>>>>>>>
>>>>>>> git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
>>>>>>>
>>>>>>> Christophe
>>>>>> Do you use a BookE machine?
>>>>>
>>>>> No I don't unfortunately, and I have tried booting in QEMU a kernel built with your config, but 
>>>>> it freezes before any output.
>>>> You can use my kernels and distributions.
>>>>
>>>
>>> Ok, I'll see if I can do something with them.
>>>
>>> In the meantime, have you been able to bisect ?
>>>
>>> Thanks
>>> Christophe
>> I am bisecting currently.
>>
>> $ git bisect start -- arch/powerpc
>> $ git bisect good 887f3ceb51cd3~
>> $ git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
> OK, there is another issue after the second bisecting step. The boot stops after loading the dtb and 
> uImage file. I can't solve 2 issues with bisecting at the same time.

In that case, you can use 'git bisect skip' to skip the one that is not booting at all.
