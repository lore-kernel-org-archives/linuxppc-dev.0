Return-Path: <SRS0=SmZj=WM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51895C3A59C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 15:59:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C656E2133F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 15:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="i4vYuRvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C656E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4697LT3RSZzDrWy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Aug 2019 01:59:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="i4vYuRvh"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4697Hv49cBzDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2019 01:57:31 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4697Hp4Hxsz9txKQ;
 Fri, 16 Aug 2019 17:57:26 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=i4vYuRvh; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1aF1Nh7DXJ84; Fri, 16 Aug 2019 17:57:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4697Hp2l79z9txKK;
 Fri, 16 Aug 2019 17:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1565971046; bh=C4MwGsOSBiPFS6TjAAwjC7UyECCJUqF4L3EYFExWE6g=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=i4vYuRvhymXPG9MijpoZTzbl3VlYeqk7V/a0yOBe12Jva853qoPakRiEwUrvyeC/A
 6nyVxZtmtd1ku1mggUAr2hO/7FXDa7isaJ6wjkcNS5dRILplYj85HOepJm3k2Ar9hT
 yJ4nQeoKVPxCwSKUQRuaer5JBZ64sfOaZhXm3ngQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 284138B78F;
 Fri, 16 Aug 2019 17:57:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hMT4k5X4x1Nw; Fri, 16 Aug 2019 17:57:28 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EB96D8B754;
 Fri, 16 Aug 2019 17:57:27 +0200 (CEST)
Subject: Re: [PATCH 3/6] powerpc: Convert flush_icache_range & friends to C
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190815041057.13627-1-alastair@au1.ibm.com>
 <20190815041057.13627-4-alastair@au1.ibm.com>
 <8a86bccf-ae4d-6d2c-72b1-db136cec9d10@c-s.fr>
Message-ID: <b6c76696-8b00-b35b-934a-5e6eb2e997c3@c-s.fr>
Date: Fri, 16 Aug 2019 17:57:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8a86bccf-ae4d-6d2c-72b1-db136cec9d10@c-s.fr>
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
Cc: Michal Hocko <mhocko@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Qian Cai <cai@lca.pw>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/08/2019 à 09:29, christophe leroy a écrit :
> 
> 
> Le 15/08/2019 à 06:10, Alastair D'Silva a écrit :
>> From: Alastair D'Silva <alastair@d-silva.org>
>>
>> Similar to commit 22e9c88d486a
>> ("powerpc/64: reuse PPC32 static inline flush_dcache_range()")
>> this patch converts flush_icache_range() to C, and reimplements the
>> following functions as wrappers around it:
>> __flush_dcache_icache
>> __flush_dcache_icache_phys
> 
> Not sure you can do that for __flush_dcache_icache_phys(), see detailed 
> comments below
> 

I just sent you an RFC patch that could be the way to convert 
__flush_dcache_icache_phys() to C.

Feel free to modify it as wished and include it in your series.

Christophe
