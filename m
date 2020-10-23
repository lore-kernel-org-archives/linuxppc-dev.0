Return-Path: <SRS0=t5Sp=D6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22580C388F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:06:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFBF20882
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj60c/JJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFBF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CHwG04qpNzDqML
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 07:05:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b42;
 helo=mail-yb1-xb42.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Xj60c/JJ; dkim-atps=neutral
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CHwCf1ks6zDqNK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2020 07:03:41 +1100 (AEDT)
Received: by mail-yb1-xb42.google.com with SMTP id n142so2184340ybf.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2020 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8sL+bG1sqMHkQncq4Op9T7TZBeUfdZ7Ectn5rHvgjdY=;
 b=Xj60c/JJiEUDW/nQi3Zu+winDPCU+pFOwg1VSiH62tOwtrW0i290GH3JwGZoUHZtHx
 XEOVI9KFxHSDicwA4vd4noZJQ+so5tQXC0QJyXjTWr1ow/eTB4f5cmXelY1eRlb0gBIo
 ZqLoO4rDTAMJqkTWSgCrxVbJxNDPkMtHvkhAIP1XWzzJuOwZHWdLzg+QdmK5ya3OFtM+
 BwZIsRINJCFWoe+7Wa3TElK8sun3aT/up/nWATxpHQ76pVdK3tpxCiCJdUIhJpuBgzVT
 7YyoPAPskCWXzrVJvp3/+nZTacsRulzLpUSWSLojruskOlI8mKTl6TDU58lPZaIrYoxX
 q/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8sL+bG1sqMHkQncq4Op9T7TZBeUfdZ7Ectn5rHvgjdY=;
 b=qFqoSnpD5+458yRxT3K/QNyZMzIVlT5DfG4f95C+VqO1zXdq/eG8dL/cENGLeOTP/R
 pmJU0pGG8aH0iNyehp26bTsP/Rcezv2v/bz3tN5MsBXMEupEO6N7NauBXRArkbok5+u5
 TfrtYVAsUoFdJ/RTnzz69UrCVuuEIhhvkPiI+gDdW2mUf4kEwAyOZwsbBXo93OOZP8w6
 VjEOaTKPtTtILvxyC9tastt9Ncit7asBHyC2OocXLTKqGaYdWvvcFtEWX4+oPSSWeYHD
 7GxDWQsPB7RvOlD7IpE+HRv8t6bWDxkd0eTu9WvmGyPKd1C0WVZc0hT0nPIIHTPtA8Km
 dKPQ==
X-Gm-Message-State: AOAM531GersvowbP4K5iSEMxwJGhOSiPLarYgAC0e+oOnzdEqklfdJQ9
 8rnoA9A6NZQmIJjJ1BMeHnvBshSOQd8j4FOJLc0=
X-Google-Smtp-Source: ABdhPJz5KsCW+JmSszBCoUsaIbeELOddhzELtCYLQyx0ud6rdY/6qViPIMKZAHt7zz9Jqh/2BWGpqAnhIQcbfduu2Uc=
X-Received: by 2002:a25:ae97:: with SMTP id b23mr6341309ybj.26.1603483414252; 
 Fri, 23 Oct 2020 13:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com>
 <64b49cd3680f45808dad286b408e7b196c31ec79.camel@perches.com>
In-Reply-To: <64b49cd3680f45808dad286b408e7b196c31ec79.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Oct 2020 22:03:23 +0200
Message-ID: <CANiq72=AneP9=NBFpE2eFzqsYnQxEVjxHQQYSybBCeh6_vWHMg@mail.gmail.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
To: Joe Perches <joe@perches.com>
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
Cc: clang-built-linux <clang-built-linux@googlegroups.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 23, 2020 at 10:03 AM Joe Perches <joe@perches.com> wrote:
>
> Thanks Miguel, but IMO it doesn't need time in next.

You're welcome! It never hurts to keep things for a bit there.

> Applying it just before an rc1 minimizes conflicts.

There shouldn't be many conflicts after -rc1. The amount of changes is
reasonable too, so no need to apply the script directly. In any case,
if you prefer that Linus picks it up himself right away for this -rc1,
it looks good to me (with the caveat that it isn't tested):

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
