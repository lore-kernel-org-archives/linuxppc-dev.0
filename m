Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC3C47078
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 16:06:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CFB61104
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 16:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CFB61104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fms0T09gtz3c1D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 May 2021 02:06:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=G3iYeUln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::12e;
 helo=mail-lf1-x12e.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=G3iYeUln; 
 dkim-atps=neutral
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fmrzy4D32z2xYv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 May 2021 02:05:34 +1000 (AEST)
Received: by mail-lf1-x12e.google.com with SMTP id w33so22492549lfu.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dtlfB3jKZO3PrjflKCPyB/i4mJYyJi11nH+YNdsIumg=;
 b=G3iYeUln/SMVQdtoLyWBf9Ooe3OmWnICHMyL61f8J0P9p5P7wIRaopb+HJeHIp6zOi
 2pcL71aOT8vsZT2zeheavW/7IrRyCLToEtvCHLzjTA6PLJC51M1o519zv/J0ULvm+gMO
 wZD3jIXrMfwoz0fl73Qy1SjQSIrxtOKDbXf2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dtlfB3jKZO3PrjflKCPyB/i4mJYyJi11nH+YNdsIumg=;
 b=R1xSvrxw5dFDdHUnrv+olDGk9XkXooUJv0hlmnyFKYYna8G64qVYPD7Z07mvD7M//O
 9lSqIpMcqBcz8BW4Tulem6KAik8CLD7WNKX34Pjt+u6QR3EnKF3jTnP0sghBiIxhcncG
 eqAvj5zCWjiCPH+hbhjVatgKcj0QykGiQRtAM1W9anooNPtdFWyixxff0S5avewG7pLm
 IFULUSlz28fsVxTvltIRSPAgmljROIyyCdsUeGCsyfYIu5ic08zQZAfF7mHj20NeY9iW
 VhTbTCi0aT/sKGse/Q6t4dgU9MFjODDzVup/jWtae8x7T5Osd2Qp/zC/s0+BUsW4YtsP
 fHAw==
X-Gm-Message-State: AOAM531DUx9FsIxOhK4Hsi8oJVKHnTXN/go/3eSruAtdBnaFS/E3O+kz
 KndoMgWextJeRVq3h7gG0Pk8JI+ZqQw4zDXD
X-Google-Smtp-Source: ABdhPJyvwcV+CLxBvRee0li+899zeHzP1pFtjglzX2KvftHcRcNsNTP2TVGg1qh7l4rkwEze45Cdeg==
X-Received: by 2002:a19:c49:: with SMTP id 70mr2699685lfm.555.1621613129752;
 Fri, 21 May 2021 09:05:29 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id c7sm660318lfv.27.2021.05.21.09.05.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 09:05:28 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id m11so30469961lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 09:05:27 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id
 a11mr2612700lfs.377.1621613127369; 
 Fri, 21 May 2021 09:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210422054323.150993-1-aneesh.kumar@linux.ibm.com>
 <20210422054323.150993-8-aneesh.kumar@linux.ibm.com>
 <b3047082-fc82-b326-dbdb-835b88df78d0@linux.ibm.com>
 <2eafd7df-65fd-1e2c-90b6-d143557a1fdc@linux.ibm.com>
 <CAHk-=wjq8thag3uNv-2MMu75OgX5ybMon7gZDUHYwzeTwcZHoA@mail.gmail.com>
 <f676b053-bda4-a1f5-321e-f00fb3de8a40@linux.ibm.com>
 <CAHk-=wgXVR04eBNtxQfevontWnP6FDm+oj5vauQXP3S-huwbPw@mail.gmail.com>
 <5ea8fa4f-a5a2-7dc4-7958-23df6a2c1f3a@linux.ibm.com>
 <20210521152438.jczhe6nxnz5woxpl@revolver>
In-Reply-To: <20210521152438.jczhe6nxnz5woxpl@revolver>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 May 2021 06:05:11 -1000
X-Gmail-Original-Message-ID: <CAHk-=whOMg3jQCY23J9xzVWT9y--x3DRWd__Z8kiE-eoiK8oOg@mail.gmail.com>
Message-ID: <CAHk-=whOMg3jQCY23J9xzVWT9y--x3DRWd__Z8kiE-eoiK8oOg@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] mm/mremap: Move TLB flush outside page table lock
To: Liam Howlett <liam.howlett@oracle.com>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Kalesh Singh <kaleshsingh@google.com>, Joel Fernandes <joel@joelfernandes.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 21, 2021 at 5:25 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> mremap holds the mmap_sem in write mode as well, doesn't it?  How is the user thread
> getting the new location?

No amount of locking protects against the HW page table walker (or,
indeed, software ones, but they are irrelevant).

And an attacker _knows_ the new address, because that's who would be
doing the mremap() in the first place - to trigger this bug.

             Linus
