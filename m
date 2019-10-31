Return-Path: <SRS0=EHb9=YY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDFCA9EC3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 09:25:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926822086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weLvOuQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926822086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473g0047X3zF5dW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 20:25:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::143;
 helo=mail-il1-x143.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="weLvOuQe"; 
 dkim-atps=neutral
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473fxp07kDzF5GP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 20:23:08 +1100 (AEDT)
Received: by mail-il1-x143.google.com with SMTP id y5so4743462ilb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tcqb+IhaSDNJqj7Em32KI5EwoshodE6lIm8MXsmML5E=;
 b=weLvOuQe1qp7SmhCa5wqkA+qSy/HEWoAjkcTVlSLmbLlzcNRUYU35rD6ep79Car13u
 zKYBIaW1HL+b+Ge52YcNvy+uigJvgEvkl2WJ5/xcQHSfo9uz/tLpaufL77nD/StOag98
 5g0E/oajUNfHB3BaXhwyd+V6VC0DOOCkEdTVe6hgSLb+zF/DQRZrhi8Ja6YM6EH63NbX
 INzL+8Y+jxQq1t32aM9SzxjjwZgkcoJxE2WGtHVb8mRN9BOIuXfCMQrYFOtkHs0AiBgO
 GZAfXiwJTEGGz8yJ8QLfyZ+vTPRonyzYtQnbfO6X8991QDuI76GzMx0tXFymBenoUEsH
 rruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tcqb+IhaSDNJqj7Em32KI5EwoshodE6lIm8MXsmML5E=;
 b=s3owp/ldEzqNGpx5PEQtlSa9N9LQW/qR6pYPOvVO1YMRV118qwt+6E8+ZfIXvx1vy3
 6rb9Lh0OomjFzQK25e6NRgR29U0qA9i1rb4vV4fyBKz3mX0Yj1F4Tf6qHPdkiA/d1l0y
 2Ohvn2d1rNuqvDbd4D3DtoLkzOYi7QalkFYVJRbukTyKxB4l9fIxlEIJyOhfOuEiNN5X
 7ARs+lYPeRwHFQzeFmyPDdsiQFmTJcvbS8GNUJ58zBEn1c8h3bqNhAJMFO5Bv8iMrtc2
 QXARWTPXaU6FC8pLWYwdFe76aDRgss5on+IXly3ft9CfVn9huDgKpoayEBUWirCc1Vw1
 hLHw==
X-Gm-Message-State: APjAAAWK8ck0Kii1PT1D60MkXtVJKfIqvHj/CXim6/NcxVdehXNZudhU
 lzP8Ab8zid9xjW5/hBe7YWpRcjtKxisRlfVmw0C/mg==
X-Google-Smtp-Source: APXvYqwTEs0TXLg+Y9KN1LSZ7g7ly19CRMffOhO7e8e4HHml/6cDYR6bH9s2YdOlfMGLddxa8lx0sqJHYZVTLpNjaAw=
X-Received: by 2002:a92:af99:: with SMTP id v25mr5291400ill.167.1572513784923; 
 Thu, 31 Oct 2019 02:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191031052159.4125031-1-jhubbard@nvidia.com>
In-Reply-To: <20191031052159.4125031-1-jhubbard@nvidia.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 31 Oct 2019 14:52:53 +0530
Message-ID: <CAKohpomBZPYyX_u2xSzE4UenR0s3eFo5SOmDZ=4NLVcD_pA5iQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: powernv: fix stack bloat and hard limit on
 num cpus
To: John Hubbard <jhubbard@nvidia.com>
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
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 31 Oct 2019 at 10:52, John Hubbard <jhubbard@nvidia.com> wrote:
>
> The following build warning occurred on powerpc 64-bit builds:
>
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of
> 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> This is with a cross-compiler based on gcc 8.1.0, which I got from:
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/
>
> The warning is due to putting 1024 bytes on the stack:
>
>     unsigned int chip[256];
>
> ...and it's also undesirable to have a hard limit on the number of
> CPUs here.
>
> Fix both problems by dynamically allocating based on num_possible_cpus,
> as recommended by Michael Ellerman.
>
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
