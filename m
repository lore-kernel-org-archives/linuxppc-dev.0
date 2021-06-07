Return-Path: <SRS0=rLAe=LB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB5C47082
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 08:45:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA1060FE3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 08:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA1060FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fz6QD6Xmhz3bsh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 18:45:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.217.50; helo=mail-vs1-f50.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fz6Pq5tfTz2yWG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jun 2021 18:45:01 +1000 (AEST)
Received: by mail-vs1-f50.google.com with SMTP id y207so117435vsy.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jun 2021 01:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NMLFqpyinJNzmHBwsTXpi/IC86W5Z3EEdqUV4Gadqtw=;
 b=DU49e19JJ7rAlfcwFtZLCZNSVIX4kNx0Rj38bmquiouEnf7/OxYNXjf1FB5zg8210y
 XE3oXsb2rEOsaY6yfLv2t3kkrXmDGAmEMcgfhGJjmd+FTse+YaezOzrNBmtPFPffRBkT
 3Et24Yhua6rMiP8ou7p37O9fpiaauuwKk0SjSZjkGPZabYXSY+VPjEgIgOGUIXeiSecb
 KiqQnGNt+1xx4iC1kg8tleHHcyolrhuQBooHZT9soXzrmSNDq/tjmcX6wfPzJrFmYGoX
 +uRBFYlcShJ2kJoVPrgbInjIA5Pk94juPM+1afhQflWYBKKRwiyHOo+GBupzKJKYio/e
 g69g==
X-Gm-Message-State: AOAM532pdguNQ/JXwFYHzqrXEcn5dSiTQYqvQQRKNLHhdrMSI7CHTWuN
 NvsFMypjxzTv/QhXX7NhqJ9KxaWLz7caBIyWhzU=
X-Google-Smtp-Source: ABdhPJwMLHirwEQ4tJUPI7qaplUDz3bp0fsmhod8P88K7RhBRU2njU8TgCywfoM2VwxcEnVDrH/bezsBM2ie2giEJTc=
X-Received: by 2002:a05:6102:c4c:: with SMTP id
 y12mr3863270vss.18.1623055497041; 
 Mon, 07 Jun 2021 01:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210604064916.26580-1-rppt@kernel.org>
In-Reply-To: <20210604064916.26580-1-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Jun 2021 10:44:45 +0200
Message-ID: <CAMuHMdWuOk2LBJunCsCjzjYnBDs1rZh_x=ez7N=gjYv_ETMAcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Remove DISCINTIGMEM memory model
To: Mike Rapoport <rppt@kernel.org>
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
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, sparclinux <sparclinux@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Matt Turner <mattst88@gmail.com>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>,
 kexec@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mike,

You may want to fix the DISCINTIGMEM typo in the subject for v3, unless
you think that makes tracking series versions more complicated ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
