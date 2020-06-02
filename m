Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038F3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 18:49:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9837D2077D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 18:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LppZWpUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9837D2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49c1Kr3xKvzDqYd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 04:49:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::f44; helo=mail-qv1-xf44.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.a=rsa-sha256
 header.s=google header.b=LppZWpUd; dkim-atps=neutral
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49c1Hm5DxQzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 04:47:32 +1000 (AEST)
Received: by mail-qv1-xf44.google.com with SMTP id z9so2278103qvi.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2020 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5Ek/i/6ax6ZbXrDVWsNeagdjRVYMfWWo92kpBvqURLc=;
 b=LppZWpUdNriiyHnLSTR7EoXopJSgF50Fg0SDsKilB92+au5FkrfdbbZA88O7fiaujy
 rCPGNy84abgA2FoZBfAqUz/sMIMNP0PByfkxmuoXEaUPPAZCkQfkn3spgV7hps6DIVCd
 HviyA2Ulz80HeQ0A091ARwEy0YDbb1AnwdQrNIusvzgx6+RfL8xCAjqlPj+LqttT59eP
 iYvcvnj3mpLI+JKoTTfhpKU+iVUvogrF1sFspdSEGfMEsVxpTHb0PpmjRD6rke/6BWsi
 NWU7DrfwbCPNU74TcXLPLjv4FlHMA4Fis4qo0eEOvRl0tXgsjKnNz2gzPIjmv/P9OEhj
 LYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5Ek/i/6ax6ZbXrDVWsNeagdjRVYMfWWo92kpBvqURLc=;
 b=UwHrxn9qU1kGrna1sbLjjEjnCfd1EeRx/Uhk3wz+vabuzhxhq1m9wQqSAmG8Tbgtr/
 qK94F1XLDd2alWD3ahMOcbxo5zepSNpATrImzqpp7QKbmM0Sf5KZzJp8sWToXRdiQ5xC
 A9kz4l+y+8oiPAx6W4Tar8Q9wPsk5pHh8jwQzKo7BgFqJD/WTBEv3jKOCd1rNnLyhI/k
 EZjDIZMblkn9atvia9wCI7zfRcq4kwwKQrH6tM7DeTfj3nGYAQV2VdQp2pvmlrAxnGfo
 qInrc3WwMvT1f6Lf93kX7gdwGKB+lEHGwcX70IeDLoCqs5zCL238orE4QS15LwghWN6J
 n0+w==
X-Gm-Message-State: AOAM533VFrCSl39aEk4wfmVQpNoPRmdu/8MXVA8hW7GFmTluaXZldKWu
 TCLv9Idw0djF7oGXDkV/OKf3lw==
X-Google-Smtp-Source: ABdhPJz5qHBqjeOiFEIVRjToyL8LZDQGkfq2HX9tcEnka+4baxtizORgBdeZqLo9JIMzqtpopg6JBg==
X-Received: by 2002:a05:6214:365:: with SMTP id
 t5mr11153638qvu.126.1591123648788; 
 Tue, 02 Jun 2020 11:47:28 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id l2sm3708904qtc.80.2020.06.02.11.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 11:47:28 -0700 (PDT)
Date: Tue, 2 Jun 2020 14:47:20 -0400
From: Qian Cai <cai@lca.pw>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 11/14] x86/entry: Clarify irq_{enter,exit}_rcu()
Message-ID: <20200602184720.GA1607@lca.pw>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.359433429@infradead.org>
 <20200602144235.GA1129@lca.pw>
 <20200602150511.GH706478@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602150511.GH706478@hirez.programming.kicks-ass.net>
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
Cc: daniel.thompson@linaro.org, andrew.cooper3@citrix.com,
 bigeasy@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, luto@amacapital.net,
 Lai Jiangshan <laijs@linux.alibaba.com>, rostedt@goodmis.org,
 a.darwish@linutronix.de, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 02, 2020 at 05:05:11PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 02, 2020 at 10:42:35AM -0400, Qian Cai wrote:
> 
> > Reverted this commit fixed the POWER9 boot warning,
> 
> ARGH, I'm an idiot. Please try this instead:
>
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index a3eb6eba8c41..c4201b7f42b1 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -438,7 +438,7 @@ void irq_exit_rcu(void)
>   */
>  void irq_exit(void)
>  {
> -	irq_exit_rcu();
> +	__irq_exit_rcu();
>  	rcu_irq_exit();
>  	 /* must be last! */
>  	lockdep_hardirq_exit();

This works fine.
