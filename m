Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34097C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:16:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8E920842
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8E920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zM8j2z4qzDqPw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 23:16:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=virtuozzo.com
 (client-ip=185.231.240.75; helo=relay.sw.ru;
 envelope-from=aryabinin@virtuozzo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=virtuozzo.com
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zM5t0z3mzDqM5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:14:24 +1100 (AEDT)
Received: from [172.16.25.12] by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <aryabinin@virtuozzo.com>)
 id 1gtWx9-000831-M1; Tue, 12 Feb 2019 15:14:19 +0300
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
To: Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Axtens
 <dja@axtens.net>, Andrey Konovalov <andreyknvl@google.com>
References: <cover.1548166824.git.christophe.leroy@c-s.fr>
 <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
 <87ef8i45km.fsf@dja-thinkpad.axtens.net>
 <69720148-fd19-0810-5a1d-96c45e2ec00c@c-s.fr>
 <CAAeHK+wcUwLiSQffUkcyiH2fuox=VihJadEqQqRG1YfU3Y2gDA@mail.gmail.com>
 <f8b9e9ec-991b-6824-46c2-f7fc0aaa7fb8@c-s.fr>
 <CAAeHK+zop5ajOJQ4KEYbuxMRegk2GM1LvuGcSbCU1O5EZxB0MA@mail.gmail.com>
 <805fbf9d-a10f-03e0-aa52-6f6bd16059b9@virtuozzo.com>
 <87imxpak4r.fsf@linkitivity.dja.id.au>
 <a11adaf3-beda-ed0c-e6aa-9ef30f2e80cf@c-s.fr>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c5599614-128b-69a8-2526-72b135070e8d@virtuozzo.com>
Date: Tue, 12 Feb 2019 15:14:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a11adaf3-beda-ed0c-e6aa-9ef30f2e80cf@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kasan-dev <kasan-dev@googlegroups.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/12/19 2:38 PM, Christophe Leroy wrote:
> 
> 
> Le 12/02/2019 à 02:08, Daniel Axtens a écrit :
>> Andrey Ryabinin <aryabinin@virtuozzo.com> writes:
>>
>>>
>>> Christophe, you can specify KASAN_SHADOW_OFFSET either in Kconfig (e.g. x86_64) or
>>> in Makefile (e.g. arm64). And make early mapping writable, because compiler generated code will write
>>> to shadow memory in function prologue/epilogue.
>>
>> Hmm. Is this limitation just that compilers have not implemented
>> out-of-line support for stack instrumentation, or is there a deeper
>> reason that stack/global instrumentation relies upon inline
>> instrumentation?
> 
> No, it looks like as soon as we define KASAN_SHADOW_OFFSET in Makefile in addition to asm/kasan.h, stack instrumentation works with out-of-line.
> 


I think you confusing two different things.
CONFIG_KASAN_INLINE/CONFIG_KASAN_OUTLINE affects only generation of code that checks memory accesses,
whether we call __asan_loadx()/__asan_storex() or directly insert code, checking shadow memory. 

But with stack instrumentation we also need to poison redzones around stack variables and unpoison them
when we leave the function. That poisoning/unpoisoning thing is always inlined. Currently there is no option to make it out-of-line.

So you can have stack instrumentation with KASAN_OUTLINE, but it just means that checking shadow memory on memory access will be outlined,
poisoning/unpoisoing stack redzones will remain inlined.

