Return-Path: <SRS0=PqB2=LE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E7AC48BE0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 18:17:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7BF601FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 18:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7BF601FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1ByZ1Yr0z3c2P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 04:17:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=PRhBVpAT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::135;
 helo=mail-lf1-x135.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=PRhBVpAT; 
 dkim-atps=neutral
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1By36ZqKz308Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 04:16:41 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id a1so4617924lfr.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=03Gr3Txe0MZ46bais6LpruC3JkNhDTxLPGun+VaUFM4=;
 b=PRhBVpATsjtXy3Q3CA9nl/lfJ63QfNNGseJ4k6/xSMMwbeaisNbmVX0fu62mvFB/2p
 QjRwj0gYUL8Zs+GZDqpMDxvEWejsq4yRyNWzUdDbdSqOUWKH+X+XwUIUv4VfQOyQhy+5
 bPIHMsSYqeS567Z0t8ZIo2du7OUQHowUZJiWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=03Gr3Txe0MZ46bais6LpruC3JkNhDTxLPGun+VaUFM4=;
 b=hPqb12EK2mQWPHpuM3dErRtgc4Fitkv8QNNS814v1F4u7fxG1uGYfPTL5j1aR82hd2
 ZTbAvnIt7+XqQ0bEuw+6J5U38Es2ctPqjUDcw99otNVs6dwBVTuSXgUU/tNfoKt2gWNS
 iDwRynRvwmEz2o/ZJfbQ+LTV8HGA5i2g4dG1mv7qPTN6OexOBDiNaLX1EYJpEO/wHp57
 qdDm2wZZRwM8iKE/JaYro5kWSq8f1FG8fqXpyGHXKfY08BmHV4aCfUV95MAuhhtc2QRK
 QwNqf/Gq4c/KLCjRx9MsDHcAKYYKDezoM++dcHDeaA/2Zu6kcErwgCO3/CWXCcI0XR/S
 9sVw==
X-Gm-Message-State: AOAM531LDcQAmpXNbVPganHKQbsDczNJ0ref88/cr98nIoSmMCuCJjJk
 uju3+H88RyB9A3mxDeqP1oDr3WDpzpyRUJK7Aow=
X-Google-Smtp-Source: ABdhPJzUNxLtnDaQ9NiuVgZhcpcZi+Ffi/KjwKpjdDH/5yUKMxuDig7doc1rKSbToYyrDhTdE8Vocw==
X-Received: by 2002:a19:e008:: with SMTP id x8mr67049lfg.439.1623348992079;
 Thu, 10 Jun 2021 11:16:32 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178])
 by smtp.gmail.com with ESMTPSA id 9sm368067lfy.41.2021.06.10.11.16.28
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 11:16:29 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r16so6176288ljk.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 11:16:28 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id
 u17mr3156133lja.48.1623348988400; 
 Thu, 10 Jun 2021 11:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210610083549.386085-1-aneesh.kumar@linux.ibm.com>
 <20210610083549.386085-6-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210610083549.386085-6-aneesh.kumar@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jun 2021 11:16:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com>
Message-ID: <CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm/mremap: Use pmd/pud_poplulate to update page table
 entries
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Kalesh Singh <kaleshsingh@google.com>, Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 10, 2021 at 1:36 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> @@ -306,8 +306,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
>
>         VM_BUG_ON(!pud_none(*new_pud));
>
> -       /* Set the new pud */
> -       set_pud_at(mm, new_addr, new_pud, pud);
> +       pud_populate(mm, new_pud, (pmd_t *)pud_page_vaddr(pud));
>         flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
>         if (new_ptl != old_ptl)
>                 spin_unlock(new_ptl);

That "(pmd_t *)pud_page_vaddr(pud)" looks a bit odd and doesn't match
the pattern.

Should we perhaps have a wrapper for it? Maybe called "pud_pgtable()",
the same way we have pmd_pgtable()?

And that wrapper would be good to have a comment or two about what it
actually is. The same way that pmd_pgtable() should but doesn't ;(

            Linus
