Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A788C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 16:09:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C485A2083E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q8J93Ot9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C485A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444zvH4bkyzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 03:09:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::942; helo=mail-ua1-x942.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q8J93Ot9";
 dkim-atps=neutral
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com
 [IPv6:2607:f8b0:4864:20::942])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444zsV1FcZzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 03:08:11 +1100 (AEDT)
Received: by mail-ua1-x942.google.com with SMTP id z24so9713617ual.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hJ/Znfa+tWfWs5sYjJzu8xwLocgzM9WbK699cugU0DM=;
 b=Q8J93Ot9Q4iSYr2okdbQFyZXsFgWdsTcLa12hXOpRknmj23ITWX3UfP3w9Of8Q4NLm
 EUAtd+pdK4BUWlSaixTcyCbsbhKoE8tZcl55OHxMmukVUaYWvphgYKAaaH2ktpHhatUo
 f0RGL8BmPOba7zhd4FlSAdLtGZK+Nj7zGFGwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hJ/Znfa+tWfWs5sYjJzu8xwLocgzM9WbK699cugU0DM=;
 b=WJCEpClsPLa1yjkC8pnGzjofAis6vLlEsdHr6JB/i8UTjZZeKqNwNDVNWRiwSw7VF/
 lMLTJ63W4E7GWm8dKhmchznfj1TBwJinmvRUw0IkZpka8PsUqwDcYXcVVB8fKahqtMxH
 VvuZ1Pg3+1/8E6q4O3jTXVIOoC4fXf/lwcpsbGCVAlp+rCERbzwrqVssR2D0duzQwgy/
 /SzsmoUS9ymLcxJbyT6NyeO0ZUUg/UKMLmJq2DaY2+UIHTsVyl2tyQkw0tmvyQh7enuP
 hWlNOrudBGjEjbo0mQzYcxvKjCpISezB+kofL401UQ2QsAnkLWcF7IU0RJISoueEWMF9
 nBvA==
X-Gm-Message-State: AHQUAual4FmA+rIB/TjnMqE3B2LW+zEevgKPkXhn5ZWl4Z8XZpD1h3PJ
 BWjdUcqpeJDGcQQinD0vKDsS7re9d9k=
X-Google-Smtp-Source: AHgI3Iae7FeButtzBioWPbt2PN/uhvloE0hMwcx5NNunICA8SNiBnOVnbzHSjL1uVidR81PzykQg1g==
X-Received: by 2002:a67:7e49:: with SMTP id z70mr20234009vsc.26.1550765288170; 
 Thu, 21 Feb 2019 08:08:08 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53])
 by smtp.gmail.com with ESMTPSA id t133sm20460993vsc.8.2019.02.21.08.08.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 08:08:07 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id d21so9713808uap.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 08:08:06 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr22782177vsi.66.1550765286037; 
 Thu, 21 Feb 2019 08:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20190221093601.27920-1-ruscur@russell.cc>
In-Reply-To: <20190221093601.27920-1-ruscur@russell.cc>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 21 Feb 2019 08:07:54 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+P1wh0uf1kfMywSTo4NYtwFPSnKXg6wbfyBRqwVRZVYA@mail.gmail.com>
Message-ID: <CAGXu5j+P1wh0uf1kfMywSTo4NYtwFPSnKXg6wbfyBRqwVRZVYA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Kernel Userspace Protection for radix
To: Russell Currey <ruscur@russell.cc>
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Nick Piggin <npiggin@gmail.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 1:36 AM Russell Currey <ruscur@russell.cc> wrote:
> The first three patches of these series are from Christophe's work and are
> the bare minimum framework needed to implement the support for radix.
>
> In patch 3, I have removed from Christophe's patch my implementation of
> the 64-bit exception handling code, since we don't have an answer for
> making nested exceptions work yet.  This is mentioned in the final KUAP
> patch.  Regardless, this is still a significant security improvement
> and greatly narrows the attack surface.

Nice! Am I understanding correctly that with this series powerpc9 and
later, using radix, will pass the lkdtm tests for KUAP and KUEP (i.e.
EXEC_USERSPACE and ACCESS_USERSPACE)?

-- 
Kees Cook
