Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5812C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 16:26:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C7920651
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 16:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="beYzAjhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C7920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ml7n2rhTzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 03:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="beYzAjhY"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ml650ZZqzDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 03:25:16 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Ml5w4sLVz9vRZm;
 Sun, 17 Mar 2019 17:25:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=beYzAjhY; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ZUQumd2YIwKe; Sun, 17 Mar 2019 17:25:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Ml5w3cDgz9vRZl;
 Sun, 17 Mar 2019 17:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552839908; bh=IO+4tvFGfsNhpj2HjtRCDv9bYpXWcyHaNjhj3qhwv08=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=beYzAjhYfA+LazPU+SJSTEf9S4LolWjnMwKqDFkbTEcRtDCqw7Unlv1PxMqWAipXV
 vS6km6NoyuPhxVeIg7uedgnKYWoF6JRrj3jZhtixH6w3qA1zSG6x4RpRkDfiHoWWsH
 aV5VYlPrsg/kGdmgthESNKI3euSe9SNnX37EGS54=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D2BC98B84D;
 Sun, 17 Mar 2019 17:25:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KnYMSvzySkn3; Sun, 17 Mar 2019 17:25:11 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 35B138B750;
 Sun, 17 Mar 2019 17:25:11 +0100 (CET)
Subject: Re: Mac Mini G4 hang on boot with git master
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 linuxppc-dev@lists.ozlabs.org
References: <cf3327d8-3e04-2f37-4734-5525a5b638b2@ilande.co.uk>
 <f5ded479-7008-7b81-a5d9-84f4b3724fe9@ilande.co.uk>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <926e0e0b-c54c-13ed-f2ec-be22bef92538@c-s.fr>
Date: Sun, 17 Mar 2019 17:25:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <f5ded479-7008-7b81-a5d9-84f4b3724fe9@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190317-2, 17/03/2019), Outbound message
X-Antivirus-Status: Clean
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
Cc: paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/03/2019 à 15:15, Mark Cave-Ayland a écrit :
> On 15/03/2019 13:37, Mark Cave-Ayland wrote:
> 
>> Hi all,
>>
>> I've just done a git pull and rebuilt master on my Mac Mini G4 in order to test
>> Michael's merge of my KVM PR fix, and unfortunately my kernel now hangs on boot :(
>>
>> My last working git checkout was somewhere around the 5.0-rc stage, so I suspect it's
>> something that's been merged for 5.1.
>>
>> The hang occurs just after the boot console is disabled which makes me wonder if
>> something is going wrong during PCI bus enumeration. Does anyone have an idea as to
>> what may be causing this? I can obviously bisect it down, but on slow hardware it can
>> take some time...
> 
> This was a weird one: bisecting directly from git master gave a nonsense result,
> however by manually rebasing Michael's PR onto my last known good commit from master
> I was able to finally pin it down to this commit:
> 
> 
> 7a0d6955f3f7a4250da63d528bfff7a9c91b5725 is the first bad commit
> commit 7a0d6955f3f7a4250da63d528bfff7a9c91b5725
> Author: Christophe Leroy <christophe.leroy@c-s.fr>
> Date:   Thu Feb 21 10:37:55 2019 +0000
> 
>      powerpc/6xx: Store PGDIR physical address in a SPRG
> 
>      Use SPRN_SPRG2 to store the current thread PGDIR and
>      avoid reading thread_struct.pgdir at every TLB miss.
> 
>      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 

Hi,

The fix is there:

https://patchwork.ozlabs.org/patch/1053385/

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

