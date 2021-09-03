Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F1C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 07:03:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F1860F9C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 07:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62F1860F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H17zW6Gylz2yp5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=PRH/6+LL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=PRH/6+LL; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H17ym2fXSz2xYJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Sep 2021 17:02:22 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id j1so3052599pjv.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Sep 2021 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=tX5qYs0dETvoqBWPP8HUyqwljyhj3JImYoPGL2w/Zd8=;
 b=PRH/6+LLhOSqbVBzSZru0205gmu8g6INkPK22GFwFBSTnWVCfPw+AC61/LaLUG1DH4
 47VkeuctfiFS7/CZVN4Pb0VyuyUekqKBRstv8iJMmLG3FBMr26b+4/w/4YwR+h1D+z9i
 gF2+KtIF/ynk9pbTb2ELc3RSH2aOSMP0rm+cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=tX5qYs0dETvoqBWPP8HUyqwljyhj3JImYoPGL2w/Zd8=;
 b=ZXSgN8tmbqBNDlGnmXJW7elNvOvvR0iya4bgJ+/Kf784JK/frc3q0PtqXuiwySHJhJ
 vPAs6BvC7tN34dU9uSfRU5Oxxoskxqd3WhEIUiC1el1wTlv2D2cqzYI9ndCH8rbGRuru
 xIiZuSZmZFJMqsuxRQGkGCjoLFRm/fo8rGVEavtMGZMBho7dfWkm4183UqJ3ZUCkw2+0
 3lpmBotx4HTpV008N/3LnSNdCCFGBXhxeGhcNfl3+A7CQI83w8dKI6yR06wyeZnjZOH3
 vn4LJQUeS8vzEOQzNUH1OUH5V4diDhUONT3d1r07Nd8F97fxqZ9485VRTtl76OG1Og2D
 cMdA==
X-Gm-Message-State: AOAM531xG47COz+EUxmGYMKGxDxBfKXJW+nCyVhEj67xmatCsBHPdzkx
 LvSDiixx+QzldOdKmNq3YOjshA==
X-Google-Smtp-Source: ABdhPJwsTOxyAZHH5DdU+UKyd/usnRPUaX8BNpHXz1U2nfu+DzPEh9rxZPDzBA+N0Zb2ucVYoZkdOA==
X-Received: by 2002:a17:902:848c:b029:12c:daf3:94f1 with SMTP id
 c12-20020a170902848cb029012cdaf394f1mr1865204plo.50.1630652540381; 
 Fri, 03 Sep 2021 00:02:20 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:ddd7:1b3:9327:fcf5])
 by smtp.gmail.com with ESMTPSA id v7sm4030673pjg.34.2021.09.03.00.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 00:02:19 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
In-Reply-To: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
References: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
Date: Fri, 03 Sep 2021 17:02:16 +1000
Message-ID: <87fsum5eh3.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
> decrementer and timebase") made generic_suspend_enable_irqs() and
> generic_suspend_disable_irqs() static.
>
> Fold them into their only caller.

This does what it says, and simplifies the code.
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
