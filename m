Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA46AC3F2CD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 14:46:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CF620714
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="lpmaeeRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CF620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mHJ05fJPzDqfy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 01:46:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mHFF4gPRzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 01:43:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=lpmaeeRJ; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 48mHFF3Ygqz8t5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 01:43:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 48mHFF33zbz9sPk; Tue, 24 Mar 2020 01:43:45 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=lpmaeeRJ; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48mHFF0C30z9sNg
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2020 01:43:45 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48mHF46mwVz9tygX;
 Mon, 23 Mar 2020 15:43:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=lpmaeeRJ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 5OS2piXT3d5I; Mon, 23 Mar 2020 15:43:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48mHF44dCNz9twsk;
 Mon, 23 Mar 2020 15:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1584974616; bh=4KbpIn5gE8GlCBG/NPc2kd7yMbB4nom8AvGf03RFoO8=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=lpmaeeRJqvFBJvrZn45YPb+KXENSd7tLL0ftf4hF4NiJiCDjq2fz4TsKBM0DxWQO8
 DlKRuP3oD1zsFCTpQj0+YIJBe6nHJLllgC3gThATtEyaoLfJsiLDdzArrQ/s7+vCLD
 Ws3mwPzwugwEgl+hBj+GD6cit4WSLmBzqEhP3dys=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A73CC8B752;
 Mon, 23 Mar 2020 15:43:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zjAa6V2dbqDe; Mon, 23 Mar 2020 15:43:41 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 66CE88B779;
 Mon, 23 Mar 2020 15:43:41 +0100 (CET)
Subject: Re: hardcoded SIGSEGV in __die() ?
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
References: <73da05c0f54692a36471a2539dbd9b30594b687a.camel@infinera.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b20d978b-268b-773a-a43e-7ff4c741f2df@c-s.fr>
Date: Mon, 23 Mar 2020 15:43:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <73da05c0f54692a36471a2539dbd9b30594b687a.camel@infinera.com>
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



Le 23/03/2020 à 15:17, Joakim Tjernlund a écrit :
> In __die(), see below, there is this call to notify_send() with SIGSEGV hardcoded, this seems odd
> to me as the variable "err" holds the true signal(in my case SIGBUS)
> Should not SIGSEGV be replaced with the true signal no.?

As far as I can see, comes from 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66fcb1059

Christophe
