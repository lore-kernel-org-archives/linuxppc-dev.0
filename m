Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767BC433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 03:26:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493D5206A1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 03:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czG0uxgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493D5206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Br7t25GXlzDqSR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 13:26:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=czG0uxgt; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Br7qz6x32zDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2020 13:24:14 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id f1so605946plo.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 20:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=irbkPgnfVyWMQHxRCFB56no1LsWgtr4nyisml0hvN5M=;
 b=czG0uxgtgmPzrOOxLt4QmLQjK9z2MyB/I3cVw41+bQI4inEF/0imI47qizBZzP9IGA
 aBeVvkgZgvUlmGO2x8HpojXnjrb/SGdRb+rxGVk5Hi+J75XNmSIBsJm+ELSzvsps7+iM
 PlzLu7vx2uxw8UhKzIJFQ0gG7dMa+Lrl/iexLy9ADk/w8PHdlJk55PaKztDmo2caxnDM
 uuAx55TUPcqvnCij2WTA3qURpI03MY7RB1Kd4/9YOpa6Uu6mvRlmkJx4/oWQOQ08OxNN
 pOQiS+d6LMOl95lawfzdaUZZiaSJmAfMgbX/vN6C0ESuYiXRkUOiP/GTSg15ZiE8vcuZ
 0mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=irbkPgnfVyWMQHxRCFB56no1LsWgtr4nyisml0hvN5M=;
 b=PMzf7wUoEuCrYToLIkFVkZFBffQfhv2X5qBg4UvfIQRo4P2vuZF7IvJ+QbfTby/wFE
 xiobZ12qWY1k4V6AJK3yDIggYrMQNHqXGpsYvqVrAZi50+SggmVvfsJG+fnYc5Jbt1Zz
 rYKXznMWtaFq/TDu2Ra07CmKeeQW6gzFgPdq2dOcdjR1Bb4pPNx1lU8RMXfoaVfX+QFO
 GGf7l/bYpSA4cY9TztQ4VJSLzFXZYI4C7/hblIlJL2xvc05qBfSMCBuzbHpHM0CZgEWA
 7p0wuJeuJAoPXwZZ4EuURIra8Dgx+f62cxDta4n4RPfIV5rrUZdCh+PQyl5KqBOE0NBq
 5KlA==
X-Gm-Message-State: AOAM533vwYqEJd2Bh0mwo9kkMNK834ZNfcrFrcI6cLoEZpp1AfXsShdf
 ysgCixelS2CHTB526Sc4ptI=
X-Google-Smtp-Source: ABdhPJySSgYe8lF/6JDS960pKpGJxF72ZmNu6Ie+xgS/tQum+ZxCJr6+X0CzlaFCQ2vkb+wTaG3xAA==
X-Received: by 2002:a17:90a:6e45:: with SMTP id
 s5mr2238591pjm.12.1600140252750; 
 Mon, 14 Sep 2020 20:24:12 -0700 (PDT)
Received: from localhost ([203.185.249.227])
 by smtp.gmail.com with ESMTPSA id b20sm12442113pfb.198.2020.09.14.20.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:24:12 -0700 (PDT)
Date: Tue, 15 Sep 2020 13:24:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
To: David Miller <davem@davemloft.net>
References: <20200914045219.3736466-1-npiggin@gmail.com>
 <20200914045219.3736466-4-npiggin@gmail.com>
 <20200914.125942.5644261129883859.davem@davemloft.net>
In-Reply-To: <20200914.125942.5644261129883859.davem@davemloft.net>
MIME-Version: 1.0
Message-Id: <1600139445.qwycwjuwdq.astroid@bobo.none>
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
Cc: axboe@kernel.dk, linux-arch@vger.kernel.org, peterz@infradead.org,
 aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from David Miller's message of September 15, 2020 5:59 am:
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Mon, 14 Sep 2020 14:52:18 +1000
>=20
>  ...
>> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
>> optimisation could be effectively restored by sending IPIs to mm_cpumask
>> members and having them remove themselves from mm_cpumask. This is more
>> tricky so I leave it as an exercise for someone with a sparc64 SMP.
>> powerpc has a (currently similarly broken) example.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Sad to see this optimization go away, but what can I do:
>=20
> Acked-by: David S. Miller <davem@davemloft.net>
>=20

Thanks Dave, any objection if we merge this via the powerpc tree
to keep the commits together?

Thanks,
Nick
