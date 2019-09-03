Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74395C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 23:44:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E0621883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 23:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AIRHruYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E0621883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NNnp5sJgzDqng
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 09:43:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="AIRHruYm"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NNlj5XQQzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 09:42:09 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id b13so5292311pfo.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2019 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=d3Uvki+kfJgt1m0UONqlkiavQ6oLL7OnGA9HqPCX/bA=;
 b=AIRHruYm217BkNNbELn4rzWRu2lVdGvFiEuUy9/LBzLsYWn7tEdN22R8Y7Ix3jRzU8
 vi11fisWq8csSt4oXJS1lipZtvV1zI0lONGn1udWn9lzDMaQDTMGUVK4vRHDPXY3cGe+
 f5BwJ5lmavFRl45vKN4vFDlQq5lLGETQewU3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=d3Uvki+kfJgt1m0UONqlkiavQ6oLL7OnGA9HqPCX/bA=;
 b=QlX60FVv1aDHytIIPUtBcSnGbMwEjF/g688d8RComiwLa/13gnlTxTOUvaZHmjpzw0
 szUPndgGAYL22WGi2teM9NiqbHDylS1u84jkKyuT1x2/54AC9pxS99Ao9DsI+8TFjAeY
 3e9m+B4gMc3kKIHAry+Dc7Rw5wlpKxw8oNJwlkUK6+9ax/GkgTDLkymJkxH9w1395Q9D
 0EfMzh3us8RZzdGyKknydSob6momG8TJVT4Q74MW54WEglMXbVBp7fLL+zfjSTm0mqJK
 w1L9f2XHZMgf6BPAnmD0CLbcW8zrPVamo451bQ/vjTCJwXRAhuMAo5agdwqfSCJm8DaP
 713g==
X-Gm-Message-State: APjAAAXsh9wH+2GRlS1SsyThbXDP6HPTbIcFeM7T6Ag+JguawALx6a5i
 8J3P2hYDoaLQdpVp66wRA/cobQ==
X-Google-Smtp-Source: APXvYqxeNo3PMrJsRo3FgG7XCb00MrhJflwc1xD555RVHRItPittdp6EdRFQwCHwDzhPeLggQRWf8A==
X-Received: by 2002:a17:90a:cb89:: with SMTP id
 a9mr1908300pju.93.1567554126677; 
 Tue, 03 Sep 2019 16:42:06 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net.
 [59.167.251.205])
 by smtp.gmail.com with ESMTPSA id m24sm6976787pfa.37.2019.09.03.16.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 16:42:05 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v7 5/5] kasan debug: track pages allocated for vmalloc
 shadow
In-Reply-To: <CAAeHK+w_HKVh___E0j3hctt_efSPR3PwKuO5XNpf=w5obfYSSA@mail.gmail.com>
References: <20190903145536.3390-1-dja@axtens.net>
 <20190903145536.3390-6-dja@axtens.net>
 <CAAeHK+w_HKVh___E0j3hctt_efSPR3PwKuO5XNpf=w5obfYSSA@mail.gmail.com>
Date: Wed, 04 Sep 2019 09:41:51 +1000
Message-ID: <87ef0xt0ao.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Mark Rutland <mark.rutland@arm.com>, gor@linux.ibm.com,
 the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrey Konovalov <andreyknvl@google.com> writes:

> On Tue, Sep 3, 2019 at 4:56 PM Daniel Axtens <dja@axtens.net> wrote:
>>
>> Provide the current number of vmalloc shadow pages in
>> /sys/kernel/debug/kasan_vmalloc/shadow_pages.
>
> Maybe it makes sense to put this into /sys/kernel/debug/kasan/
> (without _vmalloc) and name e.g. vmalloc_shadow_pages? In case we want
> to expose more generic KASAN debugging info later.

We certainly could. I just wonder if this patch is useful on an ongoing
basis. I wrote it to validate my work on lazy freeing of shadow pages -
which is why I included it - but I'm not sure it has much ongoing value
beyond demonstrating that the freeing code works.

If we think it's worth holding on to this patch, I can certainly adjust
the paths.

Regards,
Daniel

>
>>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>>
>> ---
>>
>> Merging this is probably overkill, but I leave it to the discretion
>> of the broader community.
>>
>> On v4 (no dynamic freeing), I saw the following approximate figures
>> on my test VM:
>>
>>  - fresh boot: 720
>>  - after test_vmalloc: ~14000
>>
>> With v5 (lazy dynamic freeing):
>>
>>  - boot: ~490-500
>>  - running modprobe test_vmalloc pushes the figures up to sometimes
>>     as high as ~14000, but they drop down to ~560 after the test ends.
>>     I'm not sure where the extra sixty pages are from, but running the
>>     test repeately doesn't cause the number to keep growing, so I don't
>>     think we're leaking.
>>  - with vmap_stack, spawning tasks pushes the figure up to ~4200, then
>>     some clearing kicks in and drops it down to previous levels again.
>> ---
>>  mm/kasan/common.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index e33cbab83309..e40854512417 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/vmalloc.h>
>>  #include <linux/bug.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/debugfs.h>
>>
>>  #include <asm/tlbflush.h>
>>
>> @@ -750,6 +751,8 @@ core_initcall(kasan_memhotplug_init);
>>  #endif
>>
>>  #ifdef CONFIG_KASAN_VMALLOC
>> +static u64 vmalloc_shadow_pages;
>> +
>>  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>>                                       void *unused)
>>  {
>> @@ -776,6 +779,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>>         if (likely(pte_none(*ptep))) {
>>                 set_pte_at(&init_mm, addr, ptep, pte);
>>                 page = 0;
>> +               vmalloc_shadow_pages++;
>>         }
>>         spin_unlock(&init_mm.page_table_lock);
>>         if (page)
>> @@ -829,6 +833,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>>         if (likely(!pte_none(*ptep))) {
>>                 pte_clear(&init_mm, addr, ptep);
>>                 free_page(page);
>> +               vmalloc_shadow_pages--;
>>         }
>>         spin_unlock(&init_mm.page_table_lock);
>>
>> @@ -947,4 +952,25 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>>                                        (unsigned long)shadow_end);
>>         }
>>  }
>> +
>> +static __init int kasan_init_vmalloc_debugfs(void)
>> +{
>> +       struct dentry *root, *count;
>> +
>> +       root = debugfs_create_dir("kasan_vmalloc", NULL);
>> +       if (IS_ERR(root)) {
>> +               if (PTR_ERR(root) == -ENODEV)
>> +                       return 0;
>> +               return PTR_ERR(root);
>> +       }
>> +
>> +       count = debugfs_create_u64("shadow_pages", 0444, root,
>> +                                  &vmalloc_shadow_pages);
>> +
>> +       if (IS_ERR(count))
>> +               return PTR_ERR(root);
>> +
>> +       return 0;
>> +}
>> +late_initcall(kasan_init_vmalloc_debugfs);
>>  #endif
>> --
>> 2.20.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190903145536.3390-6-dja%40axtens.net.
