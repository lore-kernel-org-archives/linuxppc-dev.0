Return-Path: <SRS0=UNki=6E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399CC54FCB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 01:16:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5278C2145D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 01:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqV2q4iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5278C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49580l2HTWzDqYp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 11:16:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XqV2q4iG; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4957xd3jmpzDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2020 11:13:41 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id o15so3674824pgi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2020 18:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=8mak7fzA2iH9hORi7KVOGUB3PBDwqPkV7uTEPmEFybA=;
 b=XqV2q4iG7j1YSvu3OOLFoXpgMQK+6at1tAqHhGzHPoBjJrxkJQnrUIyqexn7E1P7Y3
 4fa+84W8xo8XqFQZE2T/r+19HM0Gh4yziPYIPjpqkDGWyB14SGeY5PvFot35U6+fsoyR
 ZPkSsVmw9uWFOS111hVyh4zhLQlVKlAWZz7GcWfh4sADM+jxXTCp915mFB2cC8nAk/4W
 8YBBPPBqRkCa9m3+OmgbhTIsYrPmR8xCu6QFyKIevn1y4RPMKLmWGhhcAVpzijYCkrDj
 Vf3LaW411qYHDI6XFjtHAeB8PLXXx2YJ1ghcRvPPerZ6GjVldywBmPXitXijz6L+ECyq
 CnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=8mak7fzA2iH9hORi7KVOGUB3PBDwqPkV7uTEPmEFybA=;
 b=GoGH/DrGC4HzOysJzUGW5XcGSmcYcDPUr7/1tDZjok/+T3XAjAR9hJ+bB15EIeVUIp
 TPFzEwy+EWq0rCsSjfcxPYvsBQFukM0Byc6Pd04cAQmh9PMPJgjwibDLoczBYP+dV2oL
 WXgVagUG9qxN8n5vzZEBMRy3lfRl8lgcyjqlohnMH+TgXMIPkQqQDoun33tl/bHMjM57
 1r2YiviLRSY4aUhOX7sCESCG6QUgVNCJ/ZGO/HPRkyapUqz+N7+AE5zQWFybZHcXW7DZ
 evHtfWFDrtlET7xNQlFevw557jpJYOVvYD2d4UlW+bxjlTvMKiIQPq+cssAidX7UdQiw
 fNTQ==
X-Gm-Message-State: AGi0PuZjU69kBWG+WdwV8Tfm/upD4YHh+Wy4PGTh2PIzSgcYRHBBuS1Z
 eFIgQBGgRsTv2Tejij29NNY=
X-Google-Smtp-Source: APiQypJcK+iD06FfXRO7tEQFLld6y4/ihI+YknPJq286D/+7suyEO5sqCb1JFYctarxS2RvowGieaw==
X-Received: by 2002:aa7:9305:: with SMTP id 5mr15299136pfj.188.1587345217456; 
 Sun, 19 Apr 2020 18:13:37 -0700 (PDT)
Received: from localhost ([203.185.249.170])
 by smtp.gmail.com with ESMTPSA id i9sm7735710pfk.199.2020.04.19.18.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 18:13:36 -0700 (PDT)
Date: Mon, 20 Apr 2020 11:12:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/book3s64/kuap: SPRN_AMR modification need CSI
 instructions before and after
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20200419135359.731325-1-aneesh.kumar@linux.ibm.com>
 <1587341611.capj46kr99.astroid@bobo.none>
In-Reply-To: <1587341611.capj46kr99.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1587345091.ewst0wvt61.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Excerpts from Nicholas Piggin's message of April 20, 2020 10:17 am:
> Excerpts from Aneesh Kumar K.V's message of April 19, 2020 11:53 pm:
>> As per the ISA, context synchronizing instructions is needed before and =
after
>> SPRN_AMR update. Use isync before and the CSI after is implied by the rf=
id
>> that we will use to switch to a new context.
>=20
> Not entirely sure if we need this. This will restore AMR to more=20
> permissive, so if it executes ahead of a stray load from this
> context, it won't make it fault.
>=20
> That said, leaving this end open makes it harder to reason about
> user access protection I guess, so let's add it.

We probably should test whether it needs updating, like the entry=20
code does.

Thanks,
Nick
