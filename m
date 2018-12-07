Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083C6C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:47:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CD72082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZZVrDpHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CD72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BM0r3YYWzDrDN
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 05:47:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="ZZVrDpHf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sifive.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=palmer@sifive.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=sifive.com header.i=@sifive.com header.b="ZZVrDpHf"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BLxm575vzF0PS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 05:45:15 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y4so2074628pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=klopY/IsuJEDowTc4qrt4dyez0fGpBDt1xs5/j2mVbY=;
 b=ZZVrDpHfZs52iuETgv3m44IeOtThlIBsuU8+93Vxx7aBcyIR3CfRT2lS31h8wJewmV
 Tki/oz/jT6A7N4MGx481OP3Ps6TfITealhGoP+JTLC5p3O6m82JGXuTjm4MWJPiDDJCd
 9EM9eqL6VYHHdGU1Bbtl+2lYmINTz3fkchPJj6pBGjTeh2ZntnCGYTTqejWBvjffftmA
 toRKjgdsx+CHfywJWPgM5ghK05Brr0Nyal9TZfyhadDDwN7cBZzDrkwfdK203vs0gGwr
 AjaKi368ZuHFSEclC49QQ0orgjY0eyXcBcs8mUkDr49hFKBs8OxYP3kz6S111fXbWDUC
 Z4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=klopY/IsuJEDowTc4qrt4dyez0fGpBDt1xs5/j2mVbY=;
 b=f3n5usjS763pGcCiRhWp7Pr906aaheykktbXXMs7yTZUSf5kcr3l9WtiylANDUdOzX
 UdikF8iTqz7E251iG0wxdReMDSBrGgJr5ph53oUZ4K9urbgBtJldxC2y5AyoEM/a5FGe
 ZvCw4qQqxcJFYRA63ddPeaKVBiN7uc2KCUhOWEtxQ+ImaNQXZnaxZRkC/E+csNqGDONL
 1jI92MUrsx5hC/ZFXpvF5dJ49Kc7Nmiq9PWpeKhLHuQgaLKugQKOANu0PQ3Ez7gr34jy
 1vc9rAjWOQM3TUzIc2aK0HTIDCPGMY3iPrbbZMzz7VtBcWIiFiYIu2TWBQsB5Vm2EUq3
 w3ug==
X-Gm-Message-State: AA+aEWaV134/FehHCDeJSrEWrzeocYepEtMmGG0GbN6HQBNTpNvn6aW0
 AUORNwPeMdCNFdrnZ1d5+5IC5g==
X-Google-Smtp-Source: AFSGD/XwDgPF73po7jcMK0WLUnbQk9jaegnMO7Qp7EVNMCgsiulHRkkPkb3v6ey4N4xdmNlmrKTYkg==
X-Received: by 2002:a63:f515:: with SMTP id w21mr2938694pgh.220.1544208313756; 
 Fri, 07 Dec 2018 10:45:13 -0800 (PST)
Received: from localhost ([216.3.10.7])
 by smtp.gmail.com with ESMTPSA id y89sm6257168pfa.136.2018.12.07.10.45.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 10:45:13 -0800 (PST)
Date: Fri, 07 Dec 2018 10:45:13 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:44:39 PST (-0800)
Subject: Re: [PATCH RFC 4/7] riscv/vdso: don't clear PG_reserved
In-Reply-To: <20181205122851.5891-5-david@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: david@redhat.com
Message-ID: <mhng-3e6b4869-d5d7-42f4-a9d8-789a6772f52a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linux-s390@vger.kernel.org, aou@eecs.berkeley.edu,
 akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 tklauser@distanz.ch, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 05 Dec 2018 04:28:48 PST (-0800), david@redhat.com wrote:
> The VDSO is part of the kernel image and therefore the struct pages are
> marked as reserved during boot.
>
> As we install a special mapping, the actual struct pages will never be
> exposed to MM via the page tables. We can therefore leave the pages
> marked as reserved.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/riscv/kernel/vdso.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 582cb153eb24..0cd044122234 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -54,7 +54,6 @@ static int __init vdso_init(void)
>  		struct page *pg;
>
>  		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
> -		ClearPageReserved(pg);
>  		vdso_pagelist[i] = pg;
>  	}
>  	vdso_pagelist[i] = virt_to_page(vdso_data);

I'm going to assume this will go in through another tree along with the rest of 
the set assuming everyone else is happy with it.

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
