Return-Path: <SRS0=UVon=TW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA1BC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 12:22:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE782173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 12:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YvRuIYHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE782173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458Bbx70vBzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 22:22:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="YvRuIYHk"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458BYd5n5FzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2019 22:20:53 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 458BYW1hRBz9v1nY;
 Wed, 22 May 2019 14:20:47 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=YvRuIYHk; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nYBnYkHiC9Ld; Wed, 22 May 2019 14:20:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 458BYW0Lxyz9v0f4;
 Wed, 22 May 2019 14:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1558527647; bh=5oNTOzkz7UIE/hMLqa5BxYGbDiaXDOiAlBlv2B0PXAk=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=YvRuIYHkkqgxmewmDbVM76bv6crRYInpY/Wsj8cJ1GY5m198GFYGhRu5jz8VRP5/4
 k1X8GDMTIqAD1hrzFbS1qXUTzk0AFQCeTrAz2y+dd2p1ovxkrY7CegJon9GPkRY6kO
 uQaGvSaGPnZ9LKcpI2/xwZMzrb/SAc2GUZ0CHXjc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 687848B83E;
 Wed, 22 May 2019 14:20:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GaZGSuXpoCne; Wed, 22 May 2019 14:20:48 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AAB18B83A;
 Wed, 22 May 2019 14:20:48 +0200 (CEST)
Subject: Re: Failure to boot G4: dt_headr_start=0x01501000
To: Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CA+7wUszwugJeS_x_ExaHPUb8p23D7Zo2f2qqXfLQwr8EiLsk2g@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <33ab57c7-294a-6ae4-d678-1490ce5b97f1@c-s.fr>
Date: Wed, 22 May 2019 14:20:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+7wUszwugJeS_x_ExaHPUb8p23D7Zo2f2qqXfLQwr8EiLsk2g@mail.gmail.com>
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



Le 22/05/2019 à 14:15, Mathieu Malaterre a écrit :
> Hi all,
> 
> I have not boot my G4 in a while, today using master here is what I see:
> 
> done
> Setting btext !
> W=640 H=488 LB=768 addr=0x9c008000
> copying OF device tree...
> starting device tree allocs at 01401000
> otloc_up(00100000, 0013d948)
>    trying: 0x01401000
>    trying: 0x01501000
>   -› 01501000
>    alloc_bottom : 01601000
>    alloc_top    : 20000000
>    alloc_top_hi : 20000000
>    nmo_top      : 20000000
>    ram_top      : 20000000
> Building dt strings...
> Building dt structure...
> reserved memory map:
>    00d40000 - 006c1000
> Device tree strings 0x01502000 -> 0x00000007
> Device tree struct 0x01503000 -> 0x00000007
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x001400000
> ->dt_headr_start=0x01501000
> 
> Any suggestions before I start a bisect ?
> 

Have you tried without CONFIG_PPC_KUEP and CONFIG_PPC_KUAP ?

Christophe
