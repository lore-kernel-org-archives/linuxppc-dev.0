Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31444C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 13:33:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25FF2075E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25FF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wY4K0xkWzDqlg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 23:33:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wXzm03mCzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 23:29:39 +1000 (AEST)
Received: by mail-qt1-f194.google.com with SMTP id c13so6621515qtn.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 May 2019 06:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fk5GUwth5BvvK8Eer/x9OS3rdg8YnckRm3ge9ViV+sM=;
 b=HficPYt7p+oErZH9DbVYaGxzAdc2XhMZne8c+PBEJOPRuILneY3sB1wcHwmm7+2kQU
 r7pRjd/g8pv09ALDQz+nGz+lqc4aSvXgRkR2x39wQaXYpvZsl50HLDHNRhPRXjM8hV4f
 Bdr4KO7t8jLrS9oqx0+bE1i92XulSrt5Iz87oJS07I+jLt8pWA1cSwSgEx4Toe/AHXtl
 mzqI10w8qyyZtyQlqnW7jyTQcesc3SWeJXLQfVW1RL2DPuptIoul2ieUu6roq6MOk9vm
 HyrNKAAdZE8M1Tz8sRtgKyIfHtGuct5yPme1I5n0soaPxkptEnQR12qTyv4dT08z3Lp9
 +5ZA==
X-Gm-Message-State: APjAAAXap7Fu6XH/SC22icJkfZ5NzCnnTPwvCPKL1rT7JZUc9D8mllqL
 Tjz6D999HihUK60xwSgUtwdomdMZwvHgJhc0MOU=
X-Google-Smtp-Source: APXvYqw8ksabgFtpp8q3N/HfcPgRVYjc/VIhVGxEo5Nm6nyf24/EmnBpzo4QPweVmQKnq4DCKvnFaYM9qsG1Qqd+NVU=
X-Received: by 2002:a0c:89c8:: with SMTP id 8mr8014801qvs.149.1556890176895;
 Fri, 03 May 2019 06:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190501173943.5688-1-hch@lst.de>
 <20190501173943.5688-6-hch@lst.de>
In-Reply-To: <20190501173943.5688-6-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 3 May 2019 09:29:20 -0400
Message-ID: <CAK8P3a2-bFU=2Pmva9qj06JQ44MAW_D-Jaf_0fSExYm1yM8dtQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] asm-generic: remove ptrace.h
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 1, 2019 at 1:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> No one is using this helper anymore.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
