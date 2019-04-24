Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A7C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7172148D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="eS6BwuOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7172148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44prWb4yqnzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:48:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="eS6BwuOp"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44prT40nfDzDq9p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:46:46 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id w23so13699761lfc.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 23:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+DGUqjoCrDfp5F6ZJ/aJXzIUf0QAsTMXcihi5jieQHU=;
 b=eS6BwuOpFxo4AGLk+dWPGZVp5SZ6diE7JHQkOhzpNeZyBrBcfzem5PJ8VsYeXe19wo
 SuvzRMh0GQgedKOaEfziUAIl8h10F3s2ZQptniYHNYwco8gPAwPPp+Wa/obFfUqHqONC
 lC1j56a30Kw5SCi/qaMAcnh7HlkYWDiQT8aSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+DGUqjoCrDfp5F6ZJ/aJXzIUf0QAsTMXcihi5jieQHU=;
 b=nIf/XWJ6D+Yn+Tk3V+FYBGiQdub5I2d/sD1DjqAa2YUz6wq9pFSIF+wPI33N3/UbYz
 wcPHhEbv4zprbX3bXZ3Nmmy2nZ31uxPRtbgZItAK/MAZROgPgc9V9SwzbwB3k6XgXGOo
 c3MRBTbqXh3gCUREFHVZi7/m2mxpXKVRdl8PiYfT7yVxMbKIRaAKBxf5ae2uwzfOdOq3
 BetG71ODrAXrupDqKn1e40lIZ6RbzbZpvUfLjtPQ4PAIDPsDcJHgvHFu4E6cItARxMU/
 h8lSNs+Ddy1yR2iGHhSPjqxHEw1FcYgpuyvmszlA+uW6KGBkRLHEZTFHGhTG1fiFk9R7
 3yWA==
X-Gm-Message-State: APjAAAVgYxZmXaMDT5VBV29QERr652E08iFSZnrRSTXd3wZLO1vvnlVL
 fKvmTpc4XQOgLe6zJTe0etcC5w==
X-Google-Smtp-Source: APXvYqyt7du1ZpItlD2H1oCeywUqc1PcrY5PGA49A7C18M7lK800MaxpTakCPog3d2z0uBNSObzqfA==
X-Received: by 2002:a19:2d57:: with SMTP id t23mr14979726lft.99.1556088402257; 
 Tue, 23 Apr 2019 23:46:42 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id z2sm144803lji.77.2019.04.23.23.46.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 23:46:41 -0700 (PDT)
Subject: Re: [PATCH 10/10] powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for
 PPC64
To: Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <20190409212517.7321-11-linux@rasmusvillemoes.dk>
 <b5304c4c-736a-fd8b-e025-4ea040f5c346@c-s.fr>
 <20190423123611.1f7276cc4eb9f7a7005899a9@linux-foundation.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0fbffd5d-7e2a-1b12-5c94-b75f3f5d7ac1@rasmusvillemoes.dk>
Date: Wed, 24 Apr 2019 08:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423123611.1f7276cc4eb9f7a7005899a9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Jason Baron <jbaron@akamai.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 23/04/2019 21.36, Andrew Morton wrote:
> On Tue, 23 Apr 2019 17:37:33 +0200 Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -155,6 +155,7 @@ config PPC
>>>   	select BUILDTIME_EXTABLE_SORT
>>>   	select CLONE_BACKWARDS
>>>   	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
>>> +	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
>>
>> Why only PPC64 ? Won't it work with PPC32 ? Or would it be 
>> counter-performant on 32 bits ?
> 
> Ditto arm and i386?
> 

It's pointless on 32-bit platforms - I'm replacing absolute const char*
pointers with a relative s32 offset from the _ddebug descriptor, so if
sizeof(void*)==4 there's no gain.

And yes, the current implementation also wouldn't work out-of-the-box
for 32-bit platforms, since the asm needs to know how to properly
initialize a whole struct _ddebug, which (often) contains a static_key,
which in turn contains a pointer member, which both affects its size as
well as its placement inside _ddebug. The C code in dynamic_debug.c
would likely Just Work, but there's no point in complicating the asm
part for no gain, so there are static_assert()s in place to ensure
BITS_PER_LONG==64 (as well as checking the various offsetof()s etc.).

[I don't think performance matters at all, it's one extra addition to
access these fields, and that is only done in the rare cases where
someone interacts with the dynamic_debug/control sysfs file, and when
one of the activated pr_debug()s is actually hit (so a few extra
instructions drown in the printk overhead).]

I do now see that PPC64 does not select GENERIC_BUG_RELATIVE_POINTERS,
so maybe this scheme simply doesn't work on PPC64, or nobody has done
the work to reduce the sizeof(struct bug_entry) on PPC64? As I said,
I've only compile-tested arm64 and ppc64.

Rasmus
