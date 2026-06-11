Return-Path: <linuxppc-dev+bounces-22446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6186BCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:00:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbS7h4PjWz2xll;
	Thu, 11 Jun 2026 13:00:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781146832;
	cv=none; b=U8zQoPoLGgwvuyROMOHvA8SlfLGzrMPOvbIqjglufRRBq2Xd5XA7zbl8FuTC+bFBnwFjdTXGxtqEOTdas2GTBTfFuDhTGDV7DRzrB8QRSRILmI+Qyr5vOvZ0INMPNZGqe3wo0/galvrPwgPrITRJlrGbM3MD5vhzoQzl/U7hkghZ3E2g/hMTmBRcfjPNOH2Nk5wPrTA6W9jIXSfJBuOCbUECul8RUJWW02Ax0GWuvOmMlrdlB+cJcftuJ0tShVOtlBqXVbQEUVmchxLiSV2KKxVN+toMsSKB+evsBzPT2ARtZIC1HH5+yUwdd70fChyGZmDbX2GVIvGLR1bqZPKjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781146832; c=relaxed/relaxed;
	bh=Pa2td8JJrEnqwMk5Z5fBZlq/pLvJPJzsyqnI7UNfNGs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=MD/UkTRn8Q4iIutZfKVSM7VCeu0Wxpw5vuDpW0nxXmw6MIhLlIrP6n2ekOwJebOZnpn+n52gn3b3+NUsaTaSd/EXsPnK1L2LnIRbEEs0kbaC7vG6vwZ7Hc+Ql1ELUeGfxXDCmu6JKlM73TKY0p2KZYYNseFKtUQAteb88p8XiDFPO0QFz8Lb2ZqV0KMa70uJRWvCdVekQqBCGKPcwnmD5KAkTkhMkjE+tHeuxXWBR59cMNGMS08MPCWD7LdkBt/Q+ZNKuoVs5DIvzY+iopLd/Td32SicW2X+2eeFIrNpDIbq1GSWwLWLAvxSoFgtP7F6ehpmIf1SAHBydDMYTcGLrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UX6OcPh2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UX6OcPh2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbS7g0r76z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:00:30 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84236f9b638so3565974b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146823; x=1781751623; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pa2td8JJrEnqwMk5Z5fBZlq/pLvJPJzsyqnI7UNfNGs=;
        b=UX6OcPh200uKjlcD9BoVwwqHKrni3KPPUNVspx+0P/4DSVuQyTh71Yg0Iv7i+wMkod
         z6lrjAOVKD62sTCV5jm8HVUZtsQVQD3oGgk6747RqzGjJbOnaZGkd/VRAxtJvuyLGJXZ
         QrwYAl0tFcDlABFCKPDl/ShVr/TxZVmknrHaS9tvck6whr1A2kzd0/C7QTYhupZTt5Jf
         yNSmlDiqlFsLQ7IdLs0iIMh9AO0wenlGznw7d6idMTkREKcSz/wzQxrJAdOq/cZAkrJA
         8qFmszNAq5gG4ApFA1PuSCY1tgFsW0cTR1u9N5jA6lOW+URukcx6obPHQvjNRiHd3EHA
         89fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146823; x=1781751623;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pa2td8JJrEnqwMk5Z5fBZlq/pLvJPJzsyqnI7UNfNGs=;
        b=PV/BvZ5Dk4Qre+ketghRVJL6b2uoIOmdMLqzjmgSstIpIvclEqu31aAKRRInxnjZ0o
         eEHJZLoHWrxhwXr1UDGdU+CJs2+r8YNt+viOr4v63OWMS+CHr8c0Br9PgMLA6ZXpg16h
         r4dmmRn520azexSf1E/Y1qw5npemHBY5qnmRE9hZHj6iaHdt1hQmzrOKPA/g7/7dM3A2
         NmihLur5PwcO8EZ8d/QrgVvbehDwF5Vfiud8jVjFdvQKizP0S9BKb+w9/ezgqzMttFoy
         ksMbk/Z50JeIexSeaebhPzDPJ0PQczTdIrh/cgOKlM/08u88hUhAnfF6em8AS8uc0L5P
         ucWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aPgxYuF+2LTwghVHR+7Aw4pLX6kYsaH7M3LvsNWKuWd3gx2fZO2HtWilTR/b7J05yvRD0U1ep673ABdk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpAKnoVZ8ErrqgoSq9wxF0iPvW5TMdphSyRzWE37y7mQEYQ2RA
	TBP6p8mdBM08AgbYF1vYhTMgYD+RZvaqYJ+k/AZmC/UZXA3A3k3rhHcX
X-Gm-Gg: Acq92OGgul9rcCBpIPTvCZqnE5N5XQz0iaqnf8nKhnVImI5SLXeAmnJ7iHiGyGY4Pmn
	2miYFfW2oV8AfiKzAwH0NPqaA6AEehmKg+J8UBYZnwpszLVif/Jjk3NfaTjIMfVtBL8qa1S2Qo0
	Wpfp4fjAT7UaJWBfapAhfe/ZKEiX/Lz1gOLX10MFAMx1c62g5L1gCumNYtg1PhBh56DDEsuJEqW
	gSTMfsWTGVUMFurJLhhkiDPiIJuSNASt2Rf++QuPPiRDeoChY17zRjG9Nf25ZJ3V7Q9Gvw7xaWk
	PVJoEBCRQjyzDj2ppEnypt4GZWXQL7p9NmT8MbcoxbAGHnt5/YdbNJGBWpV1aJ4rEKn4dgDm74a
	Vb9iGxUjNDla31LCrS58Ldd/hqSqQJAvI5ajxfD8vtw7dYpTfVynkvzCg6SNy4P+SoDfnWwn19j
	BHZ0zbjKFDTiQzU1N4OfB6RbErlCOk6eRo
X-Received: by 2002:a05:6a00:390b:b0:837:a211:4ee2 with SMTP id d2e1a72fcca58-84336df7ea7mr788008b3a.38.1781146818735;
        Wed, 10 Jun 2026 20:00:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843380c96a5sm247895b3a.38.2026.06.10.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:00:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [RFC 1/4] include/linux/swap.h: Remove unused leftovers
In-Reply-To: <CAGsJ_4zFi78j5hz4=B7-25y__zOi70pzsA4c+BN3weyJW+gpHQ@mail.gmail.com>
Date: Thu, 11 Jun 2026 08:27:35 +0530
Message-ID: <mrx1eqcg.ritesh.list@gmail.com>
References: <cover.1781000840.git.ritesh.list@gmail.com> <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com> <CAKEwX=NCB6yrf4Dc0yU_CwZWi0Kk3tBup7yvP7EUz2k7_CR2RA@mail.gmail.com> <CAGsJ_4zFi78j5hz4=B7-25y__zOi70pzsA4c+BN3weyJW+gpHQ@mail.gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Barry Song <baohua@kernel.org> writes:

> On Thu, Jun 11, 2026 at 12:41 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Tue, Jun 9, 2026 at 6:20 AM Ritesh Harjani (IBM)
>> <ritesh.list@gmail.com> wrote:
>> >
>> > This removed unused leftovers most of them are forward structure
>> > declarations. Also removes SWAP_BATCH macro which isn't used any
>> > where in the code.
>> >
>> > Found these during manual code review.
>> >
>> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> > ---
>> >  include/linux/swap.h | 7 -------
>> >  1 file changed, 7 deletions(-)
>>
>> Seems like this can be submitted independently of this patch series right?
>
> +1
>
> Applied the patch and built the kernel. It seems to work.
> Feel free to add:
> Reviewed-by: Barry Song <baohua@kernel.org>

Sure thanks Nhat & Barry. Yes, this patch can be picked up separately
and it should not cause any conflict with the rest of the patch series
either.

Let me split it and will send this one out separately with Barry's RB
tag.

-ritesh

