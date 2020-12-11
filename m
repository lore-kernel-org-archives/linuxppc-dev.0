Return-Path: <SRS0=d9E3=FP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F10C4361B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 00:13:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618E823D50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 00:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618E823D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsWTn0F7BzDqsy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 11:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=luto@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=C+0jn6o9; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsWRr4PlyzDqf2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2020 11:11:51 +1100 (AEDT)
X-Gm-Message-State: AOAM530OdrTcsNYYuZyedRsUVOFOFNfkaV9FlsvXUipEqTCv60xNs6rZ
 d3G0wnubFLJXrHdit2oapulmr9a3cJaffCmtJ1o9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607645509;
 bh=Cofiyz62cvN7fzCefudCkKNVJKZ45g5WsucZa64FPpA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=C+0jn6o9vwUqjjd6f6CIgI8ic4Dc1d+O9ysXMT3QZQbI4JG6cNTs1xXSKSM5DkCvV
 FhOTbsiz7Z1d6drfO1VoXxt9NP2zpaXtAh00zU8Jzp0Mx1PKhhruws1mNybQscSirZ
 TvDZcXfTovOEPMgyK5/MAkgkWU1UaGo7MMD1BPm2VaLPuGjIvVfJhqKwWdEX4rvEbg
 UOGReXpyRtUliPrTjgLUOJLCdu0KcjG5pvNOcUs+ZcY98DQ8bER9e2pFUPW246aLTC
 OLUtPW/EFWAV8JXDukqZMTlMP/DwB49qgTg9qhZ4ufDIJfxeMP1oQ9txHO71iE6w12
 qk9es7bV3hILw==
X-Google-Smtp-Source: ABdhPJxDDSK+EyEWrV85EAnSD1YFD7Ma/HEk0AvjGndG+w0b26Y9PplLtS1ujaNX2t/s+KYP+0f/cLisBWT1kfjpRfA=
X-Received: by 2002:adf:e64b:: with SMTP id b11mr10727032wrn.257.1607645507570; 
 Thu, 10 Dec 2020 16:11:47 -0800 (PST)
MIME-Version: 1.0
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
 <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
 <1607209402.fogfsh8ov4.astroid@bobo.none>
 <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
 <1607224014.8xeujbleij.astroid@bobo.none>
In-Reply-To: <1607224014.8xeujbleij.astroid@bobo.none>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 10 Dec 2020 16:11:36 -0800
X-Gmail-Original-Message-ID: <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
Message-ID: <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To: Nicholas Piggin <npiggin@gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> On Dec 5, 2020, at 7:59 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>

> I'm still going to persue shoot-lazies for the merge window. As you
> see it's about a dozen lines and a if (IS_ENABLED(... in core code.
> Your change is common code, but a significant complexity (which
> affects all archs) so needs a lot more review and testing at this
> point.

I don't think it's ready for this merge window.  I read the early
patches again, and I think they make the membarrier code worse, not
better.  I'm not fundamentally opposed to the shoot-lazies concept,
but it needs more thought and it needs a cleaner foundation.
