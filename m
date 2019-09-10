Return-Path: <SRS0=Blre=XF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1211BC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 10:36:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8804E20872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 10:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gK+teGnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8804E20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46SLzT4zKMzDsFV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 20:36:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="gK+teGnp"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46SLsK38NgzDr7P
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2019 20:30:45 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46SLsB5w8Gz9txVK;
 Tue, 10 Sep 2019 12:30:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=gK+teGnp; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id XYbDMiw_bo64; Tue, 10 Sep 2019 12:30:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46SLsB4t61z9txV9;
 Tue, 10 Sep 2019 12:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1568111438; bh=1PgGlSprSeIbOT0wT6D/m7gTOTRW3sm+0mnAEbklP5I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gK+teGnpkbI6Ao/NmOh9iviJwDxU/R959RzQY8ZUTOTzhSOFf13ZoZZRCUsQwN4qz
 t211I/yxfd04MUXE01+JzkP+4SAZMg8I+KPyi0t/O9ywRYomShl+tBMDRuZ88KgWsO
 ZPizeELopxXtISKyT7vhn1vWyhWEyjFjz+vCadXQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E15D08B86F;
 Tue, 10 Sep 2019 12:30:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5I4nzrWAZ74q; Tue, 10 Sep 2019 12:30:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57FCE8B874;
 Tue, 10 Sep 2019 12:30:39 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc/watchpoint: Disable watchpoint hit by
 larx/stcx instruction
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
 mikey@neuling.org
References: <20190910102422.23233-1-ravi.bangoria@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <34c222f3-e185-f859-f9d5-7447886fd1a8@c-s.fr>
Date: Tue, 10 Sep 2019 12:30:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910102422.23233-1-ravi.bangoria@linux.ibm.com>
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
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/09/2019 à 12:24, Ravi Bangoria a écrit :
> I've prepared my patch on top of Christophe's patch as it's easy
> to change stepping_handler() rather than hw_breakpoint_handler().
> 2nd patch is the actual fix.

Anyway, my patch is already commited on powerpc/next

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190904&id=658d029df0bce6472c94b724ca54d74bc6659c2e

Christophe

> 
> Christophe Leroy (1):
>    powerpc/hw_breakpoint: move instruction stepping out of
>      hw_breakpoint_handler()
> 
> Ravi Bangoria (1):
>    powerpc/watchpoint: Disable watchpoint hit by larx/stcx instructions
> 
>   arch/powerpc/kernel/hw_breakpoint.c | 77 +++++++++++++++++++----------
>   1 file changed, 50 insertions(+), 27 deletions(-)
> 
