Return-Path: <SRS0=Uveu=YL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A5CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 05:10:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A5621835
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 05:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or1S1NJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A5621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46vYxd6nCDzDrPd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 16:09:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Or1S1NJB"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46vYtc25DdzDqjj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 16:07:17 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so2248946plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2019 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BN38U1tWSQycIwUtKvgVS41nw2Y5xmAR6qADXcgIN/E=;
 b=Or1S1NJBS21mZ3T0kRuw3+pg9/9vA19tlOBKzPCu+VJOzUGorap9nhyIFOs7X2qgrg
 zvJDJQwIS1BW+6v7Hpb7lsxv4M+N1QE5YfJhC/1Fj5/SMhEmHI+miSmHuYfJPzUy6eFa
 GC0iDI+pBneF36jZra4sKjv7DLrI/2YleI/qLkqhHXu5iCL7IzKssn9od150fmLSzfsz
 LCOOYySKfikf3B2ZqQcd/I/6X7u97Zel3TIjOM8ZSAJdp2jpXC24fyV1GimkEn+jQcpD
 jBnPpOKMTIiYCrVbDyuUNr2v1+bDc60g12qFOhDG8ORiKRo/fqfAbqCIaTrPDAbvhTUO
 GGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BN38U1tWSQycIwUtKvgVS41nw2Y5xmAR6qADXcgIN/E=;
 b=TAG+iw4OSc9OpjCKuPlvwSLoI0vTpQhNhzpV1vBe+9ul2d2Ck1gBwGN0/U5h0mCXGZ
 i20F2G5z69K9oG5sRPzKLopYq7SQyM9oyZoMkOyMIS1gid7++ZNDDsKcJawHX9dp1mx2
 MnqVSUJeDfy7jmGqK72NykgU8Eb/7X3/P44IESqB4URbcM44ambvmMOcBFIBOa5mXH4q
 +uEsLIkcL+TjGfkEYLtvOeN74z6BnK1ROWgcuZpcix3HHv6mhEMiLlNTaizkZBiVw6Q5
 M+rym5jlC39qGJUe+C4LO7QYsG3Fqf8HO4Noxa1m/fdEqE3QcNfX2+jKFiVGKs46nXm1
 symw==
X-Gm-Message-State: APjAAAVsVHV6RcD/kGLDug+vVh9YlEBzc09Vrs0hX7YTE8IHSnHQfQV4
 45DTx9GdMElGIcJf+Lsuh2dS4Q==
X-Google-Smtp-Source: APXvYqzkRC1EwPpxmXJHKXXdNdXNMqjA0MEl0CEAzz/4I6yX9UtNA1XEwdpB6tAX43Fk+9Ejz7Ry3Q==
X-Received: by 2002:a17:902:904b:: with SMTP id
 w11mr7882591plz.182.1571375235738; 
 Thu, 17 Oct 2019 22:07:15 -0700 (PDT)
Received: from localhost ([122.172.151.112])
 by smtp.gmail.com with ESMTPSA id 74sm4821485pfy.78.2019.10.17.22.07.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 22:07:14 -0700 (PDT)
Date: Fri, 18 Oct 2019 10:37:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2] cpufreq: powernv: fix stack bloat and NR_CPUS
 limitation
Message-ID: <20191018050712.qr2axffmbms5h4xb@vireshk-i7>
References: <20191018045539.3765565-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018045539.3765565-1-jhubbard@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
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
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 17-10-19, 21:55, John Hubbard wrote:
> The following build warning occurred on powerpc 64-bit builds:
> 
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This is due to putting 1024 bytes on the stack:
> 
>     unsigned int chip[256];
> 
> ...and while looking at this, it also has a bug: it fails with a stack
> overrun, if CONFIG_NR_CPUS > 256.
> 
> Fix both problems by dynamically allocating based on CONFIG_NR_CPUS.
> 
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Changes since v1: includes Viresh's review commit fixes.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
