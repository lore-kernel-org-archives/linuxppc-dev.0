Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5E3C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 06:21:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C267C2173C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 06:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="amdKcfyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C267C2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VFBW3s5yzDqR5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 17:21:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="amdKcfyn"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VF8h0FqBzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 17:20:02 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44VF8Y1MCFz9v163;
 Thu, 28 Mar 2019 07:19:57 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=amdKcfyn; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4TzLt52_E3o7; Thu, 28 Mar 2019 07:19:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44VF8X72GBz9v160;
 Thu, 28 Mar 2019 07:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553753997; bh=l7YbsCji1aMTrkRsMFe2dFCB4dIikgmReMCHtlbUFRQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=amdKcfynGB/34aFXhb0qdRLJ5OAH1BK1ZpozjLK0i5R2EA0vB23zSLHrvav+aE1TP
 crlhQWjbBIYYbaE9nzooJFy0p9hmH8rDSrIlYl5oej/4c2/hAumOn+WY3FAV8DFnW5
 y8O3qf5UuUHS6KIq3YYCNP/4CqikU35UCa+rvyL4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CBA508B851;
 Thu, 28 Mar 2019 07:19:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5QHjbgult4T5; Thu, 28 Mar 2019 07:19:57 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8644E8B75A;
 Thu, 28 Mar 2019 07:19:57 +0100 (CET)
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
 <d340ae4b-a009-0ef3-9621-da3e0a7684f5@c-s.fr>
 <20190326181914.GS3969@gate.crashing.org>
 <5f4aa4b2-1c44-70b9-c383-5d40aecd695c@c-s.fr>
 <20190326201231.GV3969@gate.crashing.org>
 <20190326222941.GW3969@gate.crashing.org>
 <8aa0290a-908c-38d8-e040-c8c0cc226eb9@c-s.fr>
 <20190327124754.GY3969@gate.crashing.org>
 <20190327182128.GA3969@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4ceb12ff-b114-6edd-e9c2-a6cd922720a2@c-s.fr>
Date: Thu, 28 Mar 2019 07:19:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327182128.GA3969@gate.crashing.org>
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



Le 27/03/2019 à 19:21, Segher Boessenkool a écrit :
> On Wed, Mar 27, 2019 at 07:47:55AM -0500, Segher Boessenkool wrote:
>> On Wed, Mar 27, 2019 at 07:40:32AM +0100, Christophe Leroy wrote:
>>> Le 26/03/2019 à 23:29, Segher Boessenkool a écrit :
>>>> I tried to reproduce this.  It does not fail with a ppc6xx_defconfig
>>>> build, and mpc885_ads_defconfig fails with
>>>
>>> So far, the only defconfig which fails for me is ppc64_defconfig, like
>>> Michael.
>>
>> Oh, I misunderstood then.  Let me try that :-)
> 
> Yeah, okay, we should have some PHDRS statement here still.  You can drop
> the dummy segment, and the notes segment as well, or you can keep the notes
> section in both the notes and kernel segments.

Is the note segment useful at all ? I guess if we decide to keep it, we 
should have a reason.

> 
> (You patch doesn't apply btw, whitespace damage I think; will you send a
> new one?)

Originally the patch is by Joel Stanley <joel@jms.id.au>

I guess he will send a v2 taking into account the discussion ?

Or maybe you can send it yourself as you are probably the best person to 
explain in details the change in the commit message.

Christophe
