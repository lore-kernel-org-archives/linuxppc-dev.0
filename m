Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B36C54EEB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218AD20753
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OafFvJo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218AD20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mHLw67X9zDrB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 01:48:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mHH334KhzDqjT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 01:45:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=OafFvJo1; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 48mHH269c4z9Bry
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 01:45:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 48mHH23jVrz9sQt; Tue, 24 Mar 2020 01:45:18 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=OafFvJo1; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48mHH16Cjrz9sPk
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2020 01:45:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48mHGs5nxSz9vBTG;
 Mon, 23 Mar 2020 15:45:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=OafFvJo1; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1sQPCeOFk3pi; Mon, 23 Mar 2020 15:45:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48mHGs4hWFz9vBTD;
 Mon, 23 Mar 2020 15:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1584974709; bh=BRedvy12qLbyAM5l9rtPvWiDZLHEyMCdW7M8JSh8nBg=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=OafFvJo1Eu0hwiEL4Qvpn9hV2ZHh5rj6RnaKUvr+uZHSmIJYxlGhA4R3vI2d5SWgj
 J69w0zgWChdWFXWNg0CRiG/y1uHVIUG3U21Zp0IkdAQsu0/wJyMU1PI6yFggbzRJbL
 bwjCJC6Zu/ZwWFCHWtbmiLz85KcqLc7XPGchl7ho=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C72438B779;
 Mon, 23 Mar 2020 15:45:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id x9n7Q2de_hQ7; Mon, 23 Mar 2020 15:45:14 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 85D298B76E;
 Mon, 23 Mar 2020 15:45:14 +0100 (CET)
Subject: Re: hardcoded SIGSEGV in __die() ?
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
References: <73da05c0f54692a36471a2539dbd9b30594b687a.camel@infinera.com>
 <b20d978b-268b-773a-a43e-7ff4c741f2df@c-s.fr>
Message-ID: <c14de482-6784-f1ac-f675-d771e55ac688@c-s.fr>
Date: Mon, 23 Mar 2020 15:45:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b20d978b-268b-773a-a43e-7ff4c741f2df@c-s.fr>
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



Le 23/03/2020 à 15:43, Christophe Leroy a écrit :
> 
> 
> Le 23/03/2020 à 15:17, Joakim Tjernlund a écrit :
>> In __die(), see below, there is this call to notify_send() with 
>> SIGSEGV hardcoded, this seems odd
>> to me as the variable "err" holds the true signal(in my case SIGBUS)
>> Should not SIGSEGV be replaced with the true signal no.?
> 
> As far as I can see, comes from 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66fcb1059 
> 

And 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ae87221d3ce49d9de1e43756da834fd0bf05a2ad 
shows it is (was?) similar on x86.

Christophe
