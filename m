Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32932C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:41:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6732084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHcTe/v4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6732084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yj4m2V7dzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 21:41:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GHcTe/v4"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yj2t2hsFzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 21:39:33 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id q21so16318154wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
 b=GHcTe/v4HLTE6/ZcIf6lGV4ciNnib00F0miBQKJ/h849hGbvpylts6FbdNzfzkLCoA
 kEZJZgxvXWR05iwQH6TglhLsW3luSoxuZSoOafur7xRkm+HucfsvvvyhrGCleinsdB7a
 kOKt6ePQGkkAvZgLGpAqxiZYf0kHWJJX9HQmrFTSGE8lrjQx6tIHXY3u/qip4OWoalqb
 n/9ukgVhnW2jvZYUZ+dkiFka5KTup8rI2fD7QxHZWg9FtOJS57KdgEu1/QdFsDsQrA7f
 f0yTITJvlyuX9LZ89piQz+46mR2R0uLfipoujrOoIEPaGnhfgup0ylO/7xEAA2KaP8sa
 Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
 b=CB6wvYQ3PZuX9LcYKkGgYKPqDWznoxaRTt+bPKTE7HOjZ8ohRXfucSlvOpEuby1Ooh
 XpR4fqyZMMVxDsSgpxY6U2CQQJcqlLg63j5KQ6xgt+3YzpRb4QjNt6GEYd/xLRSvpJ2E
 ArTk8rHYHyYyd8VG2xUSb/Z/RGlZ87wbFGhw2X9vkmaFz8O+Ya+Evf/VQ39l8Bbx3Hf1
 Oxb2hwiL49oHnJU4unOTtqTyccKUhxu7tTcCzQ/EKSDPjSB4h6zbLtlxqSKJzhJh80ZS
 hFHo2EF1yJ0RCRvlob6INmuN+uGW4D4qS9TGT7cFJ2Um2r7a5ZcZiS8Ba1y+RjZD9Wu2
 lFeQ==
X-Gm-Message-State: AHQUAuYCEST/QKqNRieVgSyKlubSfjQTvVXkWlq3WXVk+Ldt7mMLVKBT
 iS4wCgeCFsMxvmeckbpD8bo=
X-Google-Smtp-Source: AHgI3IZf3wahjDIx/L7PG9L3qJubpkc8NKYYmZR89WZekk9Sg8y67JBJz4VnSSQGjYaDrsxP6nvI7w==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr20556355wrq.273.1549881571132; 
 Mon, 11 Feb 2019 02:39:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id r12sm10477719wrt.76.2019.02.11.02.39.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 02:39:30 -0800 (PST)
Date: Mon, 11 Feb 2019 11:39:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211103927.GA118071@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211071159.GA55579@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Ingo Molnar <mingo@kernel.org> wrote:

> Sounds good to me - I've merged this patch, will push it out after 
> testing.

Based on Peter's feedback I'm delaying this - performance testing on at 
least one key ll/sc arch would be nice indeed.

Thanks,

	Ingo
