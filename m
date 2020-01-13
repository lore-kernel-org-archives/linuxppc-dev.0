Return-Path: <SRS0=2lRn=3C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E007EC33CAD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 12:08:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A082084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 12:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RYPWm/IX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A082084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xC5l3QSTzDqKM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 23:07:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=RYPWm/IX; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xC1j51xkzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2020 23:04:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 47xC1R5FbGz9txxD;
 Mon, 13 Jan 2020 13:04:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=RYPWm/IX; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Hval_bWc400h; Mon, 13 Jan 2020 13:04:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47xC1R4CpHz9txxC;
 Mon, 13 Jan 2020 13:04:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1578917051; bh=MvSTc3YCiZWGwG0qnYB8ibq5lqkALByXbfzJloZm6VI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RYPWm/IXQ/KxMHRniZs4sJA0UPIhBFyVBryEW3BKqF+e4rY1+/0Wr9KTb1Oy2Acmm
 QrU95xCviWgxho42vEOCHJ/Ec2LbEtDqIZJ4fGcLpTEgDDzqFJ3q5Tte95EDnP9ZWN
 /49rH0RisWsJHOGyX6JNukoKDcuHt44/tBSegBbY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 82B088B7B7;
 Mon, 13 Jan 2020 13:04:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5C6xgoSYmG2P; Mon, 13 Jan 2020 13:04:16 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 47C788B79F;
 Mon, 13 Jan 2020 13:04:16 +0100 (CET)
Subject: Re: [PATCH] lib: vdso: mark __cvdso_clock_getres() as static
To: Thomas Gleixner <tglx@linutronix.de>, arnd@arndb.de,
 vincenzo.frascino@arm.com, luto@kernel.org
References: <e7becc50bee355e3872b84d91cc68ae8d7776bb9.1578764712.git.christophe.leroy@c-s.fr>
 <875zhhsr0h.fsf@nanos.tec.linutronix.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <658045cd-3f97-946d-6920-bea772e9be24@c-s.fr>
Date: Mon, 13 Jan 2020 13:04:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <875zhhsr0h.fsf@nanos.tec.linutronix.de>
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/01/2020 à 20:59, Thomas Gleixner a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> When __cvdso_clock_getres() became __cvdso_clock_getres_common()
>> and a new __cvdso_clock_getres() was added, static qualifier was
>> forgotten.
>>
>> Fixes: 502a590a170b ("lib/vdso: Move fallback invocation to the callers")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> I've already queued:
> 
>       https://lore.kernel.org/r/20191128111719.8282-1-vincenzo.frascino@arm.com
> 
> but thanks for caring!
> 


Is there a git tree with the latest VDSO status ?

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git?h=timers%2Fvdso 
is 6 monthes old.

Christophe
