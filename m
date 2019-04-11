Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A4C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 10:37:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9932084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 10:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="i49hv+D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9932084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fyCJ2fPGzDqR0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:37:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fy9f4rs3zDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 20:36:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="i49hv+D0"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44fy9f3l3Mz8tZK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 20:36:06 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44fy9f3M4cz9s71; Thu, 11 Apr 2019 20:36:06 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="i49hv+D0"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44fy9c5zk4z9s47
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2019 20:36:04 +1000 (AEST)
Received: by mail-qt1-x842.google.com with SMTP id x12so6423612qts.7
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2019 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RrTSgamKINRlcosP1Z1SPCm/54kg3DP8rcroNAyPFVU=;
 b=i49hv+D0cbAZomcgnCfHUSsUrYq8qYqJVmgTYHBj5E0CWbUoiFGuVewCCwXCyTo2YD
 cjfpO8FvLSTNbRwDsc7e1hGQby0dO6py6F4mK2mZkEQDhQH3z8EYO7xX+R/+ItAoW5lp
 Qgx1db/bQVIQUKCH26kLkFQqFcWdvxpo5M4H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RrTSgamKINRlcosP1Z1SPCm/54kg3DP8rcroNAyPFVU=;
 b=nd9Dw4BP6xeJZGAQUpvdWYXNs+dJ3ssT9In3A7zZDhBZejabuLW1NS1uo4huAmCL2X
 eQIKbFUzpS3G1fuZSUr59CpGtrJLOxslxXodKL0S0ldKvVC2JKKlji9mE698VDymmf5G
 iqIDymE6IjOhCzsNchGWxqyTGtprS2UK0C+YlKpy/8BYwaUZ5kcO3WDW6KqfJbggxAOv
 rMsYcql0qnbCtQLrUHp1zwJtSCD7D3AARovKzJGY2J2KIkPW3YLTBaYubcZFKnV9c5Cx
 fhUY9x1atHiLAjFbCJUaDTnz0fMxqOhIHWMuQW3U9jXtutxv6YABW+Lj2ikiPBInxk+0
 3a0g==
X-Gm-Message-State: APjAAAX4PWu2lAbwYv2lNjcXGA2ZJWIK0sJQ6lQgDr6Kbqk49cMYVSzz
 5rXtUX40MUInQCOCgAtCjTSI7RqWHqV5vDV/OpIbUXX/lGbaNA==
X-Google-Smtp-Source: APXvYqxVhI50AswZ8D+43B8GHszhqaEOOjhFUcdcmsG3H6+Lvqzk3Ttvzf7jVqplgccwu+tAFoRHYMfhzjaM64fWF8k=
X-Received: by 2002:ac8:2c72:: with SMTP id e47mr40652555qta.189.1554978960721; 
 Thu, 11 Apr 2019 03:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190409131420.18842-1-mpe@ellerman.id.au>
In-Reply-To: <20190409131420.18842-1-mpe@ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 11 Apr 2019 20:05:49 +0930
Message-ID: <CACPK8XfnGtGx68NT7KEepWtpxvYN6HYdNU04+09CB4Z_UsWjwg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/security: Show powerpc_security_features in
 debugfs
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 9 Apr 2019 at 22:45, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> This can be helpful for debugging problems with the security feature
> flags, especially on guests where the flags come from the hypervisor
> via an hcall and so can't be observed in the device tree.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  arch/powerpc/kernel/security.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index b33bafb8fcea..d6ba696d0ed0 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -104,6 +104,14 @@ static __init int barrier_nospec_debugfs_init(void)
>         return 0;
>  }
>  device_initcall(barrier_nospec_debugfs_init);
> +
> +static __init int security_feature_debugfs_init(void)
> +{
> +       debugfs_create_x64("security_features", 0400, powerpc_debugfs_root,
> +                          (u64 *)&powerpc_security_features);
> +       return 0;
> +}
> +device_initcall(security_feature_debugfs_init);
>  #endif /* CONFIG_DEBUG_FS */
>
>  #ifdef CONFIG_PPC_FSL_BOOK3E
> --
> 2.20.1
>
