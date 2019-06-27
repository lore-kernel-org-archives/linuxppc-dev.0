Return-Path: <SRS0=L8Yn=U2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17859C48BD7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 19:58:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1F62064A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 19:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fek+7sFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1F62064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZW0y0hL5zDqdT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 05:58:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="fek+7sFa"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZVw61NvxzDqkW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 05:54:14 +1000 (AEST)
Received: by mail-qk1-x744.google.com with SMTP id c70so2831477qkg.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2019 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=553rdQLJIBk30wNrf7KA331BGV1DmLK681B/LC9Sp6Y=;
 b=fek+7sFaz2NmgnMkjBf4hCVq2Os9rpMZyltUfaBER/PufqJ+vhmMRXpkbh5onlck3D
 OnSKQWKXouC6SGBgqGEcTQ90YxO4kSKK/itxFIaHBngafq5QLJ27kklLi6qN0KjN5wAj
 Xg8h4CM/PAL4s14HpEO7NXEP6NgrDRWYkADRT5Oqi+0kRwuidP/yhUzt9BqxCt7/fjTN
 NWOe/kKZXZx/CXO1fC1GUuL5vkAwuRHvZ4sDMnfWi6PAzRumsXoLx/nDmS4HD+nXk1aY
 CTiiL5IkQubsP26Nxn7vpnQU5Ztj43JlwNTQKuoklbaTF0TaS0l7hpZU7wPF1FUzlVas
 dwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=553rdQLJIBk30wNrf7KA331BGV1DmLK681B/LC9Sp6Y=;
 b=R2++pqQFkFm6HxQzDPLL/PKtAK0Ss5nexNfR7cKh1/oITN6OIQJn3a01GZX2CuOts/
 YD/SsVqDqvn8doCiaCR0xWUBp7LUK+0yadwcFdg9NGulF1hMd/WWaPOItwR12cA9P30M
 6yGsJLe1mgdgBEqKVQuRP+1uEZVapTXeGapHUnfo1FW1jNU9kDK+WTVyzbV2w1/V741u
 Il/FJN8yJmHqHCMK7rmoAxUEjmgxZVAqmw+rllsvmXU1rScznCgeclX4pvkyCNZKTJwT
 0ZY8tpjPQBD25RRxAanwCCuV4/CHwNwh5cPwA8B7r9/OO2u5ISGDi3sAsOEUKV4psydS
 jFfA==
X-Gm-Message-State: APjAAAUAjkIu1d+7HnkXooOG2htTICGfgITKh7y/nSBxKqgT6tm90+qx
 lyfQacGpZJ8cnbRaxRES1V+18Q==
X-Google-Smtp-Source: APXvYqwDJWwHslnijHUtTNbSVL2Ww4PFg66QvqhhwOJeHsLKrqPq5pAF3F9PqOAv4dV5OJeXtHs13A==
X-Received: by 2002:a05:620a:1443:: with SMTP id
 i3mr5242536qkl.11.1561665250370; 
 Thu, 27 Jun 2019 12:54:10 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id s11sm53481qte.49.2019.06.27.12.54.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 12:54:09 -0700 (PDT)
Message-ID: <1561665248.5154.91.camel@lca.pw>
Subject: Re: [PATCH] powerpc/cacheflush: fix variable set but not used
From: Qian Cai <cai@lca.pw>
To: mpe@ellerman.id.au
Date: Thu, 27 Jun 2019 15:54:08 -0400
In-Reply-To: <1559829493-28457-1-git-send-email-cai@lca.pw>
References: <1559829493-28457-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: akpm@linux-foundation.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ping.

On Thu, 2019-06-06 at 09:58 -0400, Qian Cai wrote:
> The powerpc's flush_cache_vmap() is defined as a macro and never use
> both of its arguments, so it will generate a compilation warning,
> 
> lib/ioremap.c: In function 'ioremap_page_range':
> lib/ioremap.c:203:16: warning: variable 'start' set but not used
> [-Wunused-but-set-variable]
> 
> Fix it by making it an inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/include/asm/cacheflush.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cacheflush.h
> b/arch/powerpc/include/asm/cacheflush.h
> index 74d60cfe8ce5..fd318f7c3eed 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -29,9 +29,12 @@
>   * not expect this type of fault. flush_cache_vmap is not exactly the right
>   * place to put this, but it seems to work well enough.
>   */
> -#define flush_cache_vmap(start, end)		do { asm
> volatile("ptesync" ::: "memory"); } while (0)
> +static inline void flush_cache_vmap(unsigned long start, unsigned long end)
> +{
> +	asm volatile("ptesync" ::: "memory");
> +}
>  #else
> -#define flush_cache_vmap(start, end)		do { } while (0)
> +static inline void flush_cache_vmap(unsigned long start, unsigned long end) {
> }
>  #endif
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
