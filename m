Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1111BC32771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 02:20:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB752214AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 02:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="MVkn66nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB752214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ynwC1wmMzDqVC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 13:20:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ynMD574nzDqST
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 12:55:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=MVkn66nM; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 47ynMC6WtWz9B7L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 12:55:03 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 47ynMC4CQRz9sRQ; Thu, 16 Jan 2020 12:55:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=MVkn66nM; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47ynMC1Tvlz9sR4
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jan 2020 12:55:03 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id w127so17696856qkb.11
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2020 17:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1jQPiz895agk64Djkkz8pv7tlcB1doI8kha27mNFNNM=;
 b=MVkn66nMqH65aqnGSfC22WPtEb7g+VNJewgDgDwix4iEn61h6VIEGJMstYMD1N3X+6
 rZthGerSDSyPOiob8Da5TW0r6PMXgkKYPPmn7s/Hz+6cSRlmT54pLUcBWXZg9oxlTHxJ
 hAEMs6XaxOLOG/yKzVkDmB2wVn91NnWKO/cA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1jQPiz895agk64Djkkz8pv7tlcB1doI8kha27mNFNNM=;
 b=JV0dF/fzeMEPPF1gWAqullZ4RKPpJPHfIuf6bMw3UY2t0SsvL18eTX7A/vMV4xbhjc
 16avRbpp5HFEgMP/JfBWbob0/9OUAKqGaHrs0cVol3fHiKMBkXAyB8BabpBpNXkSfHAs
 VBpfewgmKO+qyHB4JAzwEpMfbFppgOE+iTzKBmS7T1kbl4czN8fcIJ+3vfa/u7ZxqH52
 dNZhUe5dKtnHXIozq8j8tsM7XWP14LAU7wvVbp4bSRm1F9lmMOSXijqkNGjto2AO3Fqv
 X3vMnVTOC0x32uzAMeuFvf6av+zL8YJGfmaIrzrLFk1EdGDmjM+pbvzwZC9Id6GXWE6s
 eEYw==
X-Gm-Message-State: APjAAAWvIkITcC2zckZeGmoo1rDF09XMElrfrdguj6NoxfwKDrTmRA0q
 HvyCSh839pAvVScNm9K+iDZnUCQq4Wlb4R7IHgc=
X-Google-Smtp-Source: APXvYqyeZm6Q9cZHvcgNm4OMWLWDCxNO+EDevPFoSiMSUWGVWJ8BPOtZxyvXKR0hRnX5aCRUmyhSyYY+5FCGJIZP4Ag=
X-Received: by 2002:a37:6255:: with SMTP id w82mr30801455qkb.330.1579139700711; 
 Wed, 15 Jan 2020 17:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20200116014808.15756-1-mpe@ellerman.id.au>
 <20200116014808.15756-3-mpe@ellerman.id.au>
In-Reply-To: <20200116014808.15756-3-mpe@ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 16 Jan 2020 01:54:49 +0000
Message-ID: <CACPK8XehKun1yFEaUh9+GSDSr5TetVHpXm3Pm0r-aJxR7+=2Jw@mail.gmail.com>
Subject: Re: [PATCH 3/9] powerpc/configs: Drop NET_VENDOR_HP which moved to
 staging
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 16 Jan 2020 at 01:48, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The HP network driver moved to staging in commit 52340b82cf1a ("hp100:
> Move 100BaseVG AnyLAN driver to staging") meaning we don't need to
> disable it any more in our defconfigs.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>
