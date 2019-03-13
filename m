Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1095C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 13:26:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AE92070D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 13:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AE92070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KCKt0j4JzDqLj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 00:26:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KCHw0d8szDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 00:25:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44KCHv5sz6z8wQV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 00:24:59 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44KCHv5WrNz9s9h; Thu, 14 Mar 2019 00:24:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44KCHv182Wz9s71
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2019 00:24:56 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id s26so1028834qkm.10
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2019 06:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ZeJ3NNaRP26nEXpWMX7nvnHeisnf3Hy47e8EtFPvvU=;
 b=UMQ94BsDkRlmzl/2x0n1jY07/UsBSqHs1rNZjw+GjO+9AWPX7i2PWjEhWYAsk3LsnE
 WQV/Z8J9STITvEzT09DRbFk00L3+kO5SXMRqaN0VzqakbrVCzBHbZnlfQBjX06YUTHlh
 0v2qN7Pyckufq0rVCD6eexQTD6q06QTq774FiXyydWmgDHZuXpxBLmt5Q7B0VuZqWP5i
 LGQRCpqyR5mwqVTx5a0VwTHvn58Sg8xCA/yKFwrApBWVmh9rdNT7BXzOQ/n4uZ4J48V4
 Lp/NqTH8cBRcPrZ3vGm/qE/WXAusQYKXsujSoNdzHCDqc7o4ynfvRUOxa2DyS5WDC39f
 /5dg==
X-Gm-Message-State: APjAAAX64gu9cjOtDQ5uftBgeQIl/Us1fAfMTzYTgDLmxVJTwZe0VQb9
 6Ix0GKq2uo+T8EEKKj4Mwkn5oWC7rvqMUQO4koU=
X-Google-Smtp-Source: APXvYqyEb/kYJ238BSFaBG5LGlhQem8Nym0+CkaPGjskctag+4Cqeo0Y2qKg2UNe/n2DFN82sjOSFKiJEKIOcErn7/Q=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr33122517qki.291.1552483494186; 
 Wed, 13 Mar 2019 06:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190313131438.8212-1-mpe@ellerman.id.au>
In-Reply-To: <20190313131438.8212-1-mpe@ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Mar 2019 14:24:35 +0100
Message-ID: <CAK8P3a0A9dbneHo7_CrgiPS8ROaV1bWrYWJUh5Zo2FfEuABfhw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies
 across Y2038
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, John Stultz <john.stultz@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, jaydee@email.cz
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 13, 2019 at 2:14 PM Michael Ellerman <mpe@ellerman.id.au> wrote:

> That causes CLOCK_MONOTONIC to jump ahead by ~4 billion seconds which
> it is not meant to do. Worse, if the time is then set back before the
> Y2038 boundary CLOCK_MONOTONIC will jump backward.
>
> We can fix it simply by storing the full 64-bit offset in the
> vdso_data, and using that in the VDSO assembly code. We also shuffle
> some of the fields in vdso_data to avoid creating a hole.

I see nothing wrong with your patch, but I would point out that there is
a patch series [1] from Vincenzo Frascino to unify the vdso implementation
across architectures that I hope can make it into linux-5.2, and that will
resolve this issue, as well as allow 32-bit architectures to provide
a working interface with 64-bit time_t.

      Arnd

[1] https://lore.kernel.org/linux-arm-kernel/20190222122430.21180-1-vincenzo.frascino@arm.com/
