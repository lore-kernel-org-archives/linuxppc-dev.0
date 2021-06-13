Return-Path: <SRS0=g+Gz=LH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E7C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jun 2021 18:54:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F3B61153
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jun 2021 18:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F3B61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G33f12wdPz308k
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 04:54:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JGOFEBDm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::12b;
 helo=mail-lf1-x12b.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=JGOFEBDm; 
 dkim-atps=neutral
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G33dT1rtRz2xZk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jun 2021 04:53:48 +1000 (AEST)
Received: by mail-lf1-x12b.google.com with SMTP id h4so2445053lfu.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jun 2021 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jIwBuaKEyUe8RPybEEGjfCPj/QP2GIowPZPUUKF9Zo4=;
 b=JGOFEBDm1r/vyu8Dznn4PgkQZZWr85EZTSQAnko+JKmdIrLZyXiN9aTqjDJtNxuUdV
 S7oHqQk+bVfMmj7VLfuc+USUe2nhB5mIYNWJDi0FjK5W6kohDOSsk1QcKhyW+Zu2ShV/
 lJvSJHD1xWrnsdeoPReSdGSt+vPCltoXOb+M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jIwBuaKEyUe8RPybEEGjfCPj/QP2GIowPZPUUKF9Zo4=;
 b=dqUal6sRjizSLsdrflTsPSEgdm65vL5AtdCyDAqTL0CBZaxulcszmeigMC+ThFQbJx
 YT2W+a8CgUfuzFK26WRURxw/zzQOk8SWNlDhWslbJoJpnD2FJEQUfa1Hk032KtF2EMWy
 Ndro5OueUCuYeTHSdxdumOUvRc+fwgqYu4t0mHwNOqCioejUHRdhe4lj2DDKZ3cVr42v
 g0cSScvMxSoj4geCt7qNeRjvhcic8yFC35FjFoloENfVPH/Wh1YkwxpT02Yh+/wJwe3P
 QdDfZx9rwTtBjIKjpLZjlU7jocKF8sbLrCbZmFDVqE/XSZdY9ra1o+6djkQSfZphqfaf
 oU1A==
X-Gm-Message-State: AOAM531U84dORd0Fj9NKWyV9H7SlmntVrK9Y+E8Qk+o8qxkN66392GIS
 0YcvdRYJqHkOlH7kTtLXC/AAqKwcxD9YlLV6
X-Google-Smtp-Source: ABdhPJyHaS03Nw/dQdXNIkdoKaIhVNim6uV6ZGSmy6WRNrWaetLggRT7M5SlAw54qSCPfrww/4V/NQ==
X-Received: by 2002:ac2:4899:: with SMTP id x25mr9901725lfc.372.1623610417564; 
 Sun, 13 Jun 2021 11:53:37 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id z139sm1354255lfc.150.2021.06.13.11.53.36
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Jun 2021 11:53:36 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id r198so17240276lff.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jun 2021 11:53:36 -0700 (PDT)
X-Received: by 2002:a05:6512:3d13:: with SMTP id
 d19mr9490584lfv.41.1623610415825; 
 Sun, 13 Jun 2021 11:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210610083549.386085-1-aneesh.kumar@linux.ibm.com>
 <20210610083549.386085-6-aneesh.kumar@linux.ibm.com>
 <CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com>
 <87wnqy9lru.fsf@linux.ibm.com>
In-Reply-To: <87wnqy9lru.fsf@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 13 Jun 2021 11:53:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+VM6meE26x+UegDdL_F3daMB_7HzA+16D10KYsBJwAQ@mail.gmail.com>
Message-ID: <CAHk-=wj+VM6meE26x+UegDdL_F3daMB_7HzA+16D10KYsBJwAQ@mail.gmail.com>
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

On Sun, Jun 13, 2021 at 2:06 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> IIUC the reason why we do have pmd_pgtable() is that pgtable_t type
> is arch dependent. On some architecture it is pte_t * and on the other
> struct page *. The reason being highmem and level 4 page table can
> be located in highmem.

Honestly, the same confusion is real - in a different way - about
pud_page_vaddr().

I really hate that function.

Just grep for the uses, and the definitions, to see what I mean. It's crazy.

I'm perfectly happy not having a "pud_pagetable()" function, but that
cast on pud_page_vaddr() is indicative of real problems.

One solution might be to just say "pud_page_vaddr()" must return a "pmd_t *".

I think it's what all the users actually want anyway.

              Linus
