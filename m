Return-Path: <SRS0=LfN0=TY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7EEC072B5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 13:37:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D06E2175B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="O3QpmQfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D06E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 459S9N1nn0zDqVF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 23:37:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="O3QpmQfT"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 459S6m7339zDqV8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2019 23:35:27 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 459S6d0n3Nz9vDbw;
 Fri, 24 May 2019 15:35:21 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=O3QpmQfT; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8JdMYw1lfZV5; Fri, 24 May 2019 15:35:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 459S6c6mZlz9vDbt;
 Fri, 24 May 2019 15:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1558704920; bh=i+etlnkkFMl108nCKHBrU2x0RAePUjL64QozVawAjyo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O3QpmQfT0+M/YUPSmX5iYnprh+CxEySUt/bubJm6i9pRyKEG5DfQnQEDnn4MuN4F4
 urCvzaHW/NlAuyXFvtbQEKDircGEuaEr51jwpVIeAkBeFtXqxteGcYqfXiBfQxrHiz
 upQhYyHz6iFaiN5RCWfhlPrW574C1RKKGuvuxrmc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E6158B879;
 Fri, 24 May 2019 15:35:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id aA4O0UaO1_mM; Fri, 24 May 2019 15:35:22 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BC098B7BF;
 Fri, 24 May 2019 15:35:22 +0200 (CEST)
Subject: Re: [BISECTED] kexec regression on PowerBook G4
To: Aaro Koskinen <aaro.koskinen@iki.fi>
References: <20190522223335.Horde.JIF8kbX8AwL8wErArEvEcg1@messagerie.si.c-s.fr>
 <20190522211724.GC456@darkstar.musicnaut.iki.fi>
 <a3619327-14ba-ff34-913f-cf3384284c9a@c-s.fr>
 <20190523172717.GA5234@darkstar.musicnaut.iki.fi>
 <dc24cfa0-cefa-3245-a9aa-5493b094ffac@c-s.fr>
 <20190523222344.GC5234@darkstar.musicnaut.iki.fi>
 <334b0aca-3731-5754-bd26-af147991345d@c-s.fr>
 <ed5f9739-7661-b32a-cb8f-157b516baafa@c-s.fr>
 <20190524073615.GD5234@darkstar.musicnaut.iki.fi>
 <969271d1-0943-42e6-8992-77b20e305e48@c-s.fr>
 <20190524132907.GE5234@darkstar.musicnaut.iki.fi>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0a691729-45f3-34da-da22-ca418d611179@c-s.fr>
Date: Fri, 24 May 2019 15:35:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190524132907.GE5234@darkstar.musicnaut.iki.fi>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/05/2019 à 15:29, Aaro Koskinen a écrit :
> Hi,
> 
> On Fri, May 24, 2019 at 09:40:30AM +0200, Christophe Leroy wrote:
>> Le 24/05/2019 à 09:36, Aaro Koskinen a écrit :
>>> On Fri, May 24, 2019 at 08:08:36AM +0200, Christophe Leroy wrote:
>>>>> Le 24/05/2019 à 00:23, Aaro Koskinen a écrit :
>>>>>> Unfortunately still no luck... The crash is pretty much the same with
>>>>>> both
>>>>>> changes.
>>>>>
>>>>> Right. In fact change_page_attr() does nothing because this part of RAM is
>>>>> mapped by DBATs so v_block_mapped() returns not NULL.
>>>>>
>>>>> So, we have to set an IBAT for this area. I'll try and send you a new
>>>>> patch for that before noon (CET).
>>>>>
>>>>
>>>> patch sent out. In the patch I have also added a printk to print the buffer
>>>> address, so if the problem still occurs, we'll know if the problem is really
>>>> at the address of the buffer or if we are wrong from the beginning.
>>>
>>> Reboot code buffer at ef0c3000
>>> Bye!
>>> BUG: Unable to handle kernel instruction fetch
>>> Faulting instruction address: 0xef0c3000
>>>
>>
>> Oops, I forgot to call update_bats() after setibat().
>>
>> Can you add it and retry ?
> 
> Thanks, that was it, now it finally works!
> 

Thanks for reporting the issue and testing.

I'll work on a clean fix patch in the begining of June.

Christophe
