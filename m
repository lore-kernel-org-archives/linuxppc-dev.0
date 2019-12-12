Return-Path: <SRS0=eY2C=2C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA0AC00454
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B558205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EfCot0cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B558205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47YdjJ74MbzDqy1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 02:57:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="EfCot0cP"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Ydfy5sq2zDqy1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 02:55:19 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47Ydfl2H6MzB09ZV;
 Thu, 12 Dec 2019 16:55:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=EfCot0cP; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id D9rWWWTshkIZ; Thu, 12 Dec 2019 16:55:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47Ydfl1CmQzB09ZT;
 Thu, 12 Dec 2019 16:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1576166111; bh=PJztFoqZeZST1HMzqILi2xyKFqgX3RxPFx1/4+TG/tk=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=EfCot0cPMLRcALyzGy3x1WzkPa0APIh0auRG5pNwxZo4b8aMF1/1AuW51bYPESZ9Y
 ziBgDeI5oE/4VJLWfQJzArHXiDhT/RM2jU9+Mlon2y9KpuYpFaPvE9JRTUFmP0hPUw
 SWOnTZe7prONi+zR7dyM5qmsxnh/nNhDVTJJhZm4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B10348B872;
 Thu, 12 Dec 2019 16:55:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9AsI8caOxSn5; Thu, 12 Dec 2019 16:55:12 +0100 (CET)
Received: from [172.25.230.112] (po15451.idsi0.si.c-s.fr [172.25.230.112])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 935D68B860;
 Thu, 12 Dec 2019 16:55:12 +0100 (CET)
Subject: Re: [PATCH v3 1/3] kasan: define and use MAX_PTRS_PER_* for early
 shadow tables
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
References: <20191212151656.26151-1-dja@axtens.net>
 <20191212151656.26151-2-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <65a52c58-4409-de89-6f5d-8797d0ebca74@c-s.fr>
Date: Thu, 12 Dec 2019 16:55:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191212151656.26151-2-dja@axtens.net>
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



Le 12/12/2019 à 16:16, Daniel Axtens a écrit :
> powerpc has a variable number of PTRS_PER_*, set at runtime based
> on the MMU that the kernel is booted under.
> 
> This means the PTRS_PER_* are no longer constants, and therefore
> breaks the build.
> 
> Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
> As KASAN is the only user at the moment, just define them in the kasan
> header, and have them default to PTRS_PER_* unless overridden in arch
> code.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Suggested-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   include/linux/kasan.h | 18 +++++++++++++++---
>   mm/kasan/init.c       |  6 +++---
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 

Christophe
