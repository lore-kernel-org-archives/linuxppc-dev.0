Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16341C37121
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 20:30:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5952F20844
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 20:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5952F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43k37w0ClHzDqST
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 07:30:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43k3631mXczDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 07:28:27 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id n32so24940137qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 12:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kD6IFPEOKNOz9iNntsGiu85pLEy/bbFmo7y1npa4eOs=;
 b=k6ZOh/yKb4z7lRKxTHzLNm2zufWtH+/V3DSJfGzj34jsrSDHlJc3bEWhI4o2IqjS+3
 PjLaAWIh4kP+iwnfK8r08yVQIELCbnVZCxKklTLs7XcXrJIhiNZLWKf+6DnnozfNSBz1
 iFr27HVCHTnmCh4ifEKLl4URSIo0MWusb17BNOsOUSJ4sBz0/S9ZEW73YroLFWFsSEH3
 6NPxVKQHJMqIQQNd5z4+udPqUEoN/8ehwjHuNSk5PTTibeJH3NnGXCoBQRZekps+ZBcz
 SChYsPdSFcRnsnW5knnpwOCXIZCaggBxR8+Ck7/9mSLBntBFbbUSzFyn9JmUorpCJMIM
 uhNw==
X-Gm-Message-State: AJcUukfXqqoFPf6ixUE9kCRW/nkSCxf7GBXMopanM8u7YPcExMFwhEZL
 Pd4q1kX1gw6oRYPo9rjSlW0M/2iWjQuFqmhUpcM=
X-Google-Smtp-Source: ALg8bN6mLscM+pbjX9xQ6/wy1A9ikEOKpuR+5XAFBodnDm12Xj0LxRlfII1AhYmWMPLWezvh7DcCeu+FaKZ+CS1nC+w=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr28748763qta.152.1548102504937; 
 Mon, 21 Jan 2019 12:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-15-arnd@arndb.de>
 <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
In-Reply-To: <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 21:28:08 +0100
Message-ID: <CAK8P3a1BxBHfHZCvTM6aoBiiN+EpnD4P9LM=Ked5Sc_QwF7hCg@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers
 everywhere
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, netdev <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Note that all architectures that already define pkey syscalls, list
> pkey_mprotect first.

It's easy enough to change, so I've reordered them for consistency now.

> Regardless, for m68k:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks,

     Arnd
