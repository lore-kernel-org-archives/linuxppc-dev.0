Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5317ACA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 18:45:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E9920856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 18:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WK/lVblA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E9920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473HTR2wZlzF4lc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 05:45:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="WK/lVblA";
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473HR71ldhzF4j8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 05:43:46 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id k10so740263pgm.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iL1b2/dZuwewbYecquyIQ6Ntyu37Tn/9b5T127ehj8U=;
 b=WK/lVblAh7BulbtEispzUnAVVHPJYdMhwReGBIqHEtusyFdsxppXUugyB5tQaE8qaj
 96ch8RuSFp/yAeFHMIrWO4RXU8/fNntKr1knCfRXvCSv1uBShRg4OkAbrEXPlnNY+XWb
 Pm6iG9ZRZp8DuzEXuvDj9m/1Ar6HfsRBMCGiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iL1b2/dZuwewbYecquyIQ6Ntyu37Tn/9b5T127ehj8U=;
 b=hBW9r2VQIvyFNY6zCsWQ5uox8OjrR30pLyzX09kc4HiPOubEGkKAm4858iM0XJapdw
 3WqzJ92kb36Jj6nPnynWG7qmgjL2JEMASUytn8lROqScy3rgEz8XQ1zbAYSmpD7sDJGy
 orV2y+ZfD1s3J4k45tieswR7UYZPy1keJucTsy/aMjFlOQMCXTrGBwjmf9bVjZZLbpaG
 SB5L8pq3AFL82iBfqZ2+LAOR9+uGJmOcvCwWtuz80H+p3O0mhSBUyA8UmU1ORUm4UxI9
 C6CvC/s6RXpRQ7YcSyj26GgqSK+kKk7UX3hCTwTFTMkj0wU+vJ5qt+wQnHH89pfX6/HZ
 2bew==
X-Gm-Message-State: APjAAAXn3E9gug33exaObWXQqGe7rfdiUk52lxxhkDAH0/h7bzUWQkT1
 aect+ydYmVxtWI+C/yQYDEyndg==
X-Google-Smtp-Source: APXvYqw5tNLHWw12J82IOIHnZ6DckC3H6m86Mqkez1zDPbawAcwK9ve9deD8ot/TTbSaihDt6cXKIA==
X-Received: by 2002:a63:fb4f:: with SMTP id w15mr859409pgj.403.1572461023577; 
 Wed, 30 Oct 2019 11:43:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id ck20sm2940451pjb.5.2019.10.30.11.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 11:43:42 -0700 (PDT)
Date: Wed, 30 Oct 2019 11:43:41 -0700
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 0/4] Implement STRICT_MODULE_RWX for powerpc
Message-ID: <201910301143.C54F8C15@keescook>
References: <20191014051320.158682-1-ruscur@russell.cc>
 <201910291601.F161FBBAB2@keescook>
 <87zhhjf5pl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhhjf5pl.fsf@mpe.ellerman.id.au>
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
Cc: ajd@linux.ibm.com, kernel-hardening@lists.openwall.com, npiggin@gmail.com,
 joel@jms.id.au, linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 30, 2019 at 11:16:22AM +1100, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Mon, Oct 14, 2019 at 04:13:16PM +1100, Russell Currey wrote:
> >> v3 cover letter here:
> >> https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198023.html
> >> 
> >> Only minimal changes since then:
> >> 
> >> - patch 2/4 commit message update thanks to Andrew Donnellan
> >> - patch 3/4 made neater thanks to Christophe Leroy
> >> - patch 3/4 updated Kconfig description thanks to Daniel Axtens
> >
> > I continue to be excited about this work. :) Is there anything holding
> > it back from landing in linux-next?
> 
> I had some concerns, which I stupidly posted in reply to v3:
> 
>   https://lore.kernel.org/linuxppc-dev/87pnio5fva.fsf@mpe.ellerman.id.au/

Ah-ha! Thanks; I missed that. :)

-- 
Kees Cook
