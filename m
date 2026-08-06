Return-Path: <linuxppc-dev+bounces-25531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF23C56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 21:29:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGL4q69bwz3br2;
	Fri, 07 Aug 2026 07:28:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786051739;
	cv=none; b=imEzWaZfzwFXRLQl1+XDjQcf1NqwIAZWtutQL454s4Ma3ICcSSE7QEYKlkxUnErKgXTpTGeU999Fd5fRlq8xeT40AgPoVkbvz1oRgv71j9jsDvbz0bPDE52eyPd1kCrZ0K/8VG8CK4sR/h/566yB4FVVJGAF5heleMHUjmQ9Nc4O2bHepvb2er+sfBhLW3DY7WXEhZQq5K64qw0GhHs+WN2d+bv1ozIGlHrCrDiETWhBn1/gA18xDhgjIF3223gbwyXGTSrKL8JDNB9HtXzp3uFrYRk8RcTeFfljQPgBdWXUqqCz1JZTsf30G3yeTg/RCMB6ygrSpop425HlaCM3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786051739; c=relaxed/relaxed;
	bh=+wdU8SDUgGSQi9z0LrUHaN7SuK5nD8YNmGtbuiGl9Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enVszvuaGGqk9Nxdip3r8L+9AoZv1hUc5l3WIC79IgTNqTvm8EuCfDJ88HNUBriMTgKkoTiFYmxNQFlx2rCcsvQiRgi2CJ37KBAJuIUkUH0anELb14/H8TpUxNBmvozT4x3jrlLZZ/gJtnnvi/6KSdFEUsjHeoxYyGASnDCvu+pxayri/PHvv42qGx+kI4Q7Lp+bkosqRqoJYDHjbUh3fgTT9jNIJca0r/O0foRzhlrAqCzth+TjGZ+tOlK9hqjIxMsyEkafIgn05ByvhlsO4JXogT0X8t/4DgzPabeIQeDUCsPQez1ZuAw7ptLXzd0MX7uj74vJ6rfAImyUQWY9Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cleGj6fj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cleGj6fj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGL4n5Jlyz3bpx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 07:28:56 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2126011a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051733; x=1786656533; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+wdU8SDUgGSQi9z0LrUHaN7SuK5nD8YNmGtbuiGl9Zw=;
        b=cleGj6fjsDfkSvYvp37U23Rk+K9R2Gy4xD6M65zTSZ0+Hv9WzuD46WXkAOskdhIikw
         YmjFsZTRlYgIU6AMoDq1/e+m7QQozQmOUixrPIVbn5/Qg0kQSv932+XyThYvkdcwRXhI
         Y1i56K7bKl6QMAOG1QDnrigqCvxJwieY0tIZ+xbbZBHMv3m/kzan83wvjETDhNvxMkl0
         gFCm3RTUEMJbIz1jvNBYLfSmSV6mI9Dld45VelIUsI9HcCXGAr6hdSgpwmtASqCXZaP2
         ELwqR9+4ZuEYKpYx9FYz2U302GfCHa9MAxsLqta+jK+skPnrdd6YQOZ39lPRl1KyFfSO
         G4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051733; x=1786656533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wdU8SDUgGSQi9z0LrUHaN7SuK5nD8YNmGtbuiGl9Zw=;
        b=YegB2BHSc9uyjRI0BHYN96OAzic6wdYBYGcJZ49B1+IJyOBvI8kLYnyUERtmDv0oDj
         rli5RtbxRMDHdH3pMEx3EVduqBg1+QVEcf1h1CEzsa+uzxG7ODCzbCaFkRByeWArCyoQ
         5tmJXTAsvlFAQ2D70/12il0DN3cNzOY79sMOR+UdZeA7v13WkqXZtqR0fto5qK3/gDUl
         2OcasiOcQXsx/CGULb8XaZcH4tSiDlkkj5XUbV6DNiTsfhiUpAEpl7qVHW6GzZKyiIdJ
         dIDKyQD5hZGlQK8ql18xWiDMFTz2pvEL2Ft3PwBjbwSS0evwWqil9vXz7cr41ojxP8UQ
         VlJA==
X-Forwarded-Encrypted: i=1; AHgh+RrLKvXF2TjVvfJ2dUGBaP6ux49BiVU1g4+d790efZ3zQXVksmjaTSIpr18CiOBd+INVE5k+wLni6gb1ziM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLPr0KS2MN6Wogdmq3l9JveDv860e7lGdgjS/QSP19zSXpFucr
	YUS/cacsLoVI/+AUB1rhkVIQIUQTw/n7qziqOOGz7lnKOlkg2IxkwoKs
X-Gm-Gg: AR+sD11gGSfdT0V28z9boRYlz4dlXAlBXisYtfObGzaKGKCsx3dQpm4fhNtWIOSyJvT
	fU/zBWl6R5U6IPwX7OuJJBsWNL2dk410b4FLkDrvO4ZI9oub8vl0GFqbGu5WfpsNAHQAESOt+9L
	2K8ceHqvtjI5XUn1WkJjdrjvNce7twrVrw7LsIyoMJi/u/9yDVZBboprphcciU6mf62uzIEXUOo
	8/jwj/tEiBWNqnypDfLueCjR3C7Fqr1aUt0AdQbQ7t5p+p7Zo7Eq5MTe9mPdlW+8ZgBpTJKdTpw
	xWi1aA4ERc4x4rrxPhLQ6+VDX3KcMHF5M4kCOCxA+JvRjpdzi/HZ4n5kCyjhR6XCtUawbegTj87
	d7WWNok4kGdh/80SV0aRVoOVO1Uq79/KPO8zpjtUaHkMPOUVEOPL/TMq8AIxTzxqYrPn5IGRDG4
	PDRWDS0dvp3/8jppIZouHmCJQgG45U0KyOTMai2hSY2cqpeC1tVqreIKpFg6PwCIsRDWNSzxaHS
	cg=
X-Received: by 2002:a17:90b:2790:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-3909d8d3ac0mr5025025a91.15.1786051733205;
        Thu, 06 Aug 2026 14:28:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dc397esm2325841a91.2.2026.08.06.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:28:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:28:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: booke_wdt: Document unused parameter of
 __booke_wdt_disable()
Message-ID: <5fa154fc-f2f5-41e8-85eb-03c221b77d4d@roeck-us.net>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
 <20260730060617.7-3-bbnpreetsingh@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060617.7-3-bbnpreetsingh@gmail.com>

On Thu, Jul 30, 2026 at 06:06:17AM +0000, Babanpreet Singh wrote:
> scripts/kernel-doc -none reports:
> 
>   Warning: drivers/watchdog/booke_wdt.c:158 function parameter 'data'
>   not described in '__booke_wdt_disable'
> 
> __booke_wdt_disable() is invoked through on_each_cpu(), so it takes a
> void * argument that it does not use. Its kernel-doc comment does not
> describe the parameter at all.
> 
> Document it as unused.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Applied.

Thanks,
Guenter

