Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F13C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 17:32:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001F020836
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 17:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001F020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bqgr3PBNzDr4L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 04:32:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bqdz0BDCzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 04:31:02 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id e5so19615995qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 09:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SGHCnfowgHn30T+nuPC0hqbUSrYY8+wFH1Oi3pXaRzM=;
 b=SnC3jiQu0nJg2In7tKqAGlM6JhVdIe8Ml/u5mrBhNfQri9mRgquYQ1TQJWvIh5f/eM
 wABvMo+tZyA8HYYZbgc46QRe/k7pPpqeNqvrIpeig7fMj/zYy44EScYs9YC+aF5bzXZh
 YqEY5wZiYPnLjsEDaG3+p6KwEhPWjGJV0I4+yoWFqZlWhOFbR/FY9P9bzpl92ylfSluN
 SxSdO9kakWhz0c9qlW0QhinQH0kwA79waYldEjfpeTSo1wJ4JE4UlD2bGjImj6D7se7S
 CR/MkvcYpiL77EA5MSpAm81+MgKdCpOE0x0/tY6iqzy4lVh6DcstwSXP3rOUS2R6iMpv
 Pbbw==
X-Gm-Message-State: AJcUuke4ZU7JfKbDNsMZgcniXGXubJVJ/MoV/pTeZvtqy+XZQhkXlZ3t
 zq0QS2nlEjO8J02X84iCZWGxKOtzExTAjpllrbY=
X-Google-Smtp-Source: ALg8bN775BnYYqpcTaMAandAOOVFGcb1fag8zY9M3WMS/TPmNFpmSdRaCOyAJ14+1Aq8ng+YTuIZvIzlZbwDHzn2U4I=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr14875090qta.152.1547227860501; 
 Fri, 11 Jan 2019 09:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
 <20190110203638.GB3676@osiris>
In-Reply-To: <20190110203638.GB3676@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Jan 2019 18:30:43 +0100
Message-ID: <CAK8P3a0M6qSJQAtFNKVS5muissKvyzeE9MSYT_uwKnM4BKCAug@mail.gmail.com>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
To: Heiko Carstens <heiko.carstens@de.ibm.com>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 9:36 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:

> Since you only need/want the system call numbers, could you please
> change these lines to:
>
> > +384  common  pkey_alloc              -                               -
> > +385  common  pkey_free               -                               -
> > +386  common  pkey_mprotect           -                               -
>
> Otherwise it _looks_ like we would need compat wrappers here as well,
> even though all of them would just jump to sys_ni_syscall() in this
> case. Making this explicit seems to better.

Ok, fair enough. I considered doing this originally and then
decided against it for consistency with the asm-generic file,
but I don't care much either way.

Is this something you may want to add later? I'm not sure exactly
how pkey compares to s390 storage keys, or if this is something
completely unrelated.

     Arnd
