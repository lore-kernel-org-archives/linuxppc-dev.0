Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A192C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:27:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5B320651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gByyt/X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5B320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fHMj5qLpzDqZj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 04:27:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="unknown key hash" (0-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="gByyt/X9"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fHKx0JLGzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 04:25:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fHKp6Q7fz9vBJc;
 Tue, 15 Jan 2019 18:25:34 +0100 (CET)
Authentication-Results: localhost; dkim=permerror reason="key not found"
 header.d=c-s.fr header.i=@c-s.fr header.b=gByyt/X9;
 dkim-adsp=none (insecure policy); dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Lf7f_X3vnQ4Y; Tue, 15 Jan 2019 18:25:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fHKp58mcz9vBJY;
 Tue, 15 Jan 2019 18:25:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547573134; bh=nfiqene5M3o5kAGA4cFhUacIFPIGZMQYcHqzH6hGjNc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gByyt/X9hT/1zq0OG6PlK51/hNVU37xWuECwM4TeCx9xzapEuwjeNIQQt+44LpPVI
 GPQCzr25yGAZrAYdGATnFGkMH+De6KKTgXyxHHtPY/IM3+wZfsrJ1KyPmYPtItJIXT
 f2eh28nIAavAM0oJBLzprzk537I97GPpAynb7djXxsCE5sCYXS5NGivFQ8B8J8s1a4
 Uz7xlYyFXZxJGIBdlsetKewbArORfGGN6uWVHShkMsbo25geYGrhH1Ai0Uo7oZxYCy
 yJOF23I25T/AYNkvyzwOfV6pKpK04Sc2YeGRy9aak14ip49YqhvW9n531hafkubKwQ
 haLmeX+VW4K7P3Y0kPPihVVsCoqq5nOt9apMPYdMrPYiIZIXUUztsNWvp215CQHQJL
 BHNU06BH9enFTGmo1OfkQas1xZlQZBh+QHMTkOzzTHdGtXM0SJ9ZkkNS5k4ed0A3kQ
 C9DIKGGtPTtpdBjCz9BqhFZUB021FCYxCGhoCLMycy14x4N9V0JRa2xYNDNRusoLPc
 6J/QZi+XnYDnwcCGNW+iqTURwzn+UkQfcd9K/9nBNbPRQrt+PBxoKbONieBwlpa+fA
 wL+5wfG3g7vIE4rq9ewA1gcfQzuOBzMy/Rya4DVV5yqGoLlge2ozTiQBbZeuRPgNb8
 44MeCtd1qJ/r9+Tk7/Q0L7q0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E11108B7FF;
 Tue, 15 Jan 2019 18:25:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id djneeju_xvcU; Tue, 15 Jan 2019 18:25:36 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2C888B7EE;
 Tue, 15 Jan 2019 18:25:35 +0100 (CET)
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
 <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
 <801c7d58-417d-1e65-68a0-b8cf02f9f956@c-s.fr>
 <CACT4Y+ZdA-w5OeebZg3PYPB+BX5wDxw_DxNe2==VJfbpy2eJ7A@mail.gmail.com>
 <330696c0-90c6-27de-5eb3-4da2159fdfbc@virtuozzo.com>
 <CACT4Y+ajgTdDyFFWCp0oRSPKZh9ercDpq3pAq2-ZSx7ouAvZYQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <301f5826-64ab-1cf4-7e7e-cd026de77bca@c-s.fr>
Date: Tue, 15 Jan 2019 18:25:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ajgTdDyFFWCp0oRSPKZh9ercDpq3pAq2-ZSx7ouAvZYQ@mail.gmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kasan-dev <kasan-dev@googlegroups.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/01/2019 à 18:10, Dmitry Vyukov a écrit :
> On Tue, Jan 15, 2019 at 6:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>>
>>
>> On 1/15/19 2:14 PM, Dmitry Vyukov wrote:
>>> On Tue, Jan 15, 2019 at 8:27 AM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>> On 01/14/2019 09:34 AM, Dmitry Vyukov wrote:
>>>>> On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
>>>>> <christophe.leroy@c-s.fr> wrote:
>>>>> &gt;
>>>>> &gt; In kernel/cputable.c, explicitly use memcpy() in order
>>>>> &gt; to allow GCC to replace it with __memcpy() when KASAN is
>>>>> &gt; selected.
>>>>> &gt;
>>>>> &gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
>>>>> &gt; enabled"), memset() can be used before activation of the cache,
>>>>> &gt; so no need to use memset_io() for zeroing the BSS.
>>>>> &gt;
>>>>> &gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> &gt; ---
>>>>> &gt;  arch/powerpc/kernel/cputable.c | 4 ++--
>>>>> &gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
>>>>> &gt;  2 files changed, 4 insertions(+), 6 deletions(-)
>>>>> &gt;
>>>>> &gt; diff --git a/arch/powerpc/kernel/cputable.c
>>>>> b/arch/powerpc/kernel/cputable.c
>>>>> &gt; index 1eab54bc6ee9..84814c8d1bcb 100644
>>>>> &gt; --- a/arch/powerpc/kernel/cputable.c
>>>>> &gt; +++ b/arch/powerpc/kernel/cputable.c
>>>>> &gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>>>>> &gt;         struct cpu_spec *t = &amp;the_cpu_spec;
>>>>> &gt;
>>>>> &gt;         t = PTRRELOC(t);
>>>>> &gt; -       *t = *s;
>>>>> &gt; +       memcpy(t, s, sizeof(*t));
>>>>>
>>>>> Hi Christophe,
>>>>>
>>>>> I understand why you are doing this, but this looks a bit fragile and
>>>>> non-scalable. This may not work with the next version of compiler,
>>>>> just different than yours version of compiler, clang, etc.
>>>>
>>>> My felling would be that this change makes it more solid.
>>>>
>>>> My understanding is that when you do *t = *s, the compiler can use
>>>> whatever way it wants to do the copy.
>>>> When you do memcpy(), you ensure it will do it that way and not another
>>>> way, don't you ?
>>>
>>> It makes this single line more deterministic wrt code-gen (though,
>>> strictly saying compiler can turn memcpy back into inlines
>>> instructions, it knows memcpy semantics anyway).
>>> But the problem I meant is that the set of places that are subject to
>>> this problem is not deterministic. So if we go with this solution,
>>> after this change it's in the status "works on your machine" and we
>>> either need to commit to not using struct copies and zeroing
>>> throughout kernel code or potentially have a long tail of other
>>> similar cases, and since they can be triggered by another compiler
>>> version, we may need to backport these changes to previous releases
>>> too. Whereas if we would go with compiler flags, it would prevent the
>>> problem in all current and future places and with other past/future
>>> versions of compilers.
>>>
>>
>> The patch will work for any compiler. The point of this patch is to make
>> memcpy() visible to the preprocessor which will replace it with __memcpy().
> 
> For this single line, yes. But it does not mean that KASAN will work.
> 
>> After preprocessor's work, compiler will see just __memcpy() call here.

This problem can affect any arch I believe. Maybe the 'solution' would 
be to run a generic script similar to 
arch/powerpc/kernel/prom_init_check.sh on all objects compiled with 
KASAN_SANITIZE_object.o := n don't include any reference to memcpy() 
memset() or memmove() ?

Christophe
