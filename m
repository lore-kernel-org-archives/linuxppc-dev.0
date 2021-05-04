Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00355C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 11:03:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C8E613BA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 11:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C8E613BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZH5f4VyTz30FQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 21:03:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=N0XJMVzc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.51;
 helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=N0XJMVzc; 
 dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZH515P40z2xy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 21:03:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1620126145; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Bcj2b/OeLCSXbshNqgLc6AcHKlMB+rnJ1fzkDRsVz2UO7U7tq3UH6DaP2b8SbE7inR
 ncvCzPm6KYt3CwBEv4/s+f/futnRbqi36/h0P4aLwCtj6X6KE/UiUDHFu1jm5FAiVTTU
 jdiGDPDHCkouP3vpbSB+n7slIWkvt36zHTO2neXaLpZmI1mtJwthwzhAp3bSZyTxPmwj
 jx92JEDtclTi8QDvRURz13bsHIYlFwLpJz57AeEgr0vrBbZYZf8/6Cs8udE67RnFDx6O
 Ag6aWphlsjEq6G72IoyNY4C84cmU/1LBcQGBTHGHTowIxNQ0VToLnk+a30FvAyxrg/TA
 KJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620126145;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=bLdEt7pxkc6ROYKkNXiF2l/dABLikkh1oOwkkMpjZk4=;
 b=ssNSDiC3hm8qM+JSG2qSPsWpWQparWQX1MHjrk+EhNQlT9ZOPKFzQWYgfglDz+nXmc
 xdNYgvzgKq2xVVk+Z2LIGVOwC4zlxclME5wkL0spJkF+Dxp1cTLcKX+Es3xxrhJ9X2dV
 ptuP4834qjJGfPee+yhl1iPzXKCjnsQFwylx41MruWYnDZzhnN9hauXOvxOgmQNm/mSr
 5tH6AgD1twBs0DxEH2bpBDSTE1FHpOKxLO9zGKYdb50nDro/TrJx9ZmDzwhUFya9XJOI
 GdD+RgDMUnaFp7v7R35Nn85Kp5KuYm6/j0gDqfL4XdTgJjPX1qYols6ibMwwhO70ugHq
 NFpQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620126145;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=bLdEt7pxkc6ROYKkNXiF2l/dABLikkh1oOwkkMpjZk4=;
 b=N0XJMVzcd/RHkMfysFjCeKr/5WkcvMQKoGG8w5EupHcRwzCqSH/lB68Ix24aa/vzm+
 Uiy6KUwgFUYvtV/7DcoZshrxqzn+deTuI8TSP+FecJ4OWEjEANq7rsug3arLTlBzLPXk
 kjoa3NMJs8zkBcv5Zf/46t8kMkc/EPJ4cSeYregehzp0X1gc/k4OEms2HDlZeSNEXNGX
 Ov8piS5NnFVTK27rXiDX8ThNbH7qRuXMRbFKSxeBVKpUGQD5Lmq/B0SXsGsMtxEBThFA
 0SmRHc8twehs4tiS49IDXQkJa4dxdIyKVQxws5Pya8B8mhk9E9Efky/QrvpqwivdCF/6
 HYgw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSIhsJhhV/a8MrHM5J4CoqSoOzBQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:14dd:6e8f:db34:91bd]
 by smtp.strato.de (RZmta 47.25.6 AUTH)
 with ESMTPSA id D075c0x44B2N1VB
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 4 May 2021 13:02:23 +0200 (CEST)
Subject: Re: [FSL P50x0] Xorg always restarts again and again after the the
 PowerPC updates 5.13-1
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <6d3ae417-48de-3b61-f6fe-da951d74fef3@xenosoft.de>
Date: Tue, 4 May 2021 13:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f253fc33-daa1-e668-31b3-593991531ffb@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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

Am 04.05.21 um 12:07 schrieb Christian Zigotzky:
> Am 04.05.21 um 11:49 schrieb Christophe Leroy:
>>
>>
>> Le 04/05/2021 à 11:46, Christian Zigotzky a écrit :
>>> Am 04.05.21 um 11:11 schrieb Christophe Leroy:
>>>>
>>>>
>>>> Le 04/05/2021 à 11:09, Christian Zigotzky a écrit :
>>>>> Am 04.05.21 um 10:58 schrieb Christophe Leroy:
>>>>>>
>>>>>>
>>>>>> Le 04/05/2021 à 10:29, Christian Zigotzky a écrit :
>>>>>>> On 04 May 2021 at 09:47am, Christophe Leroy wrote:
>>>>>>>> Hi
>>>>>>>>
>>>>>>>> Le 04/05/2021 à 09:21, Christian Zigotzky a écrit :
>>>>>>>>> Hi Christophe,
>>>>>>>>>
>>>>>>>>> Thanks for your answer but I think I don't know how it works 
>>>>>>>>> with the cherry-pick.
>>>>>>>>>
>>>>>>>>> $ git bisect start
>>>>>>>>
>>>>>>>> As you suspect the problem to be specific to powerpc, I can do
>>>>>>>>
>>>>>>>> git bisect start -- arch/powerpc
>>>>>>>>
>>>>>>>>
>>>>>>>>> $ git bisect good 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
>>>>>>>>> $ git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
>>>>>>>>
>>>>>>>> You said that powerpc-5.13-1 is bad so you can narrow the 
>>>>>>>> search I think:
>>>>>>>>
>>>>>>>> git bisect bad powerpc-5.13-1
>>>>>>>> git bisect good 887f3ceb51cd3~
>>>>>>> I tried it but without any success.
>>>>>>>
>>>>>>> git bisect bad powerpc-5.13-1
>>>>>>>
>>>>>>> Output:
>>>>>>> fatal: Needed a single revision
>>>>>>> Bad rev input: powerpc-5.13-1
>>>>>>
>>>>>> I don't understand, on my side it works. Maybe a difference 
>>>>>> between your version of git and mine.
>>>>>>
>>>>>> In that case, just use the SHA corresponding to the merge:
>>>>>>
>>>>>> git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
>>>>>>
>>>>>> Christophe
>>>>> Do you use a BookE machine?
>>>>
>>>> No I don't unfortunately, and I have tried booting in QEMU a kernel 
>>>> built with your config, but it freezes before any output.
>>> You can use my kernels and distributions.
>>>
>>
>> Ok, I'll see if I can do something with them.
>>
>> In the meantime, have you been able to bisect ?
>>
>> Thanks
>> Christophe
> I am bisecting currently.
>
> $ git bisect start -- arch/powerpc
> $ git bisect good 887f3ceb51cd3~
> $ git bisect bad c70a4be130de333ea079c59da41cc959712bb01c
OK, there is another issue after the second bisecting step. The boot 
stops after loading the dtb and uImage file. I can't solve 2 issues with 
bisecting at the same time.
