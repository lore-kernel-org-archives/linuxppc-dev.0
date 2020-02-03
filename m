Return-Path: <SRS0=3qbC=3X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9740C33C9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Feb 2020 06:24:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B362082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Feb 2020 06:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="c+N5WD5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B362082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 489yTg2lSjzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Feb 2020 17:24:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=c+N5WD5u; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 489yQx13l7zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2020 17:21:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 489yQj2rXnz9tyLV;
 Mon,  3 Feb 2020 07:21:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=c+N5WD5u; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ayGeSZEJV-oc; Mon,  3 Feb 2020 07:21:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 489yQj1f7zz9tyLS;
 Mon,  3 Feb 2020 07:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1580710909; bh=Pm0B52FMhsUo/jdHehxS7pp30HptLqSpCFXodWa+iA8=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=c+N5WD5uZRqAwGsgodR+8AuyrP9vhuHVYr2LP+ak9xw76YkmNiLVxv4ko5sY6bl+P
 eVpatdsrwn4WpogEOP8xaIvKqGwD68mrxs/b7BZZuJHd7BVOOh9OB8N3gPjCkqkUZx
 JgkoRstkw6gY7SsIC00XXxxVnwNWgxdAg35M6w9Q=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CB4F8B791;
 Mon,  3 Feb 2020 07:21:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id y50o24pPqJ9U; Mon,  3 Feb 2020 07:21:53 +0100 (CET)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B7868B752;
 Mon,  3 Feb 2020 07:21:53 +0100 (CET)
Subject: Re: [linuxppc-dev] Patch notification: 1 patch updated
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20200203010001.21489.11114@bilbo.ozlabs.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <68a42fb3-1abc-d2f1-73eb-562f0dfe723f@c-s.fr>
Date: Mon, 3 Feb 2020 07:21:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203010001.21489.11114@bilbo.ozlabs.org>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 03/02/2020 à 02:00, Patchwork a écrit :
> Hello,
> 
> The following patch (submitted by you) has been updated in Patchwork:
> 
>   * linuxppc-dev: powerpc/nohash: Don't flush all TLBs when flushing one page
>       - http://patchwork.ozlabs.org/patch/1231983/
>       - for: Linux PPC development
>      was: New
>      now: Superseded

Superseded ? By what ?

I sent a v2 for book3s/32, but this one is for nohash.

Christophe
