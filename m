Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E4CC4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 09:25:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B2361002
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 09:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B2361002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8yYR5gxyz3btL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 19:25:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=jT/xShcV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=jT/xShcV; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8yXx5dXKz2yR4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 19:25:19 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id v13so846243ple.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=ZT/7Ux0bhzXpS+rf3sIBrRKhCNZmq/T8COWEpsyT4vY=;
 b=jT/xShcVdMcKeL4oR84DmNjF8Ol0x/t28pcCP6UWjmojgFpGCDTaWbUhUey+D9/VjC
 Fa1Y1LWPaxwZ54WdnRJaxarvAujXv6r//5mDcLAh6xR8aB6179P598fcqJpgFw/O8e9I
 yTn+mPdLFKs3Hhdq5aEBdwyy6yLqfaIjFuu+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=ZT/7Ux0bhzXpS+rf3sIBrRKhCNZmq/T8COWEpsyT4vY=;
 b=GJZOcPZ1+1V+2XatnxpkWYfuBhLJSroOp/JNHg8EpYrvZLJWF/NiR1+idQ7Hm871de
 XAp16qcfDKszEYWB/RdSFSCjE+RGasz3ZIF/TN3sv/Q+XEDHUpNSTEuuAE7bNwN5prMf
 275oyJDddsKKEJIMtQt6D2EAUISNvwCMEl5RaR9+LIwtkMfHt/7+2qbrZemhtVZLHC2c
 nTOfQuOCSCjA0GL6/biIIvpsbT7VuSWOSY3Y3r0l/kwLdwOLCsWdhMcvJ7ssCwFHzNeF
 csdMNhWxiIqOFW+GzhHwxpeWWrcyga1S5jbIGHE4VxQXvpIp0jowNJomsE9US00Fxg40
 8/4g==
X-Gm-Message-State: AOAM531Eo5qmHnqNkpmFWWjuXl5WjjS8RladlX7fUdWdzB3MibuMylTE
 bbueo0npHm90Y80iEs8O5S9/5w==
X-Google-Smtp-Source: ABdhPJzbsZxUgHYE+5c9jK/6f3Rta4+H0JAMzKESDJRylXWtH/o0U6l0mxh/tTrGSKf7QzJuynjyCw==
X-Received: by 2002:a17:90a:ee88:: with SMTP id
 i8mr8603384pjz.71.1624440316495; 
 Wed, 23 Jun 2021 02:25:16 -0700 (PDT)
Received: from localhost ([203.206.29.204])
 by smtp.gmail.com with ESMTPSA id u10sm1860501pfh.123.2021.06.23.02.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jun 2021 02:25:15 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v15 2/4] kasan: allow architectures to provide an
 outline readiness check
In-Reply-To: <CA+fCnZdJ=HHn1Y=UDiYJ2NagNF9d-bJfjQa0jmiDaLiqneB_rA@mail.gmail.com>
References: <20210617093032.103097-1-dja@axtens.net>
 <20210617093032.103097-3-dja@axtens.net>
 <CA+fCnZdJ=HHn1Y=UDiYJ2NagNF9d-bJfjQa0jmiDaLiqneB_rA@mail.gmail.com>
Date: Wed, 23 Jun 2021 19:25:12 +1000
Message-ID: <878s31hr0n.fsf@dja-thinkpad.axtens.net>
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
Cc: Marco Elver <elver@google.com>, aneesh.kumar@linux.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index 10177cc26d06..0ad615f3801d 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -331,6 +331,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>>         u8 tag;
>>         void *tagged_object;
>>
>> +       /* Bail if the arch isn't ready */
>
> This comment brings no value. The fact that we bail is clear from the
> following line. The comment should explain why we bail.
>
>> +       if (!kasan_arch_is_ready())
>> +               return false;

Fair enough, I've just dropped the comments as I don't think there's
really a lot of scope for the generic/core comment to explain why a
particular architecture might not be ready.

> Have you considered including these checks into the high-level
> wrappers in include/linux/kasan.h? Would that work?

I don't think those wrappers will catch the outline check functions
like __asan_load*, which also need guarding.

Kind regards,
Daniel
