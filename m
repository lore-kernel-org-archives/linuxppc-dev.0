Return-Path: <SRS0=pfuI=TG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4DFC04AAC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 07:36:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC8C2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HfCKA2Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC8C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yF0q6PT7zDqKD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 17:36:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="HfCKA2Gc"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yDzB518RzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2019 17:35:01 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id 132so2439653ljj.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2019 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ok4FiX0qqzxFXNlfPJQBxeAS7MtYAthIHs0pXM/1gsw=;
 b=HfCKA2GcWuIWfyCu6q7Vb4VuU5C85rltY95cYwAzVOuNpcOxt9Vpj8t6IWJzXJpM16
 uc9PlW5f9Go3h/CJ9UsWwq1rdbfbTV7+cveeHt9cUsGuK9G3I7pEgW3Zv9bOFVDQOZbH
 MpdHFdCp7U0R6aqGNC2FBUx6AIBp++6riZnVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ok4FiX0qqzxFXNlfPJQBxeAS7MtYAthIHs0pXM/1gsw=;
 b=WQeVjG2KQCSlpvP6So+MlDibBvFmaKGOf00vQgIG7nGIvZf7CAZim+Y5g6zHdaPLww
 5nPr7Pn3NoT31RZgV5DulSXIXmwz+OtJw4COFrYzkPXUd85mCsmEPFEaP0J/PA9yXQ8B
 t8ghr+pYNi8Hb0qKm50TUUo8iXuyHT1DaCVgsfjjPPsvayt89c8MWVExzZNb2IObq7Px
 9B1czrSCSPx2Xy8S0b4y5MUwA7C1K3n9JbrJayF9uXIk4n1fspLFIkDR4sSQ90wKLBx5
 SOXVGMEgKelPm+BAbV08sSerE1bMUZynDrVs6FxdqSVeiZty5k/VT5n8GpRf/ad6MVDK
 uiRA==
X-Gm-Message-State: APjAAAWn4L1S819E73pnsUN6w4x6jIhXz+aA69CtIGDsrBI7hEyNKXSk
 pmOJlHL6lAvzSQmsyBNMezsfzg==
X-Google-Smtp-Source: APXvYqyIXcDanMudqDV0cbvEgmg2JswEqVaUi3W8CZa23fGsbc0VYTSqSxQKNyi+uTC2tZHBHGapWQ==
X-Received: by 2002:a2e:9f07:: with SMTP id u7mr3713010ljk.115.1557128097278; 
 Mon, 06 May 2019 00:34:57 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id y25sm2083764ljh.31.2019.05.06.00.34.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2019 00:34:56 -0700 (PDT)
Subject: Re: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
To: Ingo Molnar <mingo@kernel.org>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk>
 <20190506070544.GA66463@gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <25dfde77-fdad-0b99-75ec-4ba480058970@rasmusvillemoes.dk>
Date: Mon, 6 May 2019 09:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506070544.GA66463@gmail.com>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Jason Baron <jbaron@akamai.com>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 06/05/2019 09.05, Ingo Molnar wrote:
> 
> 
> It's sad to see such nice data footprint savings go the way of the dodo 
> just because GCC 4.8 is buggy.
> 
> The current compatibility cut-off is GCC 4.6:
> 
>   GNU C                  4.6              gcc --version
> 
> Do we know where the GCC bug was fixed, was it in GCC 4.9?

Not sure. The report was from a build on CentOS with gcc 4.8.5, so I
tried installing the gcc-4.8 package on my Ubuntu machine and could
reproduce. Then I tried installed gcc-4.9, and after disabling
CONFIG_RETPOLINE (both CentOS and Ubuntu carry backported retpoline
support in their 4.8, but apparently not 4.9), I could see that the
problem was gone. But whether it's gone because it no longer elides an
asm volatile() on a code path it otherwise emits code for, or because it
simply doesn't emit the unused static inline() at all I don't know.

I thought 0day also tested a range of supported compiler versions, so I
was rather surprised at getting this report at all. But I suppose the
arch/config matrix is already pretty huge. Anyway, the bug certainly
doesn't exist in any of the gcc versions 0day does test.

I _am_ bending the C rules a bit with the "extern some_var; asm
volatile(".section some_section\nsome_var: blabla");". I should probably
ask on the gcc list whether this way of defining a local symbol in
inline assembly and referring to it from C is supposed to work, or it
just happens to work by chance.

Rasmus
