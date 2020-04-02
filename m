Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A7C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 07:57:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B3F20719
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 07:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="To/PTKyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B3F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tFln33jFzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 18:57:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=To/PTKyA; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tFd53cc4zDrN1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2020 18:51:30 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id q16so3073369pje.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=owhhf3a9xckUQID1JH+AKO8BSZ4NJugRxsKf3U+q8a4=;
 b=To/PTKyAFWucW5+IMeI2yi98pK//fDkr9nURGXPB17w0/PjgZQutmOJPXBxJS6aOyb
 JYGBNOdjcAr9HZAqhAdyZOIdT5Tivgr6CUdMbwXIijjZrQWlDNDrUNWj90OmRbf+aa/R
 kx8ivj8JL7Zxeosa4D/msz2M4hZMX1zrEuhV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=owhhf3a9xckUQID1JH+AKO8BSZ4NJugRxsKf3U+q8a4=;
 b=kCErwzGWwDsDgVPTRBoETBBQuvqy4shu1GX+IYDi2uD/lLwdBnl9IkuvVwFkNNOtEJ
 XSIEs6Gh8NgaWjUXP6dqCfH9VjtRuKCfnYWFDAtFX9H70MTi/znWOd8tYZLYN7cpEYMY
 hJYLDysb+XB1F44elXLQVEtr+UiVIEm83pRxEqPxVnJOkSrYPxOkYcFeX3Si/zROh6mr
 qiS6hfFYsnfDaIFjS4nw38Xurp2Yk4R2FyH3phzNF+V5IQe5iC8rAfF5LKqs0dmSy6GF
 75JKFdnv5xR4Nrhowt3mF2mG5CEzz9LApfTl1TwlJm2etgrQTmyw8vDHpfBtYCfpRfXW
 UpZA==
X-Gm-Message-State: AGi0PuYPfoAVNQRIPuI4keDGcW/EbBdn4/hMGzzOUsM4eLpV9sPWxrqu
 /olVs53AkEsQD8JOBc0pCybtBg==
X-Google-Smtp-Source: APiQypIfH5wxyPKEeGYBq6xLBeIa4cScD3yEDdZlF7pyVXcqSyqcGnUNxxgPH/tPwVIGmLIypwE60A==
X-Received: by 2002:a17:90a:228c:: with SMTP id
 s12mr2380534pjc.68.1585813888074; 
 Thu, 02 Apr 2020 00:51:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id 71sm3162361pfv.8.2020.04.02.00.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 00:51:27 -0700 (PDT)
Date: Thu, 2 Apr 2020 00:51:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH RESEND 2/4] uaccess: Selectively open read or write user
 access
Message-ID: <202004020047.401CEBED2@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <25040ad2d2a2cef45a2442b0e934141987e11b71.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25040ad2d2a2cef45a2442b0e934141987e11b71.1585811416.git.christophe.leroy@c-s.fr>
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
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, airlied@linux.ie,
 hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, viro@zeniv.linux.org.uk, daniel@ffwll.ch,
 akpm@linux-foundation.org, torvalds@linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 02, 2020 at 07:34:17AM +0000, Christophe Leroy wrote:
> [...]
> diff --git a/kernel/compat.c b/kernel/compat.c
> index 843dd17e6078..705ca7e418c6 100644
> --- a/kernel/compat.c
> +++ b/kernel/compat.c
> @@ -199,7 +199,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!user_access_begin(umask, bitmap_size / 8))
> +	if (!user_write_access_begin(umask, bitmap_size / 8))

This looks mismatched: should be user_read_access_begin()?

>  		return -EFAULT;
>  
>  	while (nr_compat_longs > 1) {
> @@ -211,11 +211,11 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	}
>  	if (nr_compat_longs)
>  		unsafe_get_user(*mask, umask++, Efault);
> -	user_access_end();
> +	user_read_access_end();
>  	return 0;
>  
>  Efault:
> -	user_access_end();
> +	user_read_access_end();
>  	return -EFAULT;
>  }

(These correctly end read access.)

>  
> @@ -228,7 +228,7 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!user_access_begin(umask, bitmap_size / 8))
> +	if (!user_read_access_begin(umask, bitmap_size / 8))

And ..._write_... here?

>  		return -EFAULT;
>  
>  	while (nr_compat_longs > 1) {
> @@ -239,10 +239,10 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	}
>  	if (nr_compat_longs)
>  		unsafe_put_user((compat_ulong_t)*mask, umask++, Efault);
> -	user_access_end();
> +	user_write_access_end();
>  	return 0;
>  Efault:
> -	user_access_end();
> +	user_write_access_end();
>  	return -EFAULT;
>  }

(These correctly end write access.)


All the others look correct. With the above fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
