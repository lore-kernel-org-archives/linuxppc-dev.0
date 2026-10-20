Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F33606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdtgPDvb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8JXh3KjSz2xwd;
	Wed, 21 Oct 2026 03:59:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792515540;
	cv=pass; b=eTLzKiyr+adPguGF1s7lOhDy5+v2VEWrEPJ4D2GbHNi7CUWMTAB0CSeLjhgdTJv4HLP/nyoSphXvpxzFAHOlctdtJ9TJgwSzB7IfxNLgxXa+9jTgZt1AgPVPSVS+c/T0M+4jP4yT53xfslVK1L2ySYmFhwCzToai4siACKGuRlIuYByJURHZRbW3hN2wNNf0SfZeLkk7rTrGLvNwtj9qzEZOisvtBIYScB/bqY+ARF4dwxJ4L2e80FrVvmvk0+kbOMPdTanrl/Rz2Brj4JWC/5qhRLk0W/6HQI+G2biqBDOA6ghXUnI4EbE5ow1soI3S7vcbHbRk2ce9S7BbqrSeew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792515540; c=relaxed/relaxed;
	bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6jpAVSE7ol/S7LPYlZFVWcwpmbKesD5NsagT3KRZZI9WKwowBufVRw9s1pe/0fktA/5TPUGf76GiH/qxx31+FF6q4/ryXcRkstiAry8R4b6Bw02znd566Lu2aLh4+R9I2z5+Tfj7PqqfpuW63DtN93Ta/078a1zzymgY71FxVTgOXDsL/vPQxPFjZyqHfUq53hwI6GKvBwC0BI5DIf339jyKsClCm8EQWVyZBCzd5Y4OU0iwYH/kR3X0e1OZtLqWJJTOL8ivNSDrgFowxAuJduiUUWxo80HpmCj48twNZZLFqjIKC9HQs6+GajQzy6rCvUku9TzsgCcDjCQI8EA5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdtgPDvb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PdtgPDvb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8JXf4B66z2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 03:58:57 +1100 (AEDT)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-66c54dc3a91so461438d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 09:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515535; cv=none;
        d=google.com; s=arc-20260327;
        b=s76dHgibR5jG1/wLF3HwfSlQFVG8ZX8icptMA565D0/gcnHKhnf5HDqX06NbmMBwa8
         NZt4q6scjptgJOU1SFGmskvbD5+xvw1EouP3EYFc2tHeGq7h3KivaJR3GjBgSLpa8Ch1
         WtSmbcaI49MVzIJweZHoS3Pe40PTXp44BI1SCvE11Am6fY/cLNgp4rWPnM0ZpyEYzRX+
         3SsCSTy0MP+nKepA0YH29ifOM0BIU2blW+kHSK0puHs/uS7T2Hbdm+wsJZe3Bj5G/WCG
         W5k85QBnZyNzHTvLtt/xkMzXG2Xpp//+FRL6y1uHdgNiAKnZa1VrTydzq4xi8yTM9Qcs
         FqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        fh=SsB4JNcF2Zn3U1zT2d6vx+vnPE4mRGiMtNPl28Wmyu8=;
        b=FPeIQlMEyTnSwRvzONrMK7SW/aREI0MXuwynyXyQdIaaUGIH7rMFg+Hbi8w5J+S2Yq
         Oqv76hXCLd281MpWcNMZq4eravLsRFL5xZVVJveBJSTLE250NdplejdRtKBRxXV4NE1m
         /ileE9ry+kkdzhYXvPnfggr5d1mpHRgc7HVvOXNUDzl+xzL2FCK4oYoTKrGEV6oCRHpS
         BR2VVEb3xa6lx4ADJWEwqJrLV8EO/ChKqwhywTL/4mpvOQ5tkcwo9IX8y0uvt5XtZEGX
         IQRntPmzyYoXzeQRMegL46XXKUuuSML0+hScHdxRMG+UwrNKkFLvfQoBxmsEiHWpjVnh
         biUA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515535; x=1793120335; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        b=PdtgPDvbLD1wxib2wuxTwnJb5//Ne+WBdF6mzDitLUYL7doD1suPXUvLYudO87zUu8
         yYiIWlJHpYvqqXo9eHAbiYEP1w2KseS5cHNbXVunHnvslcPSQBi/wcmGzHxThYDowVfV
         1MyT8yuDO5Qt8UxFgVvPopzz0vwRMIOICGOZD6gkDot+LZ/fJtwQxxzA75Sj42eackAZ
         oI6Sx9/R/hxx1/daVJtou+Kc/WlpuWbFyftWxECfsz0O7TWAfGqe/BfAcOPdxxWXGp9m
         NwGKP3YC6BYtMz5JJ1MZ+oZxrnVEN+kk6on5nOvD++EbeklNW1gb1DWYf9OxPEQp9GCZ
         RkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515535; x=1793120335;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        b=vWFV52GhvRdAKxa6ZO9Nc1zFL37uw1p0C4e2G6j92Xz+dhabhQtjYc2Cooi3ns7OLG
         Jv0tcGzwCfikr6mpFZ82J4PjdbGmTwb/fXFoNXtv2+FRX/YO5r6eVdUzgFwscwiBM/j8
         ntpKoEPztkMUX3WYsyBgkRzrQFy535ublSa/HbRjubuiDNYoPotu5a8lp6bBbEG6pWoP
         g+rlTl2m2skHJKWLQT2t9VmhfcPFkoulIsxVm/vTKzgX/FzqIJ6XLQaUhF52W3gpfWuk
         faLxTafrz8rC3LlLn9DcU9NoOfRRWtIEtETfKwDWIZ+n+eIj7CjrMO2kjgNKoZGJs+Rw
         U62g==
X-Forwarded-Encrypted: i=1; AKwUvBwZxJeBesI6PQqXM7p+DWx5yhtZgxaabWetJXFTdmT3xkuOejKPkZoMXk6G9b35psNXV5ga40KgGjzDdBQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ6N49T7ZySFLvJJppMf8vdRqyI2sOgLDQK6Xp6lMbgUtzR9/xD
	2uuwYUYofuB2FVORn9KwmcC0qwZDHxzqBxMhXHOjYP80/c052nAoT97NC2ooevpB9lotOUbJfAR
	VQBQcqszEeyJZcXlVEJRa16hq5wORtwo=
X-Gm-Gg: AYBFou2yS2sTzyxYJ4NVaagUMJL1hgW7cnP1a+JDT3S5D/zGiPfRP7FZO7CTF0BrfS/
	Rk+W4U8O3hvzMqb7qjElSmR0vpEA5hCJjA4Bosg0y8wPtdRA+fJTHqTPsGllpAdGEmQZZ2QRA0F
	ZDFBt23JGZd5XQaYJN2rlNUXi9sLJncTy2+UUCzOdxVFPW7yRT6pnK1sECz73fO59CN3Gr3rKse
	2xiht6EN5CZKYETWcE6h8J66U/tELCA/oeX0yHvMZo25EkFsZ7ADjilDacOh6CCHybY+ScnY0Qf
	6ZBudLiPxPBk6XJNUiaug+5QRdcPRoIWKoTq3QrUBZXc1Ft9GwyRgQ==
X-Received: by 2002:a05:690e:138a:b0:679:b8df:29c with SMTP id
 956f58d0204a3-679ca54432bmr6769731d50.2.1792515534972; Tue, 20 Oct 2026
 09:58:54 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 12:58:54 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 12:58:54 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 12:58:54 -0400
X-Gm-Features: AclHuK_J27k-o8Ui6g8e3q8L_DReW_3vhUszXOZ3Ua6MjDZ1MkwzX1wkuw839aA
Message-ID: <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qiliang Yuan <odys.yuan@gmail.com> writes:

>
> diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
> index 5023f98d8293d..f672aad2e30e6 100644
> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h
> @@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
>
>  /*
> @@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>  	unsigned long ret, tmp;
>
> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */

Why it's open-coded ?

> +	kasan_check_read(addr, 1);
> +	kcsan_check_read(addr, 1);
> +
>  	/* Load word from unaligned pointer addr */
>  	asm(
>  	"1:	ldr	%0, [%2]\n"

