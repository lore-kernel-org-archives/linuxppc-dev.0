Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D48C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 05:54:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9293261248
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 05:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9293261248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtyxY183tz2yp1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 15:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gtyx137Tbz2xrl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 15:54:25 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gtywt4Rsgz9sTs;
 Tue, 24 Aug 2021 07:54:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id suucyjXRqs1c; Tue, 24 Aug 2021 07:54:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gtywt3BDnz9sTp;
 Tue, 24 Aug 2021 07:54:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BBBE8B7D2;
 Tue, 24 Aug 2021 07:54:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id DgcerSLVu5AC; Tue, 24 Aug 2021 07:54:22 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DA5178B7D1;
 Tue, 24 Aug 2021 07:54:21 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non
 volatile regs
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
 <20210823184648.GY1583@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9bbc9797-cfc7-1484-90ad-2146ff1a5e18@csgroup.eu>
Date: Tue, 24 Aug 2021 07:54:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823184648.GY1583@gate.crashing.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 23/08/2021 à 20:46, Segher Boessenkool a écrit :
> On Mon, Aug 23, 2021 at 03:29:12PM +0000, Christophe Leroy wrote:
>> Instructions lmw/stmw are interesting for functions that are rarely
>> used and not in the cache, because only one instruction is to be
>> copied into the instruction cache instead of 19. However those
>> instruction are less performant than 19x raw lwz/stw as they require
>> synchronisation plus one additional cycle.
> 
> lmw takes N+2 cycles for loading N words on 603/604/750/7400, and N+3 on
> 7450.  stmw takes N+1 cycles for storing N words on 603, N+2 on 604/750/
> 7400, and N+3 on 7450 (load latency is 3 instead of 2 on 7450).
> 
> There is no synchronisation needed, although there is some serialisation,
> which of course doesn't mean much since there can be only 6 or 8 or so
> insns executing at once anyway.

Yes I meant serialisation, isn't it the same as synchronisation ?

> 
> So, these insns are almost never slower, they can easily win cycles back
> because of the smaller code, too.
> 
> What 32-bit core do you see where load/store multiple are more than a
> fraction of a cycle (per memory access) slower?
> 
>> SAVE_NVGPRS / REST_NVGPRS are used in only a few places which are
>> mostly in interrupts entries/exits and in task switch so they are
>> likely already in the cache.
> 
> Nothing is likely in the cache on the older cores (except in
> microbenchmarks), the caches are not big enough for that!

Even syscall entries/exit pathes and/or most frequent interrupts entries and interrupt exit ?


> 
>> Using standard lwz improves null_syscall selftest by:
>> - 10 cycles on mpc832x.
>> - 2 cycles on mpc8xx.
> 
> And in real benchmarks?

Don't know, what benchmark should I use to evaluate syscall entry/exit if 'null_syscall' selftest is 
not relevant ?

> 
> On mpccore both lmw and stmw are only N+1 btw.  But the serialization
> might cost another cycle here?
> 

That coherent on MPC8xx, that's only 2 cycles.
But on the mpc832x which has a e300c2 core, it looks like I have 10 cycles difference. Is anything 
wrong ?

Christophe
